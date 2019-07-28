//
//  SetViewController.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/9.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import SnapKit
import CollectionKit
import Hero

class SetViewController: UIViewController {
    
    
    
    var headlabel = [["头像","昵称"],["我要反馈","关于"],["切换账号","退出登录"]]
    var backUser = [["userImg","Jeffrey"],["",""],["",""]]
    
    // 左边返回按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        button.setTitle("←", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        button.tintColor = UIColor.red
        return button
    }()
    
    var useImg:UIImageView!
    var imgPricker:UIImagePickerController!
    
    
    fileprivate let dataSource = ArrayDataSource(data:[SetModel]())
    
    fileprivate lazy var collectionView = CollectionView()
    fileprivate lazy var img: UIImageView = {
       let iv = UIImageView()
        return iv
    }()
    
    let backView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configCV()
        configUI()
        updateUI()
    }
    


    func configUI(){
        
        backView.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
       // view.insertSubview(backView, belowSubview: leftBarButton)
        //backView.hero.modifiers = [.translate(y:100)]
        
        
        view.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.title = "设置"
        
         self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        
        view.addSubview(collectionView)
        view.addSubview(img)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        //collectionView.isScrollEnabled = false
        collectionView.alwaysBounceVertical = false
        collectionView.snp.makeConstraints{(make) in
            make.right.left.equalTo(view)
            make.top.equalTo(navigation.bar.snp.bottom).offset(0)
            make.height.equalTo(600)
        }
//        img.snp.makeConstraints{(make) in
//            make.top.equalTo(collectionView.snp.bottom).offset(10)
//            make.centerX.equalTo(collectionView.snp.centerX)
//            make.width.height.equalTo(100)
//
//        }
        //img.backgroundColor = .red
    }

    func configCV(){
        let viewSource = ClosureViewSource(viewUpdater: {(view:setCell,data:SetModel,index:Int) in
            view.updateUI(with: data)
            var topTap = UITapGestureRecognizer()
            var bottomTap = UITapGestureRecognizer()
            switch index {
            case 0 :
                topTap = UITapGestureRecognizer(target: self, action: #selector(self.userImg))
                bottomTap = UITapGestureRecognizer(target: self, action: #selector(self.userName))
                view.topView.addGestureRecognizer(topTap)
                view.bottomView.addGestureRecognizer(bottomTap)
            case 1 :
                topTap = UITapGestureRecognizer(target: self, action: #selector(self.faceBack))
                bottomTap = UITapGestureRecognizer(target: self, action: #selector(self.about))
                view.topView.addGestureRecognizer(topTap)
                view.bottomView.addGestureRecognizer(bottomTap)
            default:
                topTap = UITapGestureRecognizer(target: self, action: #selector(self.cutUser))
                bottomTap = UITapGestureRecognizer(target: self, action: #selector(self.returnLogin))
                view.topView.addGestureRecognizer(topTap)
                view.bottomView.addGestureRecognizer(bottomTap)
            }
        })
        let sizeSource = {(index:Int,data:SetModel,collectionSize:CGSize) ->CGSize in
            return CGSize(width: collectionSize.width, height: 140)
        }
        
        let provider = BasicProvider(
            dataSource: dataSource,
            viewSource: viewSource,
            sizeSource: sizeSource
        )
        provider.layout = FlowLayout(spacing: 30)
        collectionView.provider = provider
        collectionView.contentInset = UIEdgeInsets(top: 35, left: 20, bottom: 0, right: 20)
    }
    
    func updateUI(){
        for index in 0...2{
            var setModel = SetModel()
            setModel.topHead = headlabel[index][0]
            setModel.bottomHead = headlabel[index][1]
            setModel.userImg = backUser[index][0]
            setModel.userName = backUser[index][1]
            dataSource.data.append(setModel)
        }
        collectionView.reloadData()
    }
}


extension SetViewController{
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func userImg(){
        print("更换图像")
        let actionSheet = UIAlertController(title: "更改头像", message: "请选择图像来源", preferredStyle: .actionSheet)
        let alterUserImg = UIAlertAction(title: "相册选择", style: .default, handler: {(alters:UIAlertAction) -> Void in
            print("拍照继续更改头像中..")
            
            self.imgPricker = UIImagePickerController()
            self.imgPricker.delegate = self
            self.imgPricker.allowsEditing = true
            self.imgPricker.sourceType = .photoLibrary
            
            self.imgPricker.navigationBar.barTintColor = UIColor.gray
            self.imgPricker.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
            
            self.imgPricker.navigationBar.tintColor = UIColor.white
            
            self.present(self.imgPricker, animated: true, completion: nil)
            
        })
        
        let alterUserImgTake = UIAlertAction(title: "拍照选择", style: .default, handler: {(alters:UIAlertAction) -> Void in
            print("继续更改头像中..")
            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            self.imgPricker = UIImagePickerController()
            self.imgPricker.delegate = self
            self.imgPricker.allowsEditing = true
            self.imgPricker.sourceType = .camera
            self.imgPricker.cameraDevice = UIImagePickerController.CameraDevice.rear
                self.imgPricker.showsCameraControls = true
            
            self.imgPricker.navigationBar.barTintColor = UIColor.gray
            self.imgPricker.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
            
            self.imgPricker.navigationBar.tintColor = UIColor.white
            
            self.present(self.imgPricker, animated: true, completion: nil)
            }
        })
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: {(alters:UIAlertAction) -> Void in print("取消更改头像")})
        
        actionSheet.addAction(cancel)
        actionSheet.addAction(alterUserImg)
        actionSheet.addAction(alterUserImgTake)
        
        self.present(actionSheet,animated: true){
            print("正在更改")
        }
    }
    @objc func userName(){
        let alterVC = AlterUserNameController()
        self.navigationController?.pushViewController(alterVC, animated: true)
        print("改昵称")
    }
    @objc func faceBack(){
        let faceBackVC = FacebackViewController()
        self.navigationController?.pushViewController(faceBackVC, animated: true)
        print("反馈")
    }
    @objc func about(){
        let aboutVC = AboutViewController()
        self.navigationController?.pushViewController(aboutVC, animated: true)
        print("关于")
    }
    @objc func cutUser(){
        print("切换账号")
    }
    @objc func returnLogin(){
        print("退出登陆")
        
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
}

extension SetViewController :UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("图片选取成功")
        let img = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        let imageURL = info[UIImagePickerController.InfoKey.imageURL]!
        let imageData1 = try! Data(contentsOf: imageURL as! URL)
        //self.img.image = img
        
       let imageData = img.jpegData(compressionQuality: 1)
        print("imageData:\(imageData)")
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let doucument = paths[0]
        
        let fullpath = URL(fileURLWithPath: doucument).appendingPathComponent("photo.jpg").absoluteString
        
        let notes = BmobObject(className: "Notes")
        let file = BmobFile.init(filePath: fullpath)
        file?.name = "photo.jpg"
            //BmobFile(fileName: "photo.jpeg", withFileData: imageData!)
        //file?.url = "111"
        file!.saveInBackground { (isSuccessful, error) in
            if isSuccessful {
                notes?.setObject(file, forKey: "photo")
                notes?.saveInBackground()
                print(file?.url)
                print("success")
            }else{
                print(error)
                print(file?.url)
                print(file!)
                print("错误")
                self.img.image = UIImage(data: imageData!)
            }
        }
        print("Bmob云后端存储成功")
        //imageData?.write(to: <#T##URL#>)
        //imageData?.write(to: fullpath)
        //imageData?.write(toFile: fullpath, atomically: true)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
