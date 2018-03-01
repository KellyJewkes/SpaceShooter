//
//  StartScreen.swift
//  SpaceShooter
//
//  Created by Kelly Jewkes on 3/1/18.
//  Copyright © 2018 LightWing. All rights reserved.
//

import SpriteKit
import GameplayKit
import  UIKit

class StartScreen: SKScene {
    
    var startButton: UIButton?
    var titleLabel: SKLabelNode?
    var highScore: SKLabelNode?
    
    override func didMove(to view: SKView) {
        
        self.titleLabel = SKLabelNode(fontNamed: "Avenir-Book")
        //self.startButton
        self.highScore = SKLabelNode(fontNamed: "Avenir-Book")
        
        self.titleLabel?.fontColor = UIColor.cyan
        //self.startButton
        self.highScore?.fontColor = UIColor.red
        
        self.titleLabel?.fontSize = 40
        //self.startButton
        self.highScore?.fontSize = 20
        
        self.titleLabel?.text = "Space Shooter"
        //self.startButton
        self.highScore?.text = "High Score"
        
        self.titleLabel?.name = "Title"
        //self.startButton
        self.highScore?.name = "High Score"
        
        self.titleLabel?.position = CGPoint(x: 100, y: 100)
        //self.startButton.position = CGPoint(x: 200, y: 200)
        self.highScore?.position = CGPoint(x: 300, y: 300)
        
        self.addChild(self.titleLabel!)
        //self.addChild(self.startLabel!)
        self.addChild(self.highScore!)
        
        
        
    }
    
    var shooterSlider = UISlider(frame:CGRect(x: 20, y: 260, width: 280, height: 20))
    
    
    
    
}



