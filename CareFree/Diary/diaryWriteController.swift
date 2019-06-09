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
    
    public var emotionLayer: CAGradientLayer!
    public var topColor = UIColor.white
    public var writeColor = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.configUI()
            self.configCV()
        }

    }
    
    func configUI(){
        
        view.backgroundColor = UIColor.clear
        //view.addSubview(backgroundView)
        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        //collectionView.isScrollEnabled = false
        collectionView.alwaysBounceVertical = false
        //collectionView.backgroundColor = UIColor.yellow
        
        
        collectionView.snp.makeConstraints{(make) in
            make.bottom.right.left.equalTo(view)
            make.top.equalTo(view).offset(0)
        }
 
        

    }
    
    func configCV(){
        let viewHeadSource = ClosureViewSource(viewUpdater: {(view:writeDiaryCell,data:Int,index:Int) in
            view.updateUI()
            DispatchQueue.main.async {
                view.backgroundView.layer.addSublayer(self.emotionLayer)
                view.saveBtn.setTitleColor(self.topColor, for: .normal)
                view.backBtn.setTitleColor(self.topColor, for: .normal)
                view.Title.textColor = self.topColor
                view.diaryWirte.textColor = self.writeColor
            }
            view.backBtn.addTarget(self, action: #selector(self.back), for: .touchUpInside)
            view.saveBtn.addTarget(self, action: #selector(self.save), for: .touchUpInside)
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
        //self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
