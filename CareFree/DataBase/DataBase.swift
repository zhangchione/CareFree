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
    
    var diaryTable = DiaryTable()
    var noteTable = NoteTable()
    var dayDiaryTable = DayDiaryTable()
    var nowDiaryTable = NowDiaryTable()
    init() {
        dayDiaryTable.setupTable()
        nowDiaryTable.setupTable()
        diaryTable.setupTable()
        noteTable.setupTable()
    }
}

// 日记首页查询炒作
extension DataBase {
    func queryAll() -> [CFDiaryModel]{
        var datas = [CFDiaryModel]()
        do {
            for value in Array(try DataBase.db!.prepare(dayDiaryTable.table) ) {
                let user_id = value[dayDiaryTable.user_id]
                let content = value[dayDiaryTable.content]
                let weather = value[dayDiaryTable.weather]
                let day_id = value[dayDiaryTable.day_id]
                let date = value[dayDiaryTable.date]
                let mode = value[dayDiaryTable.mode]
                let title = value[dayDiaryTable.title]
                let id = value[dayDiaryTable.id]
                let images = value[dayDiaryTable.images]
                let dayData = DayDiaryModel(id: Int(id),user_id: user_id, day_id:day_id, title: title, content: content, weather: weather, images:images, date: date, mode: Int(mode))
                var nowDatas = [NowDiaryModel]()
                var modes = mode
                do {
                    for value in Array(try DataBase.db!.prepare(nowDiaryTable.table.filter(nowDiaryTable.day_id == day_id)) ) {
                        let user_id = value[nowDiaryTable.user_id]
                        let content = value[nowDiaryTable.content]
                        let day_id = value[nowDiaryTable.day_id]
                        let weather = value[nowDiaryTable.weather]
                        let date = value[nowDiaryTable.date]
                        let mode = value[nowDiaryTable.mode]
                        let title = value[nowDiaryTable.title]
                        let id = value[nowDiaryTable.id]
                        let iamges = value[nowDiaryTable.images]
                        let nowData = NowDiaryModel(id: Int(id), user_id: user_id, day_id: day_id, title: title, content: content, weather: weather, images: iamges, date: date, mode: Int(mode))
                        nowDatas.append(nowData)
                        modes += mode
                    }
                } catch {
                    assertionFailure("\(error)")
                }
                
                let CFData = CFDiaryModel(id: Int(id), mode: (Int(modes)/(nowDatas.count+1)), user_id: user_id, day_id: day_id, dayDiary: dayData, nowDiary: nowDatas)
                datas.append(CFData)
            }
        } catch {
            assertionFailure("\(error)")
        }
        datas = datas.reversed()
        return datas
    }
    
    func queryByMouth() -> [CFAlbumMouthModel]{
        var mouthDatas = [CFAlbumMouthModel]()
        var datas = [CFDiaryModel]()
        var time = ""
        do {
            for value in Array(try DataBase.db!.prepare(dayDiaryTable.table) ) {

                let user_id = value[dayDiaryTable.user_id]
                let content = value[dayDiaryTable.content]
                let weather = value[dayDiaryTable.weather]
                let day_id = value[dayDiaryTable.day_id]
                let date = value[dayDiaryTable.date]
                let mode = value[dayDiaryTable.mode]
                let title = value[dayDiaryTable.title]
                let id = value[dayDiaryTable.id]
                let images = value[dayDiaryTable.images]
                let dayData = DayDiaryModel(id: Int(id),user_id: user_id, day_id:day_id, title: title, content: content, weather: weather, images:images, date: date, mode: Int(mode))
                if time == "" {
                    time = String(day_id.prefix(6))
                }
                var nowDatas = [NowDiaryModel]()
                var modes = mode
                do {
                    for value in Array(try DataBase.db!.prepare(nowDiaryTable.table.filter(nowDiaryTable.day_id == day_id)) ) {
                        let user_id = value[nowDiaryTable.user_id]
                        let content = value[nowDiaryTable.content]
                        let day_id = value[nowDiaryTable.day_id]
                        let weather = value[nowDiaryTable.weather]
                        let date = value[nowDiaryTable.date]
                        let mode = value[nowDiaryTable.mode]
                        let title = value[nowDiaryTable.title]
                        let id = value[nowDiaryTable.id]
                        let iamges = value[nowDiaryTable.images]
                        let nowData = NowDiaryModel(id: Int(id), user_id: user_id, day_id: day_id, title: title, content: content, weather: weather, images: iamges, date: date, mode: Int(mode))
                        nowDatas.append(nowData)
                        modes += mode
                    }
                } catch {
                    assertionFailure("\(error)")
                }

                let CFData = CFDiaryModel(id: Int(id), mode: (Int(modes)/(nowDatas.count+1)), user_id: user_id, day_id: day_id, dayDiary: dayData, nowDiary: nowDatas)
                datas.append(CFData)
                
                if  time != String(day_id.prefix(6)) {
                       time = String(day_id.prefix(6))
                        let mouthdata = CFAlbumMouthModel(time: time.prefix(4) + "年" + time.suffix(2) + "月", data: datas)
                        mouthDatas.append(mouthdata)
                        datas.removeAll()
                }
            }
        } catch {
            assertionFailure("\(error)")
        }
        let mouthdata = CFAlbumMouthModel(time: time.prefix(4) + "年" + time.suffix(2) + "月", data: datas)
        mouthDatas.append(mouthdata)
        datas.removeAll()
        mouthDatas = mouthDatas.reversed()
        var resultData = [CFAlbumMouthModel]()
        for (index,data) in mouthDatas.enumerated() {
            if data.data.count == 0 {
                
            }else {
                var count = 0
                var imgdatas = AlbumModel()
                for da in data.data {

                    let imgs = da.dayDiary.images.components(separatedBy: ",")
                    if da.dayDiary.mode > 25 {
                        imgdatas.happyPhoto += imgs
                    }else if da.dayDiary.mode <= 25 && da.dayDiary.mode > 0 {
                        imgdatas.calmPhoto += imgs
                    }else if da.dayDiary.mode <= 0 && da.dayDiary.mode > -25 {
                        imgdatas.sadPhoto += imgs
                    }else{
                        imgdatas.repressionePhoto += imgs
                    }
                    for das in da.nowDiary {
                        let imgs = das.images.components(separatedBy: ",")
                        if das.mode > 25 {
                            imgdatas.happyPhoto += imgs
                        }else if das.mode <= 25 && das.mode > 0 {
                            imgdatas.calmPhoto += imgs
                        }else if das.mode <= 0 && das.mode > -25 {
                            imgdatas.sadPhoto += imgs
                        }else{
                            imgdatas.repressionePhoto += imgs
                        }
                    }
                }
                if imgdatas.happyPhoto.count != 0 {
                    let da = AlbumCellModel(photos: imgdatas.happyPhoto,type:.happy)
                    imgdatas.data.append(da)
                }
                if imgdatas.calmPhoto.count != 0 {
                    let da = AlbumCellModel(photos: imgdatas.calmPhoto,type:.calm)
                    imgdatas.data.append(da)
                }
                if imgdatas.sadPhoto.count != 0 {
                    let da = AlbumCellModel(photos: imgdatas.sadPhoto,type:.sad)
                    imgdatas.data.append(da)
                }
                if imgdatas.repressionePhoto.count != 0 {
                    let da = AlbumCellModel(photos: imgdatas.repressionePhoto,type:.repressione)
                    imgdatas.data.append(da)
                }
                resultData.insert(data, at: resultData.count)
                resultData[resultData.count-1].celldata = imgdatas.data
            }
        }
        

        return resultData
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
                dayDiaryTable.day_id <- data.day_id,
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
            print("删除成功哦")
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
                let day_id = value[dayDiaryTable.day_id]
                let date = value[dayDiaryTable.date]
                let mode = value[dayDiaryTable.mode]
                let title = value[dayDiaryTable.title]
                let id = value[dayDiaryTable.id]
                let images = value[dayDiaryTable.images]
                let data = DayDiaryModel(id: Int(id),user_id: user_id, day_id:day_id, title: title, content: content, weather: weather, images:images, date: date, mode: Int(mode))
                datas.append(data)
            }
        } catch {
            assertionFailure("\(error)")
        }
        datas = datas.reversed()
        return datas
    }
    // 查今日有无写日记
    func queryDayDiaryByDayId(day_id:String) -> Bool {
        var Empty = false
        do {
            let query = dayDiaryTable.table.filter(dayDiaryTable.day_id == day_id)
            for data in (try (DataBase.db?.prepare(query.select(dayDiaryTable.day_id)))!) {
                print(data)
                Empty = true
            }
        }catch{
            assertionFailure()
        }
        return Empty
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
    func queryNowDiaryByDayId(day_id:String) -> [NowDiaryModel] {
        var datas = [NowDiaryModel]()
        do {
            for value in Array(try DataBase.db!.prepare(nowDiaryTable.table.filter(nowDiaryTable.day_id == day_id)) ) {
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
            print("查询到的now数据data:",datas)
        } catch {
            assertionFailure("\(error)")
        }
        datas = datas.reversed()
        return datas
    }
    
}
