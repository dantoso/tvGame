import SpriteKit

class GameScene: SKScene {
	
	let screen = UIScreen.main.bounds
	
	var leftPlayer: SKShapeNode!
	var rightPlayer: SKShapeNode!
	
	var leftGoal: SKSpriteNode!
	var rightGoal: SKSpriteNode!
	
	lazy var leftLabel = ScoreLabelNode(color: .systemPurple, sideMultiplier: 0.25)
	lazy var rightLabel = ScoreLabelNode(color: .systemGreen, sideMultiplier: 0.75)
	
	var disk: SKShapeNode!
	    
    override func sceneDidLoad() {
		
		physicsWorld.contactDelegate = self
		
		addChild(leftLabel)
		addChild(rightLabel)
		addNodes()
    }
	
	//MARK: - Create and add nodes
	func createPlayer(radius: CGFloat) -> SKShapeNode {
		let player = SKShapeNode(circleOfRadius: radius)
		player.strokeColor = .black
		player.position = CGPoint(x: screen.width/2, y: screen.height/2)
		
		let body = SKPhysicsBody(circleOfRadius: radius)
		body.categoryBitMask = CollisionType.player
		body.collisionBitMask = CollisionType.wall + CollisionType.goal + CollisionType.player
		body.affectedByGravity = false
		body.linearDamping = 1
		body.restitution = 0.1
		player.physicsBody = body
		
		return player
	}
	
	func createDisk(radius: CGFloat) -> SKShapeNode {
		let disk = SKShapeNode(circleOfRadius: radius)
		disk.fillColor = .systemRed
		disk.strokeColor = .black
		disk.position = CGPoint(x: screen.width/2, y: screen.height/2)
		
		let body = SKPhysicsBody(circleOfRadius: radius)
		body.categoryBitMask = CollisionType.disk
		body.collisionBitMask = CollisionType.wall + CollisionType.goal + CollisionType.player
		body.contactTestBitMask = CollisionType.goal
		body.affectedByGravity = false
		body.linearDamping = 0.2
		body.restitution = 0.8
		body.friction = 0.7
		disk.physicsBody = body
		
		return disk
	}
	
	func createWall(size: CGSize) -> SKSpriteNode {
		let node = SKSpriteNode(color: .systemRed, size: size)
		
		let body = SKPhysicsBody(rectangleOf: size)
		body.isDynamic = false
		body.categoryBitMask = CollisionType.wall
		body.restitution = 0.1
		body.friction = 0.8
		node.physicsBody = body
		
		return node
	}
	
	func createGoal(size: CGSize) -> SKSpriteNode {
		let node = SKSpriteNode(color: .clear, size: size)
		
		let body = SKPhysicsBody(rectangleOf: size)
		body.isDynamic = false
		body.categoryBitMask = CollisionType.goal
		body.contactTestBitMask = CollisionType.disk
		body.restitution = 0
		body.friction = 1
		node.physicsBody = body
		
		return node
	}
	
	func addNodes() {
		
		// walls
		let hWallSize = CGSize(width: screen.width, height: screen.height*0.02)
		let vWallSize = CGSize(width: hWallSize.height, height: screen.height*0.3)
		
		let xRight = screen.width - vWallSize.width/2
		let xLeft = vWallSize.width/2
		let yUp = screen.height - hWallSize.height - vWallSize.height/2
		let yBot = hWallSize.height + vWallSize.height/2
				
		let bottomWall = createWall(size: hWallSize)
		bottomWall.position = CGPoint(x: screen.width/2, y: hWallSize.height/2)
		
		let topWall = createWall(size: hWallSize)
		topWall.position = CGPoint(x: screen.width/2, y: screen.height-hWallSize.height/2)
		
		let upLeftWall = createWall(size: vWallSize)
		upLeftWall.position = CGPoint(x: xLeft, y: yUp)
		
		let botLeftWall = createWall(size: vWallSize)
		botLeftWall.position = CGPoint(x: xLeft, y: yBot)
		
		let upRightWall = createWall(size: vWallSize)
		upRightWall.position = CGPoint(x: xRight, y: yUp)
		
		let botRightWall = createWall(size: vWallSize)
		botRightWall.position = CGPoint(x: xRight, y: yBot)
		
		// cima baixo
		addChild(topWall)
		addChild(bottomWall)
		
		// esquerda
		addChild(upLeftWall)
		addChild(botLeftWall)
		
		// direita
		addChild(upRightWall)
		addChild(botRightWall)
		
		//goals
		let goalSize = CGSize(width: vWallSize.width*0.2, height: screen.height-hWallSize.height*2-vWallSize.height*2)
		
		leftGoal = createGoal(size: goalSize)
		leftGoal.position = CGPoint(x: goalSize.width/2, y: screen.height/2)
		leftGoal.name = "left"
		
		rightGoal = createGoal(size: goalSize)
		rightGoal.position = CGPoint(x: screen.width-goalSize.width/2, y: screen.height/2)
		rightGoal.name = "right"
		
		addChild(leftGoal)
		addChild(rightGoal)
		
		// player
		leftPlayer = createPlayer(radius: goalSize.height*0.18)
		leftPlayer.position.x = screen.width*0.25
		leftPlayer.fillColor = .systemPurple
		
		rightPlayer = createPlayer(radius: goalSize.height*0.18)
		rightPlayer.position.x = screen.width*0.75
		rightPlayer.fillColor = .systemGreen
		
		addChild(leftPlayer)
		addChild(rightPlayer)
		
		//disk
		disk = createDisk(radius: goalSize.height*0.09)
		addChild(disk)
	}
	
}
