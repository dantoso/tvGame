import SpriteKit

protocol Contactable {
	func contactBegin(with node: SKNode)
	func contactEnd(with node: SKNode)
}

extension Contactable {
	func contactBegin(with node: SKNode) {}
	func contactEnd(with node: SKNode) {}
}

extension SKNode: Contactable {}


extension GameScene: SKPhysicsContactDelegate {
	
	func didBegin(_ contact: SKPhysicsContact) {
		guard let nodeA = contact.bodyA.node,
			  let nodeB = contact.bodyB.node else {return}
		
		nodeA.contactBegin(with: nodeB)
		nodeB.contactBegin(with: nodeA)
		
		if nodeA.name == "left" || nodeB.name == "left" {
			updateScore(label: rightLabel)
		}
		else {
			updateScore(label: leftLabel)
		}
	}
	
	func updateScore(label: ScoreLabel) {
		label.updateScore()
		removeChildren(in: [disk])
		disk.position = CGPoint(x: screen.width/2, y: screen.height/2)
		addChild(disk)
	}
	
}

