//
//  MoodInfo.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/15.
//  Copyright © 2020 张驰. All rights reserved.
//

import Foundation

/** 日期信息 */

class DateInfo {
    static let shared = DateInfo()
    
    var year = 0
    var mouth = 0
    var day = 0
    var week = 0
    var todayText = ""
    var nowText = ""
    
    var sevenDays = [String]()
    
    var sevenNums = [String]()
    init() {
        let now = Date()
        year = now.year()
        mouth = now.month()
        day = now.day()
        week = now.weekDay()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        todayText = formatter.string(from: now)
        
        
        sevenDays = getSevenDays()
        sevenNums = getSevenNums()
    }
    
    private func getSevenDays() -> [String] {
        let now = Date()
        var changeDate : Date?
        
        var result = [String]()
        for  i in -7 ... -1 {
            changeDate =  now.getDate(now, day: i)
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy年MM月dd日"
            if let date = changeDate {
                result.append(formatter.string(from: date))
            }
        }
        return result
    }
    
    private func getSevenNums() -> [String] {
        let now = Date()
        var changeDate : Date?
        
        var result = [String]()
        for  i in -7 ... -1 {
            changeDate =  now.getDate(now, day: i)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd"
            if let date = changeDate {
                result.append(formatter.string(from: date))
            }
        }
        return result
    }
}

/** 日记  */

class DiaryAndNoteInfo {
    static let shared = DiaryAndNoteInfo()
    
    /// 今天情绪值 默认为0
    var todayMoodValue = 0
    
    /// 七天情绪值
    var sevenMoodValue = [Int]()
    
    /// 总值与记录天数 默认为 0
    var totalValue = [(moodTotal:0,daysTotal:0)]
    
    /// 日记数量
    var diaryTotal = 0
    
    /// 便贴数量
    var notesTotal = 0
    
    /// 废纸数量 (日记+便贴)
    var trashTotal = 0
    
    
    
    init() {
        todayMoodValue = getTodayMoodValue()
        sevenMoodValue = getSevenMoodValue()
        diaryTotal = getDiaryTotal()
    }
    
    /// 今日情绪值
    private func getTodayMoodValue() -> Int{
        let datas = DataBase.shared.queryDiary(by: DateInfo.shared.todayText)
        var result = 0
        datas.forEach { (data) in
            result += data.mood
        }
        guard datas.count != 0 else {
            return 0
        }
        return result/(datas.count)
    }
    
    private func getSevenMoodValue() -> [Int] {
        
        var results = [Int]()
        
        let dates = DateInfo.shared.sevenDays
        dates.forEach { (date) in
            var result = 0
            let datas = DataBase.shared.queryDiary(by: date)
            datas.forEach { (data) in
                result += data.mood
            }
            if datas.count == 0 {
                results.append(0)
            }else {
                results.append(result/datas.count)
            }
        }
        return results
    }
    
    private func getDiaryTotal() -> Int {
        let datas = DataBase.shared.queryDiaryAll(isTrash: false)
        return datas.count
    }
    
}


func getTodayMoodValue() -> Int{
    let datas = DataBase.shared.queryDiary(by: DateInfo.shared.todayText)
    var result = 0
    datas.forEach { (data) in
        result += data.mood
    }
    guard datas.count != 0 else {
        return 0
    }
    return result/(datas.count)
}

func getSevenMoodValue() -> [Int] {
    
    var results = [Int]()
    
    let dates = DateInfo.shared.sevenDays
    dates.forEach { (date) in
        var result = 0
        let datas = DataBase.shared.queryDiary(by: date)
        datas.forEach { (data) in
            result += data.mood
        }
        if datas.count == 0 {
            results.append(0)
        }else {
            results.append(result/datas.count)
        }
    }
    return results
}

func getDiaryTotal() -> Int {
    let datas = DataBase.shared.queryDiaryAll(isTrash: false)
    return datas.count
}
func getNotesTotal() -> Int {
    /// todo:
    return 0
}

func getTrashTotal() -> Int {
    /// TODO
     return 0
}
