//
//  NoteTypeCell.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/16.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit

struct NoteTypeModel {
    var gradeColor = UIColor.white
    var isSelected = false
}

class NoteTypeCell: UICollectionViewCell {
    
    
    public func updateUI(with data:NoteTypeModel){
        self.backView.backgroundColor = data.gradeColor
        if data.isSelected  {
            self.selecteIcon.alpha = 1
        }else {
            self.selecteIcon.alpha = 0
        }
    }
    
    lazy var backView: UIView = {
        let vi = UIView()
        return vi
    }()
    
    lazy var selecteIcon:UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "mine_icon_fav")
        return img
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configShadow()
        configUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configShadow(){
        self.backView.backgroundColor = .white
        self.backView.layer.cornerRadius = 5.fit
        self.backView.layer.masksToBounds = false
        self.backView.layer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        self.backView.layer.shadowOffset = CGSize(width: 0, height: 4.fit)
        self.backView.layer.shadowOpacity = 1
        self.backView.layer.shadowRadius = 5.fit
    }
    
    func configUI(){
        addSubview(backView)
        backView.snp.makeConstraints{(make) in
            make.left.top.equalTo(self).offset(5.fit)
            make.right.bottom.equalTo(self).offset(-5.fit)

        }
        addSubview(selecteIcon)
        selecteIcon.snp.makeConstraints{(make) in
            make.left.top.equalTo(self).offset(10.fit)
            make.right.bottom.equalTo(self).offset(-10.fit)

        }
    }
    
    
}
