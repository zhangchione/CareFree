//
//  ZCCircle.swift
//  CareFree
//
//  Created by 张驰 on 2020/5/17.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit

let  endPointMargin:CGFloat = 1.0

class ZCCircle: UIView {

    public var progress:CGFloat = 0.0
    public var lineWidth:CGFloat = 0.0
    
    
    private var trackLayer = CAShapeLayer()
    private var progressLayer =  CAShapeLayer()
    private var endPoint = UIImageView()
    
    init() {
        super.init(frame: .zero)

        buildLayout()
    }
    
    func buildLayout(){
        var centerX = self.bounds.size.width/2.0;
        var centerY = self.bounds.size.height/2.0;
        //半径
        var radius = (self.bounds.size.width-lineWidth)/2.0;
        //创建贝塞尔路径
        
        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)
        let backLayer = CAShapeLayer()
        backLayer.frame = bounds
        backLayer.fillColor = UIColor.clear.cgColor
        backLayer.strokeColor = UIColor(red: 50.0 / 255.0, green: 50.0 / 255.0, blue: 50.0 / 255.0, alpha: 1).cgColor
        backLayer.lineWidth = lineWidth
        backLayer.path = path.cgPath
        backLayer.strokeEnd = 1
        layer.addSublayer(backLayer)
        
        progressLayer = CAShapeLayer()
        progressLayer.frame = bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        //指定path的渲染颜色
        progressLayer.strokeColor = UIColor.black.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = lineWidth
        progressLayer.path = path.cgPath
        progressLayer.strokeEnd = 0
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = happyGradientColor
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.mask = progressLayer //用progressLayer来截取渐变层
        layer.addSublayer(gradientLayer)
        
        endPoint = UIImageView()
        endPoint.frame = CGRect(x: 0, y: 0, width: lineWidth - endPointMargin * 2, height: lineWidth - endPointMargin * 2)
        endPoint.isHidden = true
        endPoint.backgroundColor = UIColor.black
        endPoint.image = UIImage(named: "endPoint")
        endPoint.layer.masksToBounds = true
        endPoint.layer.cornerRadius = endPoint.bounds.size.width / 2
        addSubview(endPoint)
        
    }
    
    func updateUI(pregree:CGFloat) {
        self.progress = pregree
        progressLayer.strokeEnd = pregree
        updateEndPoint()
        progressLayer.removeAllAnimations()
    }
    
    
    func updateEndPoint(){
        let angle: CGFloat = .pi * 2 * progress
        let radius: Float = Float((bounds.size.width - lineWidth) / 2.0)
        let index = Int((angle) / CGFloat(M_PI_2)) //用户区分在第几象限内
        let needAngle = Float(angle - CGFloat(Double(index) * M_PI_2)) //用于计算正弦/余弦的角度
        var x: Float = 0
        var y: Float = 0 //用于保存_dotView的frame
        switch index {
            case 0:
                print("第一象限")
                x = radius + sinf(needAngle) * radius
                y = radius - cosf(needAngle) * radius
            case 1:
                print("第二象限")
                x = radius + cosf(needAngle) * radius
                y = radius + sinf(needAngle) * radius
            case 2:
                print("第三象限")
                x = radius - sinf(needAngle) * radius
                y = radius + cosf(needAngle) * radius
            case 3:
                print("第四象限")
                x = radius - cosf(needAngle) * radius
                y = radius - sinf(needAngle) * radius
            default:
                break
        }
        //更新圆环的frame
        var rect = endPoint.frame
        rect.origin.x = CGFloat(x) + endPointMargin
        rect.origin.y = CGFloat(y) + endPointMargin
        endPoint.frame = rect
        //移动到最前
        bringSubviewToFront(endPoint)
        endPoint.isHidden = false
        if progress == 0 || progress == 1 {
            endPoint.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ZCCircleProgree:UIView {
    
    public var progree:CGFloat = 0.0
    lazy var circle: ZCCircle = {
       let circle = ZCCircle()
        let lineWidth: Float = Float(0.1 * bounds.size.width)
        circle.frame = bounds
        circle.lineWidth = CGFloat(lineWidth)
        return circle
    }()
    
    lazy var percentLabel: UILabel = {
       let label = UILabel(frame: bounds)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 36.fit)
        label.text = "0%"
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        configUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(){

        addSubview(circle)
        addSubview(percentLabel)
    }
    func updateUI(with value:CGFloat) {
        circle.progress = value
        self.progree = value
        self.percentLabel.text = "\(value*10)"
        circle.updateUI(pregree: value)
    }
}
