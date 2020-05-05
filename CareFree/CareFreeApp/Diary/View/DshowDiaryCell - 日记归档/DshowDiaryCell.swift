//
//  DwitreDiaryCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/20.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import Photos

class DshowDiaryCell: UICollectionViewCell {
    
    var diaryContents = [diaryModel]()
    var nowData = [NowDiaryModel]()
    var nums = [(String,Int)]()
    
    lazy var backView:UIView = {
       let vi = UIView()
        vi.backgroundColor = .white
        vi.layer.cornerRadius = 20.fit
        vi.layer.masksToBounds = true
        return vi
    }()
    
    lazy var day: UILabel = {
        let label = UILabel()
        label.text = "24"
        label.font = UIFont(name: "PingFangSC-Semibold", size: 32.fit)
        //label.backgroundColor = UIColor.red
        return label
    }()
    
    lazy var week: UILabel = {
        let label = UILabel()
        label.text = "周五"
        label.font = UIFont(name: "PingFangSC-Regular", size: 12.fit)
        //label.backgroundColor = UIColor.green
        return label
    }()
    
    lazy var yearMouth: UILabel = {
        let label = UILabel()
        label.text = "2019年5月"
        label.font = UIFont(name: "PingFangSC-Regular", size: 12.fit)
        //label.backgroundColor = UIColor.blue
        return label
    }()
    
    lazy var dayLine:UIView = {
        let vi = UIView()
        vi.backgroundColor = .black
        return vi
    }()
    
    lazy var content: UILabel = {
        let label = UILabel()
        label.text = "今天考试，准备了很久，希望能够得到好成绩"
        label.font = UIFont(name: "PingFangSC-Regular", size: 15.fit)
        label.numberOfLines = 0
        // label.backgroundColor = UIColor.red
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.init(r: 127, g: 127, b: 127)
        return label
    }()
    
    lazy var emotionValue: UILabel = {
        let label = UILabel()
        label.text = "情绪值 32"
        label.textColor = UIColor.init(r: 57, g: 210, b: 214)
        label.font = UIFont(name: "PingFangSC-Medium", size: 16.fit)
        label.textAlignment = .center
        //label.backgroundColor = UIColor.red
        return label
    }()
    
    lazy var image:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "t3")
        img.clipsToBounds = true
        img.layer.cornerRadius = 5.fit
        return img
    }()
    
    lazy var emotionData : UITableView = {
        let tableView = UITableView()
        // tableView.backgroundColor = UIColor.red
        tableView.register(UINib(nibName: "emotionCell", bundle: nil), forCellReuseIdentifier: "emotionCell")
        tableView.separatorStyle = .none
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configShadow()
        configUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(with datas:DiaryModel)
    {
        let data = datas
        
        let date = data.date
        let timeForMatter = DateFormatter()
        timeForMatter.dateFormat = "dd"
        let daytext = timeForMatter.string(from: date)
        timeForMatter.dateFormat = "yyyy年MM月"
        let yeartext = timeForMatter.string(from: date)
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = "yyyy-MM-dd"
        let weektext = date.getWeekDay(dateTime: dateFmt.string(from: date))
        day.text = daytext
        yearMouth.text = yeartext
        week.text = weektext
        content.text = data.content
        emotionValue.text = "情绪值 \(data.mood)"
        switch data.mood {
        case 26 ... 50:
            emotionValue.textColor = happyColor
        case 0 ... 25:
            emotionValue.textColor = calmColor
        case -25 ... -1:
            emotionValue.textColor = sadColor
        case -50 ... -26:
            emotionValue.textColor = repressioneColor
        default:
            break;
        }
        
        var photoData = data.images.components(separatedBy: ",")
        if photoData[0] == "" {
            photoData.removeAll()
            self.image.alpha = 0
        }else {
            self.image.alpha = 1
            let result = PHAsset.fetchAssets(withLocalIdentifiers: [photoData[0]].compactMap{ $0 },options: nil) as? PHFetchResult
            result?.enumerateObjects({ (obj, index, stop) in
                let imageAsset = obj as? PHAsset
                if let imageAsset = imageAsset {
                    let img = SKPHAssetToImageTool.PHAssetToImage(asset: imageAsset)
                    self.image.image = img
                }
            })
        }
    }
    
    func updateWriteUI(){
        
    }
    var nowDatas = [NowData]()
    
    var conten:DiaryTodayModel?{
        didSet{
            guard let model = conten else { return }
            
            
            self.day.text = (model.date as NSString).substring(to: 2)
            self.yearMouth.text = (model.date as NSString).substring(with: NSMakeRange(3,8))
            var weekText:String?
            
            switch (model.date as NSString).substring(from: 19) {
            case "Mon":
                weekText = "周一"
            case "Tue":
                weekText = "周二"
            case "Wed":
                weekText = "周三"
            case "Thu":
                weekText = "周四"
            case "Fri":
                weekText = "周五"
            case "Sat":
                weekText = "周六"
            default:
                weekText = "周日"
            }
            
            self.week.text = weekText
                
            
            self.content.text = "  " + model.content
            self.emotionValue.text = "情绪值 " + String(model.mode)

            if model.mode < 0 && model.mode > -25 {
                self.emotionValue.textColor = UIColor.init(r: 155, g: 133, b: 255)
            }
            else if model.mode < -25 {
                self.emotionValue.textColor = UIColor.init(r: 31, g: 69, b: 99)
            }
            else if model.mode > 0 && model.mode < 25 {
                 self.emotionValue.textColor = UIColor.init(r: 100, g: 175, b: 232)
            }
            else {
                self.emotionValue.textColor =  UIColor.init(r: 57, g: 210, b: 214)
            }
            
            
            var now = NowData()
            
            self.nowDatas.removeAll()
            
            if model.now.happy != 0 {
                now.type = "开心"
                now.mode = model.now.happy
                self.nowDatas.append(now)
            }
            if model.now.calm != 0 {
                now.type = "平静"
                now.mode = model.now.calm
                self.nowDatas.append(now)
            }
            if model.now.sad != 0 {
                now.type = "难过"
                now.mode = model.now.sad
                self.nowDatas.append(now)
            }
            if model.now.so_sad != 0{
                now.type = "压抑"
                now.mode = model.now.so_sad
                self.nowDatas.append(now)
            }
            
            self.emotionData.reloadData()
        }
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
        backView.addSubview(content)
        backView.addSubview(emotionValue)
        backView.addSubview(image)
        //addSubview(writeBtn)
        //addSubview(writeCollection)
        //emotionData.delegate = self
        //emotionData.dataSource = self
        
        //addSubview(emotionData)
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
        content.snp.makeConstraints{(make) in
            make.top.equalTo(dayLine.snp.bottom).offset(5.fit)
            make.left.equalTo(self).offset(38.fit)
            make.width.equalTo(180.fit)
            make.height.equalTo(100.fit)
        }
        emotionValue.snp.makeConstraints{(make) in
            make.top.equalTo(self).offset(12.fit)
            make.right.equalTo(self).offset(-35.fit)
            make.height.equalTo(30.fit)
            make.width.equalTo(90.fit)
        }
        image.snp.makeConstraints{(make) in
            make.centerY.equalTo(content.snp.centerY)
            make.centerX.equalTo(emotionValue.snp.centerX)
            make.width.equalTo(80.fit)
            make.height.equalTo(80.fit)
        }
    }
    
    func configShadow(){
        
        self.backView.backgroundColor = .white
        self.backView.layer.cornerRadius = 20.fit
        self.backView.layer.masksToBounds = false
        self.backView.layer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        self.backView.layer.shadowOffset = CGSize(width: 0, height: 4.fit)
        self.backView.layer.shadowOpacity = 1
        self.backView.layer.shadowRadius = 12.fit
    }
    
}

extension DshowDiaryCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emotionCell", for: indexPath) as! emotionCell
        cell.selectionStyle = .none
        
        let data = nums[indexPath.row]
        switch data.0 {
            case "开心":
                cell.waiView.backgroundColor = happyColor
                cell.modeData.text = "开心\(data.1)条"
            case "平静":
                cell.waiView.backgroundColor = calmColor
                cell.modeData.text = "平静\(data.1)条"
            case "难过":
                cell.waiView.backgroundColor = sadColor
                cell.modeData.text = "难过\(data.1)条"
            case "压抑":
                cell.waiView.backgroundColor = repressioneColor
                cell.modeData.text = "压抑\(data.1)条"
        default:
            break
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
