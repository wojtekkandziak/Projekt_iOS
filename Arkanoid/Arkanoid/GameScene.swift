//
//  GameScene.swift
//  Arkanoid
//
//  Created by Wojtek on 25.03.2018.
//  Copyright © 2018 Wojtek. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball:SKSpriteNode!
    var paddle:SKSpriteNode!
    var score: Int = 0
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "Ball") as! SKSpriteNode
        paddle = self.childNode(withName: "Paddle") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
        
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        self.physicsBody = border
        
        self.physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            paddle.position.x = touchLocation.x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            paddle.position.x = touchLocation.x
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyAName = contact.bodyA.node?.name
        let bodyBName = contact.bodyB.node?.name
        
        if bodyAName == "Ball" && bodyBName == "Brick" || bodyAName == "Brick" && bodyBName == "Ball" {
            if bodyAName == "Brick" {
                score += 1
                contact.bodyA.node?.removeFromParent()
                
                if score == 9 {
                    ball.physicsBody?.applyImpulse(CGVector(dx: -50, dy: -50))
                }
                    
            } else if bodyBName == "Brick" {
                contact.bodyB.node?.removeFromParent()
            }
        }
        
        if ball.position.y < -400 {
            ball.physicsBody?.applyImpulse(CGVector(dx: -50, dy: -50))
        }
    }
}
