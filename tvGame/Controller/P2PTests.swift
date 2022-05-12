import SpriteKit
import MultipeerConnectivity

extension GameViewController: MCSessionDelegate {
	
	func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
		switch state {
		case .notConnected:
			print("\(peerID.displayName): Disconnected")
			
		case .connecting:
			if session.connectedPeers.count == 3 {
				session.cancelConnectPeer(peerID)
			}
			print("\(peerID.displayName): Connecting...")
			
		case .connected:
			print("\(peerID.displayName): Connected!")
			
		@unknown default:
			print("some weird shit just happend")
		}
	}
	
	func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
		
		guard let string = String(data: data, encoding: .utf8) else {
			print("failed to convert data to string")
			return
		}
		let vector = NSCoder.cgVector(for: string)
		
		DispatchQueue.main.async { [weak self] in
			self?.scene.player?.physicsBody?.applyImpulse(vector)
		}
	}
	
	func startHosting() {
		advertiser = MCAdvertiserAssistant(serviceType: "mdv-hm", discoveryInfo: nil, session: mcSession)
		advertiser.start()
		print("hosting started")
	}
	
	func sendData() {
		
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
