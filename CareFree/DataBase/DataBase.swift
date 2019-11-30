//
//  DataBase.swift
//  LifeMemory
//
//  Created by 张驰 on 2019/11/10.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation
import SQLite


struct DataCenterConstant {
    static let dbName = "db.sqlite"
    static let dbFilePath = NSHomeDirectory() + "/Documents/" + DataCenterConstant.dbName
}

class DataBase {
    static let shared = DataBase()
    static var db: Connection? = {
        do {
            return try Connection(DataCenterConstant.dbFilePath)
        } catch {
            assertionFailure("Create DB Fail")
            debugPrint(error)
        }
        return nil
    }()
    
    var dayDiaryTable = DayDiaryTable()
    var nowDiaryTable = NowDiaryTable()
    init() {
        dayDiaryTable.setupTable()
        nowDiaryTable.setupTable()
    }
}
// DayDiaryTable 操作
extension DataBase {
    // 增
    func insertDayDiary(with data:DayDiaryModel) -> Int64? {
        do {
            let insertNotes = dayDiaryTable.table.insert(
                dayDiaryTable.user_id <- data.user_id,
                dayDiaryTable.date <- data.date,
                dayDiaryTable.content <- data.content,
                dayDiaryTable.mode <- Int64(data.mode),
                dayDiaryTable.weather <- data.weather,
                dayDiaryTable.images <- data.images,
                dayDiaryTable.title <- data.title)
            return try DataBase.db?.run(insertNotes)
        }catch {
            assertionFailure()
        }
        return nil
    }
    // 删
    func deleteDayDiaryById(id:Int) -> Bool {
        do {
            try DataBase.db?.run(dayDiaryTable.table.filter(dayDiaryTable.id == Int64(id)).delete())
            return true
        }catch{
            assertionFailure()
        }
        return false
    }
    // 改
    func updateDayDiaryById(id:Int,content:String,images:String) -> Bool {
        do {
            let update = dayDiaryTable.table.filter(dayDiaryTable.id == Int64(id))
            try DataBase.db?.run(update.update(
                dayDiaryTable.content <- content,
                dayDiaryTable.images <- images)
            )
            return true
        }catch{
            assertionFailure()
        }
        return false
    }
    //查
    func queryDayDiaryAll() -> [DayDiaryModel] {
        var datas = [DayDiaryModel]()
        do {
            for value in Array(try DataBase.db!.prepare(dayDiaryTable.table) ) {
                let user_id = value[dayDiaryTable.user_id]
                let content = value[dayDiaryTable.content]
                let weather = value[dayDiaryTable.weather]
                let date = value[dayDiaryTable.date]
                let mode = value[dayDiaryTable.mode]
                let title = value[dayDiaryTable.title]
                let id = value[dayDiaryTable.id]
                let images = value[dayDiaryTable.images]
                let data = DayDiaryModel(id: Int(id),user_id: user_id, title: title, content: content, weather: weather, images:images, date: date, mode: Int(mode))
                datas.append(data)
            }
        } catch {
            assertionFailure("\(error)")
        }
        datas = datas.reversed()
        return datas
    }
}
// NowDiaryTable 操作
extension DataBase {
    // 增
    func insertNowDiary(with data:NowDiaryModel) -> Int64? {
        do {
            let insertNotes = nowDiaryTable.table.insert(
                nowDiaryTable.user_id <- data.user_id,
                nowDiaryTable.date <- data.date,
                nowDiaryTable.day_id <- data.day_id,
                nowDiaryTable.content <- data.content,
                nowDiaryTable.mode <- Int64(data.mode),
                nowDiaryTable.weather <- data.weather,
                nowDiaryTable.images <- data.images,
                nowDiaryTable.title <- data.title)
            return try DataBase.db?.run(insertNotes)
        }catch {
            assertionFailure()
        }
        return nil
    }
    // 删
    func deleteNowDiaryById(id:Int) -> Bool {
        do {
            try DataBase.db?.run(nowDiaryTable.table.filter(nowDiaryTable.id == Int64(id)).delete())
            return true
        }catch{
            assertionFailure()
        }
        return false
    }
    // 改
    func updateNowDiaryById(id:Int,content:String,images:String) -> Bool {
        do {
            let update = nowDiaryTable.table.filter(nowDiaryTable.id == Int64(id))
            try DataBase.db?.run(update.update(
                nowDiaryTable.content <- content,
                nowDiaryTable.images <- images)
            )
            return true
        }catch{
            assertionFailure()
        }
        return false
    }
    //查
    func queryNowDiaryByDayId() -> [NowDiaryModel] {
        var datas = [NowDiaryModel]()
        do {
            for value in Array(try DataBase.db!.prepare(nowDiaryTable.table) ) {
                let user_id = value[nowDiaryTable.user_id]
                let content = value[nowDiaryTable.content]
                let day_id = value[nowDiaryTable.day_id]
                let weather = value[nowDiaryTable.weather]
                let date = value[nowDiaryTable.date]
                let mode = value[nowDiaryTable.mode]
                let title = value[nowDiaryTable.title]
                let id = value[nowDiaryTable.id]
                let iamges = value[nowDiaryTable.images]
                let data = NowDiaryModel(id: Int(id), user_id: user_id, day_id: day_id, title: title, content: content, weather: weather, images: iamges, date: date, mode: Int(mode))
                datas.append(data)
            }
        } catch {
            assertionFailure("\(error)")
        }
        datas = datas.reversed()
        return datas
    }
    
}
