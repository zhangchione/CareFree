//
//  CFBaseViewController.swift
//  CareFree
//
//  Created by 张驰 on 2019/7/25.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class CFBaseViewController: UIViewController {
    
    // 左上角标题
    
    public lazy var Title:UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configBase()
    }
    
    func configBase(){
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        Title.frame = CGRect(x: 22.fitWidth_CGFloat, y: 50.fitHeight_CGFloat, width: 100.fitWidth_CGFloat, height: 40.fitHeight_CGFloat)
        Title.text = "我的"
        Title.font = UIFont(name: "PingFangSC-Semibold", size: 26)
        view.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        view.addSubview(Title)
    }


        
}
