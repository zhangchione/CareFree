//
//  DiaryModel.swift
//  CareFree
//
//  Created by 张驰 on 2019/7/28.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation

struct DiaryModel {
    var id = -1
    var date = Date()
    var dateStr = ""
    var title = ""
    var content = ""
    var images = ""
    var mood = 0
    
    var locate = ""
    var weather = ""
    //var isTrash = false
}


struct DiaryTodayModel {
    var id = ""
    var user_id = ""
    var title = ""
    var content = ""
    var date = ""
    var images = [Data]()
    var latitude = ""
    var longitude = ""
    var location = ""
    var mode = 0
    var now = ModeNow()
    var count = 0
}
struct ModeNow {
    var happy = 0
    var calm = 0
    var sad = 0
    var so_sad = 0
}

struct NowData {
    var mode = 0
    var type = ""
}
