//
//  AboutAViewController.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/16.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit

let descripeText = "心情日记是一款本地化日记类作品，它的运行环境为完全无网状态，用户可以不必担心自己的隐私会被泄露。希望您将生活中的美好点滴留住。还提供源码开放，如果你跟我一样是一名iOSer，欢迎提交代码改善应用"

let updateText = "v1.0.0\n- 初次审核通过。名为心情日记 - 记录美好，留住回忆 \n\nv1.0.2\n- 进行了软件瘦身。\n\nv1.0.3\n- 修复了本地图片加载卡顿问题。\n\nv1.1.0\n- 全新版本上线,新增便贴功能。更名为“无忧日记”。 "

let userProtocalText = "        无忧日记是一款提供用户记录日记、便签的应用。\n        " +
                "对于用户在此应用记录的内容不作任何保证：不保证日记和便笺等记录内容永久不会损坏、丢失。因任何原因导致您不能正常使用此应用，无忧日记不承担任何法律责任。" +
                "\n        应用尊重并保护所有使用无忧的用户的个人隐私权。您在无忧日记写下的所有日记和便笺都保存在手机本地，非经过您亲自许可或根据相关法律、法规强制性规定，应用不会以以任何形式主动泄露给第三方。" +
                "你同意上传至第三方的数据，因任何原因造成信息泄露、经济损失，无忧日记将不会承担任何法律责任。备份时请务必确认选择你信任的第三方云盘上传数据。"
// "    无忧日记是一款提供用户记录日记、便笺的工具。\n    卸载应用前请在设置中对数据进行备份(iOS端在下一个版本中v1.1.1退出iCloud备份)，否则将会造成数据丢失。对于用户在此应用记录的内容不作任何保证:不保证日记和便笺等记录内容永久不会损坏、丢失。因任何原因导致您不能正常使用此应用，无忧日记不承担任何法律责任。\n   应用尊重并保护所有使用无忧的用户的个人隐私权。您在无忧日记写下的所有日记和便笺都保存在手机本地，非经过您亲自许可或根据相关法律、法规强制性规定，应用不会以以任何形式主动泄露给第三方。你同意上传至第三方的数据，因任何原因造成信息泄露、经济损失，无忧日记将不会承担任何法律责任。备份时请务必确认选择你信任的第三方云盘上传数据。"



class AboutAViewController: UIViewController {

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
    
    
    
    lazy var appImg:UIImageView = {
       let vi = UIImageView()
        vi.image = UIImage(named: "icon-76")
        vi.cornerRadius = 10.fit
        vi.clipsToBounds = true
        return vi
    }()
    
    lazy var appName:UILabel = {
       let label = UILabel()
        label.text = "无忧日记"
        label.textAlignment = .center
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 14.fit)
        return label
    }()
    
    lazy var appVersion:UILabel = {
       let label = UILabel()
        label.text = "1.1.0 (20200516)"
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 13.fit)
        label.textAlignment = .center
        label.alpha = 0.8
        return label
    }()
    
    lazy var describe:UILabel = {
        let label = UILabel()
        label.text = descripeText
        label.numberOfLines = 0
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 14.fit)
        label.alpha = 0.8
         return label
    }()
    
    lazy var openAddressView: RestDaySelectedView = {
        let restDatView = RestDaySelectedView()
        restDatView.titleLabel.text = "开源地址"
        restDatView.detailLabel.text = ""
        restDatView.callback =  {
            let url = URL(string: "https://github.com/zhangchione/CareFree")
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
       return restDatView
    }()
    
    lazy var updateNotesView: RestDaySelectedView = {
        let restDatView = RestDaySelectedView()
        restDatView.titleLabel.text = "更新日志"
        restDatView.detailLabel.text = ""
        restDatView.callback =  {
            let vc = UpdateViewController(text: updateText, imageShow: false,title: "更新日志")
            vc.update = 4
            self.navigationController?.pushViewController(vc, animated: true)
        }
       return restDatView
    }()
    
    lazy var giveMeYourMoneyView: RestDaySelectedView = {
        let restDatView = RestDaySelectedView()
        restDatView.titleLabel.text = "充电支持"
        restDatView.detailLabel.text = ""
        restDatView.callback =  {
            let vc = UpdateViewController(text: "如果你觉得这款软件还不错的话，可以通过微信向开发者充电噢~", imageShow: true,title: "充电支持")
            self.navigationController?.pushViewController(vc, animated: true)
        }
       return restDatView
    }()
    
    lazy var userProtocal: RestDaySelectedView = {
        let restDatView = RestDaySelectedView()
        restDatView.titleLabel.text = "用户协议"
        restDatView.detailLabel.text = ""
        restDatView.callback =  {
            let vc = UpdateViewController(text: userProtocalText, imageShow: false,title: "用户协议")
            vc.update = -10
            self.navigationController?.pushViewController(vc, animated: true)
        }
       return restDatView
    }()
    
     override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        configNav()
    }

    func configUI(){
        
        view.backgroundColor = backColor
        view.addSubview(appImg)
        view.addSubview(appName)
        view.addSubview(appVersion)
        view.addSubview(describe)
        
        appImg.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(self.navigation.bar.snp.bottom).offset(30.fit)
            make.width.height.equalTo(80.fit)
        }
        appName.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(appImg.snp.bottom).offset(15.fit)
            make.height.equalTo(30.fit)
            make.width.equalTo(80.fit)
        }
        appVersion.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(appName.snp.bottom).offset(0.fit)
            make.height.equalTo(25.fit)
            make.width.equalTo(120.fit)
        }
        describe.snp.makeConstraints { (make) in
            let height = getTextHeight(textStr: descripeText, font: UIFont.init(name: "PingFangSC-Medium", size: 14.fit)!, width: CFWidth-54.fit)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(appVersion.snp.bottom).offset(10.fit)
            make.height.equalTo(height + 30.fit)
            make.width.equalTo(CFWidth-54.fit)
        }
        view.addSubview(openAddressView)
        openAddressView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(27.fit)
            make.right.equalToSuperview().offset(-27.fit)
            make.top.equalTo(describe.snp.bottom).offset(40.fit)
            make.height.equalTo(40.fit)
        }
        view.addSubview(updateNotesView)
        updateNotesView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(27.fit)
            make.right.equalToSuperview().offset(-27.fit)
            make.top.equalTo(describe.snp.bottom).offset(90.fit)
            make.height.equalTo(40.fit)
        }
        
        view.addSubview(giveMeYourMoneyView)
        giveMeYourMoneyView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(27.fit)
            make.right.equalToSuperview().offset(-27.fit)
            make.top.equalTo(describe.snp.bottom).offset(140.fit)
            make.height.equalTo(40.fit)
        }
        view.addSubview(userProtocal)
        userProtocal.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(27.fit)
            make.right.equalToSuperview().offset(-27.fit)
            make.top.equalTo(describe.snp.bottom).offset(190.fit)
            make.height.equalTo(40.fit)
        }
    }
    
    func configNav(){
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.title = "关于"
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
    }
    

    @objc func back() {
         self.navigationController?.popViewController(animated: true)
    }

}
