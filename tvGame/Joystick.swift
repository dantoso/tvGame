import SpriteKit

extension CGVector {
	var intensity: CGFloat {
		let dxSqr = dx*dx
		let dySqr = dy*dy
		
		return sqrt(dxSqr+dySqr)
	}
}

final class Joystick: SKNode {
	
	var vector = CGVector.zero
//	{
//		didSet {
//			if vector.dx > maxLimit {
//				vector.dx = maxLimit
//			}
//			else if vector.dx < -maxLimit {
//				vector.dx = -maxLimit
//			}
//			if vector.dy > maxLimit {
//				vector.dy = maxLimit
//			}
//			else if vector.dy < -maxLimit {
//				vector.dy = -maxLimit
//			}
//		}
//	}
	
	var isTouched = false
	
	var player: SKShapeNode?
	let maxLimit: CGFloat = 200
	let minLimit: CGFloat = 5

	///Define o tamanho da área em que o joystick percebe toques
	private var touchableArea: SKShapeNode!
	
	///Referencial para o centro do joystick.
	///Esse ponto é usado como referência para todo o funcionamento do joystick
	private var center: CGPoint?
	
	///Ponto onde o usuário está pressionando, atualizado em tempo real
	private var touchLocation: CGPoint?
	
	var touchTime: CFTimeInterval?
	
	///Get-only-property: distância entre center e touchLocation no eixo X
	///caso um dos dois não existam, retorna 0
	private var xDistance: CGFloat {
		guard let centerX = center?.x,
			  let touchX = touchLocation?.x
		else {return 0}
		
		return touchX - centerX
	}
	///Get-only-property: distância entre center e touchLocation no eixo Y
	///caso um dos dois não existam, retorna 0
	private var yDistance: CGFloat {
		guard let centerY = center?.y,
			  let touchY = touchLocation?.y
		else {return 0}
		
		return touchY - centerY
	}


	init(rect: CGRect) {
		super.init()
		isUserInteractionEnabled = true
		touchableArea = SKShapeNode(rect: rect)
		touchableArea.strokeColor = .clear
		addChild(touchableArea)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard !isTouched else {return}
		isTouched = true
		center = touches.first?.location(in: self)
		touchTime = CACurrentMediaTime()
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first,
		let touchTime = self.touchTime else {return}
		
		guard CACurrentMediaTime() - touchTime > 0.05 else {return}
		
		touchLocation = touch.location(in: self)
		vector = CGVector(dx: xDistance*0.1, dy: yDistance*0.1)
		center = touchLocation
		movePlayer()
		self.touchTime = CACurrentMediaTime()
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touchTime = self.touchTime else {
			reset()
			return
		}
		guard CACurrentMediaTime() - touchTime > 0.05 else {
			reset()
			return
		}
		vector = CGVector(dx: xDistance*0.05, dy: yDistance*0.05)
		movePlayer()
		reset()
	}
	
	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touchTime = self.touchTime else {
			reset()
			return
		}
		guard CACurrentMediaTime() - touchTime > 0.05 else {
			reset()
			return
		}
		vector = CGVector(dx: xDistance*0.05, dy: yDistance*0.05)
		movePlayer()
		reset()
	}
	
	/// Reseta o joystick para o seu estado inicial
	func reset() {
		vector = .zero
		isTouched = false
		center = nil
		touchLocation = nil
		touchTime = nil
	}
}

extension Joystick {
	
	func movePlayer() {
		guard let body = player?.physicsBody else {return}

		body.applyImpulse(vector)
	}
	
	///Atualiza o referencial para o centro do joystick
	private func updateCenterLocation() {
		if xDistance > maxLimit {
			center!.x += xDistance - maxLimit
		}
		else if xDistance < -maxLimit {
			center!.x += xDistance + maxLimit
		}
		
		if yDistance > maxLimit {
			center!.y += yDistance - maxLimit
		}
		else if yDistance < -maxLimit {
			center!.y += yDistance + maxLimit
		}
		
	}

}

