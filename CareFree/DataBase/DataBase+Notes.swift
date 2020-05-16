//
//  DataBase+Notes.swift
//  CareFree
//
//  Created by 张驰 on 2020/5/16.
//  Copyright © 2020 张驰. All rights reserved.
//

import Foundation
import SQLite


struct CFNotesModel1 {
    var id = -1
    var date = Date()
    var dateStr = ""
    var title = ""
    var content = ""
    
    var images = ""
    
    var priority = -1
    var restDay = 0
    var startDate = Date()
    
    
    var clockTime = Date()
    var clockContent = ""
    var isTrash = false
}

extension DataBase {
    /** 查询所有 */
    func queryNoteAll(isTrash trashStatus:Bool) -> [CFNotesModel] {
        var data = [CFNotesModel]()
        do {
            for value in Array(try  DataBase.db!.prepare(noteTable.table)) {
                let isTrash = value[noteTable.isTrash]
                guard trashStatus == isTrash else {
                    continue
                }
                let id = value[noteTable.id]
                let date = value[noteTable.date]
                let dateStr = value[noteTable.dateStr]
                let title = value[noteTable.title]
                let content = value[noteTable.content]
                let images = value[noteTable.images]
                let priority = value[noteTable.priority]
                let restDay = value[noteTable.restDay]
                let startDate = value[noteTable.startDate]
                let clockTime = value[noteTable.clockTime]
                let clockContent = value[noteTable.clockContent]
                data.append(CFNotesModel(id: Int(id), date: date, dateStr: dateStr, title: title, content: content, images: images, priority: Int(priority), restDay: Int(restDay), startDate: startDate, clockTime: clockTime, clockContent: clockContent, isTrash: isTrash))
            }
        } catch {
            assertionFailure("\(error)")
        }
        data = data.reversed()
        return data
    }
    /** 按等级查询查询 --- Mark  0 1 2 3 等级*/
    func queryNote(by priority:Int) -> [CFNotesModel] {
        var datas = [CFNotesModel]()
        let data = queryNoteAll(isTrash: false)
        data.forEach { (item) in
            if item.priority == priority {
                datas.append(item)
            }
        }
        return datas
    }
    /** 按等级查询查询 --- Mark  0 1 2 3 等级*/
    func queryNote(unCount priority:[Int]) -> [CFNotesModel] {
        var datas = [CFNotesModel]()
        let data = queryNoteAll(isTrash: false)
        
        data.forEach { (item) in
            var flag = true // 添加标志
            for value in priority {
                if item.priority == value {
                    flag = false
                    break;
                }
            }
            if flag {
                datas.append(item)
            }
        }
        return datas
    }
}


// MARK: 其他操作
extension DataBase {
    // MARK: 增
    func insertNote(with data:CFNotesModel) -> Int64? {
        do {
            let insertData = noteTable.table.insert(
                noteTable.date <- data.date,
                noteTable.dateStr <- data.dateStr,
                noteTable.title <- data.title,
                noteTable.content <- data.content,
                noteTable.images <- data.images,
                noteTable.priority <- Int64(data.priority),
                noteTable.restDay <- Int64(data.restDay),
                noteTable.startDate <- data.startDate,
                noteTable.clockTime <- data.clockTime,
                noteTable.clockContent <- data.clockContent,
                noteTable.isTrash <- false )
            return try DataBase.db?.run(insertData)
        }catch {
            assertionFailure()
        }
        return nil
    }
    // MARK: 彻底删
    func deleteNote(with id:Int) -> Bool {
        do {
            try DataBase.db?.run(noteTable.table.filter(noteTable.id == Int64(id)).delete())
            return true
        }catch{
            assertionFailure()
        }
        return false
    }
    
    // MARK: 移到或移出废纸篓
    func changeNoteInTrashStatus(at id:Int,with status:Bool) -> Bool {
        do {
            let update = noteTable.table.filter(noteTable.id == Int64(id))
            try DataBase.db?.run(update.update(
                noteTable.isTrash <- status)
            )
            return true
        }catch{
            assertionFailure()
        }
        return false
    }
    
    // MARK: 改
    func updateStrNote(with data:CFNotesModel) -> Bool {
        do {
            let update = noteTable.table.filter(noteTable.id == Int64(data.id))
            try DataBase.db?.run(update.update(
                noteTable.date <- data.date,
                noteTable.dateStr <- data.dateStr,
                noteTable.title <- data.title,
                noteTable.content <- data.content,
                noteTable.images <- data.images,
                noteTable.priority <- Int64(data.priority),
                noteTable.restDay <- Int64(data.restDay),
                noteTable.startDate <- data.startDate,
                noteTable.clockTime <- data.clockTime,
                noteTable.clockContent <- data.clockContent,
                noteTable.isTrash <- false )
            )
            return true
        }catch{
            assertionFailure()
        }
        return false
    }
    

}

