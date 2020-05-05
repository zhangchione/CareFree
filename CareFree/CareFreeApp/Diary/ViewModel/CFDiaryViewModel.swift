//
//  CFDiaryViewModel.swift
//  CareFree
//
//  Created by 张驰 on 2019/12/5.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation
import UIKit

class CFDiaryViewModel:NSObject {
    var datas = [CFDiaryModel]()
    var data = [DiaryModel]()
    
}

// MARK: 数据

extension CFDiaryViewModel{
    
    func getLocalDiaryData(callback: @escaping ([DiaryModel]) -> ()){
        let data = DataBase.shared.queryDiaryAll(isTrash: false)
        callback(data)
    }
    
    func getSearchData(with keyWord:String,callback: @escaping ([DiaryModel]) -> ()) {
        
    }
    
    func getDateDiaryData(with dateStr:String,callback: @escaping ([DiaryModel]) -> () ){
        let data = DataBase.shared.queryDiary(by: dateStr)
        callback(data)
    }
}
