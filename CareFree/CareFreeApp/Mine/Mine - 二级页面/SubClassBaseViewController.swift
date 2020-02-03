//
//  SubClassBaseViewController.swift
//  Hiker
//
//  Created by 张驰 on 2019/9/10.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class SubClassBaseViewController: UIViewController {
    
    // 左边返回按钮
    private lazy var leftBarButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        button.setTitle("←", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        button.tintColor = UIColor.red
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    }
    
func configNav() {
    }
    func setUI(){
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        self.navigation.bar.backgroundColor = .white
        view.backgroundColor = .white
        self.navigation.bar.isShadowHidden = true
                if #available(iOS 11.0, *) {
                    self.navigation.bar.prefersLargeTitles = true
                    self.navigation.item.largeTitleDisplayMode = .automatic
                }
        print("SubClassBaseControler setUI方法调用")
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }

}
class SubClassBaseViewController1: UIViewController {
    
    // 左边返回按钮
    private lazy var leftBarButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "home_icon_back"), for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    }
    

    func setUI(){
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        self.navigation.bar.backgroundColor = .white
        view.backgroundColor = .white
        self.navigation.bar.isShadowHidden = true
                if #available(iOS 11.0, *) {
                    self.navigation.bar.prefersLargeTitles = true
                    self.navigation.item.largeTitleDisplayMode = .automatic
                }
        print("SubClassBaseControler setUI方法调用")
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }

}
