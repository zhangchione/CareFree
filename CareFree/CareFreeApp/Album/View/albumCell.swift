//
//  albumCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/8.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import Photos

class albumCell: UITableViewCell {

    
    var callback:((Int)->())?
    
    var imgdatas = AlbumModel()
    
    lazy var time: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        label.text = "2019年07月"
        return label
    }()
    
    lazy var photoData : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = backColor
        tableView.separatorStyle = .none
        //tableView.allowsSelection = true
        return tableView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configUI(){
        self.backgroundColor = backColor
        addSubview(time)
        addSubview(photoData)
        photoData.delegate = self
        photoData.dataSource = self
        time.snp.makeConstraints{(make) in
            make.left.top.equalTo(self).offset(20.fit)
            make.width.equalTo(150)
            make.height.equalTo(35)
        }
        
        photoData.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(time.snp.bottom).offset(10.fit)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(440)
        }
    }
    func updateUI(with data: CFAlbumMouthModel){
        self.imgdatas = AlbumModel()
        self.time.text = data.time
        for da in data.data {
            let imgs = da.dayDiary.images.components(separatedBy: ",")
            if da.dayDiary.mode > 25 {
                self.imgdatas.happyPhoto += imgs
            }else if da.dayDiary.mode <= 25 && da.dayDiary.mode > 0 {
                self.imgdatas.calmPhoto += imgs
            }else if da.dayDiary.mode <= 0 && da.dayDiary.mode > -25 {
                self.imgdatas.sadPhoto += imgs
            }else{
                self.imgdatas.repressionePhoto += imgs
            }
            for das in da.nowDiary {
                let imgs = das.images.components(separatedBy: ",")
                if das.mode > 25 {
                    self.imgdatas.happyPhoto += imgs
                }else if das.mode <= 25 && das.mode > 0 {
                    self.imgdatas.calmPhoto += imgs
                }else if das.mode <= 0 && das.mode > -25 {
                    self.imgdatas.sadPhoto += imgs
                }else{
                    self.imgdatas.repressionePhoto += imgs
                }
            }
        }
        print(imgdatas)
        if imgdatas.happyPhoto.count != 0 {
            let da = AlbumCellModel(photos: imgdatas.happyPhoto,type:.happy)
            imgdatas.data.append(da)
        }
        if imgdatas.calmPhoto.count != 0 {
            let da = AlbumCellModel(photos: imgdatas.calmPhoto,type:.calm)
            imgdatas.data.append(da)
        }
        if imgdatas.sadPhoto.count != 0 {
            let da = AlbumCellModel(photos: imgdatas.sadPhoto,type:.sad)
            imgdatas.data.append(da)
        }
        if imgdatas.repressionePhoto.count != 0 {
            let da = AlbumCellModel(photos: imgdatas.repressionePhoto,type:.repressione)
            imgdatas.data.append(da)
        }
        self.photoData.reloadData()
    }
}
extension albumCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgdatas.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "albumTwoCell\(indexPath.section)\(indexPath.row)"
        self.photoData.register(UINib(nibName: "albumTwoCell", bundle: nil), forCellReuseIdentifier: identifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! albumTwoCell
        cell.selectionStyle = .none
        cell.backgroundColor = backColor
        config(cell: cell, with: imgdatas.data[indexPath.row])
        if indexPath.row == 0 {
            cell.topline.backgroundColor = .clear
        }
        if indexPath.row == imgdatas.data.count-1 {
            cell.line.backgroundColor = .clear
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.callback!(indexPath.row)
    }
    func config(cell:albumTwoCell,with data:AlbumCellModel) {
        switch data.type {
        case .happy:
            cell.emotionCircle.backgroundColor = happyColor
        case .calm:
            cell.emotionCircle.backgroundColor = UIColor.init(r: 100, g: 175, b: 232)
        case .sad:
            cell.emotionCircle.backgroundColor = UIColor.init(r: 155, g: 133, b: 255)
        case .repressione:
            cell.emotionCircle.backgroundColor = UIColor.init(r: 31, g: 69, b: 99)
        default:
            break
        }
        
        if data.photos.count > 3 {
            cell.imgOne.image = configPic(with:data.photos[0])
            cell.imgTwo.image = configPic(with: data.photos[1])
            cell.imgNumber.text = "\(data.photos.count - 2)+"
            cell.imgThree.isHidden = true
            
        }else if data.photos.count == 3 {
            cell.imgOne.image = configPic(with:data.photos[0])
            cell.imgTwo.image = configPic(with: data.photos[1])
            cell.imgThree.image = configPic(with: data.photos[2])
            cell.moreImg.isHidden = true
            cell.imgNumber.isHidden = true
        }else if data.photos.count == 2 {
            cell.imgOne.image = configPic(with:data.photos[0])
            cell.imgTwo.image = configPic(with: data.photos[1])
            cell.moreImg.isHidden = true
            cell.imgNumber.isHidden = true
            cell.imgThree.isHidden = true
        }else if data.photos.count == 1 {
            cell.imgOne.image = configPic(with:data.photos[0])
            cell.moreImg.isHidden = true
            cell.imgNumber.isHidden = true
            cell.imgTwo.isHidden = true
            cell.imgThree.isHidden = true
        }
        

    }
    func configPic(with data:String) -> UIImage? {
        var value:UIImage?
        let result = PHAsset.fetchAssets(withLocalIdentifiers: [data].compactMap{ $0 },options: nil) as? PHFetchResult
        result?.enumerateObjects({ (obj, index, stop) in
            let imageAsset = obj as? PHAsset
            if let imageAsset = imageAsset {
                let img = SKPHAssetToImageTool.PHAssetToImage(asset: imageAsset)
                 value = img
            }
        })
        return value
    }
}
