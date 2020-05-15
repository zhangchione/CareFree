//
//  SetViewCell.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/14.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit


enum SetViewCellType {
    case image(UIImage)
    case bio(String)
    case none
}

class SetViewCell: UITableViewCell {

    public func updateUI(with text:String,type:SetViewCellType){
        self.titleLabel.text = text
        switch type {
        case .image(let image):
            self.userImg.image = image
                configUserImg()
        case .bio(let bio):
            self.userBio.text = bio
                configBio()
        case .none:
            hiddenOther()
        }
    }
    
    
    lazy var userImg:UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 5.fit
        img.clipsToBounds = true
        img.image = UIImage(named: "椭圆形(1)")
        img.contentMode = .scaleAspectFill
         return img
     }()
    
    lazy var userBio: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13.fit)
        label.text = "李一一"
        label.textColor = UIColor.gray
        label.textAlignment = .right
        return label
    }()
    

    
    
    lazy var backView: UIView = {
       let vi = UIView()
        vi.backgroundColor = .white
        return  vi
    }()
    
    // 用户名
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.fit)
        label.text = "李一一"
        label.textColor = UIColor.black
        return label
    }()
    
    
    lazy var rightIcon:UIImageView = {
        let img = UIImageView()
         img.image = UIImage(named: "mine_icon_setright")
         return img
     }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    private func configUserImg(){
        self.userImg.alpha = 1
        userImg.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-55.fit)
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(40.fit)
        }
    }
    
    private func configBio(){
        self.userBio.alpha = 1
        userBio.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-55.fit)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(20.fit)
            make.width.equalTo(150.fit)
        }
    }
    
    private func hiddenOther(){
        self.userImg.alpha = 0
        self.userBio.alpha = 0
    }
    
    private func configUI(){
//        addSubview(backView)
//        backView.snp.makeConstraints { (make) in
//            make.top.left.equalTo(self).offset(5.fit)
//            make.bottom.right.equalTo(self).offset(-5.fit)
//        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(30.fit)
            make.centerY.equalTo(self)
            make.height.equalTo(20.fit)
            make.width.equalTo(100.fit)
        }
        
        addSubview(rightIcon)
        rightIcon.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-30.fit)
             make.centerY.equalTo(self)
            make.height.equalTo(20.fit)
            make.width.equalTo(15.fit)
        }
        addSubview(userBio)
        addSubview(userImg)
    }

}
