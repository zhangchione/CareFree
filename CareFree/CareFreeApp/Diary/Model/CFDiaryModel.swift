//
//  CFDiaryModel.swift
//  CareFree
//
//  Created by 张驰 on 2019/12/5.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation

struct CFDiaryModel {
    var id = 0
    var mode = 0
    var user_id = ""
    var day_id = ""
    var dayDiary = DayDiaryModel()
    var nowDiary = [NowDiaryModel]()
}

struct CFDiaryDayModel {
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
struct CFDiaryNowModel {
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
