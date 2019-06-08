//
//  MainNavigationController.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/7.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UIBarButtonItem.appearance()
        appearance.setBackButtonTitlePositionAdjustment(UIOffset.init(horizontal: 0.0, vertical: 0), for: .default)
        self.navigationBar.isTranslucent = true
        self.navigationBar.barTintColor = UIColor.init(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 0.8)
        #if swift(>=4.0)
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)]
        #elseif swift(>=3.0)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0), NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)];
        #endif
        self.navigationBar.tintColor = UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0)
    }
    

   
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.children.count > 0
        {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        
        super.pushViewController(viewController, animated: animated)
        // viewController.hidesBottomBarWhenPushed = false
    }

}
