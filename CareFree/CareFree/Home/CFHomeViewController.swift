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

class CFHomeViewController: UIViewController {

    fileprivate let dataBodySource = ArrayDataSource(data:[1])
    fileprivate let dataHeadSource = ArrayDataSource(data:[1])
    
    fileprivate lazy var collectionView = CollectionView()
    
    fileprivate lazy var Title:UILabel = {
       let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCV()
        configUI()
        configNavBar()
    }
    
    func configUI(){
        view.backgroundColor = UIColor.init(r: 247, g: 249, b: 255)
        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        //collectionView.isScrollEnabled = false
        collectionView.alwaysBounceVertical = false
        collectionView.snp.makeConstraints{(make) in
            make.bottom.right.left.equalTo(view)
            make.top.equalTo(navigation.bar.snp.bottom).offset(0)        }
    }
    
    func configNavBar(){
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        Title.frame = CGRect(x: 22.fitWidth_CGFloat, y: 50.fitHeight_CGFloat, width: 100.fitWidth_CGFloat, height: 40.fitHeight_CGFloat)
        Title.text = "首页"
        Title.font = UIFont(name: "PingFangSC-Semibold", size: 26)
        view.addSubview(Title) 
    }
    
    func configData(){
        
    }

    func configCV(){
        let viewHeadSource = ClosureViewSource(viewUpdater: {(view:homeHeadCell,data:Int,index:Int) in
            //view.backgroundColor = UIColor.red
            DispatchQueue.main.async {
                let  emotionLayer = CAGradientLayer()
                emotionLayer.frame = view.topView.bounds
                emotionLayer.colors = [UIColor.init(r: 56, g: 213, b: 214).cgColor,UIColor.init(r: 62, g: 179, b: 213).cgColor]
                emotionLayer.cornerRadius = 15
                view.topBackgroundView.layer.addSublayer(emotionLayer)
            }
            view.chartMoreBtn.addTarget(self, action: #selector(self.emotionChart), for: .touchUpInside)
            view.todayRecommendMoreBtn.addTarget(self, action: #selector(self.recommendClick), for: .touchUpInside)
            var model = emotionChartModel()
            model.bottomValue = 0
            model.day = "1"
            model.topValue = 30
            model.color = UIColor.init(r: 57, g: 210, b: 214)
            
            var model1 = emotionChartModel()
            model1.bottomValue = 0
            model1.day = "2"
            model1.topValue = 10
            model1.color = UIColor.init(r: 100, g: 175, b: 232)
            var model2 = emotionChartModel()
            model2.bottomValue = 0
            model2.day = "3"
            model2.topValue = 20
            model2.color = UIColor.init(r:100, g: 175, b: 232)
            
            var model3 = emotionChartModel()
            model3.bottomValue = 10
            model3.day = "4"
            model3.topValue = 0
            model3.color = UIColor.init(r: 155, g: 133, b: 255)
            var model4 = emotionChartModel()
            model4.bottomValue = 20
            model4.day = "5"
            model4.topValue = 0
            model4.color = UIColor.init(r: 31, g: 69, b: 99)
            var model5 = emotionChartModel()
            model5.bottomValue = 0
            model5.day = "6"
            model5.topValue = 35
            model5.color = UIColor.init(r: 57, g: 210, b: 214)
            var model6 = emotionChartModel()
            model6.bottomValue = 0
            model6.day = "7"
            model6.topValue = 10
            model6.color = UIColor.init(r: 100, g: 175, b: 232)
            
            view.dataHeadSource.data.append(model)
            view.dataHeadSource.data.append(model1)
            view.dataHeadSource.data.append(model2)
            view.dataHeadSource.data.append(model3)
            view.dataHeadSource.data.append(model4)
            view.dataHeadSource.data.append(model5)
            view.dataHeadSource.data.append(model6)
            view.collectionView.reloadData()
            
        })
        let sizeHeadSource =  {(index:Int,data:Int,collectionSize:CGSize) ->CGSize in
            return CGSize(width: collectionSize.width, height: 620)
        }
        let provider = BasicProvider(
            dataSource: dataHeadSource,
            viewSource: viewHeadSource,
            sizeSource:sizeHeadSource
        )
        
        let viewBodySource =  ClosureViewSource(viewUpdater: {(view:homeRecommendCell,data:Int,index:Int) in
            view.updateUI()
            
        })
        
        let sizeBodySource = {(index:Int,data:Int,collectionSize:CGSize) ->CGSize in
            return CGSize(width: collectionSize.width, height: 600)
        }
        let provider1 = BasicProvider(
            dataSource: dataBodySource,
            viewSource: viewBodySource,
            sizeSource: sizeBodySource
        )
        let finalProvider = ComposedProvider(sections: [provider, provider1])
        collectionView.provider = finalProvider
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        //self.view.layer.addSublayer(self.emotionLayer)
    }
    
    @objc func emotionChart(){
        let emtionVC = EmotionChartController()
        self.navigationController?.pushViewController(emtionVC, animated: true)
    }
    
    @objc func recommendClick(){
        let recommendClickVC = RecommendController()
        self.navigationController?.pushViewController(recommendClickVC, animated: true)
    }
}


