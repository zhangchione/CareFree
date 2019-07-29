//
//  TKARViewController.swift
//  Tracks
//
//  Created by 张驰 on 2019/7/13.
//  Copyright © 2019 张驰. All rights reserved.
//
import UIKit
import SceneKit
import ARKit
import ReplayKit
import AssetsLibrary
import Photos
import SwiftEntryKit


class TKARViewController: UIViewController, ARSCNViewDelegate {

    @IBAction func supportButtonDidClick(_ sender: UIButton) {
        //GotoAppStoreTool().toAppStore(vc: self)
    }
    @IBOutlet weak var replayButtonRight: NSLayoutConstraint!
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet var sceneView: TKARSCNView!

    
    
    @IBOutlet weak var replayButton: UIButton!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet var smailButtons: [UIButton]!
    @IBOutlet weak var stopReplayButton: UIButton!
    var selectNode: SCNNode?

    
    
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var redView: UIView!
    
    
    
    var documentController: UIDocumentInteractionController?
    let replayVideoFileName: String = "REPLAY_WEARE.MP4"

    let rescouceManager = RescouceManager.share
    let rescoucceConfiguration = RescouceConfiguration.share

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        showPhotos()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    lazy var musicPlayer: AVPlayer = {
        let player = AVPlayer()
        return player
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        //抗锯齿
        sceneView.antialiasingMode = .multisampling4X
        showPhotos()
        perform(#selector(hidenPreview), with: nil, afterDelay: 3)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandle(gesture:)))
        sceneView.addGestureRecognizer(tap)
        redView.layer.cornerRadius = 5
        redView.layer.masksToBounds = true
        

        
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 2.0) {
            self.replayButton.alpha = self.replayButton.alpha < 0.5 ? 1 : 0
            self.mainButton.alpha =   self.replayButton.alpha < 0.5 ? 0.1 : 1

            for button in self.smailButtons {
                button.alpha =  self.replayButton.alpha
            }
        }
    }
}

// UI+动画
extension TKARViewController {
    func showPhotos() {
        
        sceneView.removeAllNodes()
        // 添加相册
        sceneView.addHorizontalPhoto(vector3: SCNVector3Make(0, -1.2, -6), left: -1, L: 10)
        sceneView.addVerticalPhoto(vector3: SCNVector3Make(0, 1.5, -6), left: 1, L: 20)
        // 背景
            if let panoramaImage = rescouceManager.panoramaImage {
                sceneView.addPanoramaImage(image: panoramaImage)
            }
        // 背景音乐
            sceneView.playMusic(musicName: "往后余生")
        
        // 3D文字环绕
            if let text = rescouceManager.text {
                if let color = rescouceManager.textColor {
                    sceneView.addPhotoRing_Text(text: text, color: color)
                }
            }
        
    }

    @objc func hidenPreview() {
        UIView.animate(withDuration: 1.2) {
            self.view.layoutIfNeeded()
        }
    }
}
//点击到的节点
extension TKARViewController {
    @objc func tapHandle(gesture: UITapGestureRecognizer) {
        let results: [SCNHitTestResult] = (self.sceneView?.hitTest(gesture.location(ofTouch: 0, in: self.sceneView), options: nil))!
        guard let firstNode  = results.first else {
            return
        }
        // 点击到的节点
        let node = firstNode.node.copy() as? SCNNode

        if (node?.geometry?.isKind(of: SCNSphere.self))! {
            self.selectNode?.removeFromParentNode()
            return
        }

        if firstNode.node == self.selectNode {
            let newPosition  = SCNVector3Make(firstNode.node.worldPosition.x*2, firstNode.node.worldPosition.y*2, firstNode.node.worldPosition.z*2)
            let comeOut = SCNAction.move(to: newPosition, duration: 1.2)
            firstNode.node.runAction(comeOut)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2, execute: {
                firstNode.node.removeFromParentNode()
            })
        } else {
            self.selectNode?.removeFromParentNode()
            node?.position = firstNode.node.worldPosition
            let newPosition  = SCNVector3Make(firstNode.node.worldPosition.x/2, firstNode.node.worldPosition.y/2, firstNode.node.worldPosition.z/2)
            node?.rotation = (sceneView.pointOfView?.rotation)!
            sceneView.scene.rootNode.addChildNode(node!)
            let comeOn = SCNAction.move(to: newPosition, duration: 1.2)
            node?.runAction(comeOn)
            selectNode = node
        }
    }
}
// MARK: 按钮点击事件
extension TKARViewController {
    @IBAction func mainButtonDidClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func backButtonDidClick(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

}


extension TKARViewController: RPScreenRecorderDelegate, RPPreviewViewControllerDelegate {

    func previewController(_ previewController: RPPreviewViewController, didFinishWithActivityTypes activityTypes: Set<String>) {
        print(activityTypes)
        if activityTypes.count == 0 {
            previewController.dismiss(animated: true, completion: nil)
        }
        if activityTypes.contains("com.apple.UIKit.activity.SaveToCameraRoll") {
            previewController.dismiss(animated: true, completion: nil)
            let delay = DispatchTime.now() + .seconds(2)
            DispatchQueue.main.asyncAfter(deadline: delay) {
            }
        }
    }
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        print(previewController)
    }
    func screenRecorder(_ screenRecorder: RPScreenRecorder, didStopRecordingWith previewViewController: RPPreviewViewController?, error: Error?) {
        if error != nil {
            DispatchQueue.main.async {
                let string = error?.localizedDescription
               // NoticeHelper.showError("无权限")
            
            }
        }
    }
    
    func screenRecorderDidChangeAvailability(_ screenRecorder: RPScreenRecorder) {
        print(screenRecorder)
    }
}


extension TKARViewController: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerDidDismissOpenInMenu(_ controller: UIDocumentInteractionController) {
        let PATH_MOVIE_FILE = NSTemporaryDirectory().appending(replayVideoFileName)
        try? FileManager.default.removeItem(atPath: PATH_MOVIE_FILE)
    }
}
