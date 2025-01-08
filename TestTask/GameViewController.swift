//
//  GameViewController.swift
//  TestTask
//
//  Created by Roman Khancha on 09.01.2025.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, GameSceneDelegate {
    
    var livesLabel: UILabel!
    var plusButton: UIButton!
    var minusButton: UIButton!
    var gameScene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameScene = GameScene(size: view.bounds.size)
        gameScene.scaleMode = .resizeFill
        gameScene.gameDelegate = self
        
        guard let view = self.view as? SKView else { return }
        
        view.presentScene(gameScene)
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        
        setupLivesLabel()
        setupButtons()
    }
    
    func setupLivesLabel() {
        livesLabel = UILabel()
        livesLabel.text = "Lives: \(gameScene.lives)"
        livesLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        livesLabel.textColor = .white
        livesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(livesLabel)
        
        NSLayoutConstraint.activate([
            livesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            livesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    func setupButtons() {
        
        plusButton = createButton(title: "+", action: #selector(increaseRadius))
        minusButton = createButton(title: "-", action: #selector(decreaseRadius))
        
        view.addSubview(plusButton)
        view.addSubview(minusButton)
        
        NSLayoutConstraint.activate([
            plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            plusButton.widthAnchor.constraint(equalToConstant: 70),
            plusButton.heightAnchor.constraint(equalToConstant: 70),
            
            minusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            minusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            minusButton.widthAnchor.constraint(equalToConstant: 70),
            minusButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func createButton(title: String, action: Selector) -> UIButton {
        
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 35
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        button.addTarget(self, action: action, for: .touchUpInside)
        
        return button
    }
    
    @objc func increaseRadius() {
        gameScene.circle.changeRadius(by: 10)
    }
    
    @objc func decreaseRadius() {
        gameScene.circle.changeRadius(by: -10)
    }
    
    func updateLivesLabel(lives: Int) {
        livesLabel.text = "Lives: \(lives)"
    }
}
