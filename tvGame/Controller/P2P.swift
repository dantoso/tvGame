import SpriteKit
import MultipeerConnectivity

extension GameViewController: MCSessionDelegate {
	
	func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
		switch state {
		case .notConnected:
			if scene.player1.id == peerID {
				scene.player1.id = nil
			}
			else if scene.player2.id == peerID {
				scene.player2.id = nil
			}
			print("\(peerID.displayName): Disconnected")
			
		case .connecting:
			print("\(peerID.displayName): Connecting...")
			
		case .connected:
			if scene.player1.id == nil {
				scene.player1.id = peerID
				
				let data = encodeColor(.systemPurple)
				sendData(data, to: [peerID])
				
				print("\(peerID.displayName): Connected to left player!")
			}
			
			else if scene.player2.id == nil {
				scene.player2.id = peerID

				let data = encodeColor(.systemGreen)
				sendData(data, to: [peerID])
				
				print("\(peerID.displayName): Connected to right player!")
			}
			
			if mcSession.connectedPeers.count > 2 {
				advertiser.stop()
			}
			
		@unknown default:
			print("some weird shit just happend")
		}
	}
	
	func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
		if scene.player1.id == peerID {
			scene.player1.processData(data)
		}
		else if scene.player2.id == peerID {
			scene.player2.processData(data)
		}
	}
	
	func startHosting() {
		advertiser.start()
		print("hosting started")
	}
	
	func encodeColor(_ color: UIColor) -> Data? {
		let data = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) as Data?
		return data
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
