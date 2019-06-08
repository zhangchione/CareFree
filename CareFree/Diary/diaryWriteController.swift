//
//  diaryWriteController.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/7.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import SnapKit
import CollectionKit

class diaryWriteController: UIViewController {

    fileprivate let dataHeadSource = ArrayDataSource(data:[1])
    fileprivate lazy var collectionView = CollectionView()
    
    var emotionLayer: CAGradientLayer!
    
    lazy var backgroundView:UIView = {
        let vi = UIView()
        //vi.backgroundColor = UIColor.cyan
        return vi
    }()

    
    lazy var backBtn:UIButton = {
       let btn = UIButton()
        btn.setTitle("×", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 40)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        return btn
    }()
    
    lazy var saveBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("完成", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 20)
        btn.addTarget(self, action: #selector(save), for: .touchUpInside)
        return btn
    }()

    lazy var Title:UILabel = {
       let label = UILabel()
        label.tintColor = UIColor.green
        label.text = "今天"
        label.font = UIFont(name: "PingFangSC-Regular", size: 20)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCV()
        configUI()
    }
    
    func configUI(){
        
        view.backgroundColor = UIColor.white
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints{(make) in
            make.left.top.bottom.right.equalTo(view)
        }
        
        self.emotionLayer = CAGradientLayer()
        self.emotionLayer.frame = backgroundView.bounds
        
        emotionLayer.colors = [UIColor.init(r: 100, g: 176, b: 232).cgColor,UIColor.init(r: 83, g: 121, b: 255).cgColor]
       // print("jump4")
        self.backgroundView.layer.addSublayer(emotionLayer)
        
        //view.backgroundColor = UIColor.clear
        view.addSubview(backBtn)
        view.addSubview(Title)
        view.addSubview(saveBtn)
        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        //collectionView.isScrollEnabled = false
        collectionView.alwaysBounceVertical = false
        //collectionView.backgroundColor = UIColor.yellow
        
        backBtn.snp.makeConstraints{(make) in
            make.left.equalTo(view.snp.left).offset(20)
            make.top.equalTo(view.snp.top).offset(60)
            make.width.height.equalTo(30)
        }
        Title.snp.makeConstraints{(make) in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(backBtn.snp.centerY)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        saveBtn.snp.makeConstraints{(make) in
            make.right.equalTo(view.snp.right).offset(-20)
            make.centerY.equalTo(backBtn.snp.centerY)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        collectionView.snp.makeConstraints{(make) in
            make.bottom.right.left.equalTo(view)
            make.top.equalTo(backBtn.snp.bottom).offset(0)
        }
        

    }
    
    func configCV(){
        let viewHeadSource = ClosureViewSource(viewUpdater: {(view:writeDiaryCell,data:Int,index:Int) in
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

extension diaryWriteController {
    
    // 右边保存按钮事件
    @objc func save(){
        print("日记保存成功")
    }
    // 左边退出按钮事件
    @objc func back(){
        print("退出写日记界面")
        self.dismiss(animated: true, completion: nil)
    }
}
