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


class CFNotesViewController: CFBaseViewController, UIGestureRecognizerDelegate {

    // 数据
    
    var notesArrayDatas = [CFNotesModel]()
    
    var btnIsDowm = false
    // 选择按钮
    lazy var selectedBtn:UIButton = {
       let btn = UIButton()
        btn.setTitle("普通便签", for: .normal)
        btn.titleLabel?.font = UIFont.init(name: "PingFangSC-Medium", size: 14.fit)
        let imageView = UIImageView()
        imageView.image = UIImage(named: "right_icon")?.withRenderingMode(.alwaysTemplate)
       // imageView.contentMode = .scaleAspectFit
        btn.setImage(imageView.image, for: .normal)
        btn.tintColor = UIColor.init(r: 96, g: 114, b: 255)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        btn.addTarget(self, action: #selector(allNotes), for: .touchUpInside)
        return btn
    }()
    
    @objc func allNotes(){
        UIApplication.shared.keyWindow?.addSubview(tapBackView)
        UIApplication.shared.keyWindow?.addSubview(selectedView)
        
         let imageView = UIImageView()
        if self.btnIsDowm {
            imageView.image = UIImage(named: "right_icon")?.withRenderingMode(.alwaysTemplate)
        }else {
            imageView.image = UIImage(named: "dwon_icon")?.withRenderingMode(.alwaysTemplate)
        }
        self.btnIsDowm = !self.btnIsDowm
         
        
        // imageView.contentMode = .scaleAspectFit
        UIView.animate(withDuration: 0.5) {
            self.selectedBtn.setImage(imageView.image, for: .normal)
            self.selectedView.frame = CGRect(x: 0, y: CFHeight-380.fit, width: CFWidth, height: 380.fit)
        }
        
        self.tapBackView.isHidden = false

    }
    // 添加悬浮按钮
    lazy var addBtn:UIButton = {
       let btn = UIButton()
        
        btn.setImage(UIImage(named: "notes_title_add"), for: .normal)
        btn.addTarget(self, action: #selector(note), for: .touchUpInside)
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
    
    @objc func note(){
        let vc = NoteWriteViewController(CFNotesModel(),type: .shorTimeGrade)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
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
    
    lazy var tapBackView:UIView = {
       let vi = UIView(frame: CGRect(x: 0, y: 0, width: CFWidth, height: CFHeight))
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKey))
        tap.delegate = self
        vi.addGestureRecognizer(tap)
        vi.backgroundColor = UIColor.black
        vi.alpha = 0.2
        vi.isHidden = true
        return vi
    }()
    
    @objc func closeKey(){
         let imageView = UIImageView()
        if self.btnIsDowm {
            imageView.image = UIImage(named: "right_icon")?.withRenderingMode(.alwaysTemplate)
        }else {
            imageView.image = UIImage(named: "dwon_icon")?.withRenderingMode(.alwaysTemplate)
        }
        self.btnIsDowm = !self.btnIsDowm
         
        
        UIView.animate(withDuration: 0.5) {
            self.selectedBtn.setImage(imageView.image, for: .normal)
            self.tapBackView.isHidden = true
            self.selectedView.frame = CGRect(x: 0, y: CFHeight, width: CFWidth, height: 400.fit)
        }
        
    }
    
    lazy var selectedView:NotesTypeSelectedView = {
       let vi = NotesTypeSelectedView()
        vi.frame = CGRect(x: 0, y: CFHeight, width: CFWidth, height: 380.fit)
        vi.delegate = self
        return vi
    }()
    
    //MARK: life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configData()
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
    
    func configData(){
        let data = DataBase.shared.queryNoteAll(isTrash: false)
        self.notesArrayDatas = data
        self.collectionView.reloadData()
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
        cell.updateUI(with: notesArrayDatas[indexPath.row])
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
        let data = notesArrayDatas[indexPath.row]
        var type:NoteWriteControllerType?
        switch data.priority {
        case 0:
            type = .shorTimeGrade
        case 1:
            type = .fristGrade
        case 2:
            type = .secendGrade
        case 3:
            type = .threeGrade
        case 10001:
            type = .markGrade
        default:
            type = .shorTimeGrade
        }
        let vc = NoteWriteViewController(data,type: type!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK: 滑动代理
extension CFNotesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
//        if offsetY <= 0 {
//            self.showAddBtn()
//        }else {
//            self.hiddenBtn()
//        }
    }
}
// MARK: 解决手势冲突
extension CFNotesViewController {

    // 手势冲突
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.collectionView))!{
            return false
        }
        return true
    }
}
extension CFNotesViewController:NoteTypeSelectedViewDelegate {
    func selectedViewCallBack(with data: [Int]) {
        var datas = [CFNotesModel]()
        data.forEach { (item) in
            let das = DataBase.shared.queryNote(by: item)
            datas += das
        }
        self.notesArrayDatas = datas
        self.collectionView.reloadData()
        if data.count == 4 {
            self.selectedBtn.setTitle("普通贴纸", for: .normal)
        }else if data.count == 5 {
            self.selectedBtn.setTitle("所有贴纸", for: .normal)
        }else if data.count == 1 {
            self.selectedBtn.setTitle("临时贴纸", for: .normal)
        }else  {
            self.selectedBtn.setTitle("任务贴纸", for: .normal)
        }
        closeKey()
    }
}
