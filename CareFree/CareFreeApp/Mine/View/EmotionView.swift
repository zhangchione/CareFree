//
//  EmotionView.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/13.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit

class EmotionView: UIView {

    
    public func updateUI(with value:Int){
        moodView.snp.updateConstraints { (make) in
            make.height.equalTo(abs(value*2).fit) //view 高度100  value: -50  ~ 50
        }
        DispatchQueue.main.async {
            switch value {
            case 26 ... 50:
                break;
            case 0 ... 25:
                break
            case -25 ... -1:
                break
            case -50 ... -26:
                break
            default:
                break
            }
            guard value != 50 else {
                self.moodView.corner(byRoundingCorners: [.topRight,.topLeft], radii: 8.fit)
                return
            }
            self.moodView.corner(byRoundingCorners: [.topRight,.topLeft], radii: 18.fit)
        }
    }
    
    lazy var backView:UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.white
        vi.cornerRadius = 5.fit
        return vi
    }()
    
    lazy var moodView:UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.orange
        return vi
    }()
    
    init() {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configUI(){
        self.backgroundColor = .white
        addSubview(moodView)
        
        moodView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(0)
        }
        
        DispatchQueue.main.async {

        }
        
        self.layer.cornerRadius = 8.fit
        self.layer.masksToBounds = true
    }
}
