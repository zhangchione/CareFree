//
//  ResourceManager.swift
//  Tracks
//
//  Created by 张驰 on 2019/7/13.
//  Copyright © 2019 张驰. All rights reserved.
//
import UIKit

class RescouceManager: NSObject, NSCoding {
    // 单例模式
    static let share = RescouceManager.init()
    
    
    private override init() {}
    var horizontalImages: [UIImage] = []
    var verticalImages: [UIImage] = []
    var panoramaImage: UIImage?
    var musicName: String?
    var text: String?
    var textColor: String?
    func addHorizontalImage(image: UIImage) {
        horizontalImages.append(image)
    }
    func deleteHorizontalImage(image: UIImage) {
        if horizontalImages.firstIndex(of: image) != NSNotFound {
            horizontalImages.remove(at: horizontalImages.firstIndex(of: image)!)
        }
    }
    func addVerticalImage(image: UIImage) {
        verticalImages.append(image)
    }
    func deleteVerticalImage(image: UIImage) {
        if verticalImages.firstIndex(of: image) != NSNotFound {
            verticalImages.remove(at: verticalImages.firstIndex(of: image)!)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        if let aDecoder_horizontalImages = aDecoder.decodeObject(forKey: TK_Resource_horizontalImages) as? [UIImage] {
            horizontalImages = aDecoder_horizontalImages
        } else {
            horizontalImages = []
        }
        if let aDecoder_verticalImages = aDecoder.decodeObject(forKey: TK_Resource_verticalImages) as? [UIImage] {
            verticalImages = aDecoder_verticalImages
        } else {
            verticalImages = []
        }
        panoramaImage = aDecoder.decodeObject(forKey: TK_Resource_panoramaImage) as? UIImage
        text        = aDecoder.decodeObject(forKey: TK_Resource_text) as? String
        textColor   = aDecoder.decodeObject(forKey: TK_Resource_textColor) as? String
        musicName = aDecoder.decodeObject(forKey: TK_Resource_musicName) as? String
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.horizontalImages, forKey: TK_Resource_horizontalImages)
        aCoder.encode(self.verticalImages, forKey: TK_Resource_verticalImages)
        aCoder.encode(self.panoramaImage, forKey: TK_Resource_panoramaImage)
        aCoder.encode(self.text, forKey: TK_Resource_text)
        aCoder.encode(self.textColor, forKey: TK_Resource_textColor)
        aCoder.encode(self.musicName, forKey: TK_Resource_musicName)
    }
}
