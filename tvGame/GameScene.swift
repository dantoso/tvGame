import SpriteKit


class GameScene: SKScene {
	
	let screen = UIScreen.main.bounds
    
    override func sceneDidLoad() {
		let bottomWall = createWall(size: .init(width: screen.width, height: screen.height*0.05))
		bottomWall.position = CGPoint(x: screen.width/2, y: bottomWall.size.height/2)
		
		addChild(bottomWall)
    }
	
	func createWall(size: CGSize) -> SKSpriteNode {
		let node = SKSpriteNode(color: .systemRed, size: size)
		
		let body = SKPhysicsBody(rectangleOf: size)
		body.isDynamic = false
		node.physicsBody = body
		
		return node
	}
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
}
