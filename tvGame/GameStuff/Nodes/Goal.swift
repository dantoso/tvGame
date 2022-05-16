import SpriteKit

final class Goal: SKNode, Contactable {
	
	weak var label: ScoreLabel?
	var node: SKSpriteNode
	
	init(size: CGSize, label: ScoreLabel? = nil) {
		self.node = SKSpriteNode(color: .clear, size: size)
		self.label = label
		super.init()
		
		addPhysics()
		addChild(node)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func addPhysics() {
		let body = SKPhysicsBody(rectangleOf: node.size)
		body.isDynamic = false
		body.categoryBitMask = CollisionType.goal
		body.contactTestBitMask = CollisionType.disk
		body.restitution = 0
		body.friction = 1
		
		self.physicsBody = body
	}
	
	func contactBegin(with node: SKNode) {
		print("begin")
		label?.updateScore()
	}
	
	func contactEnd(with node: SKNode) {}
	
}
