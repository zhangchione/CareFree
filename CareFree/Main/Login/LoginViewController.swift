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
        
   
            //查找GameScore表
            let query:BmobQuery = BmobQuery(className: "_User")
            query.findObjectsInBackground { (array, error) in
                for i in 0..<array!.count{
                    let obj = array![i] as! BmobObject
                    let phone = obj.object(forKey: "mobilePhoneNumber") as? String
                    let pwd = obj.object(forKey: "pwd") as? String
                    guard phone! == self.userID.text! else {
                        print("用户不存在")
                        return
                    }
                    guard pwd! == self.password.text! else {
                        print("密码不正确")
                        return
                    }
                    var user = User()
                    user.id = obj.object(forKey: "id") as! String
                    user.mode = obj.object(forKey: "mode") as! String
                    user.total_notes = obj.object(forKey: "total_notes") as! Int
                    user.userName = obj.object(forKey: "username") as! String
                    
                    saveUser(userData: user)
                    
                    print("登录成功")
                    print(obj)
                    self.navigationController?.popViewController(animated: true)
                    break;
                }
            }
            
        
//        let loginUrl = "http://120.77.151.36/api/login?UserTel=" + userID.text! + "&Password=" + password.text!
//        Alamofire.request(loginUrl).responseJSON{(responds) in
//            guard responds.result.isSuccess  else {
//                ProgressHUD.showError("网络请求失败");
//                ProgressHUD.dismiss();  return
//            }
//            if let value = responds.result.value {
//                let json = JSON(value)
//                print(json)
//                self.navigationController?.popViewController(animated: true)
//                }
//
//        }
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


    @IBAction func backgorundTap(_ sender: Any) {
        dismissKeyboard()
    }
    func dismissKeyboard(){
        self.view.endEditing(false)
    }
    

}
