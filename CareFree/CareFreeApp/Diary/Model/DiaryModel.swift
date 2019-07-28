//
//  DiaryModel.swift
//  CareFree
//
//  Created by 张驰 on 2019/7/28.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation
import HandyJSON

struct DiaryTodayModel:HandyJSON {
    var id = 0
    var user_id = ""
    var title = ""
    var content = ""
    var date = ""
    var images = Int()
    var latitude = ""
    var longitude = ""
    var location = ""
    var mode = 0
    var now:ModeNow?
    var count = 0
}
struct ModeNow:HandyJSON {
    var happy = 0
    var calm = 0
    var sad = 0
    var so_sad = 0
}
