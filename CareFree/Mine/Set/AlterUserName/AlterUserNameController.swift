//
//  AlterUserNameController.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/12.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import ProgressHUD
class AlterUserNameController: UIViewController {

    @IBOutlet weak var userNameText: UITextField!
    
    // 左边返回按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        button.setTitle("←", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        button.tintColor = UIColor.red
        return button
    }()
    
    @IBAction func saveBtn(_ sender: UIButton) {
        print("昵称正在保存")
        ProgressHUD.showSuccess("修改成功")
        //Thread.sleep(forTimeInterval: 1)
        ProgressHUD.dismiss()
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    func configUI(){
        view.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.title = "修改昵称"
        
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }

}
