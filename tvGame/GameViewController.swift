import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		view = SKView()

        let scene = GameScene()
		
		// Set the scale mode to scale to fit the window
		scene.scaleMode = .aspectFill
		
		// Present the scene
		if let view = self.view as! SKView? {
			view.presentScene(scene)
			
			view.ignoresSiblingOrder = true
			
			view.showsFPS = true
			view.showsNodeCount = true
			view.preferredFramesPerSecond = 60
		}
	}

}
