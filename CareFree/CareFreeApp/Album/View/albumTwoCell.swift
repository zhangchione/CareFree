//
//  albumTwoCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/8.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class albumTwoCell: UITableViewCell {

    @IBOutlet weak var topline: UIView!
    @IBOutlet weak var emotionCircle: UIView!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var imgOne: UIImageView!
    @IBOutlet weak var imgTwo: UIImageView!
    @IBOutlet weak var imgThree: UIImageView!
    
    @IBOutlet weak var noneLab: UILabel!
    @IBOutlet weak var moreImg: UIView!
    @IBOutlet weak var imgNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
