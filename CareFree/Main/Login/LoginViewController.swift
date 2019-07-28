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
import Foundation

let ApiUrl = "https://api.huthelper.cn"
// MARK - 登录
func getApiLogin(userId:String,password:String) -> String {
    return ApiUrl+"/api/v1/get/login/"+userId+"/"+password
}

class LoginViewController: UIViewController {

    @IBOutlet weak var userID: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginBtnBackground: UIView!
    
    
    @IBAction func loginBtn(_ sender: UIButton) {
        
   
        ProgressHUD.show("登录中",interaction: true)
        

        ProgressHUD.dismiss()
        self.navigationController?.popViewController(animated: true)
        ProgressHUD.showSuccess("登录成功")
        // ProgressHUD.show("登陆中")
        let loginApiUrl = getApiLogin(userId: userID.text!, password: password.text!)
//
//        let URL = "https://b97fe674.ngrok.io/login?username=17408001048&password=test"
//
//        Alamofire.request(URL).responseJSON{(resonds) in
//            guard resonds.result.isSuccess else {
//                print("请求错误")
//                return
//            }
//            if let value = resonds.result.value{
//                let json = JSON(value)
//                print(json)
//            }
//        }
//
//        Alamofire.request(loginApiUrl).responseJSON{(responds) in
//            guard responds.result.isSuccess else { ProgressHUD.showError("网络请求失败"); ProgressHUD.dismiss();  return }
//            if let value = responds.result.value {
//                let json = JSON(value)
//                print(json)
//            }
//        }
        
//            //查找GameScore表
//            let query:BmobQuery = BmobQuery(className: "_User")
//            query.findObjectsInBackground { (array, error) in
//                for i in 0..<array!.count{
//                    let obj = array![i] as! BmobObject
//                    let phone = obj.object(forKey: "mobilePhoneNumber") as? String
//                    let pwd = obj.object(forKey: "pwd") as? String
//                    guard phone! == self.userID.text! else {
//                        print("用户不存在")
//                        return
//                    }
//                    guard pwd! == self.password.text! else {
//                        print("密码不正确")
//                        return
//                    }
//                    var user = User()
//                    user.id = obj.object(forKey: "id") as! String
//                    user.mode = obj.object(forKey: "mode") as! String
//                    user.total_notes = obj.object(forKey: "total_notes") as! Int
//                    user.userName = obj.object(forKey: "username") as! String
//
//                    saveUser(userData: user)
//
//                    print("登录成功")
//                    print(obj)
//                    self.navigationController?.popViewController(animated: true)
//                    break;
//                }
//            }
//
        
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
    // 左边返回按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        button.setTitle(" ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        button.tintColor = UIColor.red
        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configUI()
    }

    func configUI(){
        view.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.title = ""
        
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
    }
    @IBAction func backgorundTap(_ sender: Any) {
        dismissKeyboard()
    }
    func dismissKeyboard(){
        self.view.endEditing(false)
    }
    @objc func back(){
        
    }
    

}
