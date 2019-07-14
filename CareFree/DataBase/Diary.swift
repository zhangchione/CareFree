//
//  Diary.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/13.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation
import RealmSwift
class DiaryToday: Object {
    @objc dynamic var week : String = ""
    @objc dynamic var time : String = ""
    @objc dynamic var content :String = ""
    @objc dynamic var emotionValue = 0
    @objc dynamic var happyCount = 0
    @objc dynamic var calmnessCount = 0
    @objc dynamic var sadCount = 0
    @objc dynamic var depressCount = 0
}

class DiaryNow: Object {
    @objc dynamic var time : String = ""
    @objc dynamic var content :String = ""
    @objc dynamic var emotionValue = 0
}

class testPhoto:Object{
    @objc dynamic var num : String = ""
}
class selectphoto:Object {
    //图片数据
    @objc dynamic var data:Data?
    
}


class DiarySummary:Object {
    @objc dynamic var diaryId:String = ""
    @objc dynamic var year: String = ""
    @objc dynamic var month: String = ""
    @objc dynamic var day: String = ""
    @objc dynamic var time: String = ""
    @objc dynamic var weekday: String = ""
    @objc dynamic var content: String = ""
     dynamic var photos = List<Data>()
    @objc dynamic var emotionTotol: Int = 0
    @objc dynamic var emotionValue: Int = 0
    @objc dynamic var emotionType:String = ""
}



class DiaryPhoto:Object {
    //图片数据
    @objc dynamic var data:Data?
}


class MomentSummary:Object{
    @objc dynamic var diaryKey:String = ""
    @objc dynamic var momentId:String = ""
    @objc dynamic var year: String = ""
    @objc dynamic var month: String = ""
    @objc dynamic var day: String = ""
    @objc dynamic var time: String = ""
    @objc dynamic var content: String = ""
     //dynamic var photos = List<MomentPhoto>()
    @objc dynamic var emotionType:String = ""
    @objc dynamic var emotionValue: Int = 0
}

class MomentPhoto:Object {
    //图片数据
    @objc dynamic var data:Data?
}
