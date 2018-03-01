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
var projectile = SKSpriteNode()
var enemy = SKSpriteNode()
var playerSize = CGSize(width: 70, height: 70)
var playerPostition = CGPoint(x: 0, y: -580)

var projectileVelocity = CGFloat()
var projectileSize = CGSize(width: 10, height: 10)

var enemyNode = SKSpriteNode() //repeating perhaps
var enemySize = CGSize(width: 70, height: 70)
var enemyVelocity = CGFloat()
var enemyPosistion = CGPoint()

var starSize = CGSize()
var starVelocity = 0.1

enum physicCategories {
    static let playerTag: UInt32 = 0
    static let projectileTag: UInt32 = 1
    static let enemyTag: UInt32 = 2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        playerNode.size = playerSize
        playerNode.position = playerPostition
        playerNode.color = .orange
        self.addChild(playerNode)
        fireProjectiles()
        launchEnemy()
        moveStars()
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
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
        
        let wait = SKAction.wait(forDuration: 0.3)

        let sequence = SKAction.sequence([spawnProjectile, wait])
        let fire = SKAction.repeatForever(sequence)
        
        playerNode.run(fire)

    }
    
    fileprivate func spawnProjectile() {
        projectile = SKSpriteNode(color: .white, size: projectileSize)
        projectile.position = CGPoint(x: playerNode.position.x, y: playerNode.position.y + 40)
        
        projectile.physicsBody = SKPhysicsBody(rectangleOf: projectileSize)
        projectile.physicsBody?.affectedByGravity = false
        projectile.physicsBody?.allowsRotation = false
        projectile.physicsBody?.isDynamic = false
        projectile.physicsBody?.categoryBitMask = physicCategories.projectileTag
        projectile.physicsBody?.contactTestBitMask = physicCategories.enemyTag
        projectile.name = "projectileName"
        let moveProjectile = SKAction.moveTo(y: 700, duration: 0.8)
        let destroy = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([moveProjectile, destroy]))
        self.addChild(projectile)

    }
    
    fileprivate func moveStars() {
        let spawnStar = SKAction.run {
            self.spawnStars()
        }
        
        let wait = SKAction.wait(forDuration: 0.01)
        let sequence = SKAction.sequence([spawnStar, wait, spawnStar, wait, spawnStar, wait])
        let starRepeat = SKAction.repeatForever(sequence)
        self.run(starRepeat)
    }
    
    fileprivate func spawnStars() {
        let randomSize = CGFloat(arc4random_uniform(6) + 2)
        let star = SKSpriteNode()
        star.color = UIColor(red: 254/255, green: 1, blue: 166/255, alpha: 1)
        star.size = CGSize(width: randomSize, height: randomSize)
        star.position.y = 700
        var starXPosition: CGFloat = 0.0
        let randomQuadrant = CGFloat(arc4random_uniform(2))
        let randomXPosition = CGFloat(arc4random_uniform(365))
        
        if randomQuadrant == 0 {
            starXPosition = -randomXPosition
        } else {
            starXPosition = randomXPosition
        }
        
        star.position.x = starXPosition
        self.addChild(star)
        
        let move = SKAction.moveTo(y: -700, duration: 0.8)
        let destory = SKAction.removeFromParent()
        let sequence = SKAction.sequence([move, destory])
        star.run(sequence)

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        print("something")
        if ((firstBody.categoryBitMask == physicCategories.enemyTag) && (secondBody.categoryBitMask == physicCategories.projectileTag)) || (firstBody.categoryBitMask == physicCategories.projectileTag) && (secondBody.categoryBitMask == physicCategories.enemyTag){

        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        //Check for projectile and enemy collision

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
        enemy = SKSpriteNode(color: .cyan, size: enemySize)
        let randEnemySpawn = arc4random_uniform(300) + 1
        enemy.position.y = 900
        let randomQuad = CGFloat(arc4random_uniform(2))
        if randomQuad == 0 {
            enemy.position.x = -CGFloat(randEnemySpawn)
        } else {
            enemy.position.x = CGFloat(randEnemySpawn)
        }
        
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemySize)
        enemy.physicsBody?.allowsRotation = false
        enemy.physicsBody?.isDynamic = false
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.categoryBitMask = physicCategories.enemyTag
        enemy.physicsBody?.contactTestBitMask = physicCategories.projectileTag
        enemy.name = "enemyName"
        
        let moveEnemy = SKAction.moveTo(y: -700, duration: 1.5)
        let destroy = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveEnemy, destroy])
        enemy.run(sequence)
        
        self.addChild(enemy)
        
    }

    
    
}
