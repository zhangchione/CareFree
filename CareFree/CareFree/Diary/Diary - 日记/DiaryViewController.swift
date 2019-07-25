//
//  DiaryViewController.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/20.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController {
    
    
    var dismissKetboardTap = UITapGestureRecognizer()
    
    @objc func dismissKeyboard(){
        print("键盘成功关闭")
        self.view.endEditing(false)
    }
    
    // MARK - 右边日历按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:40, height: 40)
        button.addTarget(self, action: #selector(calendar), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named: "calendar_right"), for: .normal)
        //button.backgroundColor = UIColor.red
        return button
    }()
    // MARK - 左边标题
    fileprivate lazy var Title:UILabel = {
        let label = UILabel()
        label.text = "日记"
        return label
    }()
    
    // MARK - cell 注册ID
    private let DsearchCellID = "DsearchCell"
    private let DwriteDiaryCellID = "DwriteDiaryCell"
    private let DshowDiaryCellID = "DshowDiaryCell"
    
    // MARK - collectionView
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.register(DsearchCell.self, forCellWithReuseIdentifier: DsearchCellID)
        collection.register(DwriteDiaryCell.self, forCellWithReuseIdentifier: DwriteDiaryCellID)
        collection.register(DshowDiaryCell.self, forCellWithReuseIdentifier: DshowDiaryCellID)
        collection.backgroundColor = UIColor.init(r: 248, g: 249, b: 254)
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    
    lazy var viewModel: DiaryViewModel = {
        return DiaryViewModel()
    }()

    var contents = [diaryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        var model = diaryModel()
        model.day = "25"
        model.yearMouth = "2019年7月"
        model.week = "周四"
        model.content = "  上班好累呀！好想休息，去浪迹天涯诶，上班真累，难过ing 😞 🙁！"
        model.value = -15
        model.count = 4
        contents.append(model)
        
        model.day = "24"
        model.yearMouth = "2019年7月"
        model.week = "周三"
        model.content = "  今天的歌很平静如水就像我的心情一样。静下心来感受生活"
        model.value = 12
        model.count = 3
        contents.append(model)
        
        model.day = "23"
        model.yearMouth = "2019年7月"
        model.week = "周二"
        model.content = "  关于你的回忆，我只知道，你不会再理我了"
        model.value = -12
        model.count = 1
        contents.append(model)
        
        model.day = "22"
        model.yearMouth = "2019年7月"
        model.week = "周一"
        model.content = "  你知道嘛，认认真真喜欢一个人，会很累呢 😫！"
        model.value = -30
        model.count = 2
        contents.append(model)
        
        configUI()
        configNavBar()
    }
    
    func configNavBar(){
        
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        Title.frame = CGRect(x: 22.fitWidth_CGFloat, y: 50.fitHeight_CGFloat, width: 100.fitWidth_CGFloat, height: 40.fitHeight_CGFloat)

        Title.font = UIFont(name: "PingFangSC-Semibold", size: 26)
        view.addSubview(Title)
    }

    func configUI(){
        
//        dismissKetboardTap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
//        self.view.addGestureRecognizer(dismissKetboardTap)
        view.backgroundColor = UIColor.init(r: 248, g: 249, b: 254)
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.bottom.equalTo(self.view.snp.bottom).offset(-88)
            make.top.equalTo(self.navigation.bar.snp.bottom).offset(0)
        }
    }
    
    func configData(){
        
    }


}

// MARK - 导航栏按钮方法以及其他按钮方法
extension DiaryViewController {
    @objc func calendar(){
        print("右边日历选择按钮")
    }
    
    @objc func write(){
        print("跳转写日记界面...")
        
        let writeVC = diaryWriteController()
        let emotionLayer = CAGradientLayer()
        emotionLayer.frame = writeVC.view.bounds
        emotionLayer.colors = [UIColor.white.cgColor,UIColor.white.cgColor]
        emotionLayer.cornerRadius = 30
        let topColor = UIColor.black
        let writeColor = UIColor.init(r: 127, g: 127, b: 127)
        writeVC.topColor = topColor
        writeVC.writeColor = writeColor
        writeVC.emotionLayer = emotionLayer
        
        self.present(writeVC, animated: true, completion: nil)
    }
    
}

// MARK - collectionView

extension DiaryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section <= 1 {
            return 1
        }
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell :DsearchCell =  collectionView.dequeueReusableCell(withReuseIdentifier: DsearchCellID, for: indexPath) as! DsearchCell
            return cell
        }else if indexPath.section == 1{
        let cell :DwriteDiaryCell =  collectionView.dequeueReusableCell(withReuseIdentifier: DwriteDiaryCellID, for: indexPath) as! DwriteDiaryCell
        cell.writeBtn.addTarget(self, action: #selector(write), for: .touchUpInside)
        cell.backgroundColor = .white
        cell.delegate = self
        return cell
        }else {
            let cell :DshowDiaryCell = collectionView.dequeueReusableCell(withReuseIdentifier: DshowDiaryCellID, for: indexPath) as! DshowDiaryCell
            cell.conten = contents[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: 374, height: 60)
        }else if indexPath.section == 1 {
            return CGSize(width: 374, height: 160)
        }else {
            return CGSize(width: 374, height: 180)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2{
            let showDiaryVC = showDiaryController()
            let emotionLayer = CAGradientLayer()
            emotionLayer.colors = [UIColor.init(r: 155, g: 121, b: 255).cgColor,UIColor.init(r: 96, g: 114, b: 255).cgColor]
            showDiaryVC.emotionLayer = emotionLayer
            self.navigationController?.pushViewController(showDiaryVC, animated: true)
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
            return CGSize(width: 374, height: 15)
        }
        else {
            return CGSize(width: 0 , height: 0)
        }
    }

}




// MARK - 点击方法按钮进入相对应情绪日记编写界面

extension DiaryViewController:diaryWriteDelegate {
    func diaryWriteClick(mood: Int) {
        
        let writeVC = diaryWriteController()
        let emotionLayer = CAGradientLayer()
        emotionLayer.frame = writeVC.view.bounds
        switch mood {
        case 0:
            emotionLayer.colors = [UIColor.init(r: 56, g: 213, b: 214).cgColor,UIColor.init(r: 63, g: 171, b: 213).cgColor]
        case 1:
            emotionLayer.colors = [UIColor.init(r: 118, g: 175, b: 227).cgColor,UIColor.init(r: 91, g: 123, b: 218).cgColor]
        case 2:
            emotionLayer.colors = [UIColor.init(r: 151, g: 136, b: 248).cgColor,UIColor.init(r: 160, g: 115, b: 218).cgColor]
        case 3:
            emotionLayer.colors = [UIColor.init(r: 43, g: 88, b: 118).cgColor,UIColor.init(r: 9, g: 32, b: 63).cgColor]
        default: break
        }
        writeVC.emotionLayer = emotionLayer
        self.present(writeVC, animated: true, completion: nil)
        
       
    }

}
