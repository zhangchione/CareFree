//
//  CFAlbumViewController.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/6.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import CollectionKit
import SnapKit


class CFAlbumViewController: UIViewController {

    fileprivate let dataSource = ArrayDataSource(data:[1])
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
        view.backgroundColor = .white
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
    
    func configNavBar() {
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        Title.frame = CGRect(x: 22.fitWidth_CGFloat, y: 50.fitHeight_CGFloat, width: 100.fitWidth_CGFloat, height: 40.fitHeight_CGFloat)
        Title.text = "相册"
        Title.font = UIFont(name: "PingFangSC-Semibold", size: 26)
        view.addSubview(Title)
    }
    
    func configCV(){
        let viewSource = ClosureViewSource(viewUpdater: {(view:albumCell,data:Int,index:Int) in
            
            view.updateUI()
            
        })
        
        let sizeSource = {(index:Int,data:Int,collectionSize:CGSize) ->CGSize in
            return CGSize(width: collectionSize.width, height: 520)
        }
        
        
        
        let provider = BasicProvider(
            dataSource: dataSource,
            viewSource: viewSource,
            sizeSource:sizeSource
        )
        
        provider.tapHandler = { context -> Void in
            let albumMoreVC = AlbumDetialController()
            self.navigationController?.pushViewController(albumMoreVC, animated: true)
            print("Cell")
        }
        collectionView.provider = provider
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}
