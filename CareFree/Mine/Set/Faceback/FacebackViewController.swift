//
//  FacebackViewController.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/12.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class FacebackViewController: UIViewController {

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
    
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var sumWord: UILabel!
    
    @IBOutlet weak var telTextField: UITextField!
    
    @IBAction func saveBtn(_ sender: UIButton) {
        print("正在保存")
        print(telTextField.text,content.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    func configUI(){
        view.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.title = "反馈"
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        content.text = "请输入15个字以上的问题描述以便我们提供更好的帮助"
        content.textColor = UIColor.lightGray
        content.delegate = self
        
    }
    

    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }

}
extension FacebackViewController:UITextViewDelegate{
    
    func textViewShouldBeginEditing(_ content: UITextView) -> Bool {
        if (content.text == "请输入15个字以上的问题描述以便我们提供更好的帮助") {
            content.text = ""
        }
        content.textColor = UIColor.black
        return true
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        sumWord.text = String(format: "%lu/200", UInt(textView.text.count))
        //字数限制操作
        if textView.text.count >= 200 {
            
            textView.text = (textView.text as NSString?)?.substring(to: 200)
            sumWord.text = "200/200"
        }
        
    }
}
