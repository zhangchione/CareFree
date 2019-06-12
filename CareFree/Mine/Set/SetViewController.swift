//
//  SetViewController.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/9.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import SnapKit
import CollectionKit


class SetViewController: UIViewController {
    
    var headlabel = [["头像","昵称"],["我要反馈","关于"],["切换账号","退出登录"]]
    var backUser = [["userImg","Jeffrey"],["",""],["",""]]
    
    // 左边返回按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        button.setTitle("←", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        button.tintColor = UIColor.red
        return button
    }()
    
    
    fileprivate let dataSource = ArrayDataSource(data:[SetModel]())
    
    fileprivate lazy var collectionView = CollectionView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCV()
        configUI()
        updateUI()
    }
    


    func configUI(){
        view.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.title = "设置"
        
         self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        
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

    func configCV(){
        let viewSource = ClosureViewSource(viewUpdater: {(view:setCell,data:SetModel,index:Int) in
            view.updateUI(with: data)
        })
        let sizeSource = {(index:Int,data:SetModel,collectionSize:CGSize) ->CGSize in
            return CGSize(width: collectionSize.width, height: 140)
        }
        
        let provider = BasicProvider(
            dataSource: dataSource,
            viewSource: viewSource,
            sizeSource: sizeSource
        )
        provider.layout = FlowLayout(spacing: 30)
        collectionView.provider = provider
        collectionView.contentInset = UIEdgeInsets(top: 35, left: 20, bottom: 0, right: 20)
    }
    
    func updateUI(){
        for index in 0...2{
            var setModel = SetModel()
            setModel.topHead = headlabel[index][0]
            setModel.bottomHead = headlabel[index][1]
            setModel.userImg = backUser[index][0]
            setModel.userName = backUser[index][1]
            dataSource.data.append(setModel)
        }
        collectionView.reloadData()
    }
}
extension SetViewController{
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
}
