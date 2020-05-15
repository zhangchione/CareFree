//
//  NotesModel.swift
//  LifeMemory
//
//  Created by 张驰 on 2019/11/10.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation
import UIKit

struct NotesModel {
    var id = 0
    var title = ""
    var content = ""
    var weather = ""
    var classify = ""
    var date = Date()
    var mode = 0
}

struct ContentModel {
    var id = 0
    var text = ""
    var localIdentifier = ""
}
