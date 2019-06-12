//
//  CFMineCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/6.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class CFMineCell: UITableViewCell {

    @IBOutlet weak var backgroundViewone: UIView!
    @IBOutlet weak var emotionView: UIView!
    @IBOutlet weak var emotionValue: UILabel!
    
    @IBOutlet weak var trashView: UIView!
    @IBOutlet weak var setView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var colorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
