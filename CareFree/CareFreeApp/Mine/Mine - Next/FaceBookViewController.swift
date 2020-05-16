//
//  FaceBookViewController.swift
//  Hiker
//
//  Created by 张驰 on 2019/10/15.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class FaceBookViewController: SubClassBaseViewController {

    
    var leftList = ["QQ","weibo","Mail","iMessages","tel","其他方式"]
    var rightList = ["1525163730","@zhangchione","zc@zhangchione.cc","发消息","Call me","QQ群:1054521548"]
    private lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.backgroundColor = UIColor.init(r: 247, g: 247, b: 247)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    

    func configUI() {
        view.addSubview(tableview)
        tableview.frame = CGRect(x: 0, y: 0, width: CFWidth, height: CFHeight)
        self.navigation.item.title = "反馈"
        self.navigation.bar.backgroundColor = UIColor.init(r: 247, g: 247, b: 247)
    }

}

extension FaceBookViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leftList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cellid = "setCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellid)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellid)
        }
        cell?.textLabel?.text = leftList[indexPath.row]
        cell?.detailTextLabel?.text = rightList[indexPath.row]
        cell?.accessoryType = .disclosureIndicator
        //cell?.selectionStyle = .none
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableview.deselectRow(at: indexPath, animated: true)
        
        let index = indexPath.row
        var url: URL?
        switch index {
        case 0:
            url = URL(string: String(format: "mqq://im/chat?chat_type=wpa&uin=\(1525163730)&version=1&src_type=web"))
        case 1:
            url = URL(string: "sinaweibo://userinfo?uid=6360764560")
        case 2:
             url = URL(string: "mailto:zc@zhangchione.cc")
        case 3:
             url = URL(string: "sms:1525163730@qq.com")
        case 4:
            url = URL(string: "telprompt://15274737502")
        case 5:
            url = nil
        default:
            break
        }
        if let u = url {
            UIApplication.shared.open(u, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        }
        
    }
    
}
private func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
