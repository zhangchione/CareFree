//
//  diaryPhotoCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/7.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

protocol DiaryCellDelegate:NSObjectProtocol {
    func photoDelete(with indexPath:IndexPath)
}



class diaryPhotoCell: UICollectionViewCell {

    
    public var isDeleteButtonShow = true
    
    @IBOutlet weak var deleteButton: UIButton!
    weak var delegate:DiaryCellDelegate?
    public var indexPath = IndexPath()
    @IBAction func deleteBtn(_ sender: UIButton) {
        self.delegate?.photoDelete(with: self.indexPath)
        if !isDeleteButtonShow {
            sender.isHidden = true
        }
    }
    
    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
