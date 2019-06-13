//
//  LoginViewController.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/12.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON
import Alamofire
import ProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var userID: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginBtnBackground: UIView!
    
    
    @IBAction func loginBtn(_ sender: UIButton) {
        print("正在登陆")
        let loginUrl = "http://120.77.151.36/api/login?UserTel=" + userID.text! + "&Password=" + password.text!
        Alamofire.request(loginUrl).responseJSON{(responds) in
            guard responds.result.isSuccess  else {
                ProgressHUD.showError("网络请求失败");
                ProgressHUD.dismiss();  return
            }
            if let value = responds.result.value {
                let json = JSON(value)
                print(json)
                self.navigationController?.popViewController(animated: true)
                }
            
        }
    }
    
    @IBAction func forgetPwdBtn(_ sender: UIButton) {
        
    }
    
    
    @IBAction func regitserBtn(_ sender: UIButton) {
        
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }


  

}
