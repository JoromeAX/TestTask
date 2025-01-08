//
//  GameScene.swift
//  TestTask
//
//  Created by Roman Khancha on 09.01.2025.
//

import SpriteKit
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    let minimumDistance: CGFloat = 50
    let maximumDistance: CGFloat = 200
    let spawnOffset: CGFloat = 150
    let moveSpeed: CGFloat = 5
    let spawnInterval: TimeInterval = 2
    
    var circle: Circle!
    var obstacles: [Obstacle] = []
    var lastSpawnTime: TimeInterval = 0
    var lives = 5
    
    var gameDelegate: GameSceneDelegate?
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        impactFeedbackGenerator.prepare()
        
        circle = Circle(radius: 50)
        circle.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(circle)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if currentTime - lastSpawnTime > spawnInterval {
            let newObstacle = Obstacle.spawnObstacle(
                in: self,
                minimumDistance: minimumDistance,
                maximumDistance: maximumDistance,
                spawnOffset: spawnOffset,
                width: 150,
                height: 30
            )
            
            obstacles.append(newObstacle)
            lastSpawnTime = currentTime
        }
        
        for obstacle in obstacles {
            obstacle.position.x -= moveSpeed
            
            if obstacle.position.x + 150 / 2 < 0 {
                obstacle.removeFromParent()
                obstacles.removeAll { $0 == obstacle }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node == circle || contact.bodyB.node == circle {
            print("Collision detected between circle and obstacle!")
            
            impactFeedbackGenerator.impactOccurred()
            decreaseLives()
        }
    }
    
    func decreaseLives() {
        lives -= 1
        print(lives)
        gameDelegate?.updateLivesLabel(lives: lives)
        
        if lives == 0 {
            showGameOverAlert()
        }
    }
    
    func showGameOverAlert() {
        guard let viewController = self.view?.window?.rootViewController else { return }
        
        self.isPaused = true
        
        let alert = UIAlertController(
            title: "Game Over",
            message: "Your lives have reached 0. Restart the game?",
            preferredStyle: .alert
        )
        
        let restartAction = UIAlertAction(title: "Restart", style: .default) { _ in
            self.restartGame()
            self.isPaused = false
        }
        
        alert.addAction(restartAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func restartGame() {
        lives = 5
        gameDelegate?.updateLivesLabel(lives: lives)
        
        obstacles.forEach { $0.removeFromParent() }
        obstacles.removeAll()
        
        circle.position = CGPoint(x: size.width / 2, y: size.height / 2)
        lastSpawnTime = 0
    }
}

protocol GameSceneDelegate: AnyObject {
    func updateLivesLabel(lives: Int)
}
