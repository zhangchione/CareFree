//
//  Extension.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/6.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation
import UIKit
import EachNavigationBar


extension UIImage {
    func image(withIcon iconCode: String?, inFont fontName: String?, size: Int, color: UIColor?) -> UIImage? {
        let imageSize = CGSize(width: CGFloat(size), height: CGFloat(size))
        UIGraphicsBeginImageContextWithOptions(imageSize, _: false, _: UIScreen.main.scale)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat(size), height: CGFloat(size)))
        label.font = UIFont(name: fontName ?? "", size: CGFloat(size))
        label.text = iconCode
        if color != nil {
            label.textColor = color
        }
        if let context = UIGraphicsGetCurrentContext() {
            label.layer.render(in: context)
        }
        let retImage = UIGraphicsGetImageFromCurrentImageContext()
        return retImage
    }
}


public extension Double {
    var fitWidth_Double: Double {
        return self/414.0 * Double(CFWidth)
    }
    var fitHeight_Double: Double {
        return self/896.0 * Double(CFHeight)
    }
    var fitWidth_CGFloat: CGFloat {
        return CGFloat(self)/414.0 * CGFloat(CFWidth)
    }
    var fitHeight_CGFloat: CGFloat {
        return CGFloat(self)/896.0 * CGFloat(CFHeight)
    }
    var fitWidth_Int: Int{
        return Int(self/414.0 * Double(CFWidth))
    }
    var fitHeight_Int: Int{
        return Int(self/896.0 * Double(CFHeight))
    }
}
extension Double {
    var fit: CGFloat {
        return CGFloat(self/414.0) * UIScreen.main.bounds.width
    }
    var fitW: CGFloat {
        return CGFloat(self/414.0) * UIScreen.main.bounds.width
    }
    var fitH: CGFloat {
        return CGFloat(self/896.0) * UIScreen.main.bounds.width
    }
}
extension Int {
    var fit: Int {
        return Int(CGFloat(self)/414.0 * UIScreen.main.bounds.width)
    }
    var fitW: Int {
        return Int(CGFloat(self)/414.0 * UIScreen.main.bounds.width)
    }
    var fitH: Int {
        return Int(CGFloat(self)/896.0 * UIScreen.main.bounds.width)
    }
}
extension CGFloat {
    var fitScreen: CGFloat {
        return CGFloat(self/414.0 * UIScreen.main.bounds.size.width)
    }
    var fit: CGFloat {
        return CGFloat(self/414.0) * UIScreen.main.bounds.width
    }
    var fitW: CGFloat {
        return CGFloat(self/414.0) * UIScreen.main.bounds.width
    }
    var fitH: CGFloat {
        return CGFloat(self/896.0) * UIScreen.main.bounds.width
    }
}

extension CGRect {
    var fit: CGRect {
        return CGRect(x: self.minX.fitScreen, y: self.minY.fitScreen, width: self.width.fitScreen, height: self.height.fitScreen)
    }
}

extension UIView {
 
    //Colors：渐变色色值数组
    func setLayerColors(_ colors:[CGColor])  {
        let layer = CAGradientLayer()
        layer.frame = bounds
        layer.colors = colors
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 0, y: 1)
        self.layer.addSublayer(layer)
    }
    
    //Colors：渐变色色值数组 单独的扩展， 要改
    func setLayerColorsForMine(_ colors:[CGColor])  {
        let layer = CAGradientLayer()
        layer.frame = bounds
        layer.colors = colors
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 0, y: 1)
        layer.cornerRadius = 25.fit
        layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4.fit)
        layer.shadowOpacity = 1
        layer.shadowRadius = 15.fit
        self.layer.sublayers?.removeAll()
        self.layer.addSublayer(layer)
    }
    //Colors：渐变色色值数组 单独的扩展， 要改
    func setLayerColorsForHome(_ colors:[CGColor])  {
        let layer = CAGradientLayer()
        layer.frame = bounds
        layer.colors = colors
        layer.startPoint = CGPoint(x: 1, y: 0)
        layer.endPoint = CGPoint(x: 0, y: 0)
        layer.cornerRadius = 15.fit
        layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4.fit)
        layer.shadowOpacity = 1
        layer.shadowRadius = 15.fit
        self.layer.sublayers?.removeAll()
        self.layer.addSublayer(layer)
    }
}
extension UIViewController{
    public func setTabBar(controller: UIViewController, title: String, image: UIImage, selectedImage: UIImage) -> UIViewController{
        controller.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        return controller
    }
    public func setUIVC(_ viewController: UIViewController, title: String){
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        viewController.navigationController!.setLargeTitle(viewController.navigationController!)
    }

}


extension UINavigationController{
    public func setLargeTitle(_ navigationController: UINavigationController){
        /// 设置大标题
        if #available(iOS 11.0, *)
        {
            navigationController.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.automatic
            navigationController.navigationBar.prefersLargeTitles = true
        }
        /// 黑线消失
        navigationController.navigationBar.shadowImage = UIImage()
    }
    
}

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat,alpha: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    class func navigationBarTintColor() -> UIColor{
        return UIColor(r: 94, g: 199, b: 217)
    }
    
    class func globalCyanColor() -> UIColor{
        return UIColor(r: 7, g: 216, b: 243)
    }
}

extension UIView{
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    @IBInspectable
    var shadowOpacity:Float{
        get{
            return layer.shadowOpacity
        }
        set{
            layer.shadowOpacity = newValue
        }
    }
    @IBInspectable
    var shadowColor:UIColor{
        get{
            return (layer.shadowColor != nil ? UIColor(cgColor: layer.shadowColor!) :nil)!
        }
        set{
            layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
}

extension UIView {
    
    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}
extension UIImage
{
    /**
     根据传入的宽度生成一张图片
     按照图片的宽高比来压缩以前的图片
     :param: width 制定宽度
     */
    func imageWithScale(width: CGFloat) -> UIImage
    {
        // 1.根据宽度计算高度
        let height = width *  size.height / size.width
        // 2.按照宽高比绘制一张新的图片
        let currentSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(currentSize)
        draw(in: CGRect(origin: CGPoint.zero, size: currentSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
extension Date {
    //MARK: - 获取日期各种值
    //MARK: 年
    func year() ->Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.year!
    }
    //MARK: 月
    func month() ->Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.month!
        
    }
    //MARK: 日
    func day() ->Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.day!
        
    }
    //MARK: 星期几
    func weekDay()->Int{
        let interval = Int(self.timeIntervalSince1970)
        let days = Int(interval/86400) // 24*60*60
        let weekday = ((days + 4)%7+7)%7
        return weekday == 0 ? 7 : weekday
    }
    //MARK: 当月天数
    func countOfDaysInMonth() ->Int {
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self)
        return (range?.length)!
        
    }
    //MARK: 当月第一天是星期几
    func firstWeekDay() ->Int {
        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let firstWeekDay = (calendar as NSCalendar?)?.ordinality(of: NSCalendar.Unit.weekday, in: NSCalendar.Unit.weekOfMonth, for: self)
        return firstWeekDay! - 1
        
    }
    //MARK: - 日期的一些比较
    //是否是今天
    func isToday()->Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year == comNow.year && com.month == comNow.month && com.day == comNow.day
    }
    //是否是这个月
    func isThisMonth()->Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year == comNow.year && com.month == comNow.month
    }
    
    func getWeekDay(dateTime:String)->String{
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = "yyyy-MM-dd"
        let date = dateFmt.date(from: dateTime)
        let interval = Int(date!.timeIntervalSince1970)
        let days = Int(interval/86400) // 24*60*60
        let weekday = ((days + 5)%7+7)%7
        let weekDays = ["周日","周一","周二","周三","周四","周五","周六"]
        return weekDays[weekday]
    }
    
    // 获取N天前后
    func getDate(_ currentDate: Date?, day: Int) -> Date? {
        var days = day // n天后的天数
        days = Int((days == 0 ? 2.0 : Double(days))) //未指定天数则默认为两天
        var appointDate: Date? // 指定日期声明
        let oneDay: TimeInterval = 24 * 60 * 60 // 一天一共有多少秒
        appointDate = currentDate?.addingTimeInterval((oneDay * Double(days)))
        return appointDate
    }
}
