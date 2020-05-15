//
//  CustomAlertView.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/15.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit

/// 上线后优化

enum CustomAlertViewType {
    case userName
    case bio
}

protocol CustomAlertViewDelegate: class {
    func alertViewCallback(content: String,type:CustomAlertViewType)
}


class CustomAlertView: UIView {
    
    weak var delegate : CustomAlertViewDelegate?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
