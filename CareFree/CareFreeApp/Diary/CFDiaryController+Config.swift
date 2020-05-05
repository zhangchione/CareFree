//
//  CFDiaryController+delegate.swift
//  CareFree
//
//  Created by 张驰 on 2019/11/30.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation
import UIKit
import Fuse
import FSCalendar




// MARK: 搜索
extension CFDiaryController {
    func filterContentForSearchText(_ searchText: String) {
        self.books.removeAll()
        self.searchDiaryDatas.removeAll()
        
        self.viewModel.data.forEach { (item) in
            self.books.append(item.content)
        }
        
        let results = fuse.search(searchText, in: books)

        results.forEach { item in
            self.searchDiaryDatas.append(self.viewModel.data[item.index])
            
        }
        self.viewModel.data = self.searchDiaryDatas
        self.collectionView.reloadData()
        
    }
}

//MARK: 日历
extension CFDiaryController:FSCalendarDataSource, FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        let dateStr = formatter.string(from: date)
        self.viewModel.getDateDiaryData(with: dateStr) { (value) in
                self.viewModel.data = value
                self.collectionView.reloadData()
        }
        print(date)
    }
    
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            calendar.snp.updateConstraints { (make) in
                make.top.equalTo(self.navigation.bar.snp.top).offset(bounds.origin.y)
                //make.height.equalTo(bounds.height)
                // Do other updates
            }
        }

        self.view.layoutIfNeeded()
    }
}
