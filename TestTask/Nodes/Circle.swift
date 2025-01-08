//
//  Circle.swift
//  TestTask
//
//  Created by Roman Khancha on 09.01.2025.
//

import SpriteKit

class Circle: SKNode {
    
    var radius: CGFloat
    var sectors: [SKShapeNode] = []
    
    init(radius: CGFloat) {
        self.radius = radius
        super.init()
        createSectors()
        updatePhysicsBody()
        self.startRotation(duration: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSectors() {
        
        sectors.forEach { $0.removeFromParent() }
        sectors.removeAll()
        
        let sectorWidth: CGFloat = .pi / 2
        for i in 0..<4 {
            let sector = SKShapeNode()
            let path = UIBezierPath()
            path.move(to: CGPoint.zero)
            path.addArc(
                withCenter: CGPoint.zero,
                radius: radius,
                startAngle: sectorWidth * CGFloat(i),
                endAngle: sectorWidth * CGFloat(i + 1),
                clockwise: true
            )
            path.close()
            sector.path = path.cgPath
            sector.fillColor = (i % 2 == 0) ? .blue : .red
            sector.strokeColor = .black
            sector.lineWidth = 1
            self.addChild(sector)
            sectors.append(sector)
        }
    }
    
    func updatePhysicsBody() {
        let physicsBody = SKPhysicsBody(circleOfRadius: radius)
        physicsBody.isDynamic = true
        physicsBody.affectedByGravity = false
        physicsBody.categoryBitMask = PhysicsCategory.circle
        physicsBody.contactTestBitMask = PhysicsCategory.obstacle
        physicsBody.collisionBitMask = PhysicsCategory.none
        self.physicsBody = physicsBody
    }
    
    func changeRadius(by delta: CGFloat) {
        let newRadius = max(10, radius + delta)
        if newRadius != radius {
            radius = newRadius
            createSectors()
            updatePhysicsBody()
        }
    }
    
    func startRotation(duration: TimeInterval) {
        let rotateAction = SKAction.rotate(byAngle: -.pi, duration: duration)
        let rotateForever = SKAction.repeatForever(rotateAction)
        self.run(rotateForever)
    }
}
