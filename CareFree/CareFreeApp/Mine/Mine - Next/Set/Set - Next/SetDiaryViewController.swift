//
//  SetDiaryViewController.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/15.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit

class SetDiaryViewController: UIViewController {

    // 数据源 暂时
    let setArrayDatas = [["头像","昵称","签名"],["首页","日记","便贴"],["关于","反馈交流","给个好评"]]
    
    
    private lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(SetViewCell.self, forCellReuseIdentifier: "bookCell")
        tableview.separatorStyle = .none
        tableview.backgroundColor = .clear
        tableview.showsVerticalScrollIndicator = false
        return tableview
    }()
    
    // 左边返回按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "hone_icon_back"), for: .normal)
        //button.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configNav()
    }
    


    func configUI(){
        view.backgroundColor = backColor
        self.view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(5.fit)
            make.right.equalTo(view.snp.right).offset(-5.fit)
            make.top.equalTo(navigation.bar.snp.bottom).offset(0.fit)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    func configNav(){
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        self.navigation.item.title = "日记设置"
    }
    
    

}

extension SetDiaryViewController: UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setArrayDatas[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return setArrayDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! SetViewCell
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.updateUI(with: setArrayDatas[indexPath.section][indexPath.row], type: .bio("汉语"))
            }else if indexPath.row == 1 {
                cell.updateUI(with: setArrayDatas[indexPath.section][indexPath.row], type: .bio("当前情绪值"))
            }else {
                cell.updateUI(with: setArrayDatas[indexPath.section][indexPath.row], type: .bio("显示"))
            }

        }else {
            cell.updateUI(with: setArrayDatas[indexPath.section][indexPath.row], type: .none)
        }


        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.fit
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vi = UIView()
        vi.backgroundColor  = .clear
        return vi
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.fit
    }
}

// MARK: tableview delegete

extension SetDiaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.tableview.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                
            }else if indexPath.row == 1 {
                self.alertViewShoww(with: "修改昵称") { (value) in
                    let cell = tableView.cellForRow(at: indexPath) as! SetViewCell
                    cell.updateUI(with: "昵称", type: .bio(value))
                }
            }else {
                self.alertViewShoww(with: "修改签名") { (value) in
                   let cell = tableView.cellForRow(at: indexPath) as! SetViewCell
                   cell.updateUI(with: "签名", type: .bio(value))
               }
            }

        }
    }
}
