//
//  CFNotesModel.swift
//  CareFree
//
//  Created by 张驰 on 2020/5/16.
//  Copyright © 2020 张驰. All rights reserved.
//

import Foundation
import UIKit
/**
 优先级：
 0 临时
 1 一级
 2 二级
 3 三级
 10001 Mark级
 */

let shortTimeGrade = 0
let firstGrade = 1
let secendGrade = 2
let threeGrade = 3
let markGrade = 10001

let shortTimeGradeColor = UIColor.white
let firstGradeColor = UIColor.init(r: 146, g: 236, b: 218)
let secendGradeColor = UIColor.init(r: 199, g: 189, b: 241)
let threeGradeColor = UIColor.init(r: 245, g: 86, b: 133)
let markGradeColor = UIColor.init(r: 108, g: 80, b: 233)

let shortTimeGradeText = "临时任务贴"
let firstGradeText = "一级任务贴"
let secendGradeText = "二级任务贴"
let threeGradeText = "三级任务贴"
let markGradeText = "Mark"

struct CFNotesModel {
    var id = -1
    var date = Date()
    var dateStr = ""
    var title = ""
    var content = ""
    
    var images = ""
    
    var priority = -1
    var restDay = 0
    var startDate = Date()
    
    
    var clockTime = Date()
    var clockContent = ""
    var isTrash = false
}


struct DiaryModel1 {
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
