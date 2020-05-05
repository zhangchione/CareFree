//
//  NoteTable.swift
//  CareFree
//
//  Created by 张驰 on 2020/4/30.
//  Copyright © 2020 张驰. All rights reserved.
//

import Foundation
import SQLite

class NoteTable {
    let table = Table("NoteTable")
    
    let id = Expression<Int64>("id")
    let date = Expression<Date>("date")
    let title = Expression<String?>("title")
    let content = Expression<String?>("content")
    let images = Expression<String?>("images")
    let mood = Expression<Int64>("mood")
    let weather = Expression<String?>("weather")
    
    let priority = Expression<Int64>("priority")
    let isTrash = Expression<Bool>("isTrash")
    
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
            tbl.column(date)
            tbl.column(title)
            tbl.column(content)
            tbl.column(images)
            tbl.column(mood)
            tbl.column(weather)
            
            tbl.column(priority)
            tbl.column(isTrash)
        }
    }
    
}
