import SpriteKit
import MultipeerConnectivity

class GameViewController: UIViewController {

	var id: MCPeerID!
	var mcSession: MCSession!
	var advertiser: MCAdvertiserAssistant!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		id = MCPeerID(displayName: UIDevice.current.name)
		mcSession = MCSession(peer: id, securityIdentity: nil, encryptionPreference: .required)
		mcSession.delegate = self
		
		view = SKView(frame: view.bounds)
		let scene = GameScene(size: view.bounds.size)
		
		// Set the scale mode to scale to fit the window
		scene.scaleMode = .aspectFill
		
		// Present the scene
		if let view = self.view as! SKView? {
			view.presentScene(scene)
			
			view.ignoresSiblingOrder = true
			
			view.showsFPS = true
			view.showsNodeCount = true
			view.showsPhysics = true
			view.preferredFramesPerSecond = 60
		}
		
		startHosting()
	}

}
