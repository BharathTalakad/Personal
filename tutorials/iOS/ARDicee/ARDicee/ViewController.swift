//
//  ViewController.swift
//  ARDicee
//
//  Created by bharath on 2019/01/22.
//  Copyright © 2019 bharath. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        
        let sphere = SCNSphere(radius: 0.2)
        
        //Without this a plain white cube would be displayed
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/8k_earth_daymap.jpg")
        
        
        //Cube materials accepts an slice of differnet textures
        sphere.materials = [material]
        
        let node = SCNNode()
        
        //positive value in axis right,top,closer
        node.position = SCNVector3(0, 0.1, -0.5)
        node.geometry = sphere
        
        sceneView.scene.rootNode.addChildNode(node)
     
        
        sceneView.autoenablesDefaultLighting = true
        
//        Xcode generated default code
//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
 
}
