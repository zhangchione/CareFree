//
//  ZCCircle.swift
//  CareFree
//
//  Created by 张驰 on 2020/5/17.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit

let endPointMargin: CGFloat = 3.fit

let PI: CGFloat = 3.14159265358979323846264338327950288
let PI_2:CGFloat = 1.57079632679489661923132169163975144


class ZCCircle: UIView {

    public var progress:CGFloat = 0.0
    public var lineWidth:CGFloat = 15.fit
    
    
    private var trackLayer = CAShapeLayer()
    private var progressLayer =  CAShapeLayer()
    private var endPoint = UIView()
    let backLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configUI()
    }
    
    func configUI(){
        let centerX = self.bounds.size.width/2.0;
        let centerY = self.bounds.size.height/2.0;
        //半径
        let radius = (self.bounds.size.width-lineWidth)/2.0;
        //创建贝塞尔路径
        
        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: -0.5 * PI, endAngle: 1.5 * PI, clockwise: true)
        
        backLayer.frame = bounds
        backLayer.fillColor = UIColor.clear.cgColor
        backLayer.strokeColor = UIColor.init(r: 50, g: 50, b: 50,alpha: 0.2).cgColor//UIColor.init(r: 139, g: 208, b: 231).cgColor// UIColor(red: 50.0 / 255.0, green: 50.0 / 255.0, blue: 50.0 / 255.0, alpha: 1).cgColor
        backLayer.lineWidth = lineWidth
        backLayer.path = path.cgPath
        backLayer.strokeEnd = 1
        layer.addSublayer(backLayer)
        
        progressLayer = CAShapeLayer()
        progressLayer.frame = bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        //指定path的渲染颜色
        progressLayer.strokeColor = UIColor.init(r: 255, g: 255, b: 255,alpha: 1).cgColor //UIColor.black.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = lineWidth
        progressLayer.path = path.cgPath
        progressLayer.strokeEnd = 0
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors =  [UIColor.white.cgColor,UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.mask = progressLayer //用progressLayer来截取渐变层
        layer.addSublayer(gradientLayer)
        
        endPoint = UIView()
        let width = lineWidth - endPointMargin * 2
        endPoint.frame = CGRect(x: self.bounds.size.width/2-width/2, y: endPointMargin*3, width: width, height: width)
        endPoint.isHidden = true
        
        endPoint.layer.masksToBounds = true
        endPoint.layer.cornerRadius = endPoint.bounds.size.width / 2
        addSubview(endPoint)
        
    }
    
    func updateUI(value:CGFloat) {
        let rangeValue = abs(value)
        self.progressLayer.strokeEnd = rangeValue / 50.0
        self.progress = rangeValue / 50.0
        self.updateEndPoint()
        self.progressLayer.removeAllAnimations()
        
        backLayer.strokeColor = UIColor.init(r: 50, g: 50, b: 50,alpha: 0.2).cgColor
        progressLayer.strokeColor = UIColor.init(r: 255, g: 255, b: 255,alpha: 1).cgColor
        switch rangeValue {
        case 26 ... 50:
            endPoint.backgroundColor = happyColor
        case 0 ... 25:
            endPoint.backgroundColor = calmColor
        case -25 ... -1:
            endPoint.backgroundColor = sadColor
        case -50 ... -26:
            endPoint.backgroundColor = repressioneColor
        default:
            break
        }
    }
    
    
    func updateEndPoint(){
        
        let angle: CGFloat = PI * 2 * progress
        print(self.bounds.size.width)
        let radius: Float = Float((self.bounds.size.width - lineWidth   ) / 2.0 - endPointMargin*2)
        let index = Int(angle / PI_2) //用户区分在第几象限内
        let needAngle = Float(angle - CGFloat(CGFloat(index) * PI_2)) //用于计算正弦/余弦的角度
        var x: Float = 0.0
        var y: Float = 0.0 //用于保存_dotView的frame
        switch index {
            case 0:
                x = radius + sinf(needAngle) * radius
                y = radius - cosf(needAngle) * radius
            case 1:
                x = radius + cosf(needAngle) * radius
                y = radius + sinf(needAngle) * radius
            case 2:
                x = radius - sinf(needAngle) * radius
                y = radius + cosf(needAngle) * radius
            case 3:
                x = radius - cosf(needAngle) * radius
                y = radius - sinf(needAngle) * radius
            default:
                break
        }
        //更新圆环的frame
        var rect = endPoint.frame
        rect.origin.x = CGFloat(x) + 1.fit
        rect.origin.y = CGFloat(y) + 1.fit
        endPoint.frame = rect
        //移动到最前
        bringSubviewToFront(endPoint)
        endPoint.isHidden = false
//        if  progress == 1 {
//            endPoint.isHidden = true
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ZCCircleProgree:UIView {
    
    
    lazy var circle: ZCCircle = {
        let circle = ZCCircle(frame: CGRect(x: 0, y: 0, width: 120.fit, height: 120.fit))
        let lineWidth: Float = Float(0.1 * bounds.size.width)
        circle.lineWidth = CGFloat(lineWidth)
        return circle
    }()
    
    lazy var percentLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 36.fit)
        label.text = "0%"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(){

        addSubview(circle)
        addSubview(percentLabel)
        
        circle.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        percentLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    func updateUI(with value:CGFloat) {
        circle.progress = value
        self.percentLabel.text = "\(Int(value))"
        circle.updateUI(value: value)
    }
}
