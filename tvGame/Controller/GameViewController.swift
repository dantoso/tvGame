import SpriteKit
import MultipeerConnectivity
import SwiftP2PConnector

final class GameViewController: UIViewController, ReceiveDelegate {

	lazy var scene = GameScene(size: view.bounds.size)
	var commandDictionary: [String : Command] = [:]
	
    override func viewDidLoad() {
        super.viewDidLoad()
				
		view = SKView(frame: view.bounds)
		
		// Set the scale mode to scale to fit the window
		scene.scaleMode = .aspectFill
		
		// Present the scene
		if let view = self.view as! SKView? {
			
			view.ignoresSiblingOrder = true
			
			view.showsFPS = true
			view.showsNodeCount = true
			view.showsPhysics = true
			view.preferredFramesPerSecond = 60
			
			view.presentScene(scene)
		}
		
		P2PConnector.startHosting()
	}

	func didReceiveKey(_ key: String, from peerID: MCPeerID) {}
	
	func didReceiveData(_ data: Data, from peerID: MCPeerID) {
		if scene.player1.id == peerID {
			scene.player1.processData(data)
		}
		else {
			scene.player2.processData(data)
		}
	}
}
