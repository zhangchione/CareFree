//
//  YQCircleProgressView.swift
//  YQCIrcleProgressView-Demo
//
//  Created by FreakyYang on 2018/8/29.
//  Copyright © 2018年 FreakyYang. All rights reserved.
//

import UIKit

class YQCircleProgreeView: UIView {
    
    // MARK: - public
    
    var borderWidth: CGFloat = 10
    
    var defaultBorderColor = UIColor.white
    
    var backgroundImage: UIImage? {
        didSet {
            backGroundIMGV.backgroundColor = backgroundImage == nil ?
                defaultBorderColor : UIColor.clear
            backGroundIMGV.image = backgroundImage
        }
    }
    
    var animationDuration: CFTimeInterval = 0.3
    
    func setProgress(_ theProgress: Double, animation: Bool = false) {
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = ((bounds.width < bounds.height ?
            bounds.width : bounds.height) / 2) - (borderWidth / 2) - 2
        let startA = -Double.pi / 2
        let endA = (-Double.pi / 2) + Double.pi * 2 * theProgress
        
        let progressLayer = CAShapeLayer()
        progressLayer.frame = bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.black.cgColor
        progressLayer.opacity = 1
        progressLayer.lineCap = CAShapeLayerLineCap.round
        progressLayer.lineWidth = borderWidth
        
        let toPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startA), endAngle: CGFloat(endA), clockwise: true)
        
        if animation {
            let fullEndA = (-Double.pi / 2) + Double.pi * 2 * 0.999
            let fullPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startA), endAngle: CGFloat(fullEndA), clockwise: true)
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = progress
            animation.toValue = theProgress
            animation.duration = animationDuration
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.isRemovedOnCompletion = false
            progressLayer.add(animation, forKey: nil)
            progressLayer.path = fullPath.cgPath
        } else {
            progressLayer.path = toPath.cgPath
        }
        backGroundIMGV.layer.mask = progressLayer
        
        progress = theProgress
    }
    
    private(set) public var progress: Double = 0
    
    // MARK: - private
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backGroundIMGV)
        backGroundIMGV.frame = bounds
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backGroundIMGV.frame = bounds
        setProgress(progress, animation: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var backGroundIMGV: UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFill
        imgv.layer.masksToBounds = true
        imgv.backgroundColor = defaultBorderColor
        return imgv
    }()
    
}
