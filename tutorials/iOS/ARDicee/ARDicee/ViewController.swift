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
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        // Set the view's delegate
        sceneView.delegate = self
        
//
//        let sphere = SCNSphere(radius: 0.2)
//
//        //Without this a plain white cube would be displayed
//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named: "art.scnassets/8k_earth_daymap.jpg")
//
        
        //Cube materials accepts an slice of differnet textures
//        sphere.materials = [material]
//
//        let node = SCNNode()
//
        //positive value in axis right,top,closer
//        node.position = SCNVector3(0, 0.1, -0.5)
//        node.geometry = sphere
//

        
        sceneView.autoenablesDefaultLighting = true
        
//        Xcode generated default code

//        }
        

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let touchLocation = touch.location(in: sceneView)
            //hit test to correspond 2d touch position to a 3d position
            let results = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
            
            if let hitResult = results.first {
             
                //        // Create a new scene
                let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
        
                if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true){
        
                diceNode .position = SCNVector3(
                    hitResult.worldTransform.columns.3.x,
                    hitResult.worldTransform.columns.3.y  + diceNode.boundingSphere.radius ,
                    hitResult.worldTransform.columns.3.z)
        
                sceneView.scene.rootNode.addChildNode(diceNode)
                    
                    
                    
                let randomX = Float(arc4random_uniform(4) + 1) * (Float.pi/2)
                let randomz = Float(arc4random_uniform(4) + 1) * (Float.pi/2)
                    
                diceNode.runAction(
                    SCNAction.rotateBy(
                        x: CGFloat(randomX * 5),
                        y: CGFloat(0),
                        z: CGFloat(randomz * 5),
                        duration: 0.5)
                    )
            }
        }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor{
            let planeAnchor = anchor as! ARPlaneAnchor
            //Second parameter is a plane
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x) , height: CGFloat(planeAnchor.extent.z))
            
            let planeNode = SCNNode()
            
            planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
            //To rotate counter clockwise by 90degrees
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            
            let gridMaterial = SCNMaterial()
            
            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            
            plane.materials = [gridMaterial]
            
            planeNode.geometry = plane
            
            node.addChildNode(planeNode)
        }
        else{
            return
        }
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
