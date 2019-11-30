//
//  File.swift
//  CareFree
//
//  Created by 张驰 on 2019/11/30.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation

struct DayDiaryModel{
    var id = 0
    var user_id = ""
    var title = ""
    var content = ""
    var weather = ""
    var images = ""
    var date = Date()
    var mode = 0
}

struct NowDiaryModel{
    var id = 0
    var user_id = ""
    var day_id = ""
    var title = ""
    var content = ""
    var weather = ""
    var images = ""
    var date = Date()
    var mode = 0
}
