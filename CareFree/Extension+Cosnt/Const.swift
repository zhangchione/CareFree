//
//  Const.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/6.
//  Copyright © 2019 张驰. All rights reserved.
//


import Foundation
import UIKit

let CFWidth = UIScreen.main.bounds.width
let CFHeight = UIScreen.main.bounds.height
let FooterViewColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)

// iphone X
let isIphoneX = CFHeight == 812 ? true : false
// navigationBarHeight
let navigationBarHeight : CGFloat = isIphoneX ? 88 : 64
// tabBarHeight
let tabBarHeight : CGFloat = isIphoneX ? 49 + 34 : 49

/// 四种主题心情色
let happyColor = UIColor.init(r: 57, g: 210, b: 214) // 开心
let calmColor = UIColor.init(r: 100, g: 175, b: 232) // 平静
let sadColor = UIColor.init(r: 155, g: 133, b: 255) //难过
let repressioneColor = UIColor.init(r: 31, g: 69, b: 99) //压抑


/// 四种渐变色
let happyGradientColor = [UIColor.init(r: 56, g: 213, b: 214).cgColor,UIColor.init(r: 29, g: 192, b: 193).cgColor] //开心渐变
let calmGradientColor = [UIColor.init(r: 100, g: 176, b: 232).cgColor,UIColor.init(r: 83, g: 121, b: 255).cgColor] // 平静渐变
let sadGradientColor = [UIColor.init(r: 128, g: 100, b: 255).cgColor,UIColor.init(r: 66, g: 39, b: 187).cgColor] // 难过渐变
let repressioneGradientColor = [UIColor.init(r: 38, g: 106, b: 160).cgColor,UIColor.init(r: 31, g: 69, b: 99).cgColor] //压抑渐变

