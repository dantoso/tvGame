import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
	
	func didBegin(_ contact: SKPhysicsContact) {
		guard let nodeA = contact.bodyA.node,
			  let nodeB = contact.bodyB.node else {return}
		
		if nodeA.name == "left" || nodeB.name == "left" {
			rightLabel.updateLabel()
			removeChildren(in: [disk])
			disk.position = CGPoint(x: screen.width/2, y: screen.height/2)
			addChild(disk)
		}
		else {
			leftLabel.updateLabel()
			removeChildren(in: [disk])
			disk.position = CGPoint(x: screen.width/2, y: screen.height/2)
			addChild(disk)
		}
		
		removeChildren(in: [disk!])
		disk?.position = CGPoint(x: screen.width/2, y: screen.height/2)
		addChild(disk!)
	}
	
}

