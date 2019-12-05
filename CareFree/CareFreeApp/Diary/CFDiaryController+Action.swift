//
//  CFDiaryController+Action.swift
//  CareFree
//
//  Created by 张驰 on 2019/11/30.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation

// MARK: method 以及自定义代理方法
extension CFDiaryController:diaryWriteDelegate {
    func diaryWriteClick(mood: Int) {
        var notesVC:NotesViewController?
        switch mood {
        case 0:
            notesVC = NotesViewController(type:.Happy)
        case 1:
            notesVC = NotesViewController(type:.Calm)
        case 2:
            notesVC = NotesViewController(type:.Sad)
        case 3:
            notesVC = NotesViewController(type:.Repression)
        default:
            break;
        }
        self.navigationController?.pushViewController(notesVC!, animated: true)
    }
    
    
    
    // 日历按钮方法
    @objc func calendar(){
        print("右边日历选择按钮")
    }
    
    
    // 写日记
    @objc func write(){
        
        let notesVC = NotesViewController(type: .Day)
        self.navigationController?.pushViewController(notesVC, animated: true)
    }
    
}
