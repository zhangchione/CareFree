//
//  CFMineViewController.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/6.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import SnapKit
import CollectionKit

class CFMineViewController: UIViewController {

    var emotionLayer: CAGradientLayer!
    
    fileprivate let dataSource = ArrayDataSource(data:[1])
    
    fileprivate lazy var collectionView = CollectionView()
    
    fileprivate lazy var Title:UILabel = {
        let label = UILabel()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configUI()
        configNavBar()
        configCV()
        congfigUI2()
    }
    
    func congfigUI2(){
        view.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        
        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        //collectionView.isScrollEnabled = false
        collectionView.alwaysBounceVertical = false
        collectionView.snp.makeConstraints{(make) in
            make.bottom.right.left.equalTo(view)
            make.top.equalTo(navigation.bar.snp.bottom).offset(0)
        }
        
        
    }
    var impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    public var duration = 0.3
    func configCV(){
        let viewSource = ClosureViewSource(viewUpdater: {(view:MineCell,data:Int,index:Int) in
            view.updateUI()
            
            DispatchQueue.main.async {
                let  emotionLayer = CAGradientLayer()
                emotionLayer.frame = view.emotionView.bounds
                emotionLayer.colors = [UIColor.init(r: 100, g: 176, b: 232).cgColor,UIColor.init(r: 83, g: 121, b: 255).cgColor]
                emotionLayer.cornerRadius = 25
                view.oneBackView.layer.addSublayer(emotionLayer)
            }
            
            let setTap = UITapGestureRecognizer(target: self, action: #selector(self.setEvent))
            let trashTap = UITapGestureRecognizer(target: self, action: #selector(self.trashEvent))
            let diaryChartTap = UITapGestureRecognizer(target: self, action: #selector(self.diaryChartEvnent))
            view.setView.addGestureRecognizer(setTap)
            view.trashView.addGestureRecognizer(trashTap)
            view.moodView.addGestureRecognizer(diaryChartTap)
  
            view.setView.layer.add(self.impliesAnimation, forKey: nil)
        })
        let sizeSource = {(index:Int,data:Int,collectionSize:CGSize) ->CGSize in
            return CGSize(width: collectionSize.width, height: 820)
        }
        
        let provider = BasicProvider(
            dataSource: dataSource,
            viewSource: viewSource,
            sizeSource:sizeSource
        )
        collectionView.provider = provider
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func configNavBar(){
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        Title.frame = CGRect(x: 22.fitWidth_CGFloat, y: 50.fitHeight_CGFloat, width: 100.fitWidth_CGFloat, height: 40.fitHeight_CGFloat)
        Title.text = "我的"
        Title.font = UIFont(name: "PingFangSC-Semibold", size: 26)
       
        view.addSubview(Title)
    }
    
    // 渐变色背景：

}

extension CFMineViewController{
    
    @objc func trashEvent(){
        print("废纸篓页面跳转中...")
        let trashVC = TrashViewController()
        self.navigationController?.pushViewController(trashVC, animated: true)
    }
    
    @objc func setEvent(){

        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = self.duration * 2
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        print("设置页面跳转中...")
        let setVC = SetViewController()
        self.navigationController?.pushViewController(setVC, animated: true)
    }
    @objc func diaryChartEvnent(){
        print("心情报表页面跳转中...")
    }
    @objc func back(){
        
    }
    
}
