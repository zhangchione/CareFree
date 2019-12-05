//
//  ShowViewController.swift
//  CareFree
//
//  Created by 张驰 on 2019/12/1.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

let HeadShowCellID = "HeadShowCell"
let ShowHeaderViewID = "ShowHeaderView"
let ShowBodyCellID = "ShowBodyCell"
class ShowViewController: UIViewController {
    // 左边返回按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        button.setTitle("←", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        button.tintColor = UIColor.red
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    
    // 右边完成按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        button.setTitle("", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.black, for: .normal)
        button.tintColor = UIColor.red
        return button
    }()
    // 主体tableView
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        // tableView.backgroundColor = UIColor.red
        tableView.register(HeadShowCell.self, forCellReuseIdentifier: HeadShowCellID)
        tableView.register(ShowBodyCell.self, forCellReuseIdentifier: ShowBodyCellID)
        tableView.register(ShowHeaderView.self, forHeaderFooterViewReuseIdentifier: ShowHeaderViewID)
        tableView.separatorStyle = .none
       // tableView.backgroundColor = .red
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.allowsSelection = false
        return tableView
    }()
    lazy var viewModel:ShowViewModel = {
       return ShowViewModel()
    }()
    convenience init(with datas:CFDiaryModel) {
        self.init()
        self.viewModel.datas = datas
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNav()
    }
}
// MARK: config
extension ShowViewController {
    func configUI(){
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(0)
            make.left.right.bottom.equalTo(view)
        }
    }
    func configNav(){
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
    }
}
extension ShowViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1;
        }else {
            return self.viewModel.datas.nowDiary.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HeadShowCellID, for: indexPath) as! HeadShowCell
            cell.updateUI(with: self.viewModel.datas)
            let gestrue = UITapGestureRecognizer(target: self, action: #selector(alter))
            cell.centerView.addGestureRecognizer(gestrue)
            cell.selectionStyle = .none
            return cell
        }else {
           let  cell = tableView.dequeueReusableCell(withIdentifier: ShowBodyCellID, for: indexPath) as! ShowBodyCell
            cell.updateUI(with: self.viewModel.datas.nowDiary[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 270
        }
        return 150
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ShowHeaderViewID) as! ShowHeaderView
        if section == 1 {
            return header
        }else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 40
        }else {
            return 0.0000001
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = NotesViewController(nowData: self.viewModel.datas.nowDiary[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
// 滑动代理
extension ShowViewController:UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        print(offsetY)
        if offsetY > 180 {
            self.navigation.bar.alpha = 1
        }else {
            self.navigation.bar.alpha = 0
        }
    }
}
extension ShowViewController{
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func alter(){
        let vc = NotesViewController(dayData: self.viewModel.datas.dayDiary)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
