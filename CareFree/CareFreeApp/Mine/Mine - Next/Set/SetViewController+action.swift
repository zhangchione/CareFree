//
//  SetViewController+action.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/14.
//  Copyright © 2020 张驰. All rights reserved.
//

import Foundation
import UIKit


/// action
extension SetViewController {
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func alterUserImg() {
        imgCut()
    }
    func alterUserName() {

    }
    func alterBio() {
        
    }
    func gotoHomeSet(){
        let vc = SetHomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func gotoDiarySet(){
        
        let vc = SetDiaryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func gotoNoteSet() {
        
    }
    func about() {
        
        let vc = AboutAViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func faceBack() {
        let vc = FaceBookViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func giveGood(){
        let url = URL(string: "itms-apps://itunes.apple.com/")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
}

extension SetViewController {
    func imgCut(){
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
}
extension SetViewController :UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("图片选取成功")
        let img = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let imageURL = info[UIImagePickerController.InfoKey.imageURL]!
        let imgUrl = (imageURL as! URL).path
        

        let imgData = UIImage.jpegData(img)(compressionQuality: 1.0)
        saveHeadImg(imgData)
        
        self.tableview.reloadData()
        self.dismiss(animated: true, completion: nil)
        

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
