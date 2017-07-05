//
//  ViewController.swift
//  ARDemoSwift
//
//  Created by chenyn on 2017/6/26.
//  Copyright © 2017年 chenyn. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new (and empty) scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        sceneView.scene.physicsWorld.contactDelegate = self
        
        self.addNewCube()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(didTapScreen(_:)))
        sceneView.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        configuration.planeDetection = ARWorldTrackingSessionConfiguration.PlaneDetection.horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    @objc
    func didTapScreen(_ sender: UIGestureRecognizer) {
        
        let bulletsNode = Bullet()
        bulletsNode.position = SCNVector3(0, 0, -0.2)
        
        let bulletDirection = self.getUserDirection()
        bulletsNode.physicsBody?.applyForce(bulletDirection, asImpulse: true)
        sceneView.scene.rootNode.addChildNode(bulletsNode)
    }
    
    func getUserDirection() -> SCNVector3 {
        if let frame = self.sceneView.session.currentFrame {
            let mat = SCNMatrix4FromMat4Class.scnMatrix4(fromMat4Mth: frame.camera.transform)
            return SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33)
        }
        return SCNVector3(0, 0, -1)
    }
    
    // MARK: - Contact Delegate
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            contact.nodeA.removeFromParentNode()
            contact.nodeB.removeFromParentNode()
            _ = self.sceneView.scene.rootNode.childNodes.map { node in
                node.removeFromParentNode()
            }
            self.addNewCube()
        })
    }
    
    func addNewCube() {
        let cubeNode = Cube()
        
        let posX = floatBetween(-0.5, and: 0.5)
        let posY = floatBetween(-0.5, and: 0.5)
        cubeNode.position = SCNVector3(posX, posY, -1)
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    
    func floatBetween(_ first: Float,  and second: Float) -> Float {
        return (Float(arc4random()) / Float(UInt32.max)) * (first - second) + second
    }
}
