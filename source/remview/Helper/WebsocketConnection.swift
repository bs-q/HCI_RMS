//
//  WebsocketConnection.swift
//  remview
//
//  Created by Bui Si Quan on 22/04/2022.
//

import Foundation
import Starscream
import Resolver
import RxSwift
import ObjectMapper
class WebsocketConnection : WebSocketDelegate {
   
    
    @Injected
    var appCofig: AppConfiguration
    
    enum SocketState {
        case none
        case connecting
        case connected
        case waiting
    }
    var socketState = SocketState.none
    var websocket : WebSocket?
    var session : String?
    var lastMessage : Message?
    var requests : Queue<Message>?
    var socketListener : SocketListener?
    var lastPingTime = Date()
    var lastTimeCall : Date?
    var tickDispose = DisposeBag()
    private static var socketInstance : WebsocketConnection?
    
    private init() {
        var request = URLRequest(url: URL(string: appCofig.socketUrl)!)
        request.timeoutInterval = 30
        requests = Queue()
        websocket = WebSocket(request: request)
        websocket!.delegate = self
    }
    private func startTick(){
        Observable<Int>.interval(.milliseconds(150), scheduler: MainScheduler.instance).subscribe(onNext: {_ in
            if self.socketState == .none {
                debug("* Connect socket")
                self.connect()
            } else if self.socketState == .connected {
                if self.requests?.size ?? 0 > 0 {
                    self.lastMessage = self.requests?.dequeue()
                }
                if self.lastMessage != nil {
                    debug("* sent last message")
                    self.sendMessage()
                } else if ((Date()-self.lastPingTime).second ?? 0 > 25) {
                    debug("* ping socket")
                    self.sendPing()
                    self.lastPingTime = Date()
                }
            } else if self.socketState == .waiting {
                if ((Date()-self.lastPingTime).second ?? 0 > 30) {
                    debug("* post timeout")
                    self.postTimeout()
                    self.lastTimeCall = nil
                    self.lastMessage = nil
                    self.socketState = .connected
                }
            }
        }, onError: {error in}, onCompleted: nil, onDisposed: nil).disposed(by: tickDispose)
    }
    private func stopTick(){
        tickDispose = DisposeBag()
    }
    static func getInstance() -> WebsocketConnection{
        if WebsocketConnection.socketInstance == nil {
            WebsocketConnection.socketInstance = WebsocketConnection()
        }
        return WebsocketConnection.socketInstance!
    }
    
    private func connect(){
        if socketState == .none {
            socketState = .connecting
            websocket?.connect()
        }
    }
    
    func startSocket(){
        requests = Queue()
        startTick()
    }
    func stopSocket(){
        websocket?.disconnect()
        socketState = .none
        stopTick()
    }
    func handleSocketDisconnected(){
        lastTimeCall = nil
        socketState = .none
        let eventModel = SocketEventModel(message: nil)
        eventModel.event = .offline
        socketListener?.onMessage(socketEventModel: eventModel)
    }
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        websocket = client
        switch event {
        case .connected(let headers):
            debug("* websocket is connected")
            socketListener?.onConnected()
            socketState = .connected
            if session != nil {
                doVerifyToken()
            }
            break
        case .disconnected(let reason, let code):
            debug("* websocket is disconnected: \(reason) with code: \(code)")
            handleSocketDisconnected()
            break
        case .text(let string):
            debug("* Received text: \(string)")
            lastTimeCall = nil
            socketState = .connected

            let eventModel = SocketEventModel(message: nil)
            let message = Message(JSONString: string, context: nil)
            if message != nil && (message?.cmd != Command.COMMAND_PING) {
                if lastMessage != nil {
                    message?.screen = lastMessage?.screen
                }
                eventModel.event = .message
                eventModel.message = message
                lastMessage = nil
                socketListener?.onMessage(socketEventModel: eventModel)
            } else if message == nil {
                socketListener?.onError()
            }
            break
        case .binary(let data):
            debug("* Received data: \(data.count)")
            break
        case .ping(_):
            debug("* ping")
            break
        case .pong(_):
            debug("* pong")
            break
        case .viabilityChanged(_):
            debug("* viabilityChanged")
            break
        case .reconnectSuggested(_):
            debug("* reconnectSuggested")
            break
        case .cancelled:
            debug("* websocket is disconnected")
            handleSocketDisconnected()
            break
        case .error(let error):
            debug("* \(error)")
            lastTimeCall = nil
            socketState = .none
            socketListener?.onError()
            break
        }
    }
    func sendEvent(messsage : Message)->Bool{
        if socketState != .none {
            debug("add message to queue")
            requests?.enqueue(messsage)
            return true
        }
        return false
    }
    func sendMessage(){
        socketState = .waiting
        lastTimeCall = Date()
        var msg = ""
        if lastMessage?.requestData != nil {
            msg = lastMessage!.generateRequest(message: lastMessage!)
        } else {
            msg = lastMessage!.toJSONString()!
        }
        debug(msg)
        websocket?.write(string: msg)
    }
    func doVerifyToken(){
        lastTimeCall = Date()
        socketState = .waiting
        let cmd = "{ \"cmd\": \"VERIFY_TOKEN_CLIENT\", \"platform\": 1, \"token\": \"\(session!)\" }"
        debug(cmd)
        websocket?.write(string: cmd)
    }
    func sendPing(){
        if session != nil && socketState == .connected {
            lastTimeCall = Date()
            socketState = .waiting
            let cmd = "{ \"cmd\": \"CLIENT_PING\", \"platform\": 1, \"token\": \"\(session!)\" }"
            websocket?.write(string: cmd)
        }
    }
    private func postTimeout(){
        socketListener?.onTimeout(message: lastMessage)
    }
}
protocol SocketListener {
    func onMessage(socketEventModel : SocketEventModel?)
    func onTimeout(message : Message?)
    func onError()
    func onConnected()
}
