//
//  DiaryAlterViewController.swift
//  CareFree
//
//  Created by 张驰 on 2020/5/5.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit
import Photos
import JXPhotoBrowser
import NaturalLanguage
import ProgressHUD



class DiaryAlterViewController: UIViewController {
    
    // 数据
    public var writeData = DiaryModel()
    
    convenience init(_ data:DiaryModel){
        self.init()
        self.writeData = data
    }
    
    // 照片数据
    var photoData = [String]()
    // 编辑区域
    lazy var textView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.clear
        tv.font = UIFont.systemFont(ofSize: 20.fit)
        tv.textColor = UIColor.white
        tv.text = textViewPlaceHolder
        tv.delegate = self
        return tv
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
        imageView.image = UIImage(named: "write_icon_check")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.white
        button.tintColor = UIColor.white
        button.setImage(imageView.image, for: .normal)

        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(save), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    // 右边删除按钮
    private lazy var rightDeleteBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:25, height: 25)
        //button.setTitle("删除", for: .normal)
        
        button.setImage(UIImage(named: "write_icon_whitedelete"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(deleteDiary), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        
        //button.tintColor = UIColor.white
        return button
    }()
    
    private lazy var photoAreaView: UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.init(r: 96, g: 114, b: 255)
        vi.layer.cornerRadius = 10
        return vi
    }()
    
    private lazy var photoIcon:UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "write_icon_photo")
        return img
    }()
    
    private lazy var photoBtn:UIButton = {
       let btn = UIButton()
        btn.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        return btn
    }()
    
    @objc func addImage(){
        selectPhoto()
    }
    
    private lazy var moodAreaView: UIView = {
       let vi = UIView()
        vi.backgroundColor = calmColor
        vi.layer.cornerRadius = 10
        return vi
    }()
    
    private lazy var moodLabel: UILabel = {
       let label = UILabel()
        label.text = "今天心情怎么样呀？"
        label.font = UIFont(name: "PingFangSC-Regular", size: 14.fit)
        label.textColor = .white
        return label
    }()
    
    private lazy var moodValueLabel:UILabel  =  {
       let label = UILabel()
        label.font = UIFont(name: "PingFangSC-Regular", size: 14.fit)
        label.text = "0"
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    private lazy var moodSlider:CustomSlider = {
       let slider = CustomSlider()
        slider.minimumValue = -50;
        slider.maximumValue = 50;
        slider.value = 0
        slider.isContinuous = true
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = UIColor.init(r: 222, g: 222, b: 222, alpha: 0.3)
        slider.thumbTintColor = UIColor.init(r: 96, g: 114, b: 255)
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)

        return slider
    }()
    

    
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.text = "-50"
        label.font = UIFont(name: "PingFangSC-Regular", size: 13.fit)
        label.textColor = .white
         return label
    }()
    private lazy var rightLabel:UILabel  =  {
       let label = UILabel()
        label.text = "50"
        label.font = UIFont(name: "PingFangSC-Regular", size: 13.fit)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()

         
        // Do any additional setup after loading the view.
    }
    
    func configUI(){
        configNav()
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKey))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        view.backgroundColor = .white
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        view.addSubview(textView)
        view.addSubview(photoCollection)
        photoCollection.delegate = self
        photoCollection.dataSource = self
        
        textView.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20.fit)
            make.right.equalTo(view).offset(-20.fit)
            make.top.equalTo(view).offset(20.fit)
            make.height.equalTo(CFHeight/4)
        }
        photoCollection.snp.makeConstraints{(make) in
            make.left.equalTo(view.snp.left).offset(20.fit)
            make.bottom.equalTo(view.snp.bottom).offset(-10.fit-kBottomSafeHeight)
            make.right.equalTo(view.snp.right).offset(-20.fit)
            make.height.equalTo(120.fit)
        }
        
        configPhotoArea()
        configMoodArea()
        
    }
    
    func configPhotoArea(){
        view.addSubview(photoAreaView)
        photoAreaView.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(20.fit)
            make.bottom.equalTo(photoCollection.snp.top).offset(-10.fit)
            make.height.width.equalTo(100.fit)
        }
        
        photoAreaView.addSubview(photoIcon)
        photoIcon.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(40.fit)
        }
        photoAreaView.addSubview(photoBtn)
        photoBtn.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(20.fit)
            make.bottom.equalTo(photoCollection.snp.top).offset(-10.fit)
            make.height.width.equalTo(100.fit)
        }
    }
    
    func configMoodArea(){
        view.addSubview(moodAreaView)
        moodAreaView.snp.makeConstraints { (make) in
            make.right.equalTo(view.snp.right).offset(-20.fit)
            make.bottom.equalTo(photoCollection.snp.top).offset(-10.fit)
            make.height.equalTo(100.fit)
            make.left.equalTo(photoAreaView.snp.right).offset(15.fit)
        }
        moodAreaView.addSubview(moodLabel)
        moodLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5.fit)
            make.height.equalTo(20.fit)
            make.width.equalTo(130.fit)
            make.left.equalTo(photoAreaView.snp.right).offset(25.fit)
        }
        moodAreaView.addSubview(moodValueLabel)
        moodValueLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(moodLabel.snp.centerY)
            make.height.equalTo(30.fit)
            make.right.equalTo(view.snp.right).offset(-25.fit)
            make.width.equalTo(30.fit)
        }
        
        moodAreaView.addSubview(moodSlider)
        moodSlider.snp.makeConstraints { (make) in
            make.centerY.equalTo(moodAreaView.snp.centerY)
            make.right.equalTo(view.snp.right).offset(-30.fit)
            make.height.equalTo(30.fit)
            make.left.equalTo(photoAreaView.snp.right).offset(30.fit)
        }
        
        moodAreaView.addSubview(leftLabel)
        leftLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-5.fit)
            make.height.equalTo(20.fit)
            make.width.equalTo(100.fit)
            make.left.equalTo(photoAreaView.snp.right).offset(25.fit)
        }
        moodAreaView.addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-5.fit)
            make.height.equalTo(20.fit)
            make.width.equalTo(100.fit)
            make.right.equalTo(view.snp.right).offset(-25.fit)
        }
        

        
    }
    
    func configNav(){
        self.navigation.bar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigation.item.leftBarButtonItems = [UIBarButtonItem.init(customView: leftBarButton),UIBarButtonItem.init(customView: rightDeleteBarButton)]
        self.photoData = writeData.images.components(separatedBy: ",")
        if photoData[0] == "" {
            photoData.removeAll()
        }
        self.photoCollection.reloadData()
        updateUI()
        self.navigation.item.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        
        self.navigation.item.title = DateInfo.shared.todayText
    }
    
    func updateUI(){
        var colors = [CGColor]()
        self.moodSlider.value = Float(self.writeData.mood)
                self.moodValueLabel.text = "\(self.writeData.mood)"
        self.textView.text = self.writeData.content
        switch self.writeData.mood {
            case 26 ... 50:
                colors = happyGradientColor
            case 0 ... 25:
                 colors = calmGradientColor
            case -25 ... -1:
                 colors = sadGradientColor
            case -50 ... -26:
                colors = repressioneGradientColor
            default:
                break;
        }
            
        self.view.setLayerColors(colors)
        
    }
    
    

}

// MARK: 解决手势冲突
extension DiaryAlterViewController: UIGestureRecognizerDelegate {

    // 手势冲突
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.photoCollection))!{
            return false
        }
        return true
    }


}

// MARK: objc Method
extension DiaryAlterViewController {
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func save(){
        self.writeData.content = textView.text!
        self.writeData.images = self.photoData.joined(separator: ",")
        
        if  DataBase.shared.updateStrDiary(with: writeData) {
            ProgressHUD.showSuccess("修改成功")
            self.navigationController?.popToRootViewController(animated: true)
        }else {
            ProgressHUD.showError("修改失败")
        }
    }
    @objc func deleteDiary(){
        guard self.writeData.id != -1 else {
            ProgressHUD.showError("移除失败")
            return
        }
        
        guard DataBase.shared.changeDiaryInTrashStatus(at: writeData.id,with: true) else {
            ProgressHUD.showError("移除失败")
            return
        }
        ProgressHUD.showSuccess("成功移到废纸篓")
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func closeKey(){
        self.view.endEditing(false)
    }
    @objc func sliderValueChanged(_ sender: Any?) {
        let slider = sender as? UISlider
        let value = Int(slider!.value)
        self.moodValueLabel.text = "\(value)"
        switch value {
        case 25 ... 50:
            self.moodAreaView.backgroundColor = happyColor
        case 0 ... 24:
            self.moodAreaView.backgroundColor = calmColor
        case -25 ... -1:
            self.moodAreaView.backgroundColor = sadColor
        default:
            self.moodAreaView.backgroundColor = repressioneColor
        }
        self.writeData.mood = value
    }
}
extension DiaryAlterViewController:UITextViewDelegate {

    func textViewShouldBeginEditing(_ content: UITextView) -> Bool {
//        if (content.text == textViewPlaceHolder) {
//            content.text = ""
//        }
        //content.textColor = .black
        return true
    }
}
extension DiaryAlterViewController:UICollectionViewDelegate,UICollectionViewDataSource{
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

extension DiaryAlterViewController {
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
extension DiaryAlterViewController:DiaryCellDelegate {
    func photoDelete(with indexPath: IndexPath) {
        removePhoto(at: indexPath.row)
    }
}
