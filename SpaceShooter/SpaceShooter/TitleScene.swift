//
//  TitleSceen.swift
//  SpaceShooter
//
//  Created by Andrew Foghel on 3/1/18.
//  Copyright © 2018 LightWing. All rights reserved.
//

import Foundation
import SpriteKit

var btnPlay: UIButton!
var gameTitle: UILabel!
var slider: UISlider!


class TitleScene: SKScene{
    
    override func didMove(to view: SKView) {
        
        isAlive = true
        score = 0
        setupUI()
        
    }
    
    
    
    func setupUI(){
        btnPlay = UIButton(frame: CGRect(x: 100, y: 100, width: self.view!.frame.width, height: 100))
        btnPlay.center = CGPoint(x: view!.frame.midX, y: view!.frame.midY - 50)
        btnPlay.titleLabel?.font = UIFont(name: "Avenir Next", size: 60)
        btnPlay.setTitle("PLAY", for: .normal)
        btnPlay.setTitleColor(.white, for: .normal)
        btnPlay.setTitleShadowColor(.black, for: .normal)
        btnPlay.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)
        self.view?.addSubview(btnPlay)
        
        gameTitle = UILabel(frame: CGRect(x: 0, y: 0, width: view!.frame.width, height: 100))
        gameTitle.textColor = .white
        gameTitle.font = UIFont(name: "Avenir Next", size: 60)
        gameTitle.textAlignment = .center
        gameTitle.text = "SHOOTER"
        self.view?.addSubview(gameTitle)
        
        slider = UISlider()
        slider.minimumValue = 0.1
        slider.maximumValue = 1
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        slider.frame = CGRect(x: 30, y: btnPlay.frame.maxY + 40, width: self.view!.frame.width - 60, height: 30)
        self.view?.addSubview(slider)
    }
    
    @objc func handleSlider() {
        enemyVelocity = Double(slider.value)
    }
    
    @objc func handlePlay(){
        self.view?.presentScene(GameScene(), transition: SKTransition.doorway(withDuration: 0.5))
        
        btnPlay.removeFromSuperview()
        gameTitle.removeFromSuperview()
        slider.removeFromSuperview()
        
        if let scene = TitleScene(fileNamed: "GameScene"){
            let skview = self.view! as SKView
            scene.scaleMode = .aspectFill
            skview.presentScene(scene)
        }
        
        
    }
    
    
}
