//
//  MineBodyView.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/13.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


// 点击
protocol MineBodyViewDelegate:NSObjectProtocol {
    func mineCardTapCallBack(type:CardType)
    func setCallBack(type:SetViewOnBodyViewType,isOn:Bool)
}


extension MineBodyView: CardCallBackDelegate{
    func cardCallBack(type: SetViewOnBodyViewType,isOn:Bool) {
        delegate?.setCallBack(type: type,isOn: isOn)
    }
}

// 数据模型

struct MineBodyModel {
    var emotionViewData = 0
    var diaryViewData = (diary:0,notes:0)
    var trashViewData = 0
}

class MineBodyView: UIView {

    
    public func updateUI(with data:MineBodyModel) {
        self.emotionView.updateUI(type: .emotion(data.emotionViewData))
        self.diaryView.updateUI(type: .diary(data.diaryViewData.diary, data.diaryViewData.notes))
        self.trashView.updateUI(type: .trash(data.trashViewData))
    }
    
    weak var delegate: MineBodyViewDelegate?
    
    lazy var emotionView: CardView = {
        let view = CardView()
        view.setUI(type: .emotion(0))
        return view
    }()
    
    lazy var diaryView: CardView = {
        let view = CardView()
        view.setUI(type: .diary(0,0))
        return view
    }()
    
    lazy var trashView: CardView = {
        let view = CardView()
        view.setUI(type: .trash(0))
        let tap = UITapGestureRecognizer(target: self, action: #selector(trashEvent))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var setView: CardView = {
        let view = CardView()
        view.setUI(type: .set)
        let tap = UITapGestureRecognizer(target: self, action: #selector(setEvent))
        view.addGestureRecognizer(tap)
        view.delegate = self
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        configUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI(){
        addSubview(emotionView)
        emotionView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20.fit)
            make.top.equalTo(self).offset(10.fit)
            make.width.equalTo((CFWidth-60.fit)/2)
            make.height.equalTo(210.fit)
        }
        addSubview(diaryView)
        diaryView.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-20.fit)
            make.top.equalTo(self).offset(10.fit)
            make.width.equalTo((CFWidth-60.fit)/2)
            make.height.equalTo(210.fit)
        }
        addSubview(trashView)
        trashView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20.fit)
            make.top.equalTo(self).offset(250.fit)
            make.width.equalTo((CFWidth-60.fit)/2)
            make.height.equalTo(210.fit)
        }
        addSubview(setView)
        setView.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-20.fit)
            make.top.equalTo(self).offset(250.fit)
            make.width.equalTo((CFWidth-60.fit)/2)
            make.height.equalTo(210.fit)
        }
    }
    
    @objc func trashEvent(){
        delegate?.mineCardTapCallBack(type: .trash(0))
    }
    @objc func setEvent(){
        delegate?.mineCardTapCallBack(type: .set)
    }
    
}
