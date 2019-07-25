//
//  CFMineModel.swift
//  CareFree
//
//  Created by 张驰 on 2019/7/25.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation
import HandyJSON


struct MineModel:HandyJSON {
    var id = ""
    var day_notes = ""
    var username = ""
    var password = ""
    var mode = ""
    var mode_value = Int()
    var sex = ""
    var now_notes = ""
    var head_pic = ""
}
