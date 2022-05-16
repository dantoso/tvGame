import UIKit

struct CollisionType {
	static let disk: UInt32 = 1
	static let wall: UInt32 = 2
	static let goal: UInt32 = 4
	static let player: UInt32 = 8
}

struct Sizes {
	static let screen = UIScreen.main.bounds.size
	static let hWall = CGSize(width: screen.width, height: screen.height*0.02)
	static let vWall = CGSize(width: hWall.height, height: screen.height*0.3)
	static let goal = CGSize(width: vWall.width*0.2, height: screen.height-hWall.height*2-vWall.height*2)
	static let playerRadius = goal.height*0.18
	static let diskRadius = playerRadius/2
	
}

struct Positions {
	
	static let topWall = CGPoint(x: Sizes.screen.width/2, y: Sizes.screen.height-Sizes.hWall.height/2)
	static let botWall = CGPoint(x: Sizes.screen.width/2, y: Sizes.hWall.height/2)
	
	static let right = Sizes.screen.width - Sizes.vWall.width/2
	static let left = Sizes.vWall.width/2
	static let top = Sizes.screen.height - Sizes.hWall.height - Sizes.vWall.height/2
	static let bot = Sizes.hWall.height + Sizes.vWall.height/2
	
	static let topLeftWall = CGPoint(x: left, y: top)
	static let botLeftWall = CGPoint(x: left, y: bot)
	static let topRightWall = CGPoint(x: right, y: top)
	static let botRightWall = CGPoint(x: right, y: bot)
	
	static let leftGoal = CGPoint(x: Sizes.goal.width/2, y: Sizes.screen.height/2)
	static let rightGoal = CGPoint(x: Sizes.screen.width-Sizes.goal.width/2, y: Sizes.screen.height/2)
	
}
