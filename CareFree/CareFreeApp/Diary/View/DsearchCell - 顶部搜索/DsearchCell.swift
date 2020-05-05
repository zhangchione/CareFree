//
//  DsearchCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/20.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit


class CFSearchBar:UISearchBar {
    override func layoutSubviews() {
        
    }
}


class DsearchCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        configShadow()
    }
    
    func configUI(){
        let searchBar = UISearchBar()
        
        searchBar.frame = CGRect(x: 10, y: 5, width: 354, height: 50)
        searchBar.backgroundColor = .white
        searchBar.placeholder = "搜索"
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        addSubview(searchBar)
    }
    
    func configShadow(){
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        //self.layer.borderWidth = 1.0
        //self.layer.borderColor = UIColor.clear.cgColor
        
        self.layer.shadowColor = UIColor.init(red: 110, green: 127, blue: 255, alpha: 0).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.6
        self.layer.masksToBounds = false
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
