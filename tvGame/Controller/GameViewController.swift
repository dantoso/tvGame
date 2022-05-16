import SpriteKit
import MultipeerConnectivity

class GameViewController: UIViewController {

	lazy var id = MCPeerID(displayName: UIDevice.current.name)
	lazy var mcSession = MCSession(peer: id, securityIdentity: nil, encryptionPreference: .required)
	lazy var advertiser = MCAdvertiserAssistant(serviceType: "mdv-hm", discoveryInfo: nil, session: mcSession)
	
	var leftPID: MCPeerID? = nil
	var rightPID: MCPeerID? = nil
	
	lazy var scene = GameScene(size: view.bounds.size)
	
	let leftQueue = DispatchQueue(label: "left")
	let rightQueue = DispatchQueue(label: "right")
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
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
