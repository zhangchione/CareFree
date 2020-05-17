//
//  CFHomeEmotionCell.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/14.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit

class CFHomeEmotionCell: UICollectionViewCell {
    
    
    public func updateUI(with value:Int) {
        self.emotionValue.text = "\(value)"
        DispatchQueue.main.async {
            switch value {
            case 26 ... 50:
                self.backView.setLayerColorsForHome(happyGradientColor)
            case 0 ... 25:
                self.backView.setLayerColorsForHome(calmGradientColor)
            case -25 ... -1:
                self.backView.setLayerColorsForHome(sadGradientColor)
            case -50 ... -26:
                self.backView.setLayerColorsForHome(repressioneGradientColor)
            default:
                break
            }
        }
        progressView.updateUI(with: CGFloat(value))
        
    }
    
    lazy var backView: UIView = {
        let vi = UIView()
        return vi
    }()

    lazy var line: UIView = {
        let vi = UIView()
        vi.backgroundColor = .white
        return vi
    }()
    
    
    
    
    // 心情圆
    let progressView: ZCCircleProgree = {
        let progressView = ZCCircleProgree()

        return progressView
    }()
    
    
    lazy var emotionValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32.fit)
        label.textColor = .white
        label.textAlignment = .right
        label.text = "36"
        return label
    }()
    
    lazy var favIcon:UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "mine_icon_fav")
        return img
    }()
    
    lazy var valueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18.fit)
        label.textColor = .white
        label.textAlignment = .right
        label.text = "当前情绪值"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configShadow()
        configUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI(){
        addSubview(backView)
        addSubview(line)
        addSubview(progressView)
        
        
        addSubview(emotionValue)
        addSubview(favIcon)
        addSubview(valueLabel)
        
        backView.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(20.fit)
            make.right.equalTo(self).offset(-20.fit)
            make.height.equalTo(200.fit)
            make.centerY.equalTo(self)
        }
        line.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(40.fit)
            make.centerY.equalTo(self)
            make.height.equalTo(160.fit)
            make.width.equalTo(2.fit)
        }
                
        progressView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(60.fit)
            make.width.height.equalTo(120.fit)
        }
        
        favIcon.snp.makeConstraints{(make) in
            make.top.equalTo(line.snp.top).offset(10.fit)
            make.right.equalTo(self).offset(-50.fit)
            make.height.width.equalTo(30.fit)
        }
        valueLabel.snp.makeConstraints{(make) in
            make.right.equalTo(self).offset(-50.fit)
            make.top.equalTo(favIcon.snp.bottom).offset(8.fit)
            make.width.equalTo(150.fit)
            make.height.equalTo(35.fit)
        }
        
        emotionValue.snp.makeConstraints{(make) in
            make.right.equalTo(self).offset(-50.fit)
            make.top.equalTo(valueLabel.snp.bottom).offset(7.fit)
            make.width.equalTo(70.fit)
            make.height.equalTo(50.fit)
        }


        
        
    }
    private func configShadow(){
        self.backView.backgroundColor = .white
        self.backView.layer.cornerRadius = 15.fit
        self.backView.layer.masksToBounds = false
        self.backView.layer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        self.backView.layer.shadowOffset = CGSize(width: 0, height: 4.fit)
        self.backView.layer.shadowOpacity = 1
        self.backView.layer.shadowRadius = 12.fit
    }
    
    
}
