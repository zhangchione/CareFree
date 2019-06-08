//
//  CFDiaryViewController.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/6.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import SnapKit
import CollectionKit


class CFDiaryViewController: UIViewController {

    var emotionLayer: CAGradientLayer!
    
    fileprivate let dataBodySource = ArrayDataSource(data:[diaryModel]())
    fileprivate let dataHeadSource = ArrayDataSource(data:[diaryModel]())
    
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
        configData()
    }
    
    func configNavBar(){
        
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        Title.frame = CGRect(x: 22.fitWidth_CGFloat, y: 50.fitHeight_CGFloat, width: 100.fitWidth_CGFloat, height: 40.fitHeight_CGFloat)
        Title.text = "日记"
        Title.font = UIFont(name: "PingFangSC-Semibold", size: 26)
        view.addSubview(Title)
        
    }

}

extension CFDiaryViewController{
    
    
    fileprivate func configData(){
        var model = diaryModel()
        model.content = "今天考试，准备了很久，希望能够得到好成绩"
        model.day = "24"
        model.value = 31
        model.week = "周五"
        model.yearMouth = "2019年5月"
        for index in 1...6 {
            self.dataBodySource.data.append(model)
        }
        self.dataHeadSource.data.append(model)

        self.collectionView.reloadData()
    }
    
    func configUI(){
        //        tableView.delegate = self
        //        tableView.dataSource = self
        //        tableView = UITableView(frame: CGRect(x: 0, y: 88.fitHeight_CGFloat, width: 414.fitWidth_CGFloat, height: 725.fitHeight_CGFloat))
        //        tableView.separatorStyle = .none
        view.backgroundColor = UIColor.init(r: 248, g: 249, b: 254)
        
        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        //collectionView.isScrollEnabled = false
        collectionView.alwaysBounceVertical = false
        collectionView.snp.makeConstraints{(make) in
            make.bottom.right.left.equalTo(view)
            make.top.equalTo(navigation.bar.snp.bottom).offset(0)        }
    }
    
    fileprivate func configCV(){
        let viewBodySource = ClosureViewSource(viewUpdater: {(view:diaryCell,data:diaryModel,index:Int) in
            view.updateUI(with: data)
        })
        let sizeBodySource = {(index:Int,data:diaryModel,collectionSize:CGSize) -> CGSize in
            return CGSize(width: collectionSize.width, height: 170)
        }
        let providerBody = BasicProvider(
            dataSource: dataBodySource,
            viewSource: viewBodySource,
            sizeSource: sizeBodySource
        )
        
        let viewHeadSource = ClosureViewSource(viewUpdater: {(view:diaryWriteCell,data:diaryModel,index:Int) in
            view.writeBtn.addTarget(self, action: #selector(self.write), for: .touchUpInside)
            
 
            view.jump = {
                let writeVC = diaryWriteController()
  
                switch $0 {
                case 0:print("jump1")
                case 1:print("jump2")
                case 2:print("jump3")
                case 3:print("jump4")
                default: break
                }
                self.present(writeVC, animated: true, completion: nil)

            }
            view.updateUI(with: data)
        })
        let sizeHeadSource = {(index:Int,data:diaryModel,collectionSize:CGSize) -> CGSize in
            return CGSize(width: collectionSize.width, height: 170)
        }
        let providerHead = BasicProvider(
            dataSource: dataHeadSource,
            viewSource: viewHeadSource,
            sizeSource: sizeHeadSource
        )
        
        let finalProvider = ComposedProvider(sections:[providerHead,providerBody])
        
        providerBody.layout = FlowLayout(spacing: 30)
        providerHead.layout = FlowLayout(spacing: 30)
        finalProvider.layout = FlowLayout(spacing: 30)
        collectionView.provider = finalProvider
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        
        providerBody.tapHandler = { context -> Void in
            let showDiaryVC = showDiaryController()
            self.navigationController?.pushViewController(showDiaryVC, animated: true)
        }
        
        
    }
    
    @objc func write(){
        print("跳转写日记界面...")
        let writeVC = diaryWriteController()
        
        self.emotionLayer = CAGradientLayer()
        self.emotionLayer.frame = writeVC.backgroundView.bounds
        emotionLayer.colors = [UIColor.init(r: 100, g: 176, b: 232).cgColor,UIColor.init(r: 83, g: 121, b: 255).cgColor]
        print("jump4")
        writeVC.backgroundView.backgroundColor = UIColor.yellow
        writeVC.backgroundView .layer.addSublayer(self.emotionLayer)
        
        
        self.present(writeVC, animated: true, completion: nil)
        //self.navigationController?.pushViewController(writeVC, animated: true)
        
    }
}
