//
//  TrashViewController.swift
//  CareFree
//
//  Created by 张驰 on 2020/5/16.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit

import ProgressHUD

// MARK:  Register cellID
private let CFTrashDiaryCellID = "CFTrashDiaryCell"
private let CFTrashNoteCellID = "CFTrashNoteCellI"

private let CFTrashHeaderViewID = "CFTrashHeaderView"

class TrashViewController: UIViewController {

    
    var trashDiaryDatas = [DiaryModel]()
    var trashNoteDatas = [CFNotesModel]()
    
    // 左边返回按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "hone_icon_back"), for: .normal)
        //button.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    // 主界面控件
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(DshowDiaryCell.self, forCellWithReuseIdentifier: CFTrashDiaryCellID)
        collection.register(CFHomeMarkCell.self, forCellWithReuseIdentifier: CFTrashNoteCellID)
        collection.register(CFHomeMarkHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CFTrashHeaderViewID)
        
        
        collection.backgroundColor = .white
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        configNav()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configData()
        self.collectionView.reloadData()
    }

    func configUI(){
        view.backgroundColor = .white
        
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.bottom.equalToSuperview()
            make.top.equalTo(self.navigation.bar.snp.bottom).offset(0.fit)
        }
    }
    
    func configNav(){
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        self.navigation.item.title = "废纸篓"
    }
    
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func configData(){
        
        let markData = DataBase.shared.queryDiaryAll(isTrash: true)
        self.trashDiaryDatas = markData
        
        let taskData = DataBase.shared.queryNoteAll(isTrash: true)
        self.trashNoteDatas = taskData
    }
    
    
}
extension TrashViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return self.trashDiaryDatas.count
        }else {
            return trashNoteDatas.count
        }
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
             let cell: DshowDiaryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CFTrashDiaryCellID, for: indexPath) as! DshowDiaryCell
            cell.updateUI(with: trashDiaryDatas[indexPath.row])
            return cell
        }else {
            let cell: CFHomeMarkCell =  collectionView.dequeueReusableCell(withReuseIdentifier: CFTrashNoteCellID, for: indexPath) as! CFHomeMarkCell
            cell.updateUI(with: trashNoteDatas[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: CFWidth, height: 180.fit)
        }else {
            return CGSize(width: CFWidth, height: 160.fit)
        }
    }
    
    // 头部
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CFTrashHeaderViewID, for: indexPath) as? CFHomeMarkHeaderView else {
            return UICollectionReusableView()
        }

        headerView.titleLabel.textColor = UIColor.black
        headerView.titleLabel.font = UIFont.init(name: "PingFangSC-Semibold", size: 24.fit)
        if indexPath.section == 0 {
            headerView.titleLabel.text = "日记"
        }else {
            headerView.titleLabel.text = "便贴"
        }
        return headerView
    }
    // 头部高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 || section == 1{
            return CGSize(width: CFWidth, height: 40.fit)
        }else {
            return CGSize(width: CFWidth, height: 0.fit)
        }
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
        if indexPath.section == 0 {
            let data = trashDiaryDatas[indexPath.row]
            deleteDiary(with: data.id)
        }else if indexPath.section == 1 {
            let data = trashNoteDatas[indexPath.row]
            deleteNote(with: data.id)
        }
    }
    
    func deleteDiary(with id:Int){
        let actionSheet = UIAlertController(title: "日记操作", message: "请选择想要进行的步骤", preferredStyle: .actionSheet)
        let alterUserImg = UIAlertAction(title: "恢复日记", style: .default, handler: {(alters:UIAlertAction) -> Void in
            guard DataBase.shared.changeDiaryInTrashStatus(at: id,with: false) else {
                ProgressHUD.showError("恢复失败")
                return
            }
            ProgressHUD.showSuccess("恢复成功")
            self.configData()
            self.collectionView.reloadData()
        })
        
        let alterUserImgTake = UIAlertAction(title: "彻底扔掉", style: .destructive, handler: {(alters:UIAlertAction) -> Void in
            
            guard DataBase.shared.deleteDiary(with: id) else {
                ProgressHUD.showError("扔掉失败")
                return
            }
            ProgressHUD.showSuccess("扔掉成功")
            self.configData()
            self.collectionView.reloadData()
            
        })
        
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: {(alters:UIAlertAction) -> Void in print("取消更改头像")})
        
        actionSheet.addAction(cancel)
        actionSheet.addAction(alterUserImg)
        actionSheet.addAction(alterUserImgTake)
        
        self.present(actionSheet,animated: true){

        }
    }
    func deleteNote(with id:Int){
        let actionSheet = UIAlertController(title: "便贴操作", message: "请选择想要进行的步骤", preferredStyle: .actionSheet)
        let alterUserImg = UIAlertAction(title: "恢复便贴", style: .default, handler: {(alters:UIAlertAction) -> Void in
            guard DataBase.shared.changeNoteInTrashStatus(at: id,with: false) else {
                ProgressHUD.showError("恢复失败")
                return
            }
            ProgressHUD.showSuccess("恢复成功")
            self.configData()
            self.collectionView.reloadData()
        })
        
        let alterUserImgTake = UIAlertAction(title: "彻底扔掉", style: .destructive, handler: {(alters:UIAlertAction) -> Void in
            
            guard DataBase.shared.deleteNote(with: id) else {
                ProgressHUD.showError("扔掉失败")
                return
            }
            ProgressHUD.showSuccess("扔掉成功")
            self.configData()
            self.collectionView.reloadData()
            
        })
        
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: {(alters:UIAlertAction) -> Void in print("取消更改头像")})
        
        actionSheet.addAction(cancel)
        actionSheet.addAction(alterUserImg)
        actionSheet.addAction(alterUserImgTake)
        
        self.present(actionSheet,animated: true){

        }
    }
}
