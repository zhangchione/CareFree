//
//  RegisterViewController.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/12.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import Alamofire
import ProgressHUD
import SwiftyJSON
class RegisterViewController: UIViewController {
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var verify: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func sendCheckBtn(_ sender: UIButton) {
        let registerUrl = "http://120.77.151.36/api/sendverifycode?PhoneNumber=" + phoneNumber.text!
        Alamofire.request(registerUrl).responseJSON{(responds) in
            guard responds.result.isSuccess else {
                ProgressHUD.showError("网络请求失败");
                ProgressHUD.dismiss();
                print("网络请求失败"); return
            }
            if let value = responds.result.value {
                print("value=",value)
                let json = JSON(value)
                print(json)
            }
        }
    }
    
    @IBAction func registerBtn(_ sender: UIButton) {
        let registerUrl = "http://120.77.151.36/api/registry?UserCode=" + verify.text! + "&UserTel=" + phoneNumber.text! +  "&Password=" + password.text!
        Alamofire.request(registerUrl).responseJSON{(responds) in
            print(registerUrl)
            guard responds.result.isSuccess else {
                ProgressHUD.showError("网络请求失败");
                ProgressHUD.dismiss();
                print("网络请求失败"); return
            }
            if let value = responds.result.value {
                print("value=",value)
                let json = JSON(value)
                print(json)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
