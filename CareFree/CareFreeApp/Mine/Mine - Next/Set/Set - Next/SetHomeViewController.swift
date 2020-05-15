//
//  SetHomeViewController.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/15.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit

class SetHomeViewController: UIViewController {

    
    // 数据源 暂时
    let setArrayDatas = [["语言","卡片展示内容","首页显示任务"]]
    
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
        self.navigation.item.title = "首页设置"
    }

}

extension SetHomeViewController: UITableViewDataSource  {
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

extension SetHomeViewController: UITableViewDelegate {
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


// MARK: Cell UI
    
extension SetHomeViewController {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 圆角角度
        let radius: CGFloat = 10.fit
        // 设置cell 背景色为透明
        cell.backgroundColor = UIColor.clear
        // 创建两个layer
        let normalLayer = CAShapeLayer()
        let selectLayer = CAShapeLayer()
        // 获取显示区域大小
        let bounds = cell.bounds.insetBy(dx:  20.fit, dy: 0)
        // cell的backgroundView
        let normalBgView = UIView(frame: bounds)
        // 获取每组行数
        let rowNum = tableView.numberOfRows(inSection: indexPath.section)
        // 贝塞尔曲线
        var bezierPath: UIBezierPath? = nil

        if rowNum == 1 {
            // 一组只有一行（四个角全部为圆角）
            bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
            normalBgView.clipsToBounds = false
        } else {
            normalBgView.clipsToBounds = true
            if indexPath.row == 0 {
                normalBgView.frame = bounds.inset(by: UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0))
                let rect = bounds.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
                // 每组第一行（添加左上和右上的圆角）
                bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
            } else if indexPath.row == rowNum - 1 {
                normalBgView.frame = bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: -5, right: 0))
                let rect = bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0))
                // 每组最后一行（添加左下和右下的圆角）
                bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
            } else {
                // 每组不是首位的行不设置圆角
                bezierPath = UIBezierPath(rect: bounds)
            }
        }
    
        
        // 阴影
        normalLayer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        normalLayer.shadowOpacity = 0.2
        normalLayer.shadowOffset = CGSize(width: 0, height: 0)
        normalLayer.path = bezierPath?.cgPath
        normalLayer.shadowPath = bezierPath?.cgPath

        // 把已经绘制好的贝塞尔曲线路径赋值给图层，然后图层根据path进行图像渲染render
        normalLayer.path = bezierPath?.cgPath
        selectLayer.path = bezierPath?.cgPath

        // 设置填充颜色
        normalLayer.fillColor = UIColor.white.cgColor
        // 添加图层到nomarBgView中
        normalBgView.layer.insertSublayer(normalLayer, at: 0)
        normalBgView.backgroundColor = UIColor.clear
        cell.backgroundView = normalBgView

        // 替换cell点击效果
        let selectBgView = UIView(frame: bounds)
        selectLayer.fillColor = UIColor(white: 0.95, alpha: 1.0).cgColor
        selectBgView.layer.insertSublayer(selectLayer, at: 0)
        selectBgView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = selectBgView
        
    }
}
