//
//  Const.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/6.
//  Copyright © 2019 张驰. All rights reserved.
//


import Foundation
import UIKit




/*
#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX kScreenWidth >=375.0f && kScreenHeight >=812.0f&& kIs_iphone
*/

// 根据文字 获取 content 高度
 func getTextHeight(textStr:String,font:UIFont,width:CGFloat) -> CGFloat {
    let normalText: NSString = textStr as NSString
    let size = CGSize(width: width, height: 3000)
    let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
    let stringSize = normalText.boundingRect(with: size,options: .usesLineFragmentOrigin, attributes: (dic as! [NSAttributedString.Key : Any]) , context:nil).size
    return stringSize.height
}


// INF
let INF = 100001

let CFWidth = UIScreen.main.bounds.width
let CFHeight = UIScreen.main.bounds.height
let FooterViewColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)


// iphone X
let isIphoneX = CFHeight >= 812 ? true : false
// navigationBarHeight
let navigationBarHeight : CGFloat = isIphoneX ? 88 : 64
// tabBarHeight
let tabBarHeight : CGFloat = isIphoneX ? 49 + 34 : 49


/*状态栏高度*/
let kStatusBarHeight: CGFloat = isIphoneX ? 44.0 : 20.0
/*导航栏高度*/
let kNavBarHeight: CGFloat = 44

/*状态栏和导航栏总高度*/
let kNavBarAndStatusBarHeight : CGFloat = isIphoneX ? 88.0 : 64.0
/*TabBar高度*/
let kTabBarHeight: CGFloat = isIphoneX ? 49.0 + 34.0 : 49.0

/*顶部安全区域远离高度*/
let kTopBarSafeHeight : CGFloat = isIphoneX ? 44.0 : 0
/*底部安全区域远离高度*/
let kBottomSafeHeight : CGFloat = isIphoneX ? 34.0 : 0
/*iPhoneX的状态栏高度差值*/
let kTopBarDifHeight: CGFloat = isIphoneX ? 24.0 : 0

/*导航条和Tabbar总高度*/
let kNavAndTabHeight = kNavBarAndStatusBarHeight + kTabBarHeight

/// 主题背景色
let backColor = UIColor.init(r: 247, g: 249, b: 254)

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
// 自定义索引值
let kBaseTarget : Int = 1000
// 宽度比
let kWidthRatio = CFWidth / 414.0
// 高度比
let kHeightRatio = CFHeight / 896.0
// 自适应
func Adapt(_ value : CGFloat) -> CGFloat {
    
    return AdaptW(value)
}
// 自适应宽度
func AdaptW(_ value : CGFloat) -> CGFloat {
    return ceil(value) * kWidthRatio
}
// 常规字体
func FontSize(_ size : CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: AdaptW(size))
}
// 加粗字体
func BoldFontSize(_ size : CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: AdaptW(size))
}
