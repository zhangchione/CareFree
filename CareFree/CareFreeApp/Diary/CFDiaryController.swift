//
//  CFDiaryController.swift
//  CareFree
//
//  Created by 张驰 on 2019/7/28.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


// MARK:  Register cellID
private let DsearchCellID = "DsearchCell"
private let DwriteDiaryCellID = "DwriteDiaryCell"
private let DshowDiaryCellID = "DshowDiaryCell"


class CFDiaryController: CFBaseViewController {

    
    // 右边日历按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:40, height: 40)
        //button.addTarget(self, action: #selector(calendar), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named: "calendar_right"), for: .normal)
        
        //button.backgroundColor = UIColor.red
        return button
    }()
    
    // 主界面控件
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.register(DsearchCell.self, forCellWithReuseIdentifier: DsearchCellID)
        collection.register(DwriteDiaryCell.self, forCellWithReuseIdentifier: DwriteDiaryCellID)
        collection.register(DshowDiaryCell.self, forCellWithReuseIdentifier: DshowDiaryCellID)
        collection.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    var data = [DayDiaryModel]()
    lazy var viewModel:CFDiaryViewModel = {
        return CFDiaryViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configData()
    }
    override func viewWillAppear(_ animated: Bool) {
        configData()
    }


}
// MARK: Config
extension CFDiaryController {
    
    func configUI(){
        
        self.Title.text = "日记"
        self.navigation.item.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        self.view.addSubview(self.collectionView)
        
        self.collectionView.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.bottom.equalTo(self.view.snp.bottom).offset(-88)
            make.top.equalTo(self.navigation.bar.snp.bottom).offset(0)
        }
        
    }
    
    func configData(){
        let das = DataBase.shared.queryAll()
        for da in das {
            print("da:",da)
        }
        //DataBase.shared.deleteDayDiaryById(id: 1)
        self.viewModel.datas = DataBase.shared.queryAll()
        //print(DataBase.shared.queryDayDiaryAll())
        collectionView.reloadData()
    }
    
    
}
extension CFDiaryController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section <= 1 {
            return 1
        }
        return self.viewModel.datas.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell :DsearchCell =  collectionView.dequeueReusableCell(withReuseIdentifier: DsearchCellID, for: indexPath) as! DsearchCell
            return cell
        }else if indexPath.section == 1{
        let cell :DwriteDiaryCell =  collectionView.dequeueReusableCell(withReuseIdentifier: DwriteDiaryCellID, for: indexPath) as! DwriteDiaryCell
            
        cell.writeBtn.addTarget(self, action: #selector(write), for: .touchUpInside)
        cell.backgroundColor = .white
       // cell.delegate = self
        let now = Date()
        let timeForMatter = DateFormatter()
        timeForMatter.dateFormat = "dd yyyy年MM月 HH点mm分 EE"
        let date = timeForMatter.string(from: now)
            cell.day.text = (date as NSString).substring(to: 2)
            cell.yearMouth.text = (date as NSString).substring(with: NSMakeRange(3,8))
            var weekText:String?
            switch (date as NSString).substring(from: 19) {
            case "Mon":
                weekText = "周一"
            case "Tue":
                weekText = "周二"
            case "Wed":
                weekText = "周三"
            case "Thu":
                weekText = "周四"
            case "Fri":
                weekText = "周五"
            case "Sat":
                weekText = "周六"
            default:
                weekText = "周日"
            }
            cell.week.text = weekText
            cell.delegate = self
        return cell
        }else {
            let cell :DshowDiaryCell = collectionView.dequeueReusableCell(withReuseIdentifier: DshowDiaryCellID, for: indexPath) as! DshowDiaryCell
            //cell.conten = diaryData[indexPath.row]
            cell.updateUI(with: self.viewModel.datas[indexPath.row])
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: CFWidth-40, height: 60)
        }else if indexPath.section == 1 {
            return CGSize(width: CFWidth-40, height: 160)
        }else {
            return CGSize(width: CFWidth-40, height: 180)
        }
    }
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: CFWidth-40, height: 15)
        }
        else {
            return CGSize(width: 0 , height: 0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2{
            let vc = ShowViewController(with: self.viewModel.datas[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
