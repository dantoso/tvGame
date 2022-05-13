import SpriteKit
import MultipeerConnectivity

extension GameViewController: MCSessionDelegate {
	
	func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
		switch state {
		case .notConnected:
			if peerID == leftPID {
				leftPID = nil
			}
			else if peerID == rightPID {
				rightPID = nil
			}
			print("\(peerID.displayName): Disconnected")
			
		case .connecting:
			if session.connectedPeers.count == 3 {
				session.cancelConnectPeer(peerID)
			}
			print("\(peerID.displayName): Connecting...")
			
		case .connected:
			if leftPID == nil {
				leftPID = peerID
				let purple = UIColor.systemPurple
				do {
					let data = try NSKeyedArchiver.archivedData(withRootObject: purple, requiringSecureCoding: false) as Data?
					
					sendData(data, to: [peerID])
				}
				catch {
					fatalError()
				}
				print("\(peerID.displayName): Connected to left player!")
			}
			else if rightPID == nil {
				rightPID = peerID
				let green = UIColor.systemGreen
				do {
					let data = try NSKeyedArchiver.archivedData(withRootObject: green, requiringSecureCoding: false) as Data?
					sendData(data, to: [peerID])
				}
				catch {
					fatalError()
				}
				print("\(peerID.displayName): Connected to right player!")
			}
			
		@unknown default:
			print("some weird shit just happend")
		}
	}
	
	func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
		var queue: DispatchQueue
		if peerID == leftPID {
			queue = leftQueue
		}
		else {
			queue = rightQueue
		}
		queue.async { [weak self] in
			guard let string = String(data: data, encoding: .utf8) else {
				print("failed to convert data to string")
				return
			}
			let vector = NSCoder.cgVector(for: string)
			
			let player = peerID == self?.leftPID ? self?.scene.leftPlayer : self?.scene.rightPlayer
			
			 DispatchQueue.main.async {
				player?.physicsBody?.applyImpulse(vector)
			}
		}
	}
	
	func startHosting() {
		advertiser = MCAdvertiserAssistant(serviceType: "mdv-hm", discoveryInfo: nil, session: mcSession)
		advertiser.start()
		print("hosting started")
	}
	
	func sendData(_ data: Data?, to peers: [MCPeerID]) {
		guard mcSession.connectedPeers.count > 0 else {return}
		guard let realData = data else {return}
		do {
			try mcSession.send(realData, toPeers: peers, with: .reliable)
			print("data from \(id.displayName) sent")
		}
		catch let error as NSError {
		   let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
		   ac.addAction(UIAlertAction(title: "OK", style: .default))
		   present(ac, animated: true)
	   }
	}
	
	func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
		
	}
	
	func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
		
	}
	
	func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
		
	}
	
}

extension GameViewController: MCBrowserViewControllerDelegate {
	
//	func browserViewController(_ browserViewController: MCBrowserViewController, shouldPresentNearbyPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) -> Bool {
//		<#code#>
//	}
//
	func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
		dismiss(animated: true, completion: nil)
	}
	
	func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
		dismiss(animated: true, completion: nil)
	}
	
}
