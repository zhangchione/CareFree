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

    fileprivate let dataBodySource = ArrayDataSource(data:[diaryModel]())
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
            view.updateUI()
            
        })
        let sizeHeadSource = {(index:Int,data:Int,collectionSize:CGSize) ->CGSize in
            return CGSize(width: collectionSize.width, height: 806)
        }
        
        let provider = BasicProvider(
            dataSource: dataHeadSource,
            viewSource: viewHeadSource,
            sizeSource:sizeHeadSource
        )
        collectionView.provider = provider
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

