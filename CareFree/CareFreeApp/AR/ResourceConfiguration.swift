//
//  ResourceConfiguration.swift
//  Tracks
//
//  Created by 张驰 on 2019/7/13.
//  Copyright © 2019 张驰. All rights reserved.
//
import UIKit

class RescouceConfiguration: NSObject, NSCoding {
    // 单例
    static let share = RescouceConfiguration.init()
    private override init() {}
    let showShow: Int = 20180106
    ///box 图片是否随机
    var box_Random: Bool              = false
    var panorama_isShow: Bool         = false
    ///背景音乐
    var voice_isPlay: Bool            = false
    ///文字
    var text_isShow: Bool             = false
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(box_Random, forKey: TK_Set_box_Random)
        aCoder.encode(panorama_isShow, forKey: TK_Set_panorama_isShow)
        aCoder.encode(text_isShow, forKey: TK_Set_text_isShow)
    }
    required init?(coder aDecoder: NSCoder) {
        box_Random           = aDecoder.decodeBool(forKey: TK_Set_box_Random)
        panorama_isShow      = aDecoder.decodeBool(forKey: TK_Set_panorama_isShow)
        text_isShow          = aDecoder.decodeBool(forKey: TK_Set_text_isShow)
    }
    ///是否显示
    func show() -> Bool {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let day = dateFormatter.string(from: currentDate)
        print(day)
        return Int(day)! > showShow
    }
}
