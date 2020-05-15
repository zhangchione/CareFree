//
//  CFNotesViewController.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/15.
//  Copyright © 2020 张驰. All rights reserved.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa
import Fuse
import FSCalendar


// MARK:  Register cellID
private let CFNotesMarkCellID = "CFHomeMarkCell"

private let DwriteDiaryCellID = "DwriteDiaryCell"
private let DshowDiaryCellID = "DshowDiaryCell"


class CFNotesViewController: CFBaseViewController {

    // 数据
    
    var notesArrayDatas = ["11","22","11","22"]
    // 选择按钮
    lazy var selectedBtn:UIButton = {
       let btn = UIButton()
        btn.setTitle("所有便签", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        return btn
    }()
    // 添加悬浮按钮
    lazy var addBtn:UIButton = {
       let btn = UIButton()
        
        btn.setImage(UIImage(named: "notes_title_add"), for: .normal)
        btn.frame = CGRect(x: CFWidth, y: 4*CFHeight/5, width: 60.fit, height: 60.fit)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 30.fit
        btn.layer.masksToBounds = false
        btn.layer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 4.fit)
        btn.layer.shadowOpacity = 1
        btn.layer.shadowRadius = 12.fit
        return btn
    }()
    
    // 主界面控件
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.register(CFHomeMarkCell.self, forCellWithReuseIdentifier: CFNotesMarkCellID)
        
        collection.backgroundColor = .white
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    //MARK: life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
}
// MARK: Config
extension CFNotesViewController {
    
    func configUI(){
        
        
        self.view.backgroundColor = .white
        self.Title.text = "便贴"
        self.navigation.bar.barTintColor = .white
        self.navigation.bar.alpha = 1


        self.view.addSubview(self.selectedBtn)
        self.selectedBtn.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view.snp.left).offset(20.fit)
            make.top.equalTo(self.navigation.bar.snp.bottom).offset(10.fit)
            make.height.equalTo(30.fit)
            make.width.equalTo(100.fit)
        }
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            
            make.bottom.equalToSuperview()
            make.top.equalTo(self.selectedBtn.snp.bottom).offset(0.fit)
        }
        
        self.view.addSubview(self.addBtn)
        showAddBtn()
    }
    
}


// MARK: action
extension CFNotesViewController {
    func hiddenBtn(){
        UIView.animate(withDuration: 0.5) {
            self.addBtn.frame = CGRect(x: CFWidth, y: 4*CFHeight/5, width: 60.fit, height: 60.fit)
        }
    }
    func showAddBtn() {
        UIView.animate(withDuration: 0.5) {
            self.addBtn.frame = CGRect(x: CFWidth-100.fit, y: 4*CFHeight/5, width: 60.fit, height: 60.fit)
        }

    }
}
extension CFNotesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.notesArrayDatas.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell :CFHomeMarkCell =  collectionView.dequeueReusableCell(withReuseIdentifier: CFNotesMarkCellID, for: indexPath) as! CFHomeMarkCell
        cell.updateUI(with: CFNotesModel())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize(width: CFWidth, height: 160.fit)
        
    }
    
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 20.fit, left: 0, bottom: 20.fit, right: 0)
        
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.fit
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.fit
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1{
            let vc = DiaryDetailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
// MARK: 滑动代理
extension CFNotesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY <= 0 {
            self.showAddBtn()
        }else {
            self.hiddenBtn()
        }
    }
}
