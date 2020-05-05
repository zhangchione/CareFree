//
//  DshowDiaryCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/20.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// 添加按钮点击代理方法
protocol diaryWriteDelegate:NSObjectProtocol {
    func diaryWriteClick(mood:Int)
}

class DwriteDiaryCell: UICollectionViewCell {
    
    weak var delegate : diaryWriteDelegate?
    
    
    lazy var backView:UIView = {
       let vi = UIView()
        vi.backgroundColor = .white
        vi.layer.cornerRadius = 20.fit
        vi.layer.masksToBounds = true
        return vi
    }()
    
    lazy var day: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.font = UIFont(name: "PingFangSC-Semibold", size: 32.fit)
        return label
    }()
    
    lazy var week: UILabel = {
        let label = UILabel()
        label.text = "周四"
        label.font = UIFont(name: "PingFangSC-Regular", size: 12.fit)
        return label
    }()
    
    lazy var yearMouth: UILabel = {
        let label = UILabel()
        label.text = "2019年7月"
        label.font = UIFont(name: "PingFangSC-Regular", size: 12.fit)
        return label
    }()
    
    lazy var dayLine:UIView = {
        let vi = UIView()
        vi.backgroundColor = .black
        return vi
    }()
    
    lazy var emotionValue: UILabel = {
        let label = UILabel()
        label.text = "当前情绪值"
        label.textColor = UIColor.black
        label.font = UIFont(name: "PingFangSC-Medium", size: 13.fit)
        return label
    }()
    
    let disposeBag = DisposeBag()
    // 写日记Cell
    lazy var writeBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "diary_icon_add"), for: .normal)
        btn.setTitle("描述今日", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: "PingFangSC-Medium", size: 10.fit)
        btn.tintColor = UIColor.init(r: 96, g: 114, b: 255)
        
        btn.imageEdgeInsets = UIEdgeInsets(top: -15.fit, left: 15.fit, bottom: 0, right: 0)
        btn.titleEdgeInsets = UIEdgeInsets(top: 20.fit, left: -30.fit, bottom: -20.fit, right: 0)
        btn.rx.tap.subscribe(onNext:{[weak self] in
            guard let strongSelf = self else { return }
        }).disposed(by: disposeBag)
        return btn
    }()
    
    
    lazy var writeCollection:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: 60.fit, height:60.fit)
        
        let collection = UICollectionView.init(frame:CGRect(x:100, y:50, width:265, height:180), collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.register(UINib(nibName: "writeCell", bundle: nil), forCellWithReuseIdentifier: "writeCell")
        return collection
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configShadow()
        configUI()
    }


    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configUI(){
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(20.fit)
            make.right.equalTo(self).offset(-20.fit)
        }
        backView.addSubview(day)
        backView.addSubview(week)
        backView.addSubview(yearMouth)
        backView.addSubview(dayLine)
        backView.addSubview(emotionValue)
        backView.addSubview(writeBtn)
        backView.addSubview(writeCollection)
        writeCollection.delegate = self
        writeCollection.dataSource = self
        day.snp.makeConstraints{(make) in
            make.top.equalTo(self) .offset(15.fit)
            make.left.equalTo(self).offset(40.fit)
            make.height.equalTo(35.fit)
            make.width.equalTo(40.fit)
        }
        dayLine.snp.makeConstraints{(make) in
            make.top.equalTo(day.snp.bottom).offset(5.fit)
            make.left.equalTo(self).offset(40.fit)
            make.height.equalTo(2.fit)
            make.width.equalTo(30.fit)
        }
        week.snp.makeConstraints{(make) in
            make.top.equalTo(self).offset(13.fit)
            make.left.equalTo(day.snp.right).offset(15.fit)
            make.height.equalTo(20.fit)
            make.width.equalTo(40.fit)
        }
        yearMouth.snp.makeConstraints{(make) in
            make.top.equalTo(week.snp.bottom).offset(-1.fit)
            make.left.equalTo(day.snp.right).offset(15.fit)
            make.width.equalTo(80.fit)
            make.height.equalTo(20.fit)
        }
        emotionValue.snp.makeConstraints{(make) in
            make.top.equalTo(self).offset(12.fit)
            make.right.equalTo(self).offset(-35.fit)
            make.height.equalTo(30.fit)
            make.width.equalTo(90.fit)
        }
        
        // 写日记
        writeBtn.snp.makeConstraints{(make) in
            make.top.equalTo(dayLine.snp.bottom).offset(20.fit)
            make.left.equalTo(self).offset(55.fit)
            make.height.equalTo(60.fit)
            make.width.equalTo(60.fit)
        }
        writeCollection.snp.makeConstraints{(make) in
            make.centerY.equalTo(writeBtn.snp.centerY)
            make.left.equalTo(writeBtn.snp.right).offset(10.fit)
            make.height.equalTo(60.fit)
            make.width.equalTo(250.fit)
        }
        
    }
    func configShadow() {
        self.backgroundColor = .clear
        self.backView.backgroundColor = .white
        self.backView.layer.cornerRadius = 20.fit
        self.backView.layer.masksToBounds = false
        self.backView.layer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        self.backView.layer.shadowOffset = CGSize(width: 0, height: 4.fit)
        self.backView.layer.shadowOpacity = 1
        self.backView.layer.shadowRadius = 12.fit
    }
    
}
extension DwriteDiaryCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "writeCell", for: indexPath) as! writeCell
        //cell.backgroundColor = .red
        switch indexPath.row {
        case 0 :
            cell.circleImage.image = UIImage(named: "diary_icon_happy")
            cell.emotionLabel.text = "开心"
        case 1 :
            cell.circleImage.image = UIImage(named: "diary_icon_calm")
            cell.emotionLabel.text = "平静"
        case 2 :
            cell.circleImage.image = UIImage(named: "diary_icon_sad")
            cell.emotionLabel.text = "难过"
        default:
            cell.circleImage.image = UIImage(named: "diary_icon_sadmore")
            cell.emotionLabel.text = "压抑"
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.diaryWriteClick(mood: indexPath.row)
        print("跳转写日记界面")
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        return CGSize(width: 50, height: 60 )
    //    }
    
    
    
}

