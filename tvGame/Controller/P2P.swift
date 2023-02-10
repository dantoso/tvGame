import SpriteKit
import MultipeerConnectivity
import SwiftP2PConnector

enum CommandKeys: String {
	case changeColorToGreen
	case changeColorToPurple
}

extension GameViewController: ConnectionDelegate {
	
	func didDisconnect(with peerID: MCPeerID) {
		if scene.player1.id == peerID {
			scene.player1.id = nil
		}
		else if scene.player2.id == peerID {
			scene.player2.id = nil
		}
		print("\(peerID.displayName): Disconnected")
	}
	
	func isConnecting(with peerID: MCPeerID) {
		print("\(peerID.displayName): Connecting...")
	}
	
	func didConnect(with peerID: MCPeerID) {
		if scene.player1.id == nil {
			scene.player1.id = peerID
			P2PConnector.sendKey(CommandKeys.changeColorToGreen.rawValue, to: [peerID])
			print("\(peerID.displayName): Connected to left player!")
		}
		
		else if scene.player2.id == nil {
			scene.player2.id = peerID
			P2PConnector.sendKey(CommandKeys.changeColorToPurple.rawValue, to: [peerID])
			print("\(peerID.displayName): Connected to right player!")
		}
		
		if P2PConnector.connectedPeers.count > 2 {
			P2PConnector.stopHosting()
		}
	}
}
