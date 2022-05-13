import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
	
	func didBegin(_ contact: SKPhysicsContact) {
		guard let size = leftPlayer?.frame.size else {fatalError()}
		removeChildren(in: [disk!])
		disk = createDisk(radius: size.width*0.5)
		addChild(disk!)
	}
	
}

