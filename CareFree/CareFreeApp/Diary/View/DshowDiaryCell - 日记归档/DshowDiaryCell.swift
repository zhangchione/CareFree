//
//  DwitreDiaryCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/20.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit


class DshowDiaryCell: UICollectionViewCell {
    
    var diaryContents = [diaryModel]()
    var nowData = [NowDiaryModel]()
    var nums = [(String,Int)]()
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
    
    lazy var content: UILabel = {
        let label = UILabel()
        label.text = "今天考试，准备了很久，希望能够得到好成绩"
        label.font = UIFont(name: "PingFangSC-Regular", size: 15)
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
        label.font = UIFont(name: "PingFangSC-Medium", size: 13)
        //label.backgroundColor = UIColor.red
        return label
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
        configUI()
        configShadow()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(with datas:CFDiaryModel)
    {
        let data = datas.dayDiary
        
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
        print("day_id",data.day_id)
        nowData = datas.nowDiary //DataBase.shared.queryNowDiaryByDayId(day_id: data.day_id)
        var moodValue = data.mode
        var num = [0,0,0,0]
        for nowdata in nowData {
            switch nowdata.mode {
            case 26 ... 50:
                num[0] += 1
            case 0 ... 25:
                num[1] += 1
            case -25 ... -1:
                num[2] += 1
            case -50 ... -26:
                num[3] += 1
            default:
                break
            }
            moodValue += nowdata.mode
        }
        nums.removeAll()
        if num[0] != 0 { nums.append(("开心",num[0])) }
        if num[1] != 0 { nums.append(("平静",num[1])) }
        if num[2] != 0 { nums.append(("难过",num[2])) }
        if num[3] != 0 { nums.append(("压抑",num[3])) }
        emotionValue.text = "情绪值 \(moodValue/(nowData.count + 1))"
        print("nowdata",nowData.count)
        emotionData.reloadData()
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
        addSubview(day)
        addSubview(week)
        addSubview(yearMouth)
        addSubview(dayLine)
        addSubview(content)
        addSubview(emotionValue)
        //addSubview(writeBtn)
        //addSubview(writeCollection)
        emotionData.delegate = self
        emotionData.dataSource = self
        
        addSubview(emotionData)
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
        content.snp.makeConstraints{(make) in
            make.top.equalTo(dayLine.snp.bottom).offset(5)
            make.left.equalTo(self).offset(18)
            make.width.equalTo(180)
            make.height.equalTo(100)
        }
        emotionValue.snp.makeConstraints{(make) in
            make.top.equalTo(self).offset(12)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(30)
            make.width.equalTo(90)
        }
        emotionData.snp.makeConstraints{(make) in
            make.top.equalTo(emotionValue.snp.bottom).offset(3)
            make.right.equalTo(self).offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(120)
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
