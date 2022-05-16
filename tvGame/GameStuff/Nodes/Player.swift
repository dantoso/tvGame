import SpriteKit
import MultipeerConnectivity

final class Player: SKNode {
	
	var id: MCPeerID? {
		didSet {
			guard let id = id else {
				queue = nil
				return
			}
			queue = DispatchQueue(label: id.displayName)
		}
	}
	private var queue: DispatchQueue?
	private let node: SKShapeNode
	
	init(radius: CGFloat, color: UIColor, id: MCPeerID? = nil) {
		self.node = SKShapeNode(circleOfRadius: radius)
		node.fillColor = color
		self.id = id
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
		body.mass *= 0.5
		
		node.physicsBody = body
	}
	
	func processData(_ data: Data) {
		queue?.async { [weak self] in
			guard let string = String(data: data, encoding: .utf8) else {
				print("failed to convert data to string")
				return
			}
			
			let vector = NSCoder.cgVector(for: string)
			DispatchQueue.main.async {
				self?.node.physicsBody?.applyImpulse(vector)
			}
		}
		
	}
	
}
