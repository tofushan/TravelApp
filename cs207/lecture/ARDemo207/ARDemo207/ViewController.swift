//
//  ViewController.swift
//  ARDemo207
//
//  Created by Hugh Thomas on 2/26/21.
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
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            // Where exactly did this touch land in the sceneView's coordinate system?
            let location = touches.first!.location(in:sceneView)
            
            // Now that we know the 2D location in the scene view,
            // search the 3D scene for objects located along that line
            let hits = sceneView.hitTest(location,options: nil )
            
            // Find the closest hit, and the corresponding SceneKit node
            if let closest = hits.first {
                let touchedNode = closest.node
                
                // This is an action that will create a 2 second rotate by 360º around the Y axis
                let rotateOnce = SCNAction.rotate( by:2.0 * .pi,
                                                 around: SCNVector3Make(0,1,0),
                                                 duration: 2.0)
                
                // Make a new action that repeats the rotateOnce one indefinitely
                let rotateForever = SCNAction.repeatForever(rotateOnce)
                
                // If the current node has any actions - i.e. is already spinning - make it stop.
                // Otherwise make it spin.
                
                if touchedNode.hasActions {
                    touchedNode.removeAllActions()
                } else {
                    touchedNode.runAction(rotateForever)
                }


            }
        }
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
