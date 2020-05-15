//
//  MineHeaderView.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/13.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit


struct MineHeaderViewModel {
    var img = UIImage(named: "mine_img_user")
    var bio = "一切都是最好的安排!"
    var userName = "CareFree"
}

class MineHeaderView: UIView {

    // 对外调用更新UI
    public func updateUI(with data:MineHeaderViewModel){
        self.userImg.image = data.img
        self.userBio.text = data.bio
    }
    
    
    lazy var userImg:UIImageView = {
       let vi = UIImageView()
        //vi.backgroundColor=UIColor.red
        vi.layer.cornerRadius = 50.fit
        vi.layer.masksToBounds = true
        vi.image = UIImage(named: "mine_img_user")
        vi.contentMode = .scaleAspectFill
        return vi
    }()
    
    lazy var userName:UILabel = {
       let label = UILabel()
        label.text = "CareFree"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 26.fit)
        return label
    }()
    lazy var idView:UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.init(r: 96, g: 114, b: 255)
        vi.cornerRadius = 14
        return vi
    }()
    lazy var userBio:UILabel = {
       let label = UILabel()
        //label.textColor = UIColor.white
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 16.fit)
        label.text = "一切都是最好的安排!"
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        
    
        addSubview(userImg)
        userImg.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(20.fit)
            make.centerY.equalTo(self)
            make.height.width.equalTo(100.fit)
        }
        
        addSubview(userName)
        userName.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(140.fit)
            make.bottom.equalTo(self.snp.centerY).offset(-5.fit)
            make.height.equalTo(40.fit)
            make.width.equalTo(150.fit)
        }
        
        addSubview(userBio)
        userBio.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(140.fit)
            make.top.equalTo(self.snp.centerY).offset(5.fit)
            make.width.equalTo(200.fit)
            make.height.equalTo(30.fit)
        }
    }
    


}
