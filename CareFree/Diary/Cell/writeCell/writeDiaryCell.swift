//
//  writeDiaryCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/7.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class writeDiaryCell: UIView {

    var arrayData = [1,2]
    

    
    lazy var diaryWirte : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.clear
        tv.font = UIFont.systemFont(ofSize: 20)
        tv.textColor = UIColor.init(r: 127, g: 127, b: 127)
        tv.text = "泡在了实验室一天，果然充实的学习还是最幸福的"
        return tv
    }()
    
    lazy var photoCollection:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: 120, height:120)
        
        let collection = UICollectionView.init(frame:CGRect(x:100, y:50, width:265, height:180), collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        collection.register(UINib(nibName: "diaryPhotoCell", bundle: nil), forCellWithReuseIdentifier: "diaryPhotoCell")
        return collection
    }()
    
    init(){
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configUI(){

        addSubview(diaryWirte)
        addSubview(photoCollection)
        photoCollection.delegate = self
        photoCollection.dataSource = self
        diaryWirte.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(27)
            make.top.equalTo(self).offset(30)
            make.height.equalTo(250)
            make.right.equalTo(self).offset(-27)
        }
        photoCollection.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(27)
            make.top.equalTo(diaryWirte.snp.bottom).offset(5)
            make.bottom.equalTo(self).offset(5)
            make.right.equalTo(self).offset(-27)
        }
        
    }
    func updateUI(){
        
    }

}
extension writeDiaryCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "diaryPhotoCell", for: indexPath) as! diaryPhotoCell
        if indexPath.row == arrayData.count {
            //cell.photo.image = UIImage(named: "")
        }
        return cell
    }
    
    
}
