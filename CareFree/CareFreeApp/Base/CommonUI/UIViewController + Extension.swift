//
//  UIViewController + Extension.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/15.
//  Copyright © 2020 张驰. All rights reserved.
//

import Foundation

import  UIKit

extension UIViewController {
    func alertViewShoww(with name:String,  callback: @escaping(_ result:String) -> ()){
        let alert = UIAlertController.init(title: name, message: "请输入", preferredStyle: .alert)
            
        let yesAction = UIAlertAction.init(title: "确定", style: .default) { (yes) in
             callback((alert.textFields?.first?.text!)!)
        }
        let noAction = UIAlertAction.init(title: "取消", style: .default) { (no) in
            
        }
        alert.addAction(noAction)
        alert.addAction(yesAction)
        alert.addTextField { (text) in }
            
        self.present(alert, animated: true, completion: nil)
    }
}
