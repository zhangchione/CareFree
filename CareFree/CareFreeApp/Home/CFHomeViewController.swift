//
//  CFHomeViewController.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/6.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import CollectionKit
import SnapKit


// MARK:  Register cellID
private let CFHomeEmotionCellID = "CFHomeEmotionCell"
private let CFHomeChartCellID = "CFHomeChartCell"
private let CFHomeHeaderViewID = "CFHomeMarkHeaderView"
private let CFHomeMarkCellID = "CFHomeMarkCell"
class CFHomeViewController: CFBaseViewController {

    fileprivate let dataBodySource = ArrayDataSource(data:[1])
    fileprivate let dataHeadSource = ArrayDataSource(data:[1])
    
    
    
    let homeArrayDatas = ["22"]
    var chartArrayDatas = [EmotionChartModel]()
    var moodValue = 0
    // 主界面控件
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(CFHomeEmotionCell.self, forCellWithReuseIdentifier: CFHomeEmotionCellID)
        collection.register(CFHomeChartCell.self, forCellWithReuseIdentifier: CFHomeChartCellID)
        collection.register(CFHomeMarkCell.self, forCellWithReuseIdentifier: CFHomeMarkCellID)
        collection.register(CFHomeMarkHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CFHomeHeaderViewID)
        
        collection.backgroundColor = .white
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        configUI()
        configNavBar()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configData()
        self.collectionView.reloadData()
    }
    
    
    
    func configUI(){
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints{ (make) in
             make.left.equalTo(self.view.snp.left).offset(0)
             make.right.equalTo(self.view.snp.right).offset(0)
             make.bottom.equalToSuperview()
            make.top.equalTo(self.navigation.bar.snp.bottom).offset(0.fit)
         }
    }
    
    func configNavBar(){
        self.view.backgroundColor = .white
        self.Title.text = "首页"
        self.navigation.bar.barTintColor = .white
        self.navigation.bar.alpha = 1
    }
    
    func configData(){
        self.chartArrayDatas.removeAll()
        let datas = DiaryAndNoteInfo.shared.sevenMoodValue
        let days = DateInfo.shared.sevenNums
        for index in 0 ..< datas.count {
            var data = EmotionChartModel()
            data.dayText = days[index]
            data.mood = datas[index]
            self.chartArrayDatas.append(data)
        }
        
        self.moodValue = getTodayMoodValue()
    }


    
    @objc func emotionChart(){
        let emtionVC = EmotionChartController()
        self.navigationController?.pushViewController(emtionVC, animated: true)
    }
    
    @objc func recommendClick(){
        let recommendClickVC = RCViewController()
        self.navigationController?.pushViewController(recommendClickVC, animated: true)
    }
}



extension CFHomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section <= 2 {
            return 1
        }
        return self.homeArrayDatas.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell :CFHomeEmotionCell =  collectionView.dequeueReusableCell(withReuseIdentifier: CFHomeEmotionCellID, for: indexPath) as! CFHomeEmotionCell
            cell.updateUI(with: moodValue)
            return cell
        }else if indexPath.section == 1{
            let cell :CFHomeChartCell =  collectionView.dequeueReusableCell(withReuseIdentifier: CFHomeChartCellID, for: indexPath) as! CFHomeChartCell
            cell.updateUI(with: self.chartArrayDatas)
            return cell
        }else {
            let cell :CFHomeMarkCell =  collectionView.dequeueReusableCell(withReuseIdentifier: CFHomeMarkCellID, for: indexPath) as! CFHomeMarkCell
            cell.updateUI(with: CFNotesModel())
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: CFWidth, height: 210.fit)
        }else if indexPath.section == 1{
            return CGSize(width: CFWidth, height: 330.fit)
        }else {
            return CGSize(width: CFWidth, height: 160.fit)
        }
    }
    
    // 头部
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CFHomeHeaderViewID, for: indexPath) as? CFHomeMarkHeaderView else {
            return UICollectionReusableView()
        }
        headerView.titleLabel.text = "Mark"
        headerView.titleLabel.textColor = UIColor.black
        headerView.titleLabel.font = UIFont.init(name: "PingFangSC-Semibold", size: 24.fit)
        
        return headerView
    }
    // 头部高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 2 {
            return CGSize(width: CFWidth, height: 40.fit)
        }else {
            return CGSize(width: CFWidth, height: 0.fit)
        }
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 20.fit, left: 0, bottom: 20.fit, right: 0)
        
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.fit
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.fit
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1{
            let vc = DiaryDetailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//func configCV(){
//    let viewHeadSource = ClosureViewSource(viewUpdater: {(view:homeHeadCell,data:Int,index:Int) in
//        //view.backgroundColor = UIColor.red
//        DispatchQueue.main.async {
//            let  emotionLayer = CAGradientLayer()
//            emotionLayer.frame = view.topView.bounds
//            emotionLayer.colors = [UIColor.init(r: 56, g: 213, b: 214).cgColor,UIColor.init(r: 62, g: 179, b: 213).cgColor]
//            emotionLayer.cornerRadius = 15
//            view.topBackgroundView.layer.addSublayer(emotionLayer)
//        }
//        view.chartMoreBtn.addTarget(self, action: #selector(self.emotionChart), for: .touchUpInside)
//        view.todayRecommendMoreBtn.addTarget(self, action: #selector(self.recommendClick), for: .touchUpInside)
//        var model = emotionChartModel()
//        model.bottomValue = 0
//        model.day = "1"
//        model.topValue = 30
//        model.color = UIColor.init(r: 57, g: 210, b: 214)
//
//        var model1 = emotionChartModel()
//        model1.bottomValue = 0
//        model1.day = "2"
//        model1.topValue = 10
//        model1.color = UIColor.init(r: 100, g: 175, b: 232)
//        var model2 = emotionChartModel()
//        model2.bottomValue = 0
//        model2.day = "3"
//        model2.topValue = 20
//        model2.color = UIColor.init(r:100, g: 175, b: 232)
//
//        var model3 = emotionChartModel()
//        model3.bottomValue = 10
//        model3.day = "4"
//        model3.topValue = 0
//        model3.color = UIColor.init(r: 155, g: 133, b: 255)
//        var model4 = emotionChartModel()
//        model4.bottomValue = 20
//        model4.day = "5"
//        model4.topValue = 0
//        model4.color = UIColor.init(r: 31, g: 69, b: 99)
//        var model5 = emotionChartModel()
//        model5.bottomValue = 0
//        model5.day = "6"
//        model5.topValue = 35
//        model5.color = UIColor.init(r: 57, g: 210, b: 214)
//        var model6 = emotionChartModel()
//        model6.bottomValue = 0
//        model6.day = "7"
//        model6.topValue = 10
//        model6.color = UIColor.init(r: 100, g: 175, b: 232)
//
//        view.dataHeadSource.data.append(model)
//        view.dataHeadSource.data.append(model1)
//        view.dataHeadSource.data.append(model2)
//        view.dataHeadSource.data.append(model3)
//        view.dataHeadSource.data.append(model4)
//        view.dataHeadSource.data.append(model5)
//        view.dataHeadSource.data.append(model6)
//        view.collectionView.reloadData()
//
//    })
//    let sizeHeadSource =  {(index:Int,data:Int,collectionSize:CGSize) ->CGSize in
//        return CGSize(width: collectionSize.width, height: 620)
//    }
//    let provider = BasicProvider(
//        dataSource: dataHeadSource,
//        viewSource: viewHeadSource,
//        sizeSource:sizeHeadSource
//    )
//
//    let viewBodySource =  ClosureViewSource(viewUpdater: {(view:homeRecommendCell,data:Int,index:Int) in
//        view.updateUI()
//
//    })
//
//    let sizeBodySource = {(index:Int,data:Int,collectionSize:CGSize) ->CGSize in
//        return CGSize(width: collectionSize.width, height: 600)
//    }
//    let provider1 = BasicProvider(
//        dataSource: dataBodySource,
//        viewSource: viewBodySource,
//        sizeSource: sizeBodySource
//    )
//    let finalProvider = ComposedProvider(sections: [provider, provider1])
//    collectionView.provider = finalProvider
//    collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//
//    //self.view.layer.addSublayer(self.emotionLayer)
//}
