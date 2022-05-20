import SpriteKit
import MultipeerConnectivity

class GameScene: SKScene {
		
	lazy var player1: Player = {
		let player = Player(radius: Sizes.playerRadius, color: .systemPurple)
		player.position = CGPoint(x: Sizes.screen.width*0.25, y: Sizes.screen.height/2)
		
		return player
	}()
	
	lazy var player2: Player = {
		let player = Player(radius: Sizes.playerRadius, color: .systemGreen)
		player.position = CGPoint(x: Sizes.screen.width*0.75, y: Sizes.screen.height/2)
		
		return player
	}()
	
	lazy var leftGoal: Goal = {
		let goal = Goal(size: Sizes.goal, label: rightLabel)
		goal.position = Positions.leftGoal
		
		return goal
	}()
	
	lazy var rightGoal: Goal = {
		let goal = Goal(size: Sizes.goal, label: leftLabel)
		goal.position = Positions.rightGoal
		
		return goal
	}()
	
	lazy var leftLabel = ScoreLabel(color: .systemPurple, sideMultiplier: 0.25)
	lazy var rightLabel = ScoreLabel(color: .systemGreen, sideMultiplier: 0.75)
	
	lazy var disk: SKShapeNode = {
		createDisk(radius: Sizes.diskRadius)
	}()
	    
    override func sceneDidLoad() {
		
		physicsWorld.contactDelegate = self
		
		// labels
		addChild(leftLabel)
		addChild(rightLabel)
		
		//goals
		addChild(leftGoal)
		addChild(rightGoal)
		
		//disk
		addChild(disk)
		
		addChild(player1)
		addChild(player2)
		
		addWalls()
    }
	
	//MARK: - Create and add nodes
	func createDisk(radius: CGFloat) -> SKShapeNode {
		let disk = SKShapeNode(circleOfRadius: radius)
		disk.fillColor = .systemRed
		disk.strokeColor = .black
		disk.position = CGPoint(x: Sizes.screen.width/2, y: Sizes.screen.height/2)
		
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
		node.physicsBody = body
		
		return node
	}
	
	func addWalls() {
		
		// walls
		let bottomWall = createWall(size: Sizes.hWall)
		bottomWall.position = Positions.topWall
		
		let topWall = createWall(size: Sizes.hWall)
		topWall.position = Positions.botWall
		
		let topLeftWall = createWall(size: Sizes.vWall)
		topLeftWall.position = Positions.topLeftWall
		
		let botLeftWall = createWall(size: Sizes.vWall)
		botLeftWall.position = Positions.botLeftWall
		
		let topRightWall = createWall(size: Sizes.vWall)
		topRightWall.position = Positions.topRightWall
		
		let botRightWall = createWall(size: Sizes.vWall)
		botRightWall.position = Positions.botRightWall
		
		// cima baixo
		addChild(topWall)
		addChild(bottomWall)
		
		// esquerda
		addChild(topLeftWall)
		addChild(botLeftWall)
		
		// direita
		addChild(topRightWall)
		addChild(botRightWall)
	}
	
}
