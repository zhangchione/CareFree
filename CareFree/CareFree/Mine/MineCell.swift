//
//  MineCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/10.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import Kingfisher
import CollectionKit

class MineCell: UIView {

    lazy var userImg:UIImageView = {
       let vi = UIImageView()
        //vi.backgroundColor=UIColor.red
        vi.cornerRadius = 45
        vi.image = UIImage(named: "mine_user")
        return vi
    }()
    lazy var userName:UILabel = {
       let label = UILabel()
        label.text = "Jeffrey"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 26)
        return label
    }()
    lazy var idView:UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.init(r: 96, g: 114, b: 255)
        vi.cornerRadius = 14
        return vi
    }()
    lazy var id:UILabel = {
       let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 12)
        label.text = "ID：4609"
        return label
    }()
    
    lazy var oneBackView : UIView = {
       let vi = UIView()
        return vi
    }()
    
    lazy var emotionView:UIView = {
       let vi = UIView()
        vi.cornerRadius = 25
        vi.backgroundColor = UIColor.gray
        return vi
    }()
    lazy var emotionLabel:UILabel  = {
       let label = UILabel ()
        label.textColor = UIColor.white
        label.text = "情绪值"
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 14)
        return label
    }()
    lazy var favIco:UIImageView = {
       let vi = UIImageView()
        vi.image = UIImage(named: "favor")
        return vi
    }()
    
    lazy var bottomView:UIView = {
        let vi = UIView()
        vi.cornerRadius = 8
        vi.backgroundColor = UIColor.white
        return vi
    }()
    lazy var topOneView:UIView  = {
       let vi = UIView()
        vi.cornerRadius = 20
        vi.backgroundColor = UIColor.init(r: 255, g: 135, b: 90)
        return vi
    }()
    lazy var topTwoView:UIView = {
        let vi = UIView()
        vi.cornerRadius = 8
        vi.backgroundColor = UIColor.init(r: 255, g: 135, b: 90)
        return vi
    }()
    
    lazy var emotionValue:UILabel = {
       let label = UILabel()
        label.textColor = UIColor.white
        label.text = "36"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 16)
        return label
    }()
    lazy var lineView:UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.white
        return vi
    }()
    lazy var pointLabel : UILabel = {
       let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Point"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 12)
        return label
    }()
    
    
    // 日记统计
    
    lazy var diaryView:UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.white
        vi.cornerRadius = 25
        return vi
    }()
    lazy var diaryLabel:UILabel  = {
        let label = UILabel ()
        label.textColor = UIColor.black
        label.text = "日记统计"
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 14)
        return label
    }()
    lazy var diaryIco:UIImageView = {
        let vi = UIImageView()
        vi.image = UIImage(named: "mine_diary")
        return vi
    }()
    lazy var diaryHeadValue:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "17"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 16)
        return label
    }()
    lazy var lineDiaryHeadView:UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.black
        return vi
    }()
    lazy var diaryHeadLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(r: 85, g: 85, b: 85)
        label.text = "日记"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 12)
        return label
    }()
    lazy var diaryBackValue:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "37"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 16)
        return label
    }()
    lazy var lineDiaryBackView:UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.black
        return vi
    }()
    lazy var diaryBackLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(r: 85, g: 85, b: 85)
        label.text = "此刻"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 12)
        return label
    }()
    
    // 废纸篓
    
    lazy var trashView:UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.white
        vi.cornerRadius = 25
        return vi
    }()
    lazy var trashLabel:UILabel  = {
        let label = UILabel ()
        label.textColor = UIColor.black
        label.text = "废纸篓"
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 14)
        return label
    }()
    lazy var trashIco:UIImageView = {
        let vi = UIImageView()
        vi.image = UIImage(named: "mine_trash")
        return vi
    }()
    lazy var trashValue:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "6"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 16)
        return label
    }()
    lazy var lineTrashView:UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.black
        return vi
    }()
    lazy var photoLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(r: 85, g: 85, b: 85)
        label.text = "照片"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 12)
        return label
    }()
    
    
    // 心情报表
    
    lazy var moodView:UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.white
        vi.cornerRadius = 25
        return vi
    }()
    lazy var moodLabel:UILabel  = {
        let label = UILabel ()
        label.textColor = UIColor.black
        label.text = "心情报表"
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 14)
        return label
    }()
    lazy var moodIco:UIImageView = {
        let vi = UIImageView()
        vi.image = UIImage(named: "mine_chat")
        return vi
    }()
    // 心情柱状图
    let dataHeadSource = ArrayDataSource(data:[emotionChartModel]())
    lazy var  collectionView: CollectionView = {
        let cv = CollectionView()
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    lazy var moodValue:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "7"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 16)
        return label
    }()
    lazy var lineMoodView:UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.black
        return vi
    }()
    lazy var moodDayLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(r: 85, g: 85, b: 85)
        label.text = "天"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 12)
        return label
    }()
    
    // 设置
    lazy var setView: UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.white
        vi.cornerRadius = 25
        return vi
    }()
    lazy var setLabel:UILabel  = {
        let label = UILabel ()
        label.textColor = UIColor.black
        label.text = "设置"
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 14)
        return label
    }()
    lazy var setIco:UIImageView = {
        let vi = UIImageView()
        vi.image = UIImage(named: "mine_set")
        return vi
    }()
    
    init() {
        super.init(frame: .zero)
        
        configUI()
        configShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(with data: MineModel){
        let urlTitleImage = URL(string: data.head_pic)
        self.userImg.kf.setImage(with: urlTitleImage)
        self.userName.text = data.username
        self.id.text = "ID: " + data.id
        self.emotionValue.text = data.mode
        self.diaryHeadValue.text = data.day_notes
        self.diaryBackValue.text = data.now_notes
        
        var model = emotionChartModel()
        for index in 0 ..< data.mode_value.count {
            if data.mode_value[index] > 0 {
                model.bottomValue = 0
                model.topValue = data.mode_value[index]
                if data.mode_value[index] >= 25 {
                    model.color =  UIColor.init(r: 57, g: 210, b: 214)
                }
                else {
                    model.color = UIColor.init(r: 100, g: 175, b: 232)
                }
            }
            else {
                model.bottomValue = -data.mode_value[index]
                model.topValue = 0
                if data.mode_value[index] <= -25 {
                    model.color = UIColor.init(r: 31, g: 69, b: 99)
                }
                else {
                    model.color = UIColor.init(r: 155, g: 133, b: 255)
                }
            }
            model.day = String(index + 1)
            self.dataHeadSource.data.append(model)
        }
        self.collectionView.reloadData()
        
    }
    
    func configUI(){
        
        addSubview(oneBackView)
        addSubview(userImg)
        userImg.cornerRadius = 45
        addSubview(userName)
        addSubview(idView)
        idView.addSubview(id)
        addSubview(emotionView)
        emotionView.addSubview(oneBackView)
        emotionView.addSubview(emotionLabel)
        emotionView.addSubview(favIco)
        emotionView.addSubview(bottomView)
        emotionView.addSubview(topOneView)
        emotionView.addSubview(topTwoView)
        emotionView.addSubview(emotionValue)
        emotionView.addSubview(lineView)
        emotionView.addSubview(pointLabel)


        
        userImg.snp.makeConstraints{(make) in
            make.left.top.equalTo(self).offset(25)
            make.height.width.equalTo(90)
        }
        userName.snp.makeConstraints{(make) in
            make.left.equalTo(userImg.snp.right).offset(30)
            make.top.equalTo(self).offset(30)
            make.height.equalTo(30)
            make.width.equalTo(120)
        }
        idView.snp.makeConstraints{(make) in
            make.left.equalTo(userImg.snp.right).offset(30)
            make.top.equalTo(userName.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(70)
        }
        id.snp.makeConstraints{(make) in
            make.left.equalTo(idView.snp.left).offset(9)
            make.top.equalTo(idView.snp.top).offset(0)
            make.width.equalTo(70)
            make.height.equalTo(30)
            
        }
        
        // 情绪值
        emotionView.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(22)
            make.top.equalTo(userImg.snp.bottom).offset(35)
            make.width.equalTo(175)
            make.height.equalTo(215)
        }
        oneBackView.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(22)
            make.top.equalTo(userImg.snp.bottom).offset(35)
            make.width.equalTo(175)
            make.height.equalTo(215)
        }
        emotionLabel.snp.makeConstraints{(make) in
            make.left.equalTo(emotionView.snp.left).offset(20)
            make.top.equalTo(emotionView.snp.top).offset(30)
            make.width.equalTo(42)
            make.height.equalTo(22)
        }
        favIco.snp.makeConstraints{(make) in
            make.right.equalTo(emotionView.snp.right).offset(-20)
            make.centerY.equalTo(emotionLabel.snp.centerY)
            make.width.height.equalTo(20)
        }
        bottomView.snp.makeConstraints{(make) in
            make.centerX.equalTo(emotionLabel.snp.centerX)
            make.top.equalTo(emotionLabel.snp.bottom).offset(30)
            make.width.equalTo(40)
            make.height.equalTo(105)
        }

        topTwoView.snp.makeConstraints{(make) in
            make.centerX.equalTo(emotionLabel.snp.centerX)
            make.bottom.equalTo(bottomView.snp.bottom).offset(0)
            make.width.equalTo(40)
            make.height.equalTo(60)
        }
        topOneView.snp.makeConstraints{(make) in
            make.centerX.equalTo(emotionLabel.snp.centerX)
            make.bottom.equalTo(topTwoView.snp.top).offset(30)
            make.width.equalTo(40)
            make.height.equalTo(50)
        }
        
        emotionValue.snp.makeConstraints{(make) in
            make.right.equalTo(emotionView.snp.right).offset(-20)
            make.centerY.equalTo(bottomView.snp.centerY).offset(10)
            make.width.equalTo(23)
            make.height.equalTo(20)
        }
        lineView.snp.makeConstraints{(make) in
            make.right.equalTo(emotionView.snp.right).offset(-28)
            make.top.equalTo(emotionValue.snp.bottom).offset(3)
            make.width.equalTo(14)
            make.height.equalTo(1)
        }
        pointLabel.snp.makeConstraints{(make) in
            make.right.equalTo(emotionView.snp.right).offset(-20)
            make.top.equalTo(lineView.snp.bottom).offset(3)
            make.width.equalTo(38)
            make.height.equalTo(20)
        }
        
        // 日记统计
        addSubview(diaryView)
        diaryView.addSubview(diaryLabel)
        diaryView.addSubview(diaryIco)
        diaryView.addSubview(diaryHeadValue)
        diaryView.addSubview(lineDiaryHeadView)
        diaryView.addSubview(diaryHeadLabel)
        

        
        diaryView.snp.makeConstraints{(make) in
            make.right.equalTo(self).offset(-22)
            make.centerY.equalTo(emotionView.snp.centerY)
            make.width.equalTo(175)
            make.height.equalTo(215)
        }
        diaryLabel.snp.makeConstraints{(make) in
            make.left.equalTo(diaryView.snp.left).offset(20)
            make.top.equalTo(diaryView.snp.top).offset(30)
            make.width.equalTo(60)
            make.height.equalTo(22)
        }
        diaryIco.snp.makeConstraints{(make) in
            make.right.equalTo(diaryView.snp.right).offset(-20)
            make.centerY.equalTo(diaryLabel.snp.centerY)
            make.width.height.equalTo(20)
        }
        
        diaryHeadValue.snp.makeConstraints{(make) in
            make.left.equalTo(diaryView.snp.left).offset(20)
            make.centerY.equalTo(emotionValue.snp.centerY)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        lineDiaryHeadView.snp.makeConstraints{(make) in
            make.left.equalTo(diaryView.snp.left).offset(20)
            make.top.equalTo(diaryHeadValue.snp.bottom).offset(3)
            make.width.equalTo(14)
            make.height.equalTo(1)
        }
        diaryHeadLabel.snp.makeConstraints{(make) in
            make.left.equalTo(diaryView.snp.left).offset(20)
            make.top.equalTo(lineDiaryHeadView.snp.bottom).offset(3)
            make.width.equalTo(38)
            make.height.equalTo(20)
        }
        diaryView.addSubview(diaryBackValue)
        diaryView.addSubview(lineDiaryBackView)
        diaryView.addSubview(diaryBackLabel)
        diaryBackValue.snp.makeConstraints{(make) in
            make.right.equalTo(diaryView.snp.right).offset(-40)
            make.centerY.equalTo(emotionValue.snp.centerY)
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
        lineDiaryBackView.snp.makeConstraints{(make) in
            make.right.equalTo(diaryView.snp.right).offset(-56)
            make.top.equalTo(diaryBackValue.snp.bottom).offset(3)
            make.width.equalTo(14)
            make.height.equalTo(1)
        }
        diaryBackLabel.snp.makeConstraints{(make) in
            make.right.equalTo(diaryView.snp.right).offset(-40)
            make.top.equalTo(lineDiaryBackView.snp.bottom).offset(3)
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
        
        
        // 废纸篓
        addSubview(trashView)
        trashView.addSubview(trashLabel)
        trashView.addSubview(trashIco)
        trashView.addSubview(trashValue)
        trashView.addSubview(lineTrashView)
        trashView.addSubview(photoLabel)
        trashView.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(22)
            make.top.equalTo(emotionView.snp.bottom).offset(20)
            make.width.equalTo(175)
            make.height.equalTo(175)
        }
        trashLabel.snp.makeConstraints{(make) in
            make.left.equalTo(trashView.snp.left).offset(20)
            make.top.equalTo(trashView.snp.top).offset(30)
            make.width.equalTo(42)
            make.height.equalTo(22)
        }
        trashIco.snp.makeConstraints{(make) in
            make.right.equalTo(trashView.snp.right).offset(-20)
            make.centerY.equalTo(trashLabel.snp.centerY)
            make.width.height.equalTo(20)
        }
        
        trashValue.snp.makeConstraints{(make) in
            make.left.equalTo(trashView.snp.left).offset(20)
            make.top.equalTo(trashLabel.snp.bottom).offset(50)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        lineTrashView.snp.makeConstraints{(make) in
            make.left.equalTo(trashView.snp.left).offset(20)
            make.top.equalTo(trashValue.snp.bottom).offset(3)
            make.width.equalTo(14)
            make.height.equalTo(1)
        }
        photoLabel.snp.makeConstraints{(make) in
            make.left.equalTo(trashView.snp.left).offset(20)
            make.top.equalTo(lineTrashView.snp.bottom).offset(3)
            make.width.equalTo(38)
            make.height.equalTo(20)
        }
        
        // 心情报表
        addSubview(moodView)
        moodView.addSubview(moodLabel)
        moodView.addSubview(moodIco)
        moodView.addSubview(moodValue)
        moodView.addSubview(lineMoodView)
        moodView.addSubview(moodDayLabel)
        moodView.addSubview(collectionView)
        
        moodView.snp.makeConstraints{(make) in
            make.right.equalTo(self).offset(-22)
            make.top.equalTo(diaryView.snp.bottom).offset(20)
            make.width.equalTo(175)
            make.height.equalTo(215)
        }
        moodLabel.snp.makeConstraints{(make) in
            make.left.equalTo(moodView.snp.left).offset(20)
            make.top.equalTo(moodView.snp.top).offset(30)
            make.width.equalTo(70)
            make.height.equalTo(22)
        }
        moodIco.snp.makeConstraints{(make) in
            make.right.equalTo(moodView.snp.right).offset(-20)
            make.centerY.equalTo(moodLabel.snp.centerY)
            make.width.height.equalTo(20)
        }
        
        // 心情图
        collectionView.snp.makeConstraints{(make) in
            make.centerX.equalTo(moodView.snp.centerX)
            make.centerY.equalTo(moodView.snp.centerY).offset(5)
            make.width.equalTo(150)
            make.height.equalTo(100)
        }
        let viewHeadSource = ClosureViewSource(viewUpdater: {(view:MineChartCell,data:emotionChartModel,index:Int) in
            view.updateUI(with: data)
//            view.backgroundColor = UIColor.yellow
        })
        let sizeHeadSource = {(index:Int,data:emotionChartModel,collectionSize:CGSize) ->CGSize in
            return CGSize(width: 15, height: 90)
        }
        
        let provider = BasicProvider(
            dataSource: dataHeadSource,
            viewSource: viewHeadSource,
            sizeSource:sizeHeadSource
        )
        provider.layout = FlowLayout(spacing: 5)
        collectionView.provider = provider
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        moodValue.snp.makeConstraints{(make) in
            make.left.equalTo(moodView.snp.left).offset(20)
            make.top.equalTo(moodLabel.snp.bottom).offset(100)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        lineMoodView.snp.makeConstraints{(make) in
            make.left.equalTo(moodView.snp.left).offset(20)
            make.top.equalTo(moodValue.snp.bottom).offset(3)
            make.width.equalTo(10)
            make.height.equalTo(1)
        }
        moodDayLabel.snp.makeConstraints{(make) in
            make.left.equalTo(moodView.snp.left).offset(20)
            make.top.equalTo(lineMoodView.snp.bottom).offset(3)
            make.width.equalTo(38)
            make.height.equalTo(20)
        }
        // 设置
        addSubview(setView)
        setView.addSubview(setLabel)
        setView.addSubview(setIco)
        setView.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(22)
            make.top.equalTo(trashView.snp.bottom).offset(20)
            make.width.equalTo(175)
            make.height.equalTo(185)
        }
        setLabel.snp.makeConstraints{(make) in
            make.left.equalTo(setView.snp.left).offset(20)
            make.top.equalTo(setView.snp.top).offset(30)
            make.width.equalTo(42)
            make.height.equalTo(22)
        }
        setIco.snp.makeConstraints{(make) in
            make.right.equalTo(setView.snp.right).offset(-20)
            make.centerY.equalTo(setLabel.snp.centerY)
            make.width.height.equalTo(20)
        }
    }
    func configShadow(){
        
    }
}
