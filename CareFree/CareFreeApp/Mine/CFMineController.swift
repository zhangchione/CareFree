//
//  CFMineController.swift
//  CareFree
//
//  Created by 张驰 on 2019/7/25.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import CollectionKit
import SnapKit
import Hero


extension CFMineController: MineBodyViewDelegate {
    func setCallBack(type: SetViewOnBodyViewType,isOn:Bool) {
        
        switch type {
        case .taskTop:
            saveSetHomeShowMark(value:isOn)
        case .showTask:
            saveSetHomeShowTask(value: isOn)
        }
        
        print(getSetHomeShowMark())
    }
    
    func mineCardTapCallBack(type: CardType) {
        print(type)
        var vc = UIViewController()
        switch type {
        case .set:
            vc = SetViewController()
        case .trash(_ ):
            vc = TrashViewController()
        default:
            break
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


extension CFMineController: UIScrollViewDelegate {
    
}

class CFMineController: CFBaseViewController {

    
    
    
    var mineHeaderData = MineHeaderViewModel()
    
    var mineBodyData = MineBodyModel()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
            scrollView.delegate = self
            scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let vi = UIView()
        return vi
    }()
    
    lazy var headerView: MineHeaderView = {
       let headerView = MineHeaderView()
        return headerView
    }()
    
    lazy var bodyView: MineBodyView = {
       let bodyView = MineBodyView()
        bodyView.delegate = self
        return bodyView
    }()
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        configNav()
    }
    override func viewWillAppear(_ animated: Bool) {
        configData()
        updateUI()
    }


    
    func setUI(){
        self.Title.text = "我的"
        self.view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(CFHeight)
        }
        
        contentView.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.left.equalTo(scrollView.snp.left)
            make.right.equalTo(scrollView.snp.right)
            make.top.equalTo(scrollView.snp.top).offset(10.fit)
            make.height.equalTo(130.fit)
        }
        contentView.addSubview(bodyView)
        bodyView.snp.makeConstraints { (make) in
            make.left.equalTo(scrollView.snp.left)
            make.right.equalTo(scrollView.snp.right)
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
    }
    
    func configNav(){
        self.navigation.bar.barTintColor = .white
        self.navigation.bar.alpha = 1
    }
    
    func configData(){
        mineBodyData.emotionViewData = getTodayMoodValue()
        mineBodyData.diaryViewData = (getDiaryTotal(),getNotesTotal())
        mineBodyData.trashViewData = getTrashTotal()
        
        if let username = getUserName() {
            mineHeaderData.userName = username
        }
        if let bio = getUserBio() {
            mineHeaderData.bio = bio
        }
        if let data = getHeadImg() {
            mineHeaderData.img = UIImage(data: data)
        }
    }
    
    func updateUI(){
        self.bodyView.updateUI(with: mineBodyData)
        self.headerView.updateUI(with: mineHeaderData)
    }
    
    

}

extension CFMineController{
    
    @objc func trashEvent(){
        print("照片页面跳转中...")
        let trashVC = AlbumDetialController()
        self.navigationController?.pushViewController(trashVC, animated: true)
    }
    
    @objc func setEvent(){
        

        print("设置页面跳转中...")
        let setVC = SetController()
//        setVC.hero.isEnabled = true
//        setVC.backView.hero.id = "sky"
        //setVC.backUser = [["user","Jeffrey"],["",""],["",""]]
       self.navigationController?.pushViewController(setVC, animated: true)
    }
    @objc func diaryChartEvnent(){
        print("心情报表页面跳转中...")
    }
    @objc func back(){
        
    }
    
}

// 请求数据

//extension CFMineController {

//
//        var nowNum = 0
//        var dayNum = 0
//        var picNum = 0
//        var sevenAve = 0
//        var sevenMode = [Int]()
//
//        let datas =  DataBase.shared.queryAll()
//
//        for (index,data) in datas.enumerated() {
//
//            nowNum += data.nowDiary.count
//            let imgs = data.dayDiary.images.components(separatedBy: ",")
//            picNum += imgs.count
//            for da in data.nowDiary {
//                picNum += da.images.components(separatedBy: ",").count
//            }
//            if index < 7 {
//                sevenAve += data.mode
//                sevenMode.append(data.mode)
//            }
//        }
//        if datas.count >= 7{
//            sevenAve /= 7
//        }else if datas.count == 0 {
//
//        }else{
//            sevenAve /= datas.count
//        }
//        dayNum = datas.count
//        let mimedata = MineModel(id: "123", day_notes: "\(dayNum)", username: "cone", password: "123", mode: sevenAve, mode_value: sevenMode, sex: "1", now_notes: "\(nowNum)", head_pic: "",pics: "\(picNum)")
//        dataSource.data.removeAll()
//        dataSource.data.append(mimedata)
//        sevenMode.removeAll()
//        self.collectionView.reloadData()
//
//    }
//}
//
//    /// 以下没有用
//    var emotionLayer: CAGradientLayer!
//
//    fileprivate let dataSource = ArrayDataSource(data:[MineModel]())
//    fileprivate lazy var collectionView = CollectionView()
//
//
//
//
//
//    func congfigUI() {
//        self.Title.text = "我的"
//        view.addSubview(collectionView)
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.showsHorizontalScrollIndicator = false
//        //collectionView.isScrollEnabled = false
//        collectionView.alwaysBounceVertical = false
//        collectionView.snp.makeConstraints{(make) in
//            make.bottom.right.left.equalTo(view)
//            make.top.equalTo(navigation.bar.snp.bottom).offset(0)
//        }
//    }
//
//    var impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
//    public var duration = 0.3
//
//    func configCV(){
//        let viewSource = ClosureViewSource(viewUpdater: {(view:MineCell,data:MineModel,index:Int) in
//            view.updateUI(with:data)
//
//            let setTap = UITapGestureRecognizer(target: self, action: #selector(self.setEvent))
//            let trashTap = UITapGestureRecognizer(target: self, action: #selector(self.trashEvent))
//            let diaryChartTap = UITapGestureRecognizer(target: self, action: #selector(self.diaryChartEvnent))
//            view.setView.addGestureRecognizer(setTap)
//            view.trashView.addGestureRecognizer(trashTap)
//            view.moodView.addGestureRecognizer(diaryChartTap)
//
//            //view.oneBackView.layer.add(self.impliesAnimation, forKey: nil)
////            view.diaryView.layer.add(self.impliesAnimation, forKey: nil)
////            view.trashView.layer.add(self.impliesAnimation, forKey: nil)
////            view.moodView.layer.add(self.impliesAnimation, forKey: nil)
//            view.setView.layer.add(self.impliesAnimation, forKey: nil)
//
//            view.setView.hero.id = "sky"
//
//
//
//        })
//        let sizeSource = {(index:Int,data:MineModel,collectionSize:CGSize) ->CGSize in
//            return CGSize(width: collectionSize.width, height: 820.fit)
//        }
//
//        let provider = BasicProvider(
//            dataSource: dataSource,
//            viewSource: viewSource,
//            sizeSource:sizeSource
//        )
//        collectionView.provider = provider
//        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//    func configAnimation() {
//        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
//        impliesAnimation.duration = self.duration * 2
//        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
//    }
