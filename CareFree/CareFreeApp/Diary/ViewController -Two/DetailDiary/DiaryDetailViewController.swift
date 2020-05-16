//
//  DiaryDetailViewController.swift
//  CareFree
//
//  Created by 张驰 on 2020/5/4.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Photos
import JXPhotoBrowser
import NaturalLanguage
import ProgressHUD

class DiaryDetailViewController: UIViewController {

    
    var diaryData = DiaryModel()
    // 照片数据
    var photoData = [String]()
    //
    var isImageShow = false
    
    // 左边返回按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hone_icon_back")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.white
        button.tintColor = UIColor.white
        button.setImage(imageView.image, for: .normal)
        //button.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    // 右边完成按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mine_alter_icon")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.white
        button.tintColor = UIColor.white
        button.setImage(imageView.image, for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(alter), for: UIControl.Event.touchUpInside)
        return button
    }()
    // ScrollView
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.contentSize = CGSize(width: CFWidth, height: CFHeight+180.fit-kNavBarAndStatusBarHeight)
//        scrollView.contentOffset = CGPoint(x: 0, y: 180.fit-kNavBarAndStatusBarHeight)
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var contentView:UIView = {
        let vi = UIView()
        return vi
    }()
    
    lazy var topView: HeadDetialView = {
       let topView = HeadDetialView()
        return topView
    }()
    
    // 文字内容
    lazy var diaryLabel:UITextView = {
       let textView = UITextView()
        textView.font = UIFont(name: "PingFangSC-Regular", size: 16.fit)
        textView.textColor = UIColor.init(r: 34, g: 34, b: 34)
        textView.isEditable = false
        textView.dataDetectorTypes = .link
        textView.linkTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        // 解决向下偏移问题
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0;
        return textView
    }()
    
    let disposeBag = DisposeBag()
    
    lazy var imageBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "diary_icon_add"), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: "PingFangSC-Medium", size: 10.fit)
        btn.tintColor = UIColor.init(r: 96, g: 114, b: 255)
        btn.addTarget(self, action: #selector(showImage), for: .touchUpInside)
        
        btn.rx.tap.subscribe(onNext:{[weak self] in
            guard let strongSelf = self else { return }
            
        }).disposed(by: disposeBag)
        return btn
    }()
    
    // 照片区域
     lazy var photoCollection:UICollectionView = {
         let layout = UICollectionViewFlowLayout.init()
         layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
         layout.minimumInteritemSpacing = 0
         layout.minimumLineSpacing = 0
         layout.scrollDirection = .horizontal
         layout.itemSize = CGSize(width: 120.fit, height:120.fit)
         let collection = UICollectionView.init(frame:CGRect(x:100, y:50, width:265, height:180), collectionViewLayout: layout)
         collection.backgroundColor = UIColor.clear
         collection.register(UINib(nibName: "diaryPhotoCell", bundle: nil), forCellWithReuseIdentifier: "diaryPhotoCell")
         collection.showsVerticalScrollIndicator = false
         collection.showsHorizontalScrollIndicator = false
         return collection
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNav()
        updateUI()
    }
    
    func configUI(){
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(CFHeight+(180.fit-kNavBarAndStatusBarHeight))
        }
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(CFHeight+(180.fit-kNavBarAndStatusBarHeight))
        }
        
        contentView.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.equalTo(scrollView.snp.left)
            make.right.equalTo(scrollView.snp.right)
            make.top.equalTo(scrollView.snp.top).offset(-kNavBarAndStatusBarHeight)
            make.height.equalTo(180.fit)
        }
        
        contentView.addSubview(diaryLabel)
        diaryLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20.fit)
            make.right.equalToSuperview().offset(-20.fit)
            make.top.equalTo(topView.snp.bottom).offset(20.fit)
            make.bottom.equalToSuperview().offset(-150.fit)
        }
        
        contentView.addSubview(imageBtn)
        imageBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20.fit)
            make.bottom.equalTo(view.snp.bottom).offset(-60.fit-kBottomSafeHeight)
            make.height.width.equalTo(30.fit)
        }
        
        view.addSubview(photoCollection)
        photoCollection.delegate = self
        photoCollection.dataSource = self
        
        photoCollection.snp.makeConstraints{(make) in
            make.left.equalTo(view.snp.left).offset(60.fit)
            make.bottom.equalTo(view.snp.bottom).offset(-15.fit-kBottomSafeHeight)
            make.right.equalTo(view.snp.right).offset(0.fit)
            make.height.equalTo(120.fit)
        }
        
    }
    
    func configNav(){
        self.navigation.bar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
    }
    
    func updateUI(){
        topView.updateUI(with: self.diaryData)
        DispatchQueue.main.async {
            switch self.diaryData.mood {
            case 26 ... 50:
                self.imageBtn.setImage(UIImage(named: "diary_icon_happy"), for: .normal)
            case 0 ... 25:
                self.imageBtn.setImage(UIImage(named: "diary_icon_calm"), for: .normal)
            case -25 ... -1:
                self.imageBtn.setImage(UIImage(named: "diary_icon_sad"), for: .normal)
            case -50 ... -26:
                self.imageBtn.setImage(UIImage(named: "diary_icon_sadmore"), for: .normal)
            default:
                self.imageBtn.setImage(UIImage(named: "diary_icon_happy"), for: .normal)
            }
        }
        self.diaryLabel.text = diaryData.content
        self.photoData = diaryData.images.components(separatedBy: ",")
        if photoData[0] == "" {
            photoData.removeAll()
        }
    }
    

}

// MARK: objc Mothed
extension DiaryDetailViewController{
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func alter(){
        let vc = DiaryAlterViewController(self.diaryData)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func showImage(){
        if isImageShow {
            UIView.animate(withDuration: 0.5) {
                self.photoCollection.alpha = 0
            }
        }else {
            UIView.animate(withDuration: 0.5) {
                self.photoCollection.alpha = 1
            }
        }
        isImageShow = !isImageShow
    }
}

extension DiaryDetailViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let offset = scrollView.contentOffset
        let translatePiont = scrollView.panGestureRecognizer.translation(in: scrollView)
        
        if scrollView == self.scrollView {
            if offset.y <= -64.0 {
                self.scrollView.bounces = false
                topView.showUI()
                self.navigation.item.title = ""
            }else {
                topView.hiddenUI()
                self.navigation.item.title = self.diaryData.dateStr
                
                if offset.y >= 0 {
                    self.scrollView.bounces = false
                }else {
                    
                    self.scrollView.bounces = true
                }
            
            }
        }
    }
}

extension DiaryDetailViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return    photoData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "diaryPhotoCell", for: indexPath) as! diaryPhotoCell
        // 设置选择图片展示在此界面
        let imgdata = photoData[indexPath.row]
        config(cell: cell, with: imgdata,and: indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 数据源
        let dataSource = JXLocalDataSource(numberOfItems: {
            // 共有多少项
                return 1
        }, localImage: { index -> UIImage? in
            // 每一项的图片对象
            return self.configPic(with: self.photoData[indexPath.row])
        })
        // 打开浏览器
        JXPhotoBrowser(dataSource: dataSource).show(pageIndex: 0)
        
    }
}

extension DiaryDetailViewController {
    func removePhoto(at index:Int) {
        let alert = UIAlertController.init(title: "确定要移除这张图片吗？", message: "请选择", preferredStyle: .alert)
        let yesAction = UIAlertAction.init(title: "确定", style: .default) { (yes) in
                self.photoData.remove(at: index)
                self.photoCollection.reloadData()
            print("删除后的photoData",self.photoData)
        }
        let noAction = UIAlertAction.init(title: "取消", style: .default) { (no) in }
        alert.addAction(noAction)
        alert.addAction(yesAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func selectPhoto() {
        _ = self.presentHGImagePicker(maxSelected: 9, completeHandler: { (assets) in
            for asset in assets {
                self.photoData.append(asset.localIdentifier)
            }
            self.photoCollection.reloadData()
        })
        print(photoData)

    }
    func config(cell:diaryPhotoCell,with data:String,and indexPath:IndexPath) {
        let result = PHAsset.fetchAssets(withLocalIdentifiers: [data].compactMap{ $0 },options: nil) as? PHFetchResult
        result?.enumerateObjects({ (obj, index, stop) in
            let imageAsset = obj as? PHAsset
            if let imageAsset = imageAsset {
                let img = SKPHAssetToImageTool.PHAssetToImage(asset: imageAsset)
                cell.photo.image = img
            }
        })
        cell.deleteButton.isHidden = true
        cell.indexPath = indexPath
        cell.delegate  = self
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

// MARK: 删除图片代理
extension DiaryDetailViewController:DiaryCellDelegate {
    func photoDelete(with indexPath: IndexPath) {
        removePhoto(at: indexPath.row)
    }
}
