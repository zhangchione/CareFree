//
//  CFMineViewController.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/6.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class CFMineViewController: UIViewController {

    var emotionLayer: CAGradientLayer!
    
    fileprivate lazy var Title:UILabel = {
        let label = UILabel()
        return label
    }()
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configNavBar()
    }
    
    func configUI(){
        view.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        tableView = UITableView(frame: CGRect(x: 0, y: 88.fitHeight_CGFloat, width: 414.fitWidth_CGFloat, height: 725.fitHeight_CGFloat))
        tableView.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        tableView.register(UINib(nibName: "CFMineCell", bundle: nil), forCellReuseIdentifier: "CFMineCell")
    }
    
    func configNavBar(){
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        Title.frame = CGRect(x: 22.fitWidth_CGFloat, y: 50.fitHeight_CGFloat, width: 100.fitWidth_CGFloat, height: 40.fitHeight_CGFloat)
        Title.text = "我的"
        Title.font = UIFont(name: "PingFangSC-Semibold", size: 26)
        view.addSubview(Title)
    }
    
    // 渐变色背景：

}

extension CFMineViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CFMineCell", for: indexPath) as! CFMineCell
        emotionLayer = CAGradientLayer()
        emotionLayer.frame = cell.emotionView.bounds
        emotionLayer.colors = [UIColor.init(r: 100, g: 176, b: 232).cgColor,UIColor.init(r: 83, g: 121, b: 255).cgColor]
        emotionLayer.cornerRadius = 30
        cell.backgroundViewone.layer.addSublayer(emotionLayer)
        cell.emotionValue.text = "41"
        return cell
    }
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 790.fitHeight_CGFloat
    }
    
}
