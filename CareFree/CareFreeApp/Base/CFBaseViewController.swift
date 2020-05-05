//
//  CFBaseViewController.swift
//  CareFree
//
//  Created by 张驰 on 2019/7/25.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class CFBaseViewController: UIViewController {
    
    private var titleText = ""
    
    // 左上角标题
    public lazy var Title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PingFangSC-Semibold", size: 26.fit)
        return label
    }()
    
    // Bar
    public lazy var barView: UIView = {
        let vi = UIView()
        vi.backgroundColor = .clear
        return vi
    }()
    convenience init(title: String){
        self.init()
        self.titleText = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configBase()
    }
    
    func configBase(){
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        
        
        view.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        Title.frame = CGRect(x: 22.fit, y: 10.fit, width: 100.fit, height: 40.fit)
        Title.text = titleText
        self.navigation.bar.addSubview(Title)
    }


        
}
