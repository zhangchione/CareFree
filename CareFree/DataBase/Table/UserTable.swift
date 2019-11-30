//
//  User.swift
//  CareFree
//
//  Created by 张驰 on 2019/11/30.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation
import SQLite

class UserTable {
    let table = Table("UserTable")
    let id = Expression<Int64>("id")
    let classify = Expression<String>("classify")
    let title = Expression<String>("title")
    let weather = Expression<String>("weather")
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
            tbl.column(classify)
            tbl.column(title)
            tbl.column(weather)
            tbl.column(content)
            tbl.column(date)
            tbl.column(mode)
        }
    }
}
