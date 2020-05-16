//
//  CradView.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/13.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit

protocol CardCallBackDelegate:NSObjectProtocol {
    func cardCallBack(type:SetViewOnBodyViewType,isOn:Bool)
}

struct CardViewModel {
    var titleName = ""
    var iconName = ""
    
}


enum CardType {
    case emotion(Int)
    case diary(Int,Int)
    case trash(Int)
    case set
}

class CardView: UIView {
    
    
    public func setUI(type:CardType) {
        switch type {
        case .emotion(let moodValue):
            self.configEmotionView(with: moodValue)
            self.configRightValue(value: moodValue, valueLabel: "Point", type: .rightEmotion)
            self.updateSelfUI(with: CardViewModel(titleName: "情绪值", iconName: "mine_icon_fav"))
        case .diary(let diaryTotal,let notesTotal):
            
            self.configLeftValue(value: diaryTotal, valueLabel: "日记")
            self.configRightValue(value: notesTotal, valueLabel: "贴纸", type: .rightNomnal)
            self.updateSelfUI(with: CardViewModel(titleName: "统计", iconName: "mine_icon_diary"))
        case .trash(let trashTotal):
            self.configLeftValue(value: trashTotal, valueLabel: "废纸")
            self.updateSelfUI(with: CardViewModel(titleName: "废纸篓", iconName: "mine_icon_trash"))
        case .set:
            self.configSetView(title1: "首页显示任务", title2: "首页显示Mark")
            self.updateSelfUI(with: CardViewModel(titleName: "设置", iconName: "mine_icon_set"))
        }
    }
    
    public func updateUI(type:CardType) {
        switch type {
        case .emotion(let moodValue):
            self.updateEmotion(with: moodValue)
            self.valueRightView.value.text = "\(moodValue)"
        case .diary(let diaryTotal,let notesTotal):
            self.valueLeftView.value.text = "\(diaryTotal)"
            self.valueRightView.value.text = "\(notesTotal)"
        case .trash(let trashTotal):
            self.valueLeftView.value.text = "\(trashTotal)"
        case .set:
            break
        }
    }
    
    weak var delegate: CardCallBackDelegate?
    
    lazy var backView:UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.white
        vi.cornerRadius = 25.fit
        return vi
    }()
    lazy var titleLabel:UILabel  = {
        let label = UILabel ()
        label.textColor = UIColor.black
        label.text = "照片统计"
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 16)
        return label
    }()
    lazy var titleIco:UIImageView = {
        let vi = UIImageView()
        vi.image = UIImage(named: "分组4")
        return vi
    }()
    
    
    lazy var emotionView: EmotionView = {
        let emotionView = EmotionView()
        return emotionView
    }()

    lazy var valueLeftView : ValueView = {
        let valueView = ValueView()
        return valueView
    }()
    
    lazy var valueRightView : ValueView = {
        let valueView = ValueView()
        return valueView
    }()

    lazy var setView1 : SetView = {
        let setView = SetView()
        return setView
    }()
    
    lazy var setView2 : SetView = {
        let setView = SetView()
        return setView
    }()
    
    
    
    init() {
        super.init(frame: .zero)
        configUI()
        configShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    private func configEmotionView(with value:Int){
        addSubview(emotionView)
        emotionView.snp.makeConstraints { (make) in
            make.left.equalTo(backView.snp.left).offset(20.fit)
            make.bottom.equalTo(backView.snp.bottom).offset(-20.fit)
            make.height.equalTo(100.fit)
            make.width.equalTo(50.fit)
        }
        
    }
    
    

    
    private func configLeftValue(value:Int,valueLabel:String){
        addSubview(valueLeftView)
        valueLeftView.snp.makeConstraints { (make) in
            make.left.equalTo(backView.snp.left).offset(20.fit)
            make.bottom.equalTo(backView.snp.bottom).offset(-40.fit)
            make.height.equalTo(50.fit)
            make.width.equalTo(40.fit)
        }
        valueLeftView.updateUI(value: value, valueLabel: valueLabel, type:  .left)
    }
    
    
    

    
    private func configRightValue(value:Int,valueLabel:String,type:ValueType){

        addSubview(valueRightView)
        valueRightView.snp.makeConstraints { (make) in
            make.right.equalTo(backView.snp.right).offset(-20.fit)
            make.bottom.equalTo(backView.snp.bottom).offset(-40.fit)
            make.height.equalTo(50.fit)
            make.width.equalTo(40.fit)
        }
        valueRightView.updateUI(value: value, valueLabel: valueLabel, type:type)
    }
    
    private func configSetView(title1:String,title2:String) {
        addSubview(setView1)
        setView1.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20.fit)
            make.right.equalTo(self).offset(-25.fit)
            make.bottom.equalTo(self).offset(-30.fit)
            make.height.equalTo(30.fit)
        }
        setView1.updateUI(title: title1)
        setView1.delegate = self
        
        if let value = getSetHomeShowTask() {
            setView1.controller.isOn = value
        }
        
        addSubview(setView2)
        setView2.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20.fit)
            make.right.equalTo(self).offset(-25.fit)
            make.bottom.equalTo(self).offset(-80.fit)
            make.height.equalTo(30.fit)
        }
        setView2.setViewType = .taskTop
        setView2.updateUI(title: title2)
        setView2.delegate = self
        
        if let value = getSetHomeShowMark() {
            setView2.controller.isOn = value
        }
    }
    
    
    private func configUI(){
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(5.fit)
            make.right.bottom.equalTo(self).offset(-5.fit)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(backView.snp.left).offset(20.fit)
            make.top.equalTo(backView.snp.top).offset(30.fit)
            make.height.equalTo(30.fit)
            make.width.equalTo(70.fit)
        }
        
        addSubview(titleIco)
        titleIco.snp.makeConstraints { (make) in
            make.right.equalTo(backView.snp.right).offset(-20.fit)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.height.equalTo(20.fit)
            make.width.equalTo(20.fit)
        }
        
    }
    private func configShadow(){
        self.backView.backgroundColor = .white
        self.backView.layer.cornerRadius = 25.fit
        self.backView.layer.masksToBounds = false
        self.backView.layer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        self.backView.layer.shadowOffset = CGSize(width: 0, height: 4.fit)
        self.backView.layer.shadowOpacity = 1
        self.backView.layer.shadowRadius = 12.fit
    }

    
}

extension CardView {
    private func updateSelfUI(with data:CardViewModel){
        self.titleLabel.text = data.titleName
        self.titleIco.image = UIImage(named: data.iconName)
    }
    private func updateEmotion(with value:Int) {
        DispatchQueue.main.async {
            switch value {
            case 26 ... 50:
                self.backView.setLayerColorsForMine(happyGradientColor)
            case 0 ... 25:
                self.backView.setLayerColorsForMine(calmGradientColor)
            case -25 ... -1:
                self.backView.setLayerColorsForMine(sadGradientColor)
            case -50 ... -26:
                self.backView.setLayerColorsForMine(repressioneGradientColor)
            default:
                break
            }
        }
        self.titleLabel.textColor = .white
        emotionView.updateUI(with: value)
    }
}

extension CardView : SetViewOnBodyViewCallBackDelegate {
    func setCallBack(type: SetViewOnBodyViewType, isOn: Bool) {
        delegate?.cardCallBack(type: type, isOn: isOn)
    }
    
}
