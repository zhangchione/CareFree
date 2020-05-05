//
//  CFDiaryController+Action.swift
//  CareFree
//
//  Created by 张驰 on 2019/11/30.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation
import ProgressHUD

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
        //self.navigationController?.pushViewController(notesVC!, animated: true)
    }
    
    
    
    // 日历按钮方法
    @objc func calendarMethod(){


        if isCalendarViewShow {
            UIView.animate(withDuration: 0.5) {
                self.calendarView.snp.updateConstraints { (make) in
                    make.top.equalTo(self.view.snp.top).offset(-280.fit)
                }
            }
            configData()
            

        }else {
            UIView.animate(withDuration: 0.5) {
                self.calendarView.snp.updateConstraints { (make) in
                    print(self.navigation.bar.snp.top)
                    make.top.equalTo(self.view.snp.top).offset(kNavBarAndStatusBarHeight)
                }
            }
        }
        
        isCalendarViewShow = !isCalendarViewShow
    }
    
    func updateCalendar(isShow:Bool) {
        if isShow {
            calendar(self.calendarView, boundingRectWillChange: CGRect(x: 0, y: 0, width: 0, height: 300.fit), animated: true)

        }else {
            calendar(self.calendarView, boundingRectWillChange: CGRect(x: 0, y: 0, width: 0, height: 0.fit), animated: true)
        }
    }
    
    // 写日记
    @objc func write(){
        let now = Date()
        let timeForMatter = DateFormatter()
        timeForMatter.dateFormat = "yyyyMMdd"
        let day_id = timeForMatter.string(from: now)
        
        if DataBase.shared.queryDayDiaryByDayId(day_id:day_id ) {
            
            print("今日已经有日记")
            ProgressHUD.showSuccess("今日已描述~")
        }else {
           let notesVC = WriteViewController()
           self.navigationController?.pushViewController(notesVC, animated: true)
        }
    }
    
    //MARK: 当键盘显示时
    @objc func handleKeyboardDisShow(notification: NSNotification) {
        let keyboardAnimationDur = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
        let animationDur = keyboardAnimationDur?.floatValue ?? 0.0
        //得到键盘frame
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let value = userInfo.object(forKey: UIResponder.keyboardFrameEndUserInfoKey)
        let keyboardRec = (value as AnyObject).cgRectValue

        let height = keyboardRec?.size.height

        //让textView bottom位置在键盘顶部
        UIView.animate(withDuration: TimeInterval(animationDur), animations: {
            self.tapBackView.isHidden = false
        })
    }
    
    @objc func closeKey(){
        self.tapBackView.isHidden = true
        self.view.endEditing(false)
    }
    
    
}
