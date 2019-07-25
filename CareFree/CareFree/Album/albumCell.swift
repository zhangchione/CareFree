//
//  albumCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/8.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class albumCell: UIView {

    lazy var time: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28)
        label.textColor = .black
        label.text = "2019年7月"
        return label
    }()
    
    lazy var photoData : UITableView = {
        let tableView = UITableView()
        // tableView.backgroundColor = UIColor.red
        tableView.register(UINib(nibName: "albumTwoCell", bundle: nil), forCellReuseIdentifier: "albumTwoCell")
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configUI(){
        addSubview(time)
        addSubview(photoData)
        photoData.delegate = self
        photoData.dataSource = self
        time.snp.makeConstraints{(make) in
            make.left.top.equalTo(self).offset(20)
            make.width.equalTo(150)
            make.height.equalTo(35)
        }
        
        photoData.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(time.snp.bottom).offset(10)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(440)
        }
    }
    func updateUI(){
        
    }
}
extension albumCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumTwoCell", for: indexPath) as! albumTwoCell
        if indexPath.row == 0 {
            cell.imgOne.image = UIImage(named: "img11")
            cell.imgTwo.image = UIImage(named: "img12")
        }
        if indexPath.row == 1 {
            cell.imgOne.image = UIImage(named: "img21")
            cell.imgTwo.image = UIImage(named: "img22")
            cell.moreImg.backgroundColor = UIColor.init(r: 100, g: 175, b: 232)
            cell.imgNumber.text = "4+"
            cell.emotionCircle.backgroundColor = UIColor.init(r: 100, g: 175, b: 232)
        }
        if indexPath.row == 2 {
            cell.imgOne.image = UIImage(named: "img31")
            cell.emotionCircle.backgroundColor = UIColor.init(r: 155, g: 133, b: 255)
            cell.moreImg.isHidden = true
            cell.imgNumber.isHidden = true
                        cell.imgTwo.isHidden = true
        }
        if indexPath.row == 3{
            cell.line.backgroundColor = .white
            cell.emotionCircle.backgroundColor = UIColor.init(r: 31, g: 69, b: 99)
            cell.imgOne.image = UIImage(named: "img41")
            cell.imgTwo.image = UIImage(named: "img42")
            cell.moreImg.isHidden = true
            cell.imgNumber.isHidden = true
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
