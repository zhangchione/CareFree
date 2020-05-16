//
//  SetController.swift
//  CareFree
//
//  Created by 张驰 on 2019/8/6.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import ProgressHUD


class SetController: UIViewController {

    @IBOutlet weak var userHeadImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    // 左边返回按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        button.setTitle("←", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
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
        let teamVC = TeamViewController()
        self.navigationController?.pushViewController(teamVC, animated: true)
    }
    // 换昵称
    @IBAction func userNameTap(_ sender: Any) {
        if let url = URL(string: "https://shimo.im/docs/VrWVWKCPVC9hKQpV") {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    // 反馈
    @IBAction func faceBackTap(_ sender: Any) {
                print("反馈")
        let faceBackVC = FaceBookViewController()
        self.navigationController?.pushViewController(faceBackVC, animated: true)
    }
    // 关于
    @IBAction func aboutTap(_ sender: Any) {
                print("关于")
        let aboutVC = AboutAViewController()
        self.navigationController?.pushViewController(aboutVC, animated: true)
    }
    // 换账号
    @IBAction func cutUserTap(_ sender: Any) {
                    ProgressHUD.show()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                }
                ProgressHUD.showSuccess("已是最新版本")
    }
    // 退出
    @IBAction func returnLoginTap(_ sender: Any) {
        let url = URL(string: "itms-apps://itunes.apple.com/")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
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
