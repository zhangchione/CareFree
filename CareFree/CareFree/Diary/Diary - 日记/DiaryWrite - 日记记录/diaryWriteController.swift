//
//  diaryWriteController.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/7.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import SnapKit
import CollectionKit
import RealmSwift

class diaryWriteController: UIViewController {

    /// 照片多选
    
    private var type:String?
    private var dayId:String?
    
    convenience init(modeType:String) {
        self.init()
        self.type = modeType
    }
    
    convenience init(type: String,id: String){
        self.init()
        self.type = type
        self.dayId = id
    }
    
    
    var dismissKetboardTap = UITapGestureRecognizer()
    
    @objc func dismissKeyboard(){
        print("键盘成功关闭")
        self.view.endEditing(false)
    }
    
    fileprivate let dataHeadSource = ArrayDataSource(data:[1])
    fileprivate lazy var collectionView = CollectionView()
    
    public var emotionLayer: CAGradientLayer!
    public var topColor = UIColor.white
    public var writeColor = UIColor.white
    
    private lazy var pictureImages = [UIImage]()
    
    let realm = try! Realm()
    // 今日日记
    var writeDiaryData = diaryToday()
    
    // 此刻日记
    var writeDiaryNow = diaryNow()
    
    var photoData = [Data]()
    
    var photo:[String]? {
        didSet {
            print("12342")
        }
    }
    
    //照片选取
    var imagePickerController : UIImagePickerController!
    
    lazy var selectImg :UIImageView = {
       let vi = UIImageView()
        return vi
    }()
    
    
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
    
    var content = "快记录一下吧~"
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.configUI()
            self.configCV()
        }

    }
    
    func configUI(){
        dismissKetboardTap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(dismissKetboardTap)
        self.photoCollection.addGestureRecognizer(dismissKetboardTap)
        view.backgroundColor = UIColor.clear
        //view.addSubview(backgroundView)
        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        //collectionView.isScrollEnabled = false
        collectionView.alwaysBounceVertical = false
        //collectionView.backgroundColor = UIColor.yellow
        
       
        
        collectionView.snp.makeConstraints{(make) in
            make.bottom.right.left.equalTo(view)
            make.top.equalTo(view).offset(0)
        }
 
        view.addSubview(photoCollection)
        photoCollection.delegate = self
        photoCollection.dataSource = self
        
        photoCollection.snp.makeConstraints{(make) in
            make.left.equalTo(view.snp.left).offset(27)
            make.top.equalTo(view.snp.top).offset(500)
            make.bottom.equalTo(view.snp.bottom).offset(5)
            make.right.equalTo(view.snp.right).offset(-27)
        }
        

    }
    

    
    func configCV(){
        let viewHeadSource = ClosureViewSource(viewUpdater: {(view:writeDiaryCell,data:Int,index:Int) in

            DispatchQueue.main.async {
                view.backgroundView.layer.addSublayer(self.emotionLayer)
                view.saveBtn.setTitleColor(self.topColor, for: .normal)
                view.backBtn.setTitleColor(self.topColor, for: .normal)
                view.Title.textColor = self.topColor
                view.diaryWirte.textColor = self.writeColor
            }
            view.addGestureRecognizer(self.dismissKetboardTap)
            view.delegate = self
            view.diaryWirte.text = self.content //"快记录一下吧~"
            view.diaryWirte.textColor = UIColor.lightGray
            view.diaryWirte.delegate = self
            view.backBtn.addTarget(self, action: #selector(self.back), for: .touchUpInside)
            view.saveBtn.addTarget(self, action: #selector(self.save), for: .touchUpInside)
            
            
            view.updateUI()
        })
        let sizeHeadSource = {(index:Int,data:Int,collectionSize:CGSize) ->CGSize in
            return CGSize(width: collectionSize.width, height: 806)
        }
        
        let provider = BasicProvider(
            dataSource: dataHeadSource,
            viewSource: viewHeadSource,
            sizeSource:sizeHeadSource
        )
        collectionView.provider = provider
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    var flag = 0

}

extension diaryWriteController:UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ content: UITextView) -> Bool {
        if (content.text == "快记录一下吧~") {
            content.text = ""
        }
        if self.topColor == .black {
        content.textColor = UIColor.black
        }else {
                    content.textColor = UIColor.white
        }
        return true
        
    }
    func textViewDidChange(_ textView: UITextView) {
        writeDiaryData.content = textView.text
        writeDiaryNow.content = textView.text
        self.content = textView.text
        if self.type == "描述今日" {
        print("改变的内容为：",self.writeDiaryData.content)
        }else {
        print("此刻改变的内容为：",self.writeDiaryNow.content)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
    }
    // 右边保存按钮事件
    @objc func save(){
        
        
        let now = Date()
        let timeForMatter = DateFormatter()

        
        timeForMatter.dateFormat = "yyyyMMdd"
        let id = timeForMatter.string(from: now)
        timeForMatter.dateFormat = "dd yyyy年MM月 HH点mm分 EE"
        let date = timeForMatter.string(from: now)

        if self.type == "描述今日" {
            writeDiaryData.location = "上海"
            writeDiaryData.mode = Int(arc4random() % 50)
            writeDiaryData.date = date
            let allDiary = realm.objects(diaryToday.self)
            writeDiaryData.id = id 
            if allDiary.count % 3 == 0 {
                writeDiaryData.mode = -writeDiaryData.mode
            }
            for img in photoData {
                writeDiaryData.images.append(img)
            }
            
            saveDiaryData(item: writeDiaryData)
            print("描述今日日记保存成功")
        }else if self.type == "此刻"{
            writeDiaryNow.location = "上海"
            writeDiaryNow.mode = Int(arc4random() % 50)
            writeDiaryNow.date = date
            let predicate = NSPredicate(format: "dayId = %@", id)
            let allNowDiary = realm.objects(diaryNow.self).filter(predicate)
            writeDiaryNow.id = id + String(allNowDiary.count)
            writeDiaryNow.dayId = id
            if allNowDiary.count % 3 == 0 {
                writeDiaryNow.mode = -writeDiaryNow.mode
            }
            for img in photoData {
                writeDiaryNow.images.append(img)
            }

            saveDiaryNow(item: writeDiaryNow)
            
            let predicate1 = NSPredicate(format: "id = %@", id)
            let today = realm.objects(diaryToday.self).filter(predicate1).first
            try! realm.write {
                today?.count += 1
                if writeDiaryNow.mode > 25 {
                    today?.happy += 1
                }else if writeDiaryNow.mode > 0 {
                    today?.calm += 1
                    
                }else if writeDiaryNow.mode > -25{
                    today?.sad += 1
                }else {
                    today?.so_sad += 1
                }
                today?.mode = (today!.mode * (today!.count - 1 ) + writeDiaryNow.mode) / today!.count
            }
            
            print("此刻日记保存成功")
        }else if self.type == "修改今日描述"{
            let predicate = NSPredicate(format: "id = %@", id)
            let myup = realm.objects(diaryToday.self).filter(predicate).first
            try! realm.write {
               myup?.content = self.content
                myup?.images.removeAll()
                for img in photoData {
                    myup?.images.append(img)
                }
            }
            print("今日描述修改成功")
        }else {

            let predicate = NSPredicate(format: "id = %@", dayId!)
            let myup = realm.objects(diaryNow.self).filter(predicate).first
            try! realm.write {
                myup?.content = self.content
                myup?.images.removeAll()
                for img in photoData {
                    myup?.images.append(img)
                }
            }
            print("此刻修改成功")
        }

        //键盘消失
        self.view.endEditing(false)
        self.dismiss(animated: true, completion: nil)
    }
    
    // 今日日记保存至Realm 数据库
    func saveDiaryData(item:diaryToday)
    {
            do {
                try realm.write {
                    realm.add(item)
                    print("数据保存完毕")
                }
            }catch {
                print("数据保存出错")
            }
    }
    
    // 此刻日记保存至Realm 数据库
    func saveDiaryNow(item:diaryNow)
    {
        do {
            try realm.write {
                realm.add(item)
                print("数据保存完毕")
            }
        }catch {
            print("数据保存出错")
        }
    }
    
    // 左边退出按钮事件
    @objc func back(){
        print("退出写日记界面")
        //键盘消失
        self.view.endEditing(false)
        self.dismiss(animated: true, completion: nil)
    }
    
    

    
    func getDayOfWeek(_ today:String) -> String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        
        return String(weekDay)
    }
    func SPhoto() {
        print("照片正在选取")
    }
}

// MARK - 相册照片选取
extension diaryWriteController:WriteDiaryDelegate,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    @objc func selectPhoto() {
        print("照片正在选取")
        
        
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.navigationBar.barTintColor = UIColor.orange
        self.present(imagePickerController, animated: true, completion: nil )
        print("相册打开成功")
    }
    
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//
//            let image = info["UIImagePickerControllerEditedImage"] as! UIImage
//            flag += 1
//            print("flag:\(flag)")
//            let newImage = image.imageWithScale(width: 300)
//            // 1.将当前选中的图片添加到数组中
//            pictureImages.append(newImage)
//            print("图片的数量=\(pictureImages.count)")
//            collectionView.reloadData()
//                    picker.dismiss(animated: true, completion: nil)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print(info[UIImagePickerController.InfoKey.imageURL]!)
           
            
//            let newItem = selectphoto()
            let imageURL = info[UIImagePickerController.InfoKey.imageURL]!
            let imageData = try! Data(contentsOf: imageURL as! URL)

            photoData.append(imageData)
           self.collectionView.reloadData()
           self.photoCollection.reloadData()
        }

        dismiss(animated: true, completion: nil)
    
    }

}

extension diaryWriteController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  photoData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "diaryPhotoCell", for: indexPath) as! diaryPhotoCell
        if indexPath.row == 0 {
            let selectTap = UITapGestureRecognizer(target: self, action: #selector(self.selectPhoto))
            cell.addGestureRecognizer(selectTap)
            cell.photo.image = UIImage(named: "img_hand_addpic")
            print("选取按钮")
        }
        else {
            // 设置选择图片展示在此界面
            let imgdata = photoData[indexPath.row - 1]
            cell.photo.image = UIImage(data: imgdata)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
        @objc func selectPhoto1(){
            //delegate?.selectPhoto()
        }
    
}
