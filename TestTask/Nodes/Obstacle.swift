//
//  Obstacle.swift
//  TestTask
//
//  Created by Roman Khancha on 09.01.2025.
//

import SpriteKit

class Obstacle: SKNode {
    
    var topLine: SKShapeNode!
    var bottomLine: SKShapeNode!
    var combinedPhysicsBody: SKPhysicsBody!
    
    init(distance: CGFloat, width: CGFloat, height: CGFloat) {
        super.init()
        
        topLine = SKShapeNode(rectOf: CGSize(width: width, height: height))
        topLine.fillColor = .green
        topLine.strokeColor = .black
        topLine.position = CGPoint(x: 0, y: distance / 2)
        
        bottomLine = SKShapeNode(rectOf: CGSize(width: width, height: height))
        bottomLine.fillColor = .green
        bottomLine.strokeColor = .black
        bottomLine.position = CGPoint(x: 0, y: -distance / 2)
        
        addChild(topLine)
        addChild(bottomLine)
        
        let combinedPath = CGMutablePath()
        combinedPath.addRect(topLine.frame)
        combinedPath.addRect(bottomLine.frame)
        
        combinedPhysicsBody = SKPhysicsBody(polygonFrom: combinedPath)
        combinedPhysicsBody.isDynamic = false
        combinedPhysicsBody.categoryBitMask = PhysicsCategory.obstacle
        combinedPhysicsBody.contactTestBitMask = PhysicsCategory.circle
        combinedPhysicsBody.collisionBitMask = PhysicsCategory.none
        
        physicsBody = combinedPhysicsBody
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func spawnObstacle(in scene: SKScene, minimumDistance: CGFloat, maximumDistance: CGFloat, spawnOffset: CGFloat, width: CGFloat, height: CGFloat) -> Obstacle {
        
        let randomDistance = CGFloat.random(in: minimumDistance...maximumDistance)
        
        let obstacle = Obstacle(distance: randomDistance, width: width, height: height)
        obstacle.position = CGPoint(x: scene.size.width + spawnOffset, y: scene.size.height / 2)
        
        scene.addChild(obstacle)
        return obstacle
    }
}
