//
//  CFHomeCharyCell.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/14.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit
import CollectionKit
import SnapKit

let recommendTips = "记录下美好的每一天，拥有好心情吧~"



class CFHomeChartCell: UICollectionViewCell {
    
    public func updateUI(with data:[EmotionChartModel],tips:String = recommendTips){
        self.recommendLabel.text = tips
        self.dataHeadSource.data = data
        self.collectionView.reloadData()
    }
    
    // 情绪报表
    lazy var backView:UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.white
        vi.layer.cornerRadius = 15.fit
        return vi
    }()
    
    lazy var chartLabel :UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.fit)
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
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 10.fit)
        label.textColor = UIColor.init(r: 138, g: 138, b: 138)
        label.textAlignment = .right
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
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 10.fit)
        label.textColor = UIColor.init(r: 138, g: 138, b: 138)
        label.textAlignment = .right
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
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 10.fit)
        label.textColor = UIColor.init(r: 138, g: 138, b: 138)
        label.textAlignment = .right
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
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 10.fit)
        label.textColor = UIColor.init(r: 138, g: 138, b: 138)
        label.textAlignment = .right
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
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 10.fit)
        label.textColor = UIColor.init(r: 138, g: 138, b: 138)
        label.textAlignment = .right
        return label
    }()
    lazy  var fivethLine: UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.init(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 0.2)
        return vi
    }()
    
    let dataHeadSource = ArrayDataSource(data:[EmotionChartModel]())
    lazy var  collectionView: CollectionView = {
        let cv = CollectionView()
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    
    
    lazy var recommendLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.fit)
        label.textColor = UIColor.init(r: 103, g: 103, b: 103)
        label.text = recommendTips
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configShadow()
        configUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configUI(){
        addSubview(backView)
        addSubview(chartLabel)
        addSubview(chartMoreBtn)
        addSubview(recommendLabel)
        
        addSubview(firstLabel)
        addSubview(firstLine)
        
        addSubview(secendLabel)
        addSubview(secendLine)
        
        addSubview(thirdLabel)
        addSubview(thirdTopLine)
        addSubview(thirdBottomLine)
        
        addSubview(fourthLabel)
        addSubview(fourthLine)
        
        addSubview(fivethLabel)
        addSubview(fivethLine)
        
        addSubview(collectionView)
        
        //collectionView.backgroundColor = UIColor.green
        let viewHeadSource = ClosureViewSource(viewUpdater: {(view:EmotionChartCell,data:EmotionChartModel,index:Int) in
            view.updateUI(with: data)
            //view.backgroundColor = UIColor.yellow
        })
        let sizeHeadSource = {(index:Int,data:EmotionChartModel,collectionSize:CGSize) ->CGSize in
            return CGSize(width: 30.fit, height: 210.fit)
        }
        
        let provider = BasicProvider(
            dataSource: dataHeadSource,
            viewSource: viewHeadSource,
            sizeSource:sizeHeadSource
        )
        provider.layout = FlowLayout(spacing: 15.fit)
        collectionView.provider = provider
        //collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        setConstrait()
    }
    private func configShadow(){
        self.backView.backgroundColor = .white
        self.backView.layer.cornerRadius = 15.fit
        self.backView.layer.masksToBounds = false
        self.backView.layer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        self.backView.layer.shadowOffset = CGSize(width: 0, height: 4.fit)
        self.backView.layer.shadowOpacity = 1
        self.backView.layer.shadowRadius = 12.fit
    }
    
    private func setConstrait() {
        
        backView.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(20.fit)
            make.right.equalTo(self).offset(-20.fit)
            make.centerY.equalTo(self)
            make.height.equalTo(320.fit)
        }
        chartLabel.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(30.fit)
            make.top.equalTo(self).offset(10.fit)
            make.width.equalTo(100.fit)
            make.height.equalTo(40.fit)
        }
        
        thirdLabel.snp.makeConstraints{(make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(35.fit)
            make.height.equalTo(10.fit)
            make.width.equalTo(20.fit)
        }
        thirdTopLine.snp.makeConstraints{(make) in
            make.top.equalTo(thirdLabel.snp.top)
            make.left.equalTo(self).offset(60.fit)
            make.right.equalTo(self).offset(-30.fit)
            make.height.equalTo(1)
        }
        thirdBottomLine.snp.makeConstraints{(make) in
            make.bottom.equalTo(thirdLabel.snp.bottom)
            make.left.equalTo(self).offset(60.fit)
            make.right.equalTo(self).offset(-30.fit)
            make.height.equalTo(1)
        }
        
        
        secendLabel.snp.makeConstraints{(make) in
            make.centerY.equalTo(self).offset(-55.fit)
            make.left.equalTo(self).offset(35.fit)
            make.height.equalTo(10.fit)
            make.width.equalTo(20.fit)
        }
        secendLine.snp.makeConstraints{(make) in
            make.centerY.equalTo(self).offset(-55.fit)
            make.left.equalTo(self).offset(60.fit)
            make.right.equalTo(self).offset(-30.fit)
            make.height.equalTo(1)
        }
        
        firstLabel.snp.makeConstraints{(make) in
            make.centerY.equalTo(self).offset(-105.fit)
            make.left.equalTo(self).offset(35.fit)
            make.height.equalTo(10.fit)
            make.width.equalTo(20.fit)
        }
        firstLine.snp.makeConstraints{(make) in
            make.centerY.equalTo(self).offset(-105.fit)
            make.left.equalTo(self).offset(60.fit)
            make.right.equalTo(self).offset(-30.fit)
            make.height.equalTo(1)
        }
        
        fourthLabel.snp.makeConstraints{(make) in
            make.centerY.equalTo(self).offset(55.fit)
            make.left.equalTo(self).offset(35.fit)
            make.height.equalTo(10.fit)
            make.width.equalTo(20.fit)
        }
        fourthLine.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(60.fit)
            make.right.equalTo(self).offset(-30.fit)
            make.centerY.equalTo(self).offset(55.fit)
            make.height.equalTo(1)
        }
        
        fivethLabel.snp.makeConstraints{(make) in
            make.centerY.equalTo(self).offset(105.fit)
            make.left.equalTo(self).offset(35.fit)
            make.height.equalTo(10.fit)
            make.width.equalTo(20.fit)
        }
        fivethLine.snp.makeConstraints{(make) in
            make.centerY.equalTo(self).offset(105.fit)
            make.left.equalTo(self).offset(60.fit)
            make.right.equalTo(self).offset(-30.fit)
            make.height.equalTo(1)
        }
        
//        chartMoreBtn.snp.makeConstraints{(make) in
//            make.right.equalTo(chartView.snp.right).offset(-20)
//            make.centerY.equalTo(chartLabel.snp.centerY)
//            make.width.equalTo(40)
//            make.height.equalTo(25)
//        }
        
        recommendLabel.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(30.fit)
            make.right.equalTo(self).offset(-30.fit)
            make.bottom.equalTo(self).offset(-10.fit)
            make.height.equalTo(30.fit)
        }
        
        collectionView.snp.makeConstraints{(make) in
            
            make.centerY.equalTo(self)
             make.left.equalTo(self).offset(70.fit)
            make.right.equalTo(self).offset(-30.fit)
            make.height.equalTo(210.fit)
        }
    }
}
