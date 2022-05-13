import SpriteKit


final class ScoreLabelNode: SKNode {
	
	let screen = UIScreen.main.bounds
	
	private var score: Int
	private var label: SKLabelNode
	
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
	
	func updateLabel() {
		score += 1
		label.text = "\(score)"
	}
	
	
}
