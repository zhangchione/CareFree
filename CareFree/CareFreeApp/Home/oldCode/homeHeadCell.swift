//
//  homeHeadCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/8.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import CollectionKit
import SnapKit


class homeHeadCell: UIView {
    
    
    
    lazy var topBackgroundView:UIView = {
        let vi = UIView()
        vi.layer.cornerRadius = 10
        return vi
    }()

    lazy var topView:UIView = {
       let vi = UIView()
        //vi.backgroundColor = .green
        vi.layer.cornerRadius = 10
        return vi
    }()
    lazy var line:UIView = {
        let vi = UIView()
        vi.backgroundColor = .white
        return vi
    }()
    
    // 心情圆
    let progressView: YQCircleProgreeView = {
        let progressView = YQCircleProgreeView()
        
        // 粗细
        progressView.borderWidth = 10
        // 动画时间
        progressView.animationDuration = 0.5
        return progressView
    }()
    
    
    lazy var emotionValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textColor = .white
        label.text = "36"
        return label
    }()
    
    lazy var favImg:UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "hone_fav")
        return img
    }()
    
    lazy var valueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.text = "当前情绪值"
        return label
    }()
    
    lazy var nowEmotionValue:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textColor = .white
        label.text = "36"
        return label
    }()
    
    // 情绪报表
    lazy var chartView:UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.white
        vi.layer.cornerRadius = 15
        return vi
    }()
    
    lazy var chartLabel :UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "情绪报表"
        return label
    }()
    
    lazy var chartMoreBtn:UIButton = {
       let btn = UIButton()
        btn.setTitle("更多", for: .normal)
        btn.setTitleColor(UIColor.init(r: 73, g: 73, b: 73), for: .normal)
        return btn
    }()
    
    // 情绪图
    lazy var firstLabel : UILabel = {
       let label = UILabel()
        label.text = "50"
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 8)
        label.textColor = UIColor.init(r: 138, g: 138, b: 138)
        return label
    }()
    lazy  var firstLine: UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.init(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 0.2)
        return vi
    }()
    
    lazy var secendLabel : UILabel = {
        let label = UILabel()
        label.text = "25"
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 8)
        label.textColor = UIColor.init(r: 138, g: 138, b: 138)
        return label
    }()
    lazy  var secendLine: UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.init(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 0.2)
        return vi
    }()
    
    lazy var thirdLabel : UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 8)
        label.textColor = UIColor.init(r: 138, g: 138, b: 138)
        return label
    }()
    lazy  var thirdTopLine: UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.init(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 0.2)
        return vi
    }()
    lazy  var thirdBottomLine: UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.init(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 0.2)
        return vi
    }()
    
    lazy var fourthLabel : UILabel = {
        let label = UILabel()
        label.text = "-25"
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 8)
        label.textColor = UIColor.init(r: 138, g: 138, b: 138)
        return label
    }()
    lazy  var fourthLine: UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.init(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 0.2)
        return vi
    }()
    
    lazy var fivethLabel : UILabel = {
        let label = UILabel()
        label.text = "-50"
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 8)
        label.textColor = UIColor.init(r: 138, g: 138, b: 138)
        return label
    }()
    lazy  var fivethLine: UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.init(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 0.2)
        return vi
    }()
    
    let dataHeadSource = ArrayDataSource(data:[emotionChartModel]())
    lazy var  collectionView: CollectionView = {
        let cv = CollectionView()
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    
    
    lazy var recommendLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.init(r: 103, g: 103, b: 103)
        label.text = "最近一周情绪波动较大,需要适当调整情绪"
        return label
    }()
    
    // 底部文字
    lazy var todayRecommend:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.text = "今日推荐"
        return label
    }()
    lazy var todayRecommendMoreBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("更多", for: .normal)
        btn.setTitleColor(UIColor.init(r: 73, g: 73, b: 73), for: .normal)
        return btn
    }()
    
    
    init() {
        super.init(frame: .zero)
        configUI()
        configShaow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configUI(){

        addSubview(topView)
        topView.addSubview(topBackgroundView)
        topView.addSubview(line)
        topView.addSubview(emotionValue)
        topView.addSubview(progressView)
        topView.addSubview(favImg)
        topView.addSubview(valueLabel)
        topView.addSubview(nowEmotionValue)
        
        
        
        addSubview(chartView)
        chartView.addSubview(chartLabel)
        chartView.addSubview(chartMoreBtn)
        chartView.addSubview(recommendLabel)
        
        chartView.addSubview(firstLabel)
        chartView.addSubview(firstLine)
        
        chartView.addSubview(secendLabel)
        chartView.addSubview(secendLine)
        
        chartView.addSubview(thirdLabel)
        chartView.addSubview(thirdTopLine)
        chartView.addSubview(thirdBottomLine)
        
        chartView.addSubview(fourthLabel)
        chartView.addSubview(fourthLine)
        
        chartView.addSubview(fivethLabel)
        chartView.addSubview(fivethLine)
        
        chartView.addSubview(collectionView)
        
        //collectionView.backgroundColor = UIColor.green
//        let viewHeadSource = ClosureViewSource(viewUpdater: {(view:EmotionChartCell,data:emotionChartModel,index:Int) in
//            view.updateUI(with: data)
//            //view.backgroundColor = UIColor.yellow
//        })
//        let sizeHeadSource = {(index:Int,data:emotionChartModel,collectionSize:CGSize) ->CGSize in
//            return CGSize(width: 33, height: 160)
//        }
//        
//        let provider = BasicProvider(
//            dataSource: dataHeadSource,
//            viewSource: viewHeadSource,
//            sizeSource:sizeHeadSource
//        )
//        provider.layout = FlowLayout(spacing: 10)
//        collectionView.provider = provider
//        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
//        
        
        
        addSubview(todayRecommend)
        addSubview(todayRecommendMoreBtn)
        
        
        
        topView.snp.makeConstraints{(make) in
            make.left.top.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.height.equalTo(200)
        }
        topBackgroundView.snp.makeConstraints{(make) in
            make.left.right.top.bottom.equalTo(topView)
        }
        line.snp.makeConstraints{(make) in
            make.left.equalTo(topView.snp.left).offset(10)
            make.centerY.equalTo(topView.snp.centerY)
            make.height.equalTo(120)
            make.width.equalTo(1.5)
        }
        progressView.setProgress(Double(0.72), animation: true)
        progressView.backgroundImage = nil
        progressView.defaultBorderColor = .white
        progressView.layer.shadowColor = UIColor.lightGray.cgColor
        progressView.layer.shadowRadius = 5
        progressView.layer.shadowOpacity = 0.8
        progressView.snp.makeConstraints{(make) in
            make.left.equalTo(line).offset(30)
            make.centerY.equalTo(line.snp.centerY)
            make.height.width.equalTo(100)
        }
        emotionValue.snp.makeConstraints{(make) in
            make.left.equalTo(line).offset(60)
            make.centerY.equalTo(line.snp.centerY)
            make.height.width.equalTo(40)
        }
        favImg.snp.makeConstraints{(make) in
            make.right.equalTo(topView.snp.right).offset(-40)
            make.top.equalTo(line.snp.top).offset(5)
            make.height.width.equalTo(20)
        }
        valueLabel.snp.makeConstraints{(make) in
            make.right.equalTo(topView.snp.right).offset(-40)
            make.top.equalTo(favImg.snp.bottom).offset(5)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        nowEmotionValue.snp.makeConstraints{(make) in
            make.right.equalTo(topView.snp.right).offset(-40)
            make.top.equalTo(valueLabel.snp.bottom).offset(5)
            make.width.height.equalTo(40)
        }
        
        
        // 中间View
        chartView.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.top.equalTo(topView.snp.bottom).offset(25)
            make.height.equalTo(300)
        }
        chartLabel.snp.makeConstraints{(make) in
            make.left.equalTo(chartView.snp.left).offset(10)
            make.top.equalTo(chartView.snp.top).offset(15)
            make.width.equalTo(100)
            make.height.equalTo(35)
        }
        
        firstLabel.snp.makeConstraints{(make) in
            make.left.equalTo(chartView.snp.left).offset(20)
            make.top.equalTo(chartLabel.snp.bottom).offset(15)
            make.width.height.equalTo(10)
        }
        firstLine.snp.makeConstraints{(make) in
            make.left.equalTo(firstLabel.snp.right).offset(2)
            make.centerY.equalTo(firstLabel.snp.centerY)
            make.right.equalTo(chartView.snp.right).offset(-20)
            make.height.equalTo(1)
        }
        
        secendLabel.snp.makeConstraints{(make) in
            make.left.equalTo(chartView.snp.left).offset(20)
            make.top.equalTo(firstLabel.snp.bottom).offset(30)
            make.width.height.equalTo(10)
        }
        secendLine.snp.makeConstraints{(make) in
            make.left.equalTo(secendLabel.snp.right).offset(2)
            make.centerY.equalTo(secendLabel.snp.centerY)
            make.right.equalTo(chartView.snp.right).offset(-20)
            make.height.equalTo(1)
        }
        
        thirdLabel.snp.makeConstraints{(make) in
            make.left.equalTo(chartView.snp.left).offset(20)
            make.top.equalTo(secendLabel.snp.bottom).offset(30)
            make.width.height.equalTo(10)
        }
        thirdTopLine.snp.makeConstraints{(make) in
            make.left.equalTo(thirdLabel.snp.right).offset(2)
            make.centerY.equalTo(thirdLabel.snp.top).offset(-2)
            make.right.equalTo(chartView.snp.right).offset(-20)
            make.height.equalTo(1)
        }
        thirdBottomLine.snp.makeConstraints{(make) in
            make.left.equalTo(thirdLabel.snp.right).offset(2)
            make.centerY.equalTo(thirdLabel.snp.bottom).offset(2)
            make.right.equalTo(chartView.snp.right).offset(-20)
            make.height.equalTo(1)
        }
        
        fourthLabel.snp.makeConstraints{(make) in
            make.left.equalTo(chartView.snp.left).offset(15)
            make.top.equalTo(thirdLabel.snp.bottom).offset(30)
            make.height.equalTo(10)
            make.width.equalTo(15)
        }
        fourthLine.snp.makeConstraints{(make) in
            make.left.equalTo(fourthLabel.snp.right).offset(2)
            make.centerY.equalTo(fourthLabel.snp.centerY)
            make.right.equalTo(chartView.snp.right).offset(-20)
            make.height.equalTo(1)
        }
        
        fivethLabel.snp.makeConstraints{(make) in
            make.left.equalTo(chartView.snp.left).offset(15)
            make.top.equalTo(fourthLabel.snp.bottom).offset(30)
            make.width.height.equalTo(15)
            make.height.equalTo(10)
        }
        fivethLine.snp.makeConstraints{(make) in
            make.left.equalTo(fivethLabel.snp.right).offset(2)
            make.centerY.equalTo(fivethLabel.snp.centerY)
            make.right.equalTo(chartView.snp.right).offset(-20)
            make.height.equalTo(1)
        }
        
        chartMoreBtn.snp.makeConstraints{(make) in
            make.right.equalTo(chartView.snp.right).offset(-20)
            make.centerY.equalTo(chartLabel.snp.centerY)
            make.width.equalTo(40)
            make.height.equalTo(25)
        }
        recommendLabel.snp.makeConstraints{(make) in
            make.bottom.equalTo(chartView.snp.bottom).offset(-15)
            make.left.equalTo(chartView.snp.left).offset(10)
            make.right.equalTo(chartView.snp.right).offset(-10)
        }
        
        collectionView.snp.makeConstraints{(make) in
            make.left.equalTo(firstLine.snp.left).offset(10)
            make.top.equalTo( firstLine .snp.top).offset(0)
            make.bottom.equalTo(fivethLine.snp.bottom).offset(0)
            make.right.equalTo(firstLine.snp.right).offset(0)
        }
        
        // 今日推荐
        todayRecommend.snp.makeConstraints{(make) in
            make.top.equalTo(chartView.snp.bottom).offset(30)
            make.left.equalTo(self).offset(15)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        todayRecommendMoreBtn.snp.makeConstraints{(make) in
            make.centerY.equalTo(todayRecommend.snp.centerY)
            make.right.equalTo(self).offset(-20)
            make.width.equalTo(50)
            make.height.equalTo(25)
        }
        
    }
    func configShaow(){
        
    }
    func updateUI(){
        
    }
}
