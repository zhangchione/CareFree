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
import RealmSwift

class showDiaryController: UIViewController {
    
    private var headData:DiaryTodayModel?
    
    convenience init(headData:DiaryTodayModel?) {
        self.init()
        self.headData = headData
        print("传递数据的内容为：\(headData?.content)")
        dataHeadSource.data.append(headData!)
    }
    
    let realm = try! Realm()
    
    fileprivate let dataHeadSource = ArrayDataSource(data:[DiaryTodayModel]())
    fileprivate lazy var collectionView = CollectionView()
    fileprivate let dataBodySource = ArrayDataSource(data:[nowModel]())
    
    public var emotionLayer:CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        configCV()
        configData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        print("11111")
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
        
        let now = Date()
        let timeForMatter = DateFormatter()
        timeForMatter.dateFormat = "yyyyMMdd"
        let id = timeForMatter.string(from: now)
         let predicate = NSPredicate(format: "dayId = %@", id)
        let nowdatas = realm.objects(diaryNow.self).filter(predicate)
        
        var model = nowModel()
        
        for data in nowdatas {
            model.content = data.content
            model.mode = data.mode
            model.time = (data.date as NSString).substring(with: NSMakeRange(12,6))
            self.dataBodySource.data.append(model)
        }
        

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
        var updateDiaryTap = UITapGestureRecognizer()
    @objc func update() {
        
        let now = Date()
        let timeForMatter = DateFormatter()
        timeForMatter.dateFormat = "yyyyMMdd"
        let id = timeForMatter.string(from: now)
        let predicate = NSPredicate(format: "id = %@", id)
        let nowdatas = realm.objects(diaryToday.self).filter(predicate).first
        
        let writeVC = diaryWriteController(modeType: "修改今日描述")
        let emotionLayer = CAGradientLayer()
        emotionLayer.frame = writeVC.view.bounds
        emotionLayer.colors = [UIColor.white.cgColor,UIColor.white.cgColor]
        emotionLayer.cornerRadius = 30
        let topColor = UIColor.black
        let writeColor = UIColor.init(r: 127, g: 127, b: 127)
        writeVC.topColor = topColor
        writeVC.writeColor = writeColor
        writeVC.emotionLayer = emotionLayer
        writeVC.content = nowdatas!.content
        
        for img in nowdatas!.images {
            writeVC.photoData.append(img)
        }
        self.present(writeVC, animated: true, completion: nil)
        
        
       
    }
    
    func configCV(){
        
        let viewHeadSource = ClosureViewSource(viewUpdater: {(view:showHeadCell,data:DiaryTodayModel,index:Int) in
            view.updateUI(with: data)
            
            // 主线程更新头部渐变色
            DispatchQueue.main.async {
                self.emotionLayer.frame = view.headView.bounds
                view.headView.layer.addSublayer(self.emotionLayer)
            }
            self.updateDiaryTap.addTarget(self, action: #selector(self.update))
            view.centerView.addGestureRecognizer(self.updateDiaryTap)

        })
        let sizeHeadSource = {(index:Int,data:DiaryTodayModel,collectionSize:CGSize) ->CGSize in
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
        
        providerBody.tapHandler = { context -> Void in
            print(context.index)
            
            
            let now = Date()
            let timeForMatter = DateFormatter()
            timeForMatter.dateFormat = "yyyyMMdd"
            let id = timeForMatter.string(from: now) + String(context.index)
            let predicate = NSPredicate(format: "id = %@", id)
            let nowdatas = self.realm.objects(diaryNow.self).filter(predicate).first
            
            let writeVC = diaryWriteController(type: "修改此刻描述",id: id)
            let emotionLayer = CAGradientLayer()
            emotionLayer.frame = writeVC.view.bounds
            emotionLayer.colors = [UIColor.white.cgColor,UIColor.white.cgColor]
            emotionLayer.cornerRadius = 30
            let topColor = UIColor.black
            let writeColor = UIColor.init(r: 127, g: 127, b: 127)
            writeVC.topColor = topColor
            writeVC.writeColor = writeColor
            writeVC.emotionLayer = emotionLayer
            writeVC.content = nowdatas!.content
            
            for img in nowdatas!.images {
                writeVC.photoData.append(img)
            }
            print("修改第\(context.index)记录")
            self.present(writeVC, animated: true, completion: nil)
        }
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
