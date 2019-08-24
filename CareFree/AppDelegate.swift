//
//  AppDelegate.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/2.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("CareFree停止半个月了")
        
        let config = Realm.Configuration(
        // 设置新的架构版本。这个版本号必须高于之前所用的版本号
        // （如果您之前从未设置过架构版本，那么这个版本号设置为 0）
        schemaVersion: 1,
        
        // 设置闭包，这个闭包将会在打开低于上面所设置版本号的 Realm 数据库的时候被自动调用
        migrationBlock: { migration, oldSchemaVersion in
            // 目前我们还未进行数据迁移，因此 oldSchemaVersion == 0
            if (oldSchemaVersion < 1) {
                // 什么都不要做！Realm 会自行检测新增和需要移除的属性，然后自动更新硬盘上的数据库架构
            }
        })
        
        // 告诉 Realm 为默认的 Realm 数据库使用这个新的配置对象
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        print(realm.configuration.fileURL!)
//        // 从 Realm 数据库中删除所有对象
//        try! realm.write {
//        }
        //let now = Date()
         //print(now.year(),now.month(),now.day(),now.weekDay())
        configVC()
        // 静态图片引导页
        //self.setStaticGuidePage()
        return true
    }
//    func setStaticGuidePage() {
//        let imageNameArray: [String] = ["lead1", "lead2", "lead3","lead4"]
//        let guideView = HHGuidePageHUD.init(imageNameArray: imageNameArray, isHiddenSkipButton: false)
//        self.window?.rootViewController?.view.addSubview(guideView)
//    }
    
    func save(){
        let use:BmobObject = BmobObject(className: "_User")
        use.setObject("cone2", forKey: "username")
        use.setObject("zc123...", forKey: "password")
        
//        use.saveInBackground { (isSuccessful, error) in
//            if error != nil{
//                print("error is \(String(describing: error?.localizedDescription))")
//            }else{
//                print("success")
//            }
//        }
        print("Bmob云后端存储成功")
        
        let im = UIImage(named: "userImg")
        let data = im?.pngData()
        let file = BmobFile(fileName: "test.png",withFileData: data)
        let obj = BmobObject(className: "ClassName")
        
        file?.saveInBackground{(isSuccessful,error) in
            if isSuccessful {
                obj?.setObject(file?.url, forKey: "filetypeurl")
                obj?.saveInBackground()
                print("成功")
            }
            else {
                print("失败")
                print(error)
            }
            
        }
    }
    func queryUsers()  {
        //查找GameScore表
        let query:BmobQuery = BmobQuery(className: "_User")
        query.findObjectsInBackground { (array, error) in
            for i in 0..<array!.count{
                let obj = array![i] as! BmobObject
                let use1 = obj.object(forKey: "mobilePhoneNumber")
                
            }
        }

        
    }
    
    func configVC() {
        
        let mainTabVC = mainTabBarVC()
        self.window?.rootViewController = mainTabVC
        self.window?.makeKeyAndVisible()
        
    }
    
    func mainTabBarVC() -> ESTabBarController{

        let homeVC = CFHomeViewController()
        let diaryVC = DiaryViewController()
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
        
        tabBarController.viewControllers = [homeNav, diaryNav, albumNav,mineNav]
        return tabBarController
    }
    
    
}

