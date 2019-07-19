//
//  RecommendCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/8.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import CollectionKit
import SnapKit

class homeRecommendCell: UIView {

    // 书本推荐
    lazy var bookIcon:UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "mine_set")
        return iv
    }()
    
    lazy var bookLabel:UILabel = {
        let label = UILabel()
            label.text = "图书"
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 14)
        return label
    }()
    
    lazy var bookView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.white
        view.cornerRadius = 8
        return view
    }()
    
    lazy var bookViewImg: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "home_book")
        return view
        
    }()
    
    lazy var bookViewTitle:UILabel = {
       let label = UILabel()
        label.text = "面纱"
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 15)
        return label
    }()
    
    lazy var bookViewDescrbe:UILabel = {
        let label = UILabel()
        label.text = "威廉·萨默塞特·毛姆"
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 11)
        label.textColor = UIColor.init(r: 179, g: 179, b: 179)
        return label
    }()
    
    // 音乐推荐
    lazy var musicIcon:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "mine_set")
        return iv
    }()
    
    lazy var musicLabel:UILabel = {
        let label = UILabel()
        label.text = "音乐"
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 14)
        return label
    }()
    
    lazy var musicView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.cornerRadius = 8
        return view
    }()
    
    lazy var musicViewImg: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "home_music")
        return view
        
    }()
    
    lazy var musicViewTitle:UILabel = {
        let label = UILabel()
        label.text = "嘻帖街"
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 15)
        return label
    }()
    
    lazy var musicViewDescrbe:UILabel = {
        let label = UILabel()
        label.text = "谢安琪"
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 11)
        label.textColor = UIColor.init(r: 179, g: 179, b: 179)
        return label
    }()
    
    // 壁纸
    lazy var wallIcon:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "mine_set")
        return iv
    }()
    
    lazy var wallLabel:UILabel = {
        let label = UILabel()
        label.text = "壁纸"
        return label
    }()
    
    lazy var wallView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.cornerRadius = 8
        return view
    }()
    
    lazy var wallViewImg: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "home_wall1")
        return view
        
    }()
    
    lazy var wallViewImg1: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "home_wall2")
        return view
        
    }()
    
    lazy var wallViewImg2: UIImageView = {
        let view = UIImageView()
         view.image = UIImage(named: "home_wall3")
        return view
        
    }()
    

    init() {
        super.init(frame: .zero)
        configUI()
        configShaow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(){
        
    }
    
    func configUI(){
        addSubview(bookIcon)
        addSubview(bookLabel)
        addSubview(bookView)
        bookView.addSubview(bookViewImg)
        bookView.addSubview(bookViewTitle)
        bookView.addSubview(bookViewDescrbe)
        
        addSubview(musicIcon)
        addSubview(musicLabel)
        addSubview(musicView)
        musicView.addSubview(musicViewImg)
        musicView.addSubview(musicViewTitle)
        musicView.addSubview(musicViewDescrbe)
        
        addSubview(wallIcon)
        addSubview(wallLabel)
        addSubview(wallView)
        wallView.addSubview(wallViewImg)
        wallView.addSubview(wallViewImg1)
        wallView.addSubview(wallViewImg2)
        
        bookIcon.snp.makeConstraints{(make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(20)
            make.width.height.equalTo(30)
        }
        bookLabel.snp.makeConstraints{(make) in
            make.left.equalTo(bookIcon.snp.right).offset(10)
            make.centerY.equalTo(bookIcon.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        bookView.snp.makeConstraints{(make) in
            make.top.equalTo(bookIcon.snp.bottom).offset(40)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.height.equalTo(120)
        }
        bookViewImg.snp.makeConstraints{(make) in
            make.top.equalTo(bookView.snp.top).offset(-20)
            make.bottom.equalTo(bookView.snp.bottom).offset(-15)
            make.left.equalTo(bookView.snp.left).offset(10)
            make.width.equalTo(80)
        }
        bookViewTitle.snp.makeConstraints{(make) in
            make.top.equalTo(bookView.snp.top).offset(5)
            make.left.equalTo(bookViewImg.snp.right).offset(20)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        bookViewDescrbe.snp.makeConstraints{(make) in
            make.top.equalTo(bookViewTitle.snp.bottom).offset(5)
            make.left.equalTo(bookViewImg.snp.right).offset(20)
            make.height.equalTo(25)
            make.width.equalTo(150)
        }
        
        // 音乐
        
        musicIcon.snp.makeConstraints{(make) in
            make.top.equalTo(bookView.snp.bottom).offset(10)
            make.left.equalTo(self).offset(20)
            make.width.height.equalTo(30)
        }
        musicLabel.snp.makeConstraints{(make) in
            make.left.equalTo(musicIcon.snp.right).offset(10)
            make.centerY.equalTo(musicIcon.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        musicView.snp.makeConstraints{(make) in
            make.top.equalTo(musicIcon.snp.bottom).offset(40)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.height.equalTo(120)
        }
        musicViewImg.snp.makeConstraints{(make) in
            make.top.equalTo(musicView.snp.top).offset(-20)
            make.bottom.equalTo(musicView.snp.bottom).offset(-15)
            make.left.equalTo(musicView.snp.left).offset(10)
            make.width.equalTo(80)
        }
        musicViewTitle.snp.makeConstraints{(make) in
            make.top.equalTo(musicView.snp.top).offset(5)
            make.left.equalTo(musicViewImg.snp.right).offset(20)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        musicViewDescrbe.snp.makeConstraints{(make) in
            make.top.equalTo(musicViewTitle.snp.bottom).offset(5)
            make.left.equalTo(musicViewImg.snp.right).offset(20)
            make.height.equalTo(25)
            make.width.equalTo(150)
        }
        
        wallIcon.snp.makeConstraints{(make) in
            make.top.equalTo(musicView.snp.bottom).offset(10)
            make.left.equalTo(self).offset(20)
            make.width.height.equalTo(30)
        }
        wallLabel.snp.makeConstraints{(make) in
            make.left.equalTo(wallIcon.snp.right).offset(10)
            make.centerY.equalTo(wallIcon.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        wallView.snp.makeConstraints{(make) in
            make.top.equalTo(wallIcon.snp.bottom).offset(40)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.height.equalTo(120)
        }
        wallViewImg.snp.makeConstraints{(make) in
            make.top.equalTo(wallView.snp.top).offset(-20)
            make.bottom.equalTo(wallView.snp.bottom).offset(-15)
            make.left.equalTo(wallView.snp.left).offset(34)
            make.width.equalTo(80)
        }
        
        wallViewImg1.snp.makeConstraints{(make) in
            make.top.equalTo(wallView.snp.top).offset(-20)
            make.bottom.equalTo(wallView.snp.bottom).offset(-15)
            make.left.equalTo(wallViewImg.snp.right).offset(34)
            make.width.equalTo(80)
        }
        
        wallViewImg2.snp.makeConstraints{(make) in
            make.top.equalTo(wallView.snp.top).offset(-20)
            make.bottom.equalTo(wallView.snp.bottom).offset(-15)
            make.left.equalTo(wallViewImg1.snp.right).offset(34)
            make.width.equalTo(80)
        }

    }
    
    func configShaow(){
        
    }
    
}
