//
//  GameViewController.swift
//  CubeRunner
//
//  Created by Giordano Scalzo on 25/03/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import CoreMotion
import SwiftCubicSpline

class GameViewController: UIViewController {
    private let scnView = SCNView()
    private var scene: SCNScene!
    private var cameraNode: SCNNode!
    //...
    private var laneTimer: NSTimer!
    //...
    private var motionManager : CMMotionManager?
    private let spline = CubicSpline(points: [
        CGPoint(x: 0.0, y: 0.5),
        CGPoint(x: 0.1, y: 0.5),
        CGPoint(x: 0.2, y: 0.8),
        CGPoint(x: 0.4, y: 0.2),
        CGPoint(x: 0.6, y: 0.6),
        CGPoint(x: 0.8, y: 0.4),
        CGPoint(x: 0.9, y: 0.5),
        CGPoint(x: 1.0, y: 0.5)
        ])
    //...
    override func viewDidLoad() {
        super.viewDidLoad()
        scnView.frame = view.bounds
        view.addSubview(scnView)
        
        createContents()
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

// MARK: content builder
private extension GameViewController {
    func createContents() {
        scene = SCNScene(named: "art.scnassets/eurofighter.dae")
        scene.background.contents = UIImage(named: "sky")
        scnView.showsStatistics = true
        //...
        cameraNode = createCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        let jetfighterNode = createJetfighter()
        scene.rootNode.addChildNode(createFloor())
        
        let moveForwardAction = SCNAction.repeatActionForever(
            SCNAction.moveByX(0, y: 0, z: -100, duration: 7))
        cameraNode.runAction(moveForwardAction)
        jetfighterNode.runAction(moveForwardAction)
        
        motionManager = CMMotionManager()
        motionManager?.deviceMotionUpdateInterval = 1.0 / 60.0
        motionManager?.startDeviceMotionUpdatesUsingReferenceFrame(
            //...
            CMAttitudeReferenceFrame.XArbitraryZVertical,
            toQueue: NSOperationQueue.mainQueue(),
            withHandler: { (motion: CMDeviceMotion?, error: NSError?) -> Void in
                guard let motion = motion else { return }
                let roll = CGFloat(motion.attitude.roll)
                
                let rotateCamera =
                SCNAction.rotateByAngle(roll/20.0,
                    aroundAxis: SCNVector3(x: 0, y: 0, z: 1),
                    duration: 0.1)
                self.cameraNode.runAction(rotateCamera)
                
                let rotateJetfighter =
                SCNAction.rotateByAngle(roll/10.0,
                    aroundAxis: SCNVector3(x: 0, y: 0, z: 1),
                    duration: 0.1)
                jetfighterNode.runAction(rotateJetfighter)
                
                let actionMove = SCNAction.moveByX(roll, y: 0, z: 0, duration: 0.1)
                self.cameraNode.runAction(actionMove)
                jetfighterNode.runAction(actionMove)
        })
        buildTheLane()
        laneTimer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self,
            selector: "laneTimerFired", userInfo: nil, repeats: true)
        scene!.fogStartDistance = 30
        scene!.fogEndDistance = 90
        scene!.fogColor = UIColor.blackColor()
        
        //...
        
        scnView.scene = scene
    }
    
    func createJetfighter() -> SCNNode{
        let jetfighterNode = scene!.rootNode.childNodeWithName("jetfighter", recursively: true)!
        
        jetfighterNode.scale = SCNVector3(x: 0.03, y: 0.03, z: 0.03)
        jetfighterNode.position = SCNVector3(x: 0, y: 1.0, z: 13)
        jetfighterNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: Float(M_PI))
        return jetfighterNode
    }
    
    func createCamera() -> SCNNode{
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 7, 20)
        cameraNode.rotation = SCNVector4Make(1, 0, 0, -atan2f(7, 20.0))
        return cameraNode
    }
    
    func createFloor() -> SCNNode {
        let floor = SCNFloor()
        floor.firstMaterial!.diffuse.contents = UIImage(named: "moon")
        floor.firstMaterial!.diffuse.contentsTransform = SCNMatrix4MakeScale(2, 2, 1)
        floor.reflectivity = 0
        return SCNNode(geometry: floor)
    }
    
    func buildTheLane() {
        for var zPos = 0; zPos < 200; zPos += 3 {
            let z = cameraNode.position.z - Float(zPos)
            buildCubesAtPosition(z)
        }
    }
    
    func buildCubesAtPosition(zPos: Float){
        let laneWidth: CGFloat = 40
        
        let zPosInSection = zPos%200
        let normalizedZ = CGFloat(fabs(zPosInSection/200))
        let normalizedX = Float((spline.interpolate(normalizedZ) - 0.5)*laneWidth)
        
        let cubeAtLeft = cube()
        cubeAtLeft.position = SCNVector3(x: normalizedX - 6, y: 1.0, z: zPos)
        scene.rootNode.addChildNode(cubeAtLeft)
        let cubeAtRight = cube()
        cubeAtRight.position = SCNVector3(x: normalizedX + 6, y: 1.0, z: zPos)
        scene.rootNode.addChildNode(cubeAtRight)
        //...
        if arc4random_uniform(5) < 1 {
            let centralCube = cube(1.0)
            scene.rootNode.addChildNode(centralCube)
            let xOffset = arc4random_uniform(10)
            centralCube.position = SCNVector3(x: normalizedX + Float(xOffset) - 5.0, y: 1.0, z: zPos)
        }
    }
    
    func cube(size: CGFloat = 2.0) -> SCNNode {
        let cube = SCNBox(width: size, height: size, length: size, chamferRadius: 0)
        let cubeNode = SCNNode(geometry: cube)
        
        cube.firstMaterial!.diffuse.contents = {
            switch arc4random_uniform(4) {
            case 0:
                return UIColor.ht_belizeHoleColor()
            case 1:
                return UIColor.ht_wisteriaColor()
            case 2:
                return UIColor.ht_midnightBlueColor()
            default:
                return UIColor.ht_pomegranateColor()
            }
            }()
        
        return cubeNode
    }
    
    @objc func laneTimerFired(){
        buildCubesAtPosition(cameraNode.position.z-200)
    }
}
