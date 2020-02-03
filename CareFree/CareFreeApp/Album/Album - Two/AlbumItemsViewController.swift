//
//  AlbumItemsViewController.swift
//  CareFree
//
//  Created by 张驰 on 2020/2/2.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit
import Photos
import SnapKit
import JXPhotoBrowser

struct ItemsModel {
    var photos = [String]()
    var time = ""
}
class AlbumItemsViewController: UIViewController {
    
    var diaryDatas = [CFAlbumMouthModel]()
    var datas = [ItemsModel]()
    
    // 照片区域
    lazy var photoCollection:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: 120.fit, height:120.fit)
        layout.headerReferenceSize = CGSize(width: CFWidth, height: 50.fit)
        let collection = UICollectionView.init(frame:CGRect(x:100, y:50, width:265, height:180), collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        collection.register(UINib(nibName: "diaryPhotoCell", bundle: nil), forCellWithReuseIdentifier: "diaryPhotoCell")
        // 注册头部视图
        collection.register(ItemHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ItemHeaderViewID")
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    convenience init(data:[ItemsModel]) {
        self.init()
        self.datas = data
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
    

    func configUI(){
        view.backgroundColor = backColor
        photoCollection.delegate = self
        photoCollection.dataSource = self
        view.addSubview(photoCollection)
        photoCollection.snp.makeConstraints{(make) in
            make.left.equalTo(view.snp.left).offset(20.fit)
            make.top.equalTo(view).offset(0)
            make.bottom.equalTo(view.snp.bottom).offset(0)
            make.right.equalTo(view.snp.right).offset(-20.fit)
        }

    }

}
extension AlbumItemsViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  datas[section].photos.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "diaryPhotoCell", for: indexPath) as! diaryPhotoCell
        let imgdata = datas[indexPath.section].photos[indexPath.row]
        config(cell: cell, with: imgdata)
        return cell
    }
    
    
    // 头部
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ItemHeaderViewID", for: indexPath) as? ItemHeaderView else {
            return UICollectionReusableView()
        }
        if datas[indexPath.section].photos.count != 0 {
            headerView.titleLabel.text = datas[indexPath.section].time
        }
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        return CGSize(width: CFWidth, height: 50.fit)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        // 数据源
        let dataSource = JXLocalDataSource(numberOfItems: {
            // 共有多少项
            return 1
        }, localImage: { index -> UIImage? in
            // 每一项的图片对象
            return self.configPic(with: self.datas[indexPath.section].photos[indexPath.row])
        })
        // 打开浏览器
        JXPhotoBrowser(dataSource: dataSource).show(pageIndex: 0)
    }
    
    func config(cell:diaryPhotoCell,with data:String) {
        let result = PHAsset.fetchAssets(withLocalIdentifiers: [data].compactMap{ $0 },options: nil) as? PHFetchResult
        result?.enumerateObjects({ (obj, index, stop) in
            let imageAsset = obj as? PHAsset
            if let imageAsset = imageAsset {
                let img = SKPHAssetToImageTool.PHAssetToImage(asset: imageAsset)
                cell.photo.image = img
            }
        })
    }
    func configPic(with data:String) -> UIImage? {
        var value:UIImage?
        let result = PHAsset.fetchAssets(withLocalIdentifiers: [data].compactMap{ $0 },options: nil) as? PHFetchResult
        result?.enumerateObjects({ (obj, index, stop) in
            let imageAsset = obj as? PHAsset
            if let imageAsset = imageAsset {
                let img = SKPHAssetToImageTool.PHAssetToImage(asset: imageAsset)
                 value = img
            }
        })
        return value
    }
    
}
