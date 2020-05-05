//
//  DataBase+Diary.swift
//  CareFree
//
//  Created by 张驰 on 2020/4/30.
//  Copyright © 2020 张驰. All rights reserved.
//

import Foundation
import SQLite

/**
 Diary - 日记操作
 */

// MARK: 查
extension DataBase {
    /** 查询所有 */
    func queryDiaryAll(isTrash trashStatus:Bool) -> [DiaryModel] {
        var data = [DiaryModel]()
        do {
            for value in Array(try  DataBase.db!.prepare(diaryTable.table)) {
                let isTrash = value[diaryTable.isTrash]
                guard trashStatus == isTrash else {
                    continue
                }
                let id = value[diaryTable.id]
                let content = value[diaryTable.content]
                let weather = value[diaryTable.weather]
                let dateStr = value[diaryTable.dateStr]
                let date = value[diaryTable.date]
                let mood = value[diaryTable.mood]
                let title = value[diaryTable.title]
                let images = value[diaryTable.images]
                let locate = value[diaryTable.locate]
                data.append(DiaryModel(id: Int(id), date: date, dateStr: dateStr, title: title, content: content, images: images, mood: Int(mood), locate: locate, weather: weather))

            }
        } catch {
            assertionFailure("\(error)")
        }
        data = data.reversed()
        return data
    }
    /** 按日期字符串查询*/
    
    func queryDiary(by dateStr:String) -> [DiaryModel] {
        var datas = [DiaryModel]()
        let data = queryDiaryAll(isTrash: false)
        data.forEach { (item) in
            guard item.dateStr == dateStr else {
                return
            }
            datas.append(item)
        }
        
        return datas
    }
    
    /** 按日期查询*/
    func queryDiary(by date:Date) -> [DiaryModel] {
        var data = [DiaryModel]()
        do {
            let query = diaryTable.table.filter(diaryTable.date == date)
            for value in Array(try DataBase.db!.prepare(query.select(diaryTable.date))) {
                let isTrash = value[diaryTable.isTrash]
                guard  !isTrash else {
                    continue
                }
                let id = value[diaryTable.id]
                let content = value[diaryTable.content]
                let weather = value[diaryTable.weather]
                let date = value[diaryTable.date]
                let mood = value[diaryTable.mood]
                let title = value[diaryTable.title]
                let images = value[diaryTable.images]
                let locate = value[diaryTable.locate]

                data.append(DiaryModel(id: Int(id), dateStr: "dateStr", title: title, content: content, images: images, mood: Int(mood), locate: locate, weather: weather))
            }
        } catch  {
            assertionFailure("\(error)")
        }
        return data
    }
    /** TODO: 关键字搜索*/
    func queryDiary(By key:String) -> [DiaryModel] {
        let data = [DiaryModel]()
//        let datas = queryDiaryAll(isTrash: false)
//        for value in datas {
//
//        }
        return data
    }
}
// MARK: 其他操作
extension DataBase {
    // MARK: 增
    func insertDiary(with data:DiaryModel) -> Int64? {
        do {
            let insertData = diaryTable.table.insert(
                diaryTable.date <- data.date,
                diaryTable.dateStr <- data.dateStr,
                diaryTable.content <- data.content,
                diaryTable.mood <- Int64(data.mood),
                diaryTable.weather <- data.weather,
                diaryTable.images <- data.images,
                diaryTable.title <- data.title,
                diaryTable.locate <- data.locate,
                diaryTable.isTrash <- false)
            return try DataBase.db?.run(insertData)
        }catch {
            assertionFailure()
        }
        return nil
    }
    
    // MARK: 彻底删
    func deleteDiary(with id:Int) -> Bool {
        do {
            try DataBase.db?.run(diaryTable.table.filter(diaryTable.id == Int64(id)).delete())
            return true
        }catch{
            assertionFailure()
        }
        return false
    }
    
    // MARK: 移到或移出废纸篓
    func changeDiaryInTrashStatus(at id:Int,with status:Bool) -> Bool {
        do {
            let update = diaryTable.table.filter(diaryTable.id == Int64(id))
            try DataBase.db?.run(update.update(
                diaryTable.isTrash <- status)
            )
            return true
        }catch{
            assertionFailure()
        }
        return false
    }

    // MARK: 改
    func updateStrDiary(with data:DiaryModel) -> Bool {
        do {
            let update = diaryTable.table.filter(diaryTable.id == Int64(data.id))
            try DataBase.db?.run(update.update(
                diaryTable.date <- data.date,
                diaryTable.dateStr <- data.dateStr,
                diaryTable.content <- data.content,
                diaryTable.mood <- Int64(data.mood),
                diaryTable.weather <- data.weather,
                diaryTable.images <- data.images,
                diaryTable.title <- data.title,
                diaryTable.locate <- data.locate,
                diaryTable.isTrash <- false)
            )
            return true
        }catch{
            assertionFailure()
        }
        return false
    }
}
