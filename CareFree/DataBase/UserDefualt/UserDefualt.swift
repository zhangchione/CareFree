//
//  UserDefualt.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/16.
//  Copyright © 2020 张驰. All rights reserved.
//

import Foundation

let defaults = UserDefaults.standard

func saveHeadImg(_ imgData: Data?) {
    defaults.set(imgData, forKey: "userhead_img")
    defaults.synchronize()
}
func getHeadImg() -> Data? {
    return defaults.data(forKey: "userhead_img")
}
func saveUserImg(path:String) {
    defaults.set(path, forKey: "user_image")
    defaults.synchronize()
}
func getUserImg() -> String? {
    return  defaults.string(forKey: "user_image")
}

func saveUserName(value:String) {
    defaults.set(value, forKey: "user_name")
    defaults.synchronize()
}
func getUserName() -> String? {
    return  defaults.string(forKey: "user_name")
}
func saveUserBio(value:String) {
    defaults.set(value, forKey: "user_bio")
    defaults.synchronize()
}
func getUserBio() -> String? {
    return  defaults.string(forKey: "user_bio")
}
func saveSetHomeShowMark(value: Bool) {
    defaults.set(value, forKey: "set_home_show_mark")
    defaults.synchronize()
}
func getSetHomeShowMark() -> Bool? {
    return  defaults.bool(forKey: "set_home_show_mark")
}

func saveSetHomeShowTask(value: Bool) {
    defaults.set(value, forKey: "set_home_show_task")
    defaults.synchronize()
}
func getSetHomeShowTask() -> Bool? {
    return  defaults.bool(forKey: "set_home_show_task")
}

func saveSetLanguege(value:String) {
    defaults.set(value, forKey: "set_languege")
    defaults.synchronize()
}
func getSetLanguege() -> String? {
    return  defaults.string(forKey: "set_languege")
}


var userSetInfo = getUser()

func changeUserInfo<T>(name:String,value:T) {
    var userData = defaults.object(forKey: "kUsers") as? [AnyHashable : Any]
    print(userData!["localUserBio"] as Any)
    userData![name] = value
    saveUserInfo(userData)
    userSetInfo = getUser()
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
    
    var isLocalInfoExti = false
    
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
