//
//  TKARSCNView.swift
//  Tracks
//
//  Created by 张驰 on 2019/7/13.
//  Copyright © 2019 张驰. All rights reserved.
//
import UIKit
import ARKit

class TKARSCNView: ARSCNView {
    let rescouceManager = RescouceManager.share
    let rescoucceConfiguration = RescouceConfiguration.share
    var videoPlayer: AVPlayer?
    lazy var musicPlayer: AVPlayer = {
        let  musicPlayer = AVPlayer()
        return musicPlayer
    }()
    ///环的半径
    let ringRadius: Float = 6.0
    func removeAllNodes() {
        for node in self.scene.rootNode.childNodes {
            node.removeFromParentNode()
        }
        videoPlayer = nil
        musicPlayer.pause()
        NotificationCenter.default.removeObserver(self)
    }
    func addVerticalPhoto(vector3: SCNVector3, left: CGFloat, L: Int) {
        let photoRingNode = SCNNode()
        photoRingNode.position = SCNVector3Zero
        self.scene.rootNode.addChildNode(photoRingNode)
        let photoW: CGFloat = 1.4
        let photoH: CGFloat = photoW/0.618
        let radius: CGFloat = 0.02
        for index in 0..<L {
            let photo = SCNPlane(width: photoW, height: photoH)
            photo.cornerRadius = radius
            let i = Int(index % rescouceManager.verticalImages.count)
            let image = RescouceManager.share.verticalImages[i]
            photo.firstMaterial?.diffuse.contents = image
            let photoNode = SCNNode(geometry: photo)
            photoNode.position = vector3
            let emptyNode = SCNNode()
            emptyNode.position = SCNVector3Zero
            emptyNode.rotation = SCNVector4Make(0, 1, 0, Float.pi/Float(L/2) * Float(index))
            emptyNode.addChildNode(photoNode)
            photoRingNode.addChildNode(emptyNode)
        }
        let ringAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: left, z: 0, duration: 10))
        photoRingNode.runAction(ringAction)
    }
    func addHorizontalPhoto(vector3: SCNVector3, left: CGFloat, L: Int) {
        let photoRingNode = SCNNode()
        photoRingNode.position = SCNVector3Zero
        self.scene.rootNode.addChildNode(photoRingNode)
        let photoW: CGFloat       = 2.8
        let photoH: CGFloat       = photoW * 0.618
        let radius: CGFloat = 0.02
        for index in 0..<L {
            let photo = SCNPlane(width: photoW, height: photoH)
            photo.cornerRadius = radius
            let i = Int(index % rescouceManager.horizontalImages.count)
            let image = rescouceManager.horizontalImages[i]
            photo.firstMaterial?.diffuse.contents = image
            let photoNode = SCNNode(geometry: photo)
            photoNode.position = vector3
            let emptyNode = SCNNode()
            emptyNode.position = SCNVector3Zero
            emptyNode.rotation = SCNVector4Make(0, 1, 0, Float.pi/Float(L/2) * Float(index))
            emptyNode.addChildNode(photoNode)
            photoRingNode.addChildNode(emptyNode)
        }
        let ringAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: left, z: 0, duration: 10))
        photoRingNode.runAction(ringAction)
    }
    
    // MARK: 显示文字
    func addPhotoRing_Text(text: String, color: String) {
        let textRingNode = SCNNode()
        textRingNode.position = SCNVector3Zero
        self.scene.rootNode.addChildNode(textRingNode)
        var index: Int = 0
        var angle: Float = 0
        for t in text {
            index += 1
            let str = String(t)
            let text = SCNText(string: str, extrusionDepth: 0.1)
            text.font = UIFont.systemFont(ofSize: 0.4)
            text.firstMaterial?.diffuse.wrapT = .repeat
            let textNode = SCNNode(geometry: text)
            textNode.position = SCNVector3Make(0, 0, -ringRadius)
            text.firstMaterial?.diffuse.contents = UIImage(named: color)
            let emptyNode = SCNNode()
            emptyNode.position = SCNVector3Zero
            emptyNode.rotation = SCNVector4Make(0, 1, 0, angle)
            emptyNode.addChildNode(textNode)
            textRingNode.addChildNode(emptyNode)
            let ii = UnsafePointer<Int8>(str)
            if 3 == strlen(ii) {
                angle += -Float.pi/Float(40)
            } else {
                angle += -Float.pi/Float(80)
            }
        }
        let ringAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: -1, z: 0, duration: 5))
        textRingNode.runAction(ringAction)
    }

    func addPanoramaImage(image: UIImage) {
        let sphere = SCNSphere(radius: 15)
        let sphereNode = SCNNode(geometry: sphere)
        sphere.firstMaterial?.isDoubleSided = true
        sphere.firstMaterial?.diffuse.contents = image
        sphereNode.position = SCNVector3Zero
        scene.rootNode.addChildNode(sphereNode)
    }
   
    func playMusic(musicName: String) {
        //播放音乐
        if let resourceUrl = Bundle.main.url(forResource: musicName, withExtension: "mp3") {
            if FileManager.default.fileExists(atPath: resourceUrl.path) {
                let item = AVPlayerItem(url: resourceUrl)
                musicPlayer.replaceCurrentItem(with: item)
                musicPlayer.play()
            }
        }
    }

    @objc func playEnd(notify: Notification) {
        let item = notify.object as! AVPlayerItem
        if videoPlayer?.currentItem == item {
            videoPlayer?.seek(to: CMTime.zero)
            videoPlayer?.play()
        } else if  musicPlayer.currentItem == item {
            musicPlayer.seek(to: CMTime.zero)
            musicPlayer.play()
        }
    }
}
