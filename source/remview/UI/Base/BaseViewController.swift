//
//  BaseViewController.swift
//  MQRcode
//
//  Created by Nguyen Hoang on 10/16/20.
//

import UIKit

import Resolver
import Reachability

class BaseViewController: UIViewController {
    
    private var isKeyBoardShow = false
    private var keyboardHeight: CGFloat = 0.0
    var load = false
    let reachability = try! Reachability()
        
    @Injected
    var appDelegate: AppDelegate
    
    @Injected
    var appCofig: AppConfiguration
    
    let toastView = ToastVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        load = true
        setup()
        bindData()
        
        curentViewFrame = self.view.frame
        registerKeyboardListener()
        
    }
    func shouldSetupHeaderView() -> Bool {
        return false
    }
    func showBackButton() -> Bool {
        return false
    }
    func showRightButton() -> Bool {
        return false
    }
    func heightSafeView() -> CGFloat {
        let topInset: CGFloat = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? UIApplication.shared.statusBarFrame.size.height
        return  topInset
    }
    func heightHeaderView(isPadding: Bool = false) -> CGFloat {
        let topInset: CGFloat = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? UIApplication.shared.statusBarFrame.size.height
        return  topInset + 40

    }
    func setupHeaderUI(){
        
    }
    
    func setup() {
//        self.view.backgroundColor = getBackgroundColor()
        self.setupHeaderUI()
        self.reloadData()
        
    }
    
    func setupNavigationTitle() -> String {
        return "DefaultTitle"
    }
    
    func bindData() {
        
    }
    
    func makeToast(title:String?, msg: String, myAction: @escaping ()->() = { })
    {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: getLanguageWithKey(key: "confirm_ok"), style: .default, handler: {_ in myAction()
        }))
        self.present(alert, animated: true)
        
    }
    
    func alertDialog(title:String?, msg: String, yes: @escaping ()->() = { }, no :@escaping ()->() = {})
    {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in yes()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: {_ in no()
        }))
        self.present(alert, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    @objc func reachabilityChanged(note: Notification) {

      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi:
          print("Reachable via WiFi")
          break
      case .cellular:
          print("Reachable via Cellular")
          break
      case .unavailable:
          handleNetworkError()
          break
      case .none:
//          do nothing
          break
      }
    }
    func handleNetworkError(){
        stopIndicator()
        makeToast(title: nil,msg: "You are not currently connected to any networks",myAction: {
            if self.reachability.connection == .unavailable {
                self.handleNetworkError()
            }
        })
    }
    func handleRequestError(msg:String = "Error occurred, please try again"){
        self.stopIndicator()
        self.makeToast(title: nil, msg: msg);
    }
    
    func showToastMsg(msg: String){
        self.startIndicator(msg: msg)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.stopIndicator()
        })
    }

    func startIndicator(msg: String) {
        error(String.init(describing: self.classForCoder))
        self.toastView.modalPresentationStyle = .overFullScreen
        self.toastView.msg = msg
        self.present(self.toastView, animated: false, completion: nil)
    }
    
    func stopIndicator() {
        self.toastView.dismiss(animated: false, completion: nil)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func getBackgroundColor() -> UIColor {
        // mau mac dinh muon doi vao AppConfiguration.swift
        //return "#18A0FB"
        return appCofig.backgroundColor
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    
    ///Keyboard section
    var curentViewFrame: CGRect!
    
    func handleKeyBoardShow()  {
        
    }
    
    func handleKeyBoardHide()  {
        
    }
    
    func registerDismissKeyboardOnTapOutSide() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer( target:     self, action:    #selector(self.dismissKeyboardTouchOutside))
       tap.cancelsTouchesInView = false
       view.addGestureRecognizer(tap)
    }
        
    @objc private func dismissKeyboardTouchOutside() {
       view.endEditing(true)
    }
    
    func registerKeyboardListener() {
        //  Registering for keyboard notification.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }


    /*  UIKeyboardWillShowNotification. */
    @objc internal func keyboardDidShow(_ notification : Notification?) -> Void {
        
    }
    func keyboardHeight(height:CGFloat){
        
    }
    
    /*  UIKeyboardDidNotification. */
    @objc internal func keyboardDidHide(_ notification : Notification?) -> Void {
        
        if(isKeyBoardShow){
            keyboardHeight = 0
            isKeyBoardShow = false
            
            self.view.frame = curentViewFrame
            handleKeyBoardHide()
        }
    }
    
    /// Language
    func getLanguageWithKey(key: String) -> String {
        return key.localized(bundle: appCofig.languageBundle)
    }
    
    func changeLanguage(languageCode: String) {
        appDelegate.changeLaguage(lang: languageCode)
    }
    
    func delay (second:Double,run: @escaping ()->Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + second) {
            run()
        }
    }
    func reloadData()->Void{
        
    }
}

