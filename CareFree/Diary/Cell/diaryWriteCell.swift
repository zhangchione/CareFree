//
//  diaryWriteCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/6.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class diaryWriteCell: UIView {
    var jump: ((Int) -> Void)?
    var jump2: (() -> Void)?
    lazy var day: UILabel = {
        let label = UILabel()
        label.text = "24"
        label.font = UIFont(name: "PingFangSC-Semibold", size: 32)
        //label.backgroundColor = UIColor.red
        return label
    }()
    
    lazy var week: UILabel = {
        let label = UILabel()
        label.text = "周五"
        label.font = UIFont(name: "PingFangSC-Regular", size: 12)
        //label.backgroundColor = UIColor.green
        return label
    }()
    
    lazy var yearMouth: UILabel = {
        let label = UILabel()
        label.text = "2019年5月"
        label.font = UIFont(name: "PingFangSC-Regular", size: 12)
        //label.backgroundColor = UIColor.blue
        return label
    }()
    
    lazy var dayLine:UIView = {
        let vi = UIView()
        vi.backgroundColor = .black
        return vi
    }()
    
    lazy var emotionValue: UILabel = {
        let label = UILabel()
        label.text = "情绪值"
        label.textColor = UIColor.black
        label.font = UIFont(name: "PingFangSC-Medium", size: 13)
        //label.backgroundColor = UIColor.red
        return label
    }()
    // 写日记Cell
    lazy var writeBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "addphoto_icon"), for: .normal)
        btn.setTitle("描述今日", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: "PingFangSC-Medium", size: 10)
        btn.tintColor = UIColor.init(r: 96, g: 114, b: 255)
        
        btn.imageEdgeInsets = UIEdgeInsets(top: -15, left: 12, bottom: 0, right: 0)
        btn.titleEdgeInsets = UIEdgeInsets(top: 20, left: -20, bottom: -20, right: 0)
        return btn
    }()

    
    lazy var writeCollection:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: 60, height:60)
        
        let collection = UICollectionView.init(frame:CGRect(x:100, y:50, width:265, height:180), collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.register(UINib(nibName: "writeCell", bundle: nil), forCellWithReuseIdentifier: "writeCell")
        return collection
    }()
    
    init() {
        super.init(frame: .zero)
        configUI()
        configShadow()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateUI(with data:diaryModel)
    {
    }
    
    func configUI(){
        addSubview(day)
        addSubview(week)
        addSubview(yearMouth)
        addSubview(dayLine)
        addSubview(emotionValue)
        addSubview(writeBtn)
        addSubview(writeCollection)
        writeCollection.delegate = self
        writeCollection.dataSource = self
        day.snp.makeConstraints{(make) in
            make.top.equalTo(self) .offset(15)
            make.left.equalTo(self).offset(20)
            make.height.equalTo(35)
            make.width.equalTo(40)
        }
        dayLine.snp.makeConstraints{(make) in
            make.top.equalTo(day.snp.bottom).offset(5)
            make.left.equalTo(self).offset(20)
            make.height.equalTo(2)
            make.width.equalTo(30)
        }
        week.snp.makeConstraints{(make) in
            make.top.equalTo(self).offset(13)
            make.left.equalTo(day.snp.right).offset(15)
            make.height.equalTo(20)
            make.width.equalTo(40)
        }
        yearMouth.snp.makeConstraints{(make) in
            make.top.equalTo(week.snp.bottom).offset(-1)
            make.left.equalTo(day.snp.right).offset(15)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        emotionValue.snp.makeConstraints{(make) in
            make.top.equalTo(self).offset(12)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(30)
            make.width.equalTo(90)
        }
        
        // 写日记
        writeBtn.snp.makeConstraints{(make) in
            make.top.equalTo(dayLine.snp.bottom).offset(20)
            make.left.equalTo(self).offset(35)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        writeCollection.snp.makeConstraints{(make) in
            make.centerY.equalTo(writeBtn.snp.centerY)
            make.left.equalTo(writeBtn.snp.right).offset(10)
            make.height.equalTo(60)
            make.width.equalTo(250)
        }
        
    }
    func configShadow(){
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        //self.layer.borderWidth = 1.0
        //self.layer.borderColor = UIColor.clear.cgColor
        
        self.layer.shadowColor = UIColor.init(red: 110, green: 127, blue: 255, alpha: 0).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.6
        self.layer.masksToBounds = false
    }
        var jumpC = 0

}
extension diaryWriteCell:UICollectionViewDelegate,UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "writeCell", for: indexPath) as! writeCell
        var tap = UITapGestureRecognizer()
        var tap2 = UITapGestureRecognizer()
        var tap3 = UITapGestureRecognizer()
        var tap4 = UITapGestureRecognizer()

        switch indexPath.row {
        case 0 :
            cell.circleView.backgroundColor = UIColor.init(r: 57, g: 210, b: 214)

            cell.emotionLabel.text = "开心"
            tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction))
            cell.contentView.addGestureRecognizer(tap)
        case 1 :
            cell.circleView.backgroundColor = UIColor.init(r: 100, g: 175, b: 232)
            cell.emotionLabel.text = "平静"
            tap2 = UITapGestureRecognizer(target: self, action: #selector(self.tapAction2))
            cell.contentView.addGestureRecognizer(tap2)
        case 2 :
            cell.circleView.backgroundColor = UIColor.init(r: 155, g: 133, b: 255)
            cell.emotionLabel.text = "难过"
            tap3 = UITapGestureRecognizer(target: self, action: #selector(self.tapAction3))
            cell.contentView.addGestureRecognizer(tap3)
        default:
            cell.circleView.backgroundColor = UIColor.init(r: 31, g: 69, b: 99)
            cell.emotionLabel.text = "压抑"
            tap4 = UITapGestureRecognizer(target: self, action: #selector(self.tapAction4))
            cell.contentView.addGestureRecognizer(tap4)
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @objc func tapAction(){
        print("要跳转1")
        jump!(0)
    }
    @objc func tapAction2(){
        print("要跳转2")
        jump!(1)
    }
    @objc func tapAction3(){
        print("要跳转3")
        jump!(2)
    }
    @objc func tapAction4(){
        print("要跳转4")
        jump!(3)
    }
    //collectionViewdid
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 50, height: 60 )
//    }
}