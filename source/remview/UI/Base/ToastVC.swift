//
//  ToastVC.swift
//  MQRcode
//
//  Created by Nguyen Hoang on 5/20/21.
//  Copyright © 2021 HQ-MQRCode. All rights reserved.
//

import UIKit

class ToastVC: UIViewController {

    @IBOutlet weak var contentProgressBar: UIActivityIndicatorView!
    @IBOutlet weak var lbMsg: UILabel!
    @IBOutlet weak var viewMsg: UIView!
    
    var msg:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        ViewUtils.borderView(view: viewMsg, thickness: 1.0, corner: 5.0, boderColor: UIColor().hexColor(hex: "#ffffff"), bodyColor: UIColor().hexColor(hex: "#ffffff"))
        
        self.lbMsg.text = msg.isEmpty ? "" : msg
        contentProgressBar.startAnimating()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.lbMsg.text = msg.isEmpty ? "" : msg
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    

}
