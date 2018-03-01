//
//  GameScene.swift
//  SpaceShooter
//
//  Created by Kelly Jewkes on 3/1/18.
//  Copyright © 2018 LightWing. All rights reserved.
//

import SpriteKit
import GameplayKit

var playerNode = SKSpriteNode()
var playerSize = CGSize(width: 70, height: 70)
var playerPostition = CGPoint(x: 0, y: -580)

var projectileVelocity = CGFloat()
var projectileSize = CGSize(width: 10, height: 10)

var enemyNode = SKSpriteNode() //repeating perhaps
var enemySize = CGSize(width: 50, height: 50)
var enemyVelocity = CGFloat()
var enemyPosistion = CGPoint()

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        playerNode.size = playerSize
        playerNode.position = playerPostition
        playerNode.color = .orange
        self.addChild(playerNode)
        fireProjectiles()
        launchEnemy()
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            print(touch.location(in: self).y)
            playerNode.position.x = touch.location(in: self).x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            playerNode.position.x = touch.location(in: self).x
        }
    }
    
    fileprivate func fireProjectiles() {
        let spawnProjectile = SKAction.run {
            self.spawnProjectile()
        }
        
        let wait = SKAction.wait(forDuration: 0.5)
        let sequence = SKAction.sequence([spawnProjectile, wait])
        let fire = SKAction.repeatForever(sequence)
        playerNode.run(fire)

    }

    fileprivate func spawnProjectile() {
        let projectileNode = SKSpriteNode()
        projectileNode.size = projectileSize
        projectileNode.position = CGPoint(x: playerNode.position.x, y: playerNode.position.y + 40)
        projectileNode.color = .white
        self.addChild(projectileNode)
        let moveProjectile = SKAction.moveTo(y: 700, duration: 0.8)
        projectileNode.run(moveProjectile)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    // Enemy
    fileprivate func launchEnemy() {
        let spawnEnemy = SKAction.run {
            self.spawnEnemy()
        }
    
        let wait = SKAction.wait(forDuration: 1.0)
        let sequence = SKAction.sequence([spawnEnemy, wait])
        let constantEnemies = SKAction.repeatForever(sequence)
        self.run(constantEnemies)
        
    }
    
    fileprivate func spawnEnemy() {
        let newEnemy = SKSpriteNode()
        let randEnemySpawn = arc4random_uniform(300) + 1
        newEnemy.size = enemySize
        newEnemy.position.y = 800
        newEnemy.color = .cyan
        
        let randomQuad = CGFloat(arc4random_uniform(2))
        if randomQuad == 0 {
            newEnemy.position.x = -CGFloat(randEnemySpawn)
        } else {
            newEnemy.position.x = CGFloat(randEnemySpawn)
        }
        
        self.addChild(newEnemy)
        let moveEnemy = SKAction.moveTo(y: -700, duration: 1.5)
        newEnemy.run(moveEnemy)
        
    }

}
