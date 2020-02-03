//
//  CFAlbumViewController.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/6.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import SnapKit


class CFAlbumViewController: CFBaseViewController {
    
    var datas = [CFAlbumMouthModel]()
    
    lazy var tableView:UITableView = {
        let tableview = UITableView()
            tableview.tag = 2001
            tableview.separatorStyle = .none
            tableview.delegate = self
            tableview.dataSource = self
            tableview.backgroundColor = backColor
    //        tableview.register(UINib(nibName: "HandTableViewCell", bundle: nil), forCellReuseIdentifier: "HandTableViewCell")
            return tableview
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavBar()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        configData()
    }
    func configUI(){
        view.backgroundColor = backColor
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.bottom.right.left.equalTo(view)
            make.top.equalTo(navigation.bar.snp.bottom).offset(0)
        }
    }
    
    func configNavBar() {
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        Title.text = "相册"
        view.addSubview(Title)
    }
    
    func configData(){
        self.datas = DataBase.shared.queryByMouth()
        self.tableView.reloadData()
    }

}
// MARK: 代理 数据源
extension CFAlbumViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let now = Date()
        let timeForMatter = DateFormatter()
        timeForMatter.dateFormat = "yyyy年MM月dd:HH点mm分:EE"
        let id = timeForMatter.string(from: now)
        let identifier = "\(id)MomentCell\(indexPath.section)\(indexPath.row)"
        print(identifier)
        self.tableView.register(albumCell.self, forCellReuseIdentifier: identifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! albumCell
        cell.updateUI(with: datas[indexPath.row])
        cell.callback = {[weak self] (data) in
            let vc = AlbumDetialController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

//        if count == 0 {
//            return 0
//        }else {
        return 200//CGFloat(100 + 110 * datas[indexPath.row].celldata.count)
//        }
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = AlbumDetialController()
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
}
