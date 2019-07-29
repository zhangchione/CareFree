//
//  TKPanoramaSelectViewController.swift
//  Tracks
//
//  Created by 张驰 on 2019/7/13.
//  Copyright © 2019 张驰. All rights reserved.
//
import UIKit
import ARKit

class TKPanoramaSelectViewController: UIViewController {
    @IBOutlet weak var arSCNView: ARSCNView!
    @IBOutlet weak var lastButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    let  imageNames: [String] = ["panorama"]
    let sphere = SCNSphere(radius: 10)
    var index: Int = 0 {
        didSet {
            nextButton.isHidden = index == imageNames.count - 1
            lastButton.isHidden = index == 0
            if index >= 0 && index < imageNames.count {
                if let newImage = UIImage(named: imageNames[index]) {
                    image = newImage
                }
            }
        }
    }
    var image: UIImage = UIImage() {
        didSet {
            sphere.firstMaterial?.diffuse.contents = image
        }
    }
    class  func vc() -> TKPanoramaSelectViewController {
        let vc = UIStoryboard.init(name: "ARPanorama", bundle: nil).instantiateViewController(withIdentifier: "TKPanoramaSelectViewController")
        return vc as! TKPanoramaSelectViewController
    }
    @IBAction func lastButtonDidClick(_ sender: UIButton) {
        index -= 1
    }
    @IBAction func nextButtonDidClick(_ sender: UIButton) {
        index += 1
    }
    @IBAction func completeButtonDidClick(_ sender: UIButton) {
    let manager = RescouceManager.share
        manager.panoramaImage = image
        navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        arSCNView.session.run(configuration)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arSCNView.session.pause()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        index = 0
        let sphereNode = SCNNode(geometry: sphere)
        sphere.firstMaterial?.isDoubleSided = true
        if let imageName = imageNames.first {
            sphere.firstMaterial?.diffuse.contents = UIImage(named: imageName)
        }
        sphereNode.position = SCNVector3Zero
        arSCNView.scene.rootNode.addChildNode(sphereNode)
    }
}
