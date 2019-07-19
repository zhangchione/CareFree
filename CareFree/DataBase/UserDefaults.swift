//
//  UserDefaults.swift
//  CareFree
//
//  Created by 张驰 on 2019/7/18.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation

// MARK - 数据持久化

fileprivate let defaults = UserDefaults.standard

func getUser() -> User {
    let userData = defaults.object(forKey: "kUser")
    let user = userData
    print(user)
    return user as! User
    
}

func saveUser(userData:User) {
    defaults.set(userData, forKey: "kUser")
    defaults.synchronize()
    print("User信息存储成功")
}

