//
//  AlbumModel.swift
//  CareFree
//
//  Created by 张驰 on 2020/2/1.
//  Copyright © 2020 张驰. All rights reserved.
//

import Foundation

enum Type {
    case happy
    case calm
    case sad
    case repressione
}

struct AlbumModel {
    var num = 0
    var date = ""
    var data = [AlbumCellModel]()
    var happyPhoto = [String]()
    var calmPhoto = [String]()
    var sadPhoto = [String]()
    var repressionePhoto = [String]()
}

struct AlbumCellModel {
    var photos = [String]()
    var type:Type?
}
