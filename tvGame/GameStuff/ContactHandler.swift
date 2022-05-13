import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
	
	func didBegin(_ contact: SKPhysicsContact) {
		removeChildren(in: [disk!])
		disk?.position = CGPoint(x: screen.width/2, y: screen.height/2)
		addChild(disk!)
	}
	
}

