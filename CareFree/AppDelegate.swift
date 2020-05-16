//
//  AppDelegate.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/2.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import ESTabBarController_swift

import SwiftyJSON
import HandyJSON


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Test KS")
        configVC()
        return true
    }
    func configVC() {
        
        let mainTabVC = mainTabBarVC()
        self.window?.rootViewController = mainTabVC
        self.window?.makeKeyAndVisible()
        if getUser().localSet_languege != "简体 - 中文" {
                    self.setLocalInfo()
        }else {
             print(getUser().localSet_languege)
        }

       
        
    }
    
    func mainTabBarVC() -> ESTabBarController{

        let homeVC = CFHomeViewController()
        let diaryVC = CFDiaryController()
        let notesVC = CFNotesViewController()
        let mineVC = CFMineController()
        homeVC.tabBarItem = ESTabBarItem.init(CFBouncesContentView(), title: "首页", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        diaryVC.tabBarItem = ESTabBarItem.init(CFBouncesContentView(), title: "日记", image: UIImage(named: "分组2"), selectedImage: UIImage(named: "分组2"))
        notesVC.tabBarItem = ESTabBarItem.init(CFBouncesContentView(), title: "便贴", image: UIImage(named: "分组4"), selectedImage: UIImage(named: "note_1"))
        mineVC.tabBarItem = ESTabBarItem.init(CFBouncesContentView(), title: "我的", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))

        let homeNav = MainNavigationController.init(rootViewController: homeVC)
        let diaryNav = MainNavigationController.init(rootViewController: diaryVC)
        let notesNav = MainNavigationController.init(rootViewController: notesVC)
        let mineNav = MainNavigationController.init(rootViewController: mineVC)
        
        homeNav.navigation.configuration.isEnabled = true
        diaryNav.navigation.configuration.isEnabled = true
        notesNav.navigation.configuration.isEnabled = true
        mineNav.navigation.configuration.isEnabled = true
        
        //diaryNav.navigation.configuration.barTintColor = .white
        
        if homeNav.children.count > 1 {
            
        }
        
        let tabBarController = ESTabBarController()
        
        tabBarController.viewControllers = [homeNav,diaryNav, notesNav,mineNav]
        tabBarController.tabBar.backgroundColor = .white
        //tabBarController.tabBar.shadowImage = UIImage(named: "background")
        
        tabBarController.tabBar.backgroundImage = UIImage(named: "background")
        return tabBarController
    }
    
    func setLocalInfo() {
        //1 获取json文件路径
        let path = Bundle.main.path(forResource: "localUserInfo", ofType: "json")
        //2 获取json文件里面的内容,NSData格式
        let jsonData=NSData(contentsOfFile: path!)
        //3 解析json内容
        let json = JSON(jsonData!)
        saveUserInfo(json["data"].dictionaryObject)
                    
        
    }
    
}

struct Local:HandyJSON {
    var code = 200
    var data = localInfoModel()
    
}

struct localInfoModel:HandyJSON {
    var localImagePath = ""
    var localUserName = ""
    var localUserBio = ""
    
    var localSet_HomeShowMark = true
    var localSet_HomeShowTask = false
    var localSet_HomeCardShowContent = ""
    var localSet_languege = ""
}

