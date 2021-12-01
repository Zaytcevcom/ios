//
//  GameScene.swift
//  Snake
//
//  Created by Konstantin Zaytcev on 01.12.2021.
//

import SpriteKit
import GameplayKit

struct CollisionCategory {
    static let Snake: UInt32 = 0x1 << 0 // 0001 2
    static let SnakeHead: UInt32 = 0x1 << 1 // 0010 4
    static let Apple: UInt32 = 0x1 << 2 // 0100 8
    static let EdgeBody: UInt32 = 0x1 << 3 // 1000 16
}

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var snake: Snake?
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .black
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        self.physicsWorld.contactDelegate = self
        
        view.showsPhysics = true
        
        let counterClockwiseButton = SKShapeNode()
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50)).cgPath
        
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY + 50)
        counterClockwiseButton.fillColor = .gray
        counterClockwiseButton.strokeColor = .lightGray
        counterClockwiseButton.lineWidth = 5
        counterClockwiseButton.name = "counterClockwiseButton"
        
        self.addChild(counterClockwiseButton)
        
        
        let clockwiseButton = SKShapeNode()
        clockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50)).cgPath
        
        clockwiseButton.position = CGPoint(x: view.scene!.frame.maxX - 90, y: view.scene!.frame.minY + 50)
        clockwiseButton.fillColor = .gray
        clockwiseButton.strokeColor = .lightGray
        clockwiseButton.lineWidth = 5
        clockwiseButton.name = "clockwiseButton"
        
        self.addChild(clockwiseButton)
        
        createApple()
        
        createSnake()
        
        self.physicsBody?.categoryBitMask = CollisionCategory.EdgeBody
        self.physicsBody?.collisionBitMask = CollisionCategory.Snake | CollisionCategory.SnakeHead
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode, touchNode.name == "counterClockwiseButton" || touchNode.name == "clockwiseButton" else {
                return
            }
            
            touchNode.fillColor = .orange
            
            if touchNode.name == "counterClockwiseButton" {
                
                snake!.moveCounterClockewise()
                
            } else if touchNode.name == "clockwiseButton" {
                
                snake!.moveClockewise()
                
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode, touchNode.name == "counterClockwiseButton" || touchNode.name == "clockwiseButton" else {
                return
            }
            
            touchNode.fillColor = .gray
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        snake!.move()
    }
    
    func createApple() {
        
        let randX = CGFloat(20 + arc4random_uniform(UInt32(view!.scene!.frame.maxX - 40)))
        let randY = CGFloat(200 + arc4random_uniform(UInt32(view!.scene!.frame.maxY - 400)))
        
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        
        self.addChild(apple)
    }
    
    func createSnake() {
        
        snake?.removeFromParent()
        
        snake = Snake(atPoint: CGPoint(x: view!.scene!.frame.midX, y: view!.scene!.frame.midX))
        
        self.addChild(snake!)
    
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        let collisionObject = bodyes - CollisionCategory.SnakeHead
        
        switch collisionObject {
            
        case CollisionCategory.Apple:
            
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.addBodyPart()
            apple?.removeFromParent()
            createApple()
            
        case CollisionCategory.EdgeBody:
            
            createSnake()
            
        default: break
        }
    }
}
