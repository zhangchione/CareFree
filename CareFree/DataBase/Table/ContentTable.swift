//
//  ContentTable.swift
//  LifeMemory
//
//  Created by 张驰 on 2019/11/29.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation
import SQLite

class ContentTable {
    let table = Table("ContentTable")
    let id = Expression<Int64>("id")
    let localIdentifier = Expression<String>("localIdentifier")
    let text = Expression<String>("text")
    
//    let classify = Expression<String>("classify")
//    let title = Expression<String>("title")
//    let content = Expression<String>("content")
//    let weather = Expression<String>("weather")
//    let date = Expression<Date>("date")
//    let mode = Expression<Int64>("mode")

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
            tbl.column(localIdentifier)
            tbl.column(text)
        }
    }

}
