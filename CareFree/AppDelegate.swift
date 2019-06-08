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
        let diaryVC = CFDiaryViewController()
        let albumVC = CFAlbumViewController()
        let mineVC = CFMineViewController()
        homeVC.tabBarItem = ESTabBarItem.init(CFBouncesContentView(), title: "首页", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        diaryVC.tabBarItem = ESTabBarItem.init(CFBouncesContentView(), title: "日记", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        albumVC.tabBarItem = ESTabBarItem.init(CFBouncesContentView(), title: "相册", image: UIImage(named: "photo"), selectedImage: UIImage(named: "photo_1"))
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
        
        tabBarController.viewControllers = [homeNav, diaryNav, albumNav,mineNav]
        return tabBarController
    }
    
    
}

