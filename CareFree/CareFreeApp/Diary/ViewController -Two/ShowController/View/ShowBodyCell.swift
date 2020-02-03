//
//  ShowBodyCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/12/1.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class ShowBodyCell: UITableViewCell {
    lazy var backgruondView : UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.init(r: 56, g: 213, b: 214)
        vi.layer.cornerRadius = 15
        return vi
    }()
    
    lazy var time:UILabel = {
        let label = UILabel()
        label.text = "12点17分"
        label.font = UIFont(name: "PingFangSC-Regular", size: 13)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        return label
    }()
    lazy var content:UILabel = {
        let label = UILabel()
        label.text = "泡在了实验室一天，果然充实的学习还是最幸福的"
        label.font = UIFont(name: "PingFangSC-Regular", size: 16)
        label.textColor = UIColor.white
       // label.textColor = UIColor.init(r: 127, g: 127, b: 127)
        label.numberOfLines = 0
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        //configShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configUI(){
        addSubview(backgruondView)
        addSubview(time)
        addSubview(content)
        
        backgruondView.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(30.fit)
            make.right.equalTo(self).offset(-30.fit)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(130)
        }
        time.snp.makeConstraints{(make) in
            make.left.equalTo(backgruondView.snp.left).offset(20.fit)
            make.top.equalTo(backgruondView.snp.top).offset(10.fit)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        content.snp.makeConstraints{(make) in
            make.left.equalTo(backgruondView.snp.left).offset(20.fit)
            make.top.equalTo(time.snp.bottom).offset(20.fit)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
        
    }
    func updateUI(with data:NowDiaryModel){
        let date = data.date
        let timeForMatter = DateFormatter()
        timeForMatter.dateFormat = "HH点MM分"
        let timetext = timeForMatter.string(from: date)
        self.time.text = timetext
        self.content.text = data.content
        
        switch data.mode {
        case 26 ... 50:
            backgruondView.backgroundColor = happyColor
        case 0 ... 25:
            backgruondView.backgroundColor = calmColor
        case -25 ... -1:
            backgruondView.backgroundColor = sadColor
        case -50 ... -26:
            backgruondView.backgroundColor = repressioneColor
        default:
            break
        }
    }
    func configShadow(){
        //self.backgroundColor = .cyan
        self.layer.cornerRadius = 20
        //self.layer.borderWidth = 1.0
        //self.layer.borderColor = UIColor.clear.cgColor
        
        self.layer.shadowColor = UIColor.init(red: 110, green: 127, blue: 255, alpha: 0).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.6
        self.layer.masksToBounds = false
    }
}
