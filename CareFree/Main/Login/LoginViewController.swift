////
////  LoginViewController.swift
////  CareFree
////
////  Created by 张驰 on 2019/6/12.
////  Copyright © 2019 张驰. All rights reserved.
////
//
//import UIKit
//import HandyJSON
//import SwiftyJSON
//import Alamofire
//import ProgressHUD
//import Foundation
//
//let ApiUrl = "https://api.huthelper.cn"
//// MARK - 登录
//func getApiLogin(userId:String,password:String) -> String {
//    return ApiUrl+"/api/v1/get/login/"+userId+"/"+password
//}
//
//class LoginViewController: UIViewController {
//
//    @IBOutlet weak var userID: UITextField!
//    @IBOutlet weak var password: UITextField!
//    
//    @IBOutlet weak var loginBtnBackground: UIView!
//    
//    
//    @IBAction func loginBtn(_ sender: UIButton) {
//        
//   
//        ProgressHUD.show("登录中")
//
//        let loginUrl = "http://47.107.37.32:8081/api1.1/user/" + userID.text! + "/" + password.text!
//        Alamofire.request(loginUrl).responseJSON{(responds) in
//            guard responds.result.isSuccess  else {
//                ProgressHUD.showError("网络请求失败");
//                 return
//            }
//            if let value = responds.result.value {
//                let json = JSON(value)
//                print(json)
//                ProgressHUD.showSuccess("登陆成功")
//                self.navigationController?.popViewController(animated: true)
//                }
//
//        }
//    }
//    
//    @IBAction func forgetPwdBtn(_ sender: UIButton) {
//        
//    }
//    
//    
//    @IBAction func regitserBtn(_ sender: UIButton) {
//        
//        let registerVC = RegisterViewController()
//        self.navigationController?.pushViewController(registerVC, animated: true)
//        
//    }
//    // 左边返回按钮
//    private lazy var leftBarButton:UIButton = {
//        let button = UIButton.init(type: .custom)
//        button.frame = CGRect(x:10, y:0, width:30, height: 30)
//        button.setTitle(" ", for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
//        button.tintColor = UIColor.red
//        return button
//    }()
//    
//    override func viewDidLoad() {
//        
//        super.viewDidLoad()
//        configUI()
//    }
//
//    func configUI(){
//        view.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
//        self.navigation.bar.isShadowHidden = true
//        self.navigation.bar.alpha = 0
//        self.navigation.item.title = ""
//        
//        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
//    }
//    @IBAction func backgorundTap(_ sender: Any) {
//        dismissKeyboard()
//    }
//    func dismissKeyboard(){
//        self.view.endEditing(false)
//    }
//    @objc func back(){
//        
//    }
//    
//
//}
