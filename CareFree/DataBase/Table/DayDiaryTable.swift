//
//  NotesTable.swift
//  LifeMemory
//
//  Created by 张驰 on 2019/11/10.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation
import SQLite

class DayDiaryTable {
    let table = Table("DayDiaryTable")
    
    let id = Expression<Int64>("id")
    let user_id = Expression<String>("user_id")
    let day_id = Expression<String>("day_id")
    let title = Expression<String>("title")
    let weather = Expression<String>("weather")
    let images = Expression<String>("images")
    let content = Expression<String>("content")
    let date = Expression<Date>("date")
    let mode = Expression<Int64>("mode")

    func setupTable() {
        do {
            guard let cmd = createTableCMD() else { return }
            try DataBase.db?.run(cmd)
        } catch {
            print(error)
            
        }
    }

    func createTableCMD() -> String? {
        return table.create(ifNotExists: true) { tbl in
            tbl.column(id, primaryKey: true)
            tbl.column(user_id)
            tbl.column(day_id)
            tbl.column(title)
            tbl.column(weather)
            tbl.column(images)
            tbl.column(content)
            tbl.column(date)
            tbl.column(mode)
        }
    }
}
