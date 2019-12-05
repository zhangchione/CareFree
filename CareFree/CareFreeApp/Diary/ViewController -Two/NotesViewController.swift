//
//  NotesViewController.swift
//  CareFree
//
//  Created by 张驰 on 2019/11/30.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import Photos

enum NotesType {
    case Day
    case Happy
    case Calm
    case Sad
    case Repression
}


class NotesViewController: UIViewController {

    private var type:NotesType? //记录类型
    private var themColor = UIColor()
    private var colors = [CGColor]()
    private var photoData = [String]()
    private var photoImg = ""
    private var newDiary = false
    private var isDay = false
    private var id = -1
    // 编辑区域
    lazy var textView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.clear
        tv.font = UIFont.systemFont(ofSize: 20)
        tv.textColor = UIColor.lightGray
        tv.text = "快记录一下吧~"
        tv.delegate = self
        return tv
    }()
    // 照片区域
    lazy var photoCollection:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: 120, height:120)
        let collection = UICollectionView.init(frame:CGRect(x:100, y:50, width:265, height:180), collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        collection.register(UINib(nibName: "diaryPhotoCell", bundle: nil), forCellWithReuseIdentifier: "diaryPhotoCell")
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    // 左边返回按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        button.setTitle("←", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        button.tintColor = UIColor.red
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    
    // 右边完成按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        button.setTitle("完成", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(save), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.black, for: .normal)
        button.tintColor = UIColor.red
        return button
    }()
    
    convenience init(type:NotesType) {
        self.init()
        self.type = type
        switch type {
        case .Day:
            setUI(title: "今天", photoImg: "", colors: [UIColor.white.cgColor], themColor: .black)
        case .Happy:
            setUI(title: "此刻", photoImg: "", colors: happyGradientColor, themColor: .white)
        case .Calm:
            setUI(title: "此刻", photoImg: "", colors: calmGradientColor, themColor: .white)
        case .Sad:
            setUI(title: "此刻", photoImg: "", colors: sadGradientColor, themColor: .white)
        case .Repression:
             setUI(title: "此刻", photoImg: "", colors: repressioneGradientColor, themColor: .white)
        }
        self.newDiary = true
    }
    convenience init(dayData:DayDiaryModel) {
        self.init()
        self.id = dayData.id
        self.textView.text = dayData.content
        self.photoData = dayData.images.components(separatedBy: ",")
        if photoData[0] == "" {
            photoData.removeAll()
        }
        print(photoData)
        self.newDiary = false
        self.isDay = true
    }
    convenience init(nowData:NowDiaryModel) {
        self.init()
        self.id = nowData.id
        self.textView.text = nowData.content
        self.photoData = nowData.images.components(separatedBy: ",")
        if photoData[0] == "" {
            photoData.removeAll()
        }
        print(photoData)
        switch nowData.mode {
        case 26 ... 50:
            setUI(title: "此刻", photoImg: "", colors: happyGradientColor, themColor: .white)
        case 0 ... 25:
            setUI(title: "此刻", photoImg: "", colors: calmGradientColor, themColor: .white)
        case -25 ... -1:
           setUI(title: "此刻", photoImg: "", colors: sadGradientColor, themColor: .white)
        case -50 ... -26:
            setUI(title: "此刻", photoImg: "", colors: repressioneGradientColor, themColor: .white)
        default:
            break
        }
        self.newDiary = true
        self.isDay = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        configUI()
        
    }
    func setUI(title:String,photoImg:String,colors:[CGColor],themColor:UIColor) {
        self.title = title
        self.colors = colors
        self.themColor = themColor
        self.photoImg = photoImg
    }
    
}

// MARK: config
extension NotesViewController {
    func configUI(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKey))
        view.addGestureRecognizer(tap)
        view.backgroundColor = .white
        view.setLayerColors(self.colors)
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        view.addSubview(textView)
        view.addSubview(photoCollection)
        photoCollection.delegate = self
        photoCollection.dataSource = self
        
        textView.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(view).offset(20)
            make.height.equalTo(CFHeight/4)
        }
        
        photoCollection.snp.makeConstraints{(make) in
            make.left.equalTo(view.snp.left).offset(20)
            make.top.equalTo(textView.snp.bottom).offset(50)
            make.bottom.equalTo(view.snp.bottom).offset(5)
            make.right.equalTo(view.snp.right).offset(-20)
        }

    }
    func configNav(){
        self.navigation.item.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
    }
    @objc func closeKey(){
        self.view.endEditing(false)
    }
}
// MARK: method
extension NotesViewController{
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func save(){
        let content = textView.text!
        let images = self.photoData.joined(separator: ",")
        guard newDiary else {
            if isDay {
                if DataBase.shared.updateDayDiaryById(id: self.id, content: content, images: images) {
                    self.navigationController?.popToRootViewController(animated: true) 
                }
            }else {
                if DataBase.shared.updateNowDiaryById(id: self.id, content: content, images: images) {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
            
            return
        }
        

        let now = Date()
        let timeForMatter = DateFormatter()
        timeForMatter.dateFormat = "yyyyMMdd"
        let day_id = timeForMatter.string(from: now)
        switch type {
        case .Day:
            saveDayDiary(content: content,images:images)
        self.navigationController?.popViewController(animated: true)
        default:
            if DataBase.shared.queryDayDiaryByDayId(day_id:day_id ) {
                saveNowDiary(content: content,images:images)
                print("写入完成")
            }else {
                saveDayDiary(content: "今天还未描述哦~",images:"")
                saveNowDiary(content: content,images:images)
                print("不能写入")
            }
        self.navigationController?.popViewController(animated: true)
        }

    }
    func saveDayDiary(content:String,images:String){
        let now = Date()
        let timeForMatter = DateFormatter()
        timeForMatter.dateFormat = "yyyyMMdd"
        let day_id = timeForMatter.string(from: now)
        var saveData = DayDiaryModel()
        saveData.content = content
        saveData.date = now
        saveData.day_id = day_id
        saveData.mode = Int(arc4random() % 50)
        saveData.title = ""
        saveData.user_id = ""
        saveData.weather = ""
        saveData.images = images
        let rowid = DataBase.shared.insertDayDiary(with: saveData)
        print(rowid!)
    }
    func saveNowDiary(content:String,images:String){
        let now = Date()
        let timeForMatter = DateFormatter()
        timeForMatter.dateFormat = "yyyyMMdd"
        let day_id = timeForMatter.string(from: now)
        var saveData = NowDiaryModel()
        saveData.content = content
        saveData.date = now
        saveData.day_id = day_id
        saveData.mode = Int(arc4random() % 50)
        saveData.title = ""
        saveData.user_id = ""
        saveData.weather = ""
        saveData.images = images
        let rowid = DataBase.shared.insertNowDiary(with: saveData)
        print(rowid!)
    }
}
extension NotesViewController:UITextViewDelegate {

    func textViewShouldBeginEditing(_ content: UITextView) -> Bool {
        if (content.text == "快记录一下吧~") {
            content.text = ""
        }
        content.textColor = .black
        return true
    }
}
extension NotesViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  photoData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "diaryPhotoCell", for: indexPath) as! diaryPhotoCell
        if indexPath.row == photoData.count {
            cell.photo.image = UIImage(named: "img_hand_addpic")
        }
        else {
            // 设置选择图片展示在此界面
            let imgdata = photoData[indexPath.row]
            config(cell: cell, with: imgdata)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.row == photoData.count {
            selectPhoto()
        }
    }

    
}

extension NotesViewController {
    func selectPhoto() {
        _ = self.presentHGImagePicker(maxSelected: 9, completeHandler: { (assets) in
            for asset in assets {
                self.photoData.append(asset.localIdentifier)
            }
            self.photoCollection.reloadData()
        })
        print(photoData)

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
}