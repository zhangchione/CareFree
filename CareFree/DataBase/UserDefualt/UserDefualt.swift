//
//  UserDefualt.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/16.
//  Copyright © 2020 张驰. All rights reserved.
//

import Foundation

let defaults = UserDefaults.standard

func saveUserImg(path:String) {
    defaults.set(path, forKey: "user_image")
    defaults.synchronize()
}
func getUserImg() -> String? {
    return  defaults.string(forKey: "user_image")
   
}


func getUser() -> localUserInfo {
    let userData = defaults.object(forKey: "kUsers") as? [AnyHashable : Any]
    let user = localUserInfo(dic: userData)
    return user
}


func saveUserInfo(_ userData: [AnyHashable : Any]?) {
    defaults.set(userData, forKey: "kUsers")
    defaults.synchronize()
}



class localUserInfo: NSObject {
    var localImagePath = ""
    var localUserName = ""
    var localUserBio = ""
    
    var localSet_HomeShowMark = true
    var localSet_HomeShowTask = false
    var localSet_HomeCardShowContent = ""
    var localSet_languege = ""
    
    
    init(dic Dic: [AnyHashable : Any]?) {
         super.init()
         localImagePath = Dic?["localImagePath"] as? String ?? ""
         
         localUserName = Dic?["localUserName"] as? String ?? ""
         localUserBio = Dic?["localUserBio"] as? String ?? ""
         localSet_HomeShowMark = Dic?["localSet_HomeShowMark"] as? Bool ?? true
        
         localSet_HomeShowTask = Dic?["localSet_HomeShowTask"] as? Bool ?? false
        
         localSet_HomeCardShowContent = Dic?["localSet_HomeCardShowContent"] as? String ?? ""
         localSet_languege = Dic?["localSet_languege"] as? String ?? ""
     }
    
}
