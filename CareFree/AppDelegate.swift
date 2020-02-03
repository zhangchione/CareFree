//
//  AppDelegate.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/2.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import ESTabBarController_swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configVC()
        return true
    }
    func configVC() {
        
        let mainTabVC = mainTabBarVC()
        self.window?.rootViewController = mainTabVC
        self.window?.makeKeyAndVisible()
        
    }
    
    func mainTabBarVC() -> ESTabBarController{

        let homeVC = CFHomeViewController()
        let diaryVC = CFDiaryController()
        let albumVC = CFAlbumViewController()
        let mineVC = CFMineController()
        homeVC.tabBarItem = ESTabBarItem.init(CFBouncesContentView(), title: "首页", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        diaryVC.tabBarItem = ESTabBarItem.init(CFBouncesContentView(), title: "日记", image: UIImage(named: "分组2"), selectedImage: UIImage(named: "分组2"))
        albumVC.tabBarItem = ESTabBarItem.init(CFBouncesContentView(), title: "相册", image: UIImage(named: "分组4"), selectedImage: UIImage(named: "分组4"))
        mineVC.tabBarItem = ESTabBarItem.init(CFBouncesContentView(), title: "我的", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))

        let homeNav = MainNavigationController.init(rootViewController: homeVC)
        let diaryNav = MainNavigationController.init(rootViewController: diaryVC)
        let albumNav = MainNavigationController.init(rootViewController: albumVC)
        let mineNav = MainNavigationController.init(rootViewController: mineVC)
        
        homeNav.navigation.configuration.isEnabled = true
        diaryNav.navigation.configuration.isEnabled = true
        albumNav.navigation.configuration.isEnabled = true
        mineNav.navigation.configuration.isEnabled = true
        
        
        if homeNav.children.count > 1 {
            
        }
        
        let tabBarController = ESTabBarController()
        
        tabBarController.viewControllers = [diaryNav, albumNav,mineNav]
        return tabBarController
    }
    
    
}

