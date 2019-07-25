//
//  showDiaryController.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/7.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import SnapKit
import CollectionKit

class showDiaryController: UIViewController {
    
    fileprivate let dataHeadSource = ArrayDataSource(data:[1])
    fileprivate lazy var collectionView = CollectionView()
    fileprivate let dataBodySource = ArrayDataSource(data:[nowModel]())
    
    public var emotionLayer:CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        configCV()
        configData()
    }
    // 左边返回按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        button.setTitle("←", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        button.tintColor = UIColor.red
        return button
    }()
    
    func configData(){
        var model = nowModel()

        model.content = "期待已久的书终于到了"
        model.time = "10点17分"
        model.mode = 20
        self.dataBodySource.data.append(model)
        model.content = "书没有想象中的好"
        model.time = "11点32分"
        model.mode = -10
        self.dataBodySource.data.append(model)
        model.content = "书很难看诶！！☹️！"
        model.time = "12点21分"
        model.mode = -20
        self.dataBodySource.data.append(model)
        model.content = "朋友说送我一本好书，😸！开心"
        model.time = "14点32分"
        model.mode = 36
        self.dataBodySource.data.append(model)
        model.content = "真不好过，压抑啊 ！"
        model.time = "16点32分"
        model.mode = -34
        self.dataBodySource.data.append(model)
        self.collectionView.reloadData()
    }
    
    func configUI(){
        view.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
       // view.backgroundColor = UIColor.green
        
        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        //collectionView.isScrollEnabled = false
        collectionView.alwaysBounceVertical = false
        
        collectionView.snp.makeConstraints{(make) in
            make.bottom.right.left.equalTo(view)
            make.top.equalTo(navigation.bar.snp.top).offset(-176)

        }
    }
    
    func configCV(){
        
        let viewHeadSource = ClosureViewSource(viewUpdater: {(view:showHeadCell,data:Int,index:Int) in
            view.updateUI()
            DispatchQueue.main.async {
                self.emotionLayer.frame = view.headView.bounds
                view.headView.layer.addSublayer(self.emotionLayer)
            }
            //view.backgroundColor = .blue
            
        })
        let sizeHeadSource = {(index:Int,data:Int,collectionSize:CGSize) ->CGSize in
            return CGSize(width: collectionSize.width, height: 400)
        }
        
        let providerHead = BasicProvider(
            dataSource: dataHeadSource,
            viewSource: viewHeadSource,
            sizeSource:sizeHeadSource
        )
        
        let viewBodySource = ClosureViewSource(viewUpdater: {(view:showBodyCell,data:nowModel,index:Int) in
            view.updateUI(with: data)
        })
        let sizeBodySource = {(index:Int,data:nowModel,collectionSize:CGSize) -> CGSize in
            return CGSize(width: collectionSize.width, height: 140)
        }
        let providerBody = BasicProvider(
            dataSource: dataBodySource,
            viewSource: viewBodySource,
            sizeSource: sizeBodySource
        )
        let finalProvider = ComposedProvider(sections:[providerHead,providerBody])
        
        providerBody.layout = FlowLayout(spacing: 40)
        providerHead.layout = FlowLayout(spacing: 30)
        finalProvider.layout = FlowLayout(spacing: 20)
        
        collectionView.provider = finalProvider
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
    
    
}
extension showDiaryController{
    // 放回按钮
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
}
