import SpriteKit


final class ScoreLabel: SKNode {
	
	let screen = UIScreen.main.bounds
	
	private var label: SKLabelNode
	private var score: Int {
		didSet {
			label.text = "\(score)"
		}
	}
	
	init(color: UIColor, sideMultiplier: CGFloat, score: Int = 0) {
		self.score = score
		label = SKLabelNode(text: "\(score)")
		
		label.color = color
		label.position = CGPoint(x: screen.width*sideMultiplier, y: screen.height*0.75)
		label.fontSize = 200
		
		super.init()
		
		addChild(label)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func updateScore() {
		score += 1
	}
	
	func reset() {
		score = 0
	}
	
}
