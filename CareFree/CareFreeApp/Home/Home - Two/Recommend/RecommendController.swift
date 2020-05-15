//
//  RecommendController.swift
//  CareFree
//
//  Created by 张驰 on 2019/7/19.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class RecommendController: UIViewController {
    
    private let RecommendHeaderViewID = "RecommendHeaderView"
    private let RecommendBookCellID = "RecommendBookCell"
    var BookModels = [BookModel]()
    
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
    
    lazy var tableView: UITableView = {
       let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: CFWidth, height: CFHeight))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(RecommendBookCell.self, forCellReuseIdentifier: RecommendBookCellID)
        tableView.register(RecommendHeaderView.self, forHeaderFooterViewReuseIdentifier: RecommendHeaderViewID)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    

    func configUI(){
        view.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.title = "今日推荐"
                self.view.addSubview(self.tableView)
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        
    }

}


extension RecommendController {
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension RecommendController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecommendBookCellID, for: indexPath) as! RecommendBookCell
        var model = BookModel()
        model.author = "威廉"
        model.img = "home_book"
        model.title = "面砂"
        BookModels.append(model)
        BookModels.append(model)
        BookModels.append(model)
        BookModels.append(model)
        
        cell.content = BookModels
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: RecommendHeaderViewID) as! RecommendHeaderView
        headerView.titStr = "图书"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
