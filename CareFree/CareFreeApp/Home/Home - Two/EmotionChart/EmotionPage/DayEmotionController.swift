//
//  DayEmotionController.swift
//  CareFree
//
//  Created by 张驰 on 2019/7/29.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import CollectionKit
import SnapKit

class DayEmotionController: UIViewController {

    lazy var emotionView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var viewLeftBtn: UIButton = {
       let button = UIButton()
        button.setTitle("‹", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.setTitleColor(UIColor.init(r: 151, g: 151, b: 151), for: .normal)
        button.addTarget(self, action: #selector(left), for: .touchUpInside)
        return button
    }()
    
    lazy var viewRightBtn:UIButton = {
       let button = UIButton()
        button.setTitle("›", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.setTitleColor(UIColor.init(r: 151, g: 151, b: 151), for: .normal)
        button.addTarget(self, action: #selector(right), for: .touchUpInside)
        return button
    }()
    
    lazy var titleTime:UILabel = {
       let label = UILabel()
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 12)
        label.textColor = UIColor.init(r: 111, g: 111, b: 111)
        label.text = "2019年6月3日至9日"
        label.textAlignment = .center
        return label
    }()
    
    lazy var emotionSummary:UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
        label.textColor = UIColor.init(r: 73, g: 73, b: 73)
        label.text = "最近一周情绪波动较大，但总体情绪处于积极状态。"
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var tip:UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
        label.textColor = UIColor.init(r: 73, g: 73, b: 73)
        label.text = "积极的运动有利于调节自己的情绪，稳定自己的心情，保 持充足的睡眠更是重要，当精力不足时，不仅工作没有效 率，更容易出现沮丧，烦躁的情绪。"
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        configData()
    }
    let dataHeadSource = ArrayDataSource(data:[emotionChartModel]())
    lazy var  collectionView: CollectionView = {
        let cv = CollectionView()
        cv.backgroundColor = UIColor.clear
        cv.isScrollEnabled = false
        return cv
    }()
    
    func configUI(){
         view.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        view.addSubview(emotionView)
        emotionView.snp.makeConstraints{(make) in
            make.left.equalTo(view)
            make.top.equalTo(view).offset(10)
            make.height.equalTo(300)
            make.right.equalTo(view)
        }
        emotionView.addSubview(titleTime)
        titleTime.snp.makeConstraints{(make) in
            make.centerX.equalTo(emotionView.snp.centerX)
            make.top.equalTo(emotionView.snp.top).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(200)
        }
        emotionView.addSubview(viewLeftBtn)
        viewLeftBtn.snp.makeConstraints{(make) in
            make.left.equalTo(emotionView.snp.left).offset(20)
            make.centerY.equalTo(titleTime.snp.centerY)
            make.height.width.equalTo(20)
        }
        emotionView.addSubview(viewRightBtn)
        viewRightBtn.snp.makeConstraints{(make) in
            make.right.equalTo(emotionView.snp.right).offset(-20)
            make.centerY.equalTo(titleTime.snp.centerY)
            make.height.width.equalTo(20)
        }

        view.addSubview(emotionSummary)
        emotionSummary.snp.makeConstraints{(make) in
            make.left.equalTo(view.snp.left).offset(20)
            make.top.equalTo(emotionView.snp.bottom).offset(40)
            make.height.equalTo(30)
            make.width.equalTo(374)
        }
        view.addSubview(tip)
        tip.snp.makeConstraints{(make) in
            make.left.equalTo(view.snp.left).offset(20)
            make.top.equalTo(emotionSummary.snp.bottom).offset(10)
            make.height.equalTo(100)
            make.width.equalTo(374)
        }

        
        emotionView.addSubview(firstLabel)
        emotionView.addSubview(firstLine)
        
        emotionView.addSubview(secendLabel)
        emotionView.addSubview(secendLine)
        
        emotionView.addSubview(thirdLabel)
        emotionView.addSubview(thirdTopLine)
        emotionView.addSubview(thirdBottomLine)
        
        emotionView.addSubview(fourthLabel)
        emotionView.addSubview(fourthLine)
        
        emotionView.addSubview(fivethLabel)
        emotionView.addSubview(fivethLine)
        firstLabel.snp.makeConstraints{(make) in
            make.left.equalTo(emotionView.snp.left).offset(40)
            make.top.equalTo(viewLeftBtn.snp.bottom).offset(30)
            make.width.height.equalTo(10)
        }
        firstLine.snp.makeConstraints{(make) in
            make.left.equalTo(firstLabel.snp.right).offset(2)
            make.centerY.equalTo(firstLabel.snp.centerY)
            make.right.equalTo(emotionView.snp.right).offset(-40)
            make.height.equalTo(1)
        }
        
        secendLabel.snp.makeConstraints{(make) in
            make.left.equalTo(emotionView.snp.left).offset(40)
            make.top.equalTo(firstLabel.snp.bottom).offset(40)
            make.width.height.equalTo(10)
        }
        secendLine.snp.makeConstraints{(make) in
            make.left.equalTo(secendLabel.snp.right).offset(2)
            make.centerY.equalTo(secendLabel.snp.centerY)
            make.right.equalTo(emotionView.snp.right).offset(-40)
            make.height.equalTo(1)
        }
        
        thirdLabel.snp.makeConstraints{(make) in
            make.left.equalTo(emotionView.snp.left).offset(40)
            make.top.equalTo(secendLabel.snp.bottom).offset(40)
            make.width.height.equalTo(10)
        }
        thirdTopLine.snp.makeConstraints{(make) in
            make.left.equalTo(thirdLabel.snp.right).offset(2)
            make.centerY.equalTo(thirdLabel.snp.top).offset(-3)
            make.right.equalTo(emotionView.snp.right).offset(-40)
            make.height.equalTo(1)
        }
        thirdBottomLine.snp.makeConstraints{(make) in
            make.left.equalTo(thirdLabel.snp.right).offset(2)
            make.centerY.equalTo(thirdLabel.snp.bottom).offset(3)
            make.right.equalTo(emotionView.snp.right).offset(-40)
            make.height.equalTo(1)
        }
        
        fourthLabel.snp.makeConstraints{(make) in
            make.left.equalTo(emotionView.snp.left).offset(40)
            make.top.equalTo(thirdLabel.snp.bottom).offset(40)
            make.height.equalTo(10)
            make.width.equalTo(15)
        }
        fourthLine.snp.makeConstraints{(make) in
            make.left.equalTo(fourthLabel.snp.right).offset(2)
            make.centerY.equalTo(fourthLabel.snp.centerY)
            make.right.equalTo(emotionView.snp.right).offset(-40)
            make.height.equalTo(1)
        }
        
        fivethLabel.snp.makeConstraints{(make) in
            make.left.equalTo(emotionView.snp.left).offset(40)
            make.top.equalTo(fourthLabel.snp.bottom).offset(40)
            make.width.height.equalTo(15)
            make.height.equalTo(10)
        }
        fivethLine.snp.makeConstraints{(make) in
            make.left.equalTo(fivethLabel.snp.right).offset(2)
            make.centerY.equalTo(fivethLabel.snp.centerY)
            make.right.equalTo(emotionView.snp.right).offset(-40)
            make.height.equalTo(1)
        }
        
        emotionView.addSubview(collectionView)
        collectionView.snp.makeConstraints{(make) in
            make.left.equalTo(firstLine.snp.left).offset(12)
            make.top.equalTo( firstLine .snp.top).offset(0)
            make.bottom.equalTo(fivethLine.snp.bottom).offset(0)
            make.right.equalTo(firstLine.snp.right).offset(0)
        }
        //collectionView.backgroundColor = UIColor.green
        let viewHeadSource = ClosureViewSource(viewUpdater: {(view:PageChartCell,data:emotionChartModel,index:Int) in
            view.updateUI(with: data)
            //view.backgroundColor = UIColor.yellow
        })
        let sizeHeadSource = {(index:Int,data:emotionChartModel,collectionSize:CGSize) ->CGSize in
            return CGSize(width: 33, height: 202)
        }
        
        let provider = BasicProvider(
            dataSource: dataHeadSource,
            viewSource: viewHeadSource,
            sizeSource:sizeHeadSource
        )
        provider.layout = FlowLayout(spacing: 10)
        collectionView.provider = provider
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }

    func configData(){
        var model = emotionChartModel()
        model.bottomValue = 0
        model.day = "周一"
        model.topValue = 30
        model.color = UIColor.init(r: 57, g: 210, b: 214)
        
        var model1 = emotionChartModel()
        model1.bottomValue = 0
        model1.day = "周二"
        model1.topValue = 10
        model1.color = UIColor.init(r: 100, g: 175, b: 232)
        var model2 = emotionChartModel()
        model2.bottomValue = 0
        model2.day = "周三"
        model2.topValue = 20
        model2.color = UIColor.init(r:100, g: 175, b: 232)
        
        var model3 = emotionChartModel()
        model3.bottomValue = 10
        model3.day = "周四"
        model3.topValue = 0
        model3.color = UIColor.init(r: 155, g: 133, b: 255)
        var model4 = emotionChartModel()
        model4.bottomValue = 20
        model4.day = "周五"
        model4.topValue = 0
        model4.color = UIColor.init(r: 155, g: 133, b: 255)
        var model5 = emotionChartModel()
        model5.bottomValue = 0
        model5.day = "周六"
        model5.topValue = 35
        model5.color = UIColor.init(r: 57, g: 210, b: 214)
        var model6 = emotionChartModel()
        model6.bottomValue = 0
        model6.day = "周日"
        model6.topValue = 10
        model6.color = UIColor.init(r: 100, g: 175, b: 232)
        
        dataHeadSource.data.append(model)
        dataHeadSource.data.append(model1)
        dataHeadSource.data.append(model2)
        dataHeadSource.data.append(model3)
        dataHeadSource.data.append(model4)
        dataHeadSource.data.append(model5)
        dataHeadSource.data.append(model6)
        collectionView.reloadData()
    }
}

/// MARK - emotionView 左右按钮事件
extension DayEmotionController {
    @objc func right(){
        print("右边按钮点击")
        dataHeadSource.data.removeAll()
        var model = emotionChartModel()
        model.bottomValue = 0
        model.day = "周一"
        model.topValue = -30
        model.color = UIColor.init(r: 57, g: 210, b: 214)
        dataHeadSource.data.append(model)
        collectionView.reloadData()
    }
    @objc func left(){
        print("左边按钮点击")
        dataHeadSource.data.removeAll()
        var model = emotionChartModel()
        model.bottomValue = 0
        model.day = "周一"
        model.topValue = 30
        model.color = UIColor.init(r: 57, g: 210, b: 214)
        
        var model1 = emotionChartModel()
        model1.bottomValue = 0
        model1.day = "周二"
        model1.topValue = 10
        model1.color = UIColor.init(r: 100, g: 175, b: 232)
        var model2 = emotionChartModel()
        model2.bottomValue = 0
        model2.day = "周三"
        model2.topValue = 0
        model2.color = UIColor.init(r:100, g: 175, b: 232)
        
        var model3 = emotionChartModel()
        model3.bottomValue = 10
        model3.day = "周四"
        model3.topValue = 0
        model3.color = UIColor.init(r: 155, g: 133, b: 255)
        var model4 = emotionChartModel()
        model4.bottomValue = 20
        model4.day = "周五"
        model4.topValue = 0
        model4.color = UIColor.init(r: 155, g: 133, b: 255)
        var model5 = emotionChartModel()
        model5.bottomValue = 0
        model5.day = "周六"
        model5.topValue = 0
        model5.color = UIColor.init(r: 57, g: 210, b: 214)
        var model6 = emotionChartModel()
        model6.bottomValue = 0
        model6.day = "周日"
        model6.topValue = 10
        model6.color = UIColor.init(r: 100, g: 175, b: 232)
        
        dataHeadSource.data.append(model)
        dataHeadSource.data.append(model1)
        dataHeadSource.data.append(model2)
        dataHeadSource.data.append(model3)
        dataHeadSource.data.append(model4)
        dataHeadSource.data.append(model5)
        dataHeadSource.data.append(model6)
        collectionView.reloadData()
    }
}
