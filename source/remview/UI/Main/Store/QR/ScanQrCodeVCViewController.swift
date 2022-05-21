//
//  ScanQrCodeVCViewController.swift
//  Remview
//
//  Created by Admin on 9/15/21.
//

import UIKit
import AVFoundation
import SnapKit
enum ScanQrcodeType {
    case verifyMobile
    case verifyWeb
}
protocol ScanQRCodeDelegate: AnyObject {
    func callbackQRCodeValue(code: String, type: ScanQrcodeType)
}

class ScanQrCodeVCViewController: BaseViewController {

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var qrCodeFrameView:UIView?
    var lineView:UIView?
    weak var delegate: ScanQRCodeDelegate!
    var typeScan: ScanQrcodeType?
    
    let viewModel = ScanQrCodeViewModel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qrCodeFrameView = UIView()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        // animation
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat],
                       animations: {
            self.lineView?.backgroundColor = .none
                       },
                       completion: nil)
    }
    
    override func setup() {
        view.backgroundColor = UIColor.clear
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            qrCodeCheckPermissionFailed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            qrCodeCheckPermissionFailed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        self.addQRCodePreview()
        
        captureSession.startRunning()
    }
    private func addQRCodePreview(){
        
        let middleView = UIView()
        view.addSubview(middleView)
        
        let qrCodeWidth = viewModel.appCofig.screenWidth - 40;
        
        middleView.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.height.equalTo(qrCodeWidth)
        })
        
        let centerView = UIView();
        middleView.addSubview(centerView)
        centerView.contentMode = .scaleToFill
        centerView.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(qrCodeWidth)
            make.width.equalTo(qrCodeWidth)
        })
        
        lineView = UIView()
        lineView?.backgroundColor = UIColor.red
        middleView.addSubview(lineView!)
        lineView?.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(qrCodeWidth)
            make.height.equalTo(2)
        })
      
        
        let leftView = UIView()
        middleView.addSubview(leftView)
        leftView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        leftView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.right.equalTo(centerView.snp.left).offset(0)
        })
        
        let rightView = UIView()
        middleView.addSubview(rightView)
        rightView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        rightView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.left.equalTo(centerView.snp.right).offset(0)
        })
        
        
        let topView = UIView()
        view.addSubview(topView)
        topView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        topView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalTo(middleView.snp.top).offset(0)
        })
        
        let bottomView = UIView()
        view.addSubview(bottomView)
        bottomView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        bottomView.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.top.equalTo(middleView.snp.bottom).offset(0)
        })
        
        let cancelBtn = UIButton()
        view.addSubview(cancelBtn)
        cancelBtn.setImage(UIImage(named: "ic_close"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(self.cancelBtnAction(_:)), for: .touchUpInside)
        cancelBtn.snp.makeConstraints({ make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(30)
            make.height.equalTo(30)
        })
    }
    
    func qrCodeCheckPermissionFailed() {
        
        let ac = UIAlertController(title: "device_note_support".localized, message: "camera_detail".localized, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "confirm_ok".localized, style: .default))
        present(ac, animated: true)
        captureSession = nil
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
   @objc func cancelBtnAction( _ sender: UIButton) {
       self.dismiss(animated: true, completion: nil)
    }
    
    func detectQRCode(code: String) {
        if let delegate = self.delegate {
            self.navigationController?.popViewController(animated: false)
            delegate.callbackQRCodeValue(code: code, type: typeScan!)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
extension ScanQrCodeVCViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            captureSession.stopRunning()
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            detectQRCode(code: stringValue)
        }
        //dismiss(animated: true)
    }
}
