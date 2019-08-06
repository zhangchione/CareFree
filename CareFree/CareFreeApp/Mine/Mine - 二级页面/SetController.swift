//
//  SetController.swift
//  CareFree
//
//  Created by 张驰 on 2019/8/6.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class SetController: UIViewController {

    @IBOutlet weak var userHeadImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }


    func configUI(){
        view.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.title = "设置"
        
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
    }
    // 换头像
    @IBAction func userHeadTap(_ sender: Any) {
        print("头像更换")
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
    // 换昵称
    @IBAction func userNameTap(_ sender: Any) {
        print("昵称更换")
        let alterVC = AlterUserNameController()
        self.navigationController?.pushViewController(alterVC, animated: true)
    }
    // 反馈
    @IBAction func faceBackTap(_ sender: Any) {
                print("反馈")
        let faceBackVC = FacebackViewController()
        self.navigationController?.pushViewController(faceBackVC, animated: true)
    }
    // 关于
    @IBAction func aboutTap(_ sender: Any) {
                print("关于")
        let aboutVC = AboutViewController()
        self.navigationController?.pushViewController(aboutVC, animated: true)
    }
    // 换账号
    @IBAction func cutUserTap(_ sender: Any) {
                print("切换账号")
    }
    // 退出
    @IBAction func returnLoginTap(_ sender: Any) {
        print("退出登录")
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
}
extension SetController{
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension SetController :UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("图片选取成功")
        let img = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        let imageURL = info[UIImagePickerController.InfoKey.imageURL]!
        let imageData1 = try! Data(contentsOf: imageURL as! URL)
        //self.img.image = img
        
        self.userHeadImg.image = img
        
        let imageData = img.jpegData(compressionQuality: 1)
        print("imageData:\(imageData)")
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let doucument = paths[0]
        
        //        let fullpath = URL(fileURLWithPath: doucument).appendingPathComponent("photo.jpg").absoluteString
        //
        //        let notes = BmobObject(className: "Notes")
        //        let file = BmobFile.init(filePath: fullpath)
        //        file?.name = "photo.jpg"
        //            //BmobFile(fileName: "photo.jpeg", withFileData: imageData!)
        //        //file?.url = "111"
        //        file!.saveInBackground { (isSuccessful, error) in
        //            if isSuccessful {
        //                notes?.setObject(file, forKey: "photo")
        //                notes?.saveInBackground()
        //                print(file?.url)
        //                print("success")
        //            }else{
        //                print(error)
        //                print(file?.url)
        //                print(file!)
        //                print("错误")
        //                self.img.image = UIImage(data: imageData!)
        //            }
        //        }
//        print("Bmob云后端存储成功")
        //imageData?.write(to: <#T##URL#>)
        //imageData?.write(to: fullpath)
        //imageData?.write(toFile: fullpath, atomically: true)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
