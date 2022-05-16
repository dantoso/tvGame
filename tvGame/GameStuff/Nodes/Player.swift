import SpriteKit
import MultipeerConnectivity

final class Player: SKNode {
	
	var id: MCPeerID?
	private var queue: DispatchQueue?
	private let node: SKShapeNode
	
	init(radius: CGFloat, id: MCPeerID? = nil) {
		self.node = SKShapeNode(circleOfRadius: radius)
		self.id = id
		if let id = id {
			self.queue = DispatchQueue(label: id.displayName)
		}
		super.init()
		
		addPhysics()
		addChild(node)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func addPhysics() {
		let body = SKPhysicsBody(circleOfRadius: node.frame.size.width/2)
		body.categoryBitMask = CollisionType.player
		body.collisionBitMask = CollisionType.wall + CollisionType.goal + CollisionType.player
		body.affectedByGravity = false
		body.linearDamping = 1
		body.restitution = 0.1
		
		node.physicsBody = body
	}
	
	func processData(_ data: Data) {
		queue?.async { [weak self] in
			guard let string = String(data: data, encoding: .utf8) else {
				print("failed to convert data to string")
				return
			}
			
			let vector = NSCoder.cgVector(for: string)
			self?.node.physicsBody?.applyImpulse(vector)
		}
		
	}
	
}
