import SpriteKit

protocol Contactable {
	func contactBegin(with node: SKNode)
	func contactEnd(with node: SKNode)
}

extension GameScene: SKPhysicsContactDelegate {
	
	func didBegin(_ contact: SKPhysicsContact) {
		guard let nodeA = contact.bodyA.node,
			  let nodeB = contact.bodyB.node else {return}
				
		if let node = nodeA as? Contactable {
			node.contactBegin(with: nodeB)
		}
		else {
			(nodeB as! Contactable).contactBegin(with: nodeA)
		}
		
		resetDisk()
//		if nodeA.name == "left" || nodeB.name == "left" {
//			updateScore(label: rightLabel)
//		}
//		else {
//			updateScore(label: leftLabel)
//		}
	}
	
	func resetDisk() {
		removeChildren(in: [disk])
		disk.position = CGPoint(x: Sizes.screen.width/2, y: Sizes.screen.height/2)
		addChild(disk)
	}
	
}

