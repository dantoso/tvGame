import SpriteKit
import MultipeerConnectivity

class GameViewController: UIViewController {

	var id: MCPeerID!
	var mcSession: MCSession!
	var advertiser: MCAdvertiserAssistant!
	
	var leftPID: MCPeerID? = nil
	var rightPID: MCPeerID? = nil
	
	lazy var scene = GameScene(size: view.bounds.size)
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		id = MCPeerID(displayName: UIDevice.current.name)
		mcSession = MCSession(peer: id, securityIdentity: nil, encryptionPreference: .required)
		mcSession.delegate = self
		
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
		
		startHosting()
	}

}
