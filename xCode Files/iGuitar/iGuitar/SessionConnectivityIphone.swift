//
//  SessionConnectivityIphone.swift
//  iGuitar
//
//  Created by Giuseppe De Simone on 10/07/2019.
//  Copyright © 2019 Giuseppe De Simone. All rights reserved.
//

import UIKit
import WatchConnectivity

class SessionConnectivityIphone: NSObject, WCSessionDelegate {
    
    let session = WCSession.default
    var sessionStatus = WCSessionActivationState.notActivated // Stato della sessione
    var messageReceived: Bool?
    
    override init() {
        super.init()
        session.delegate = self
        session.activate()
        sessionStatus = session.activationState
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Sessione Conclusa")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Sessione Inattiva")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Sessione Disattivata")
    }
    
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        messageReceived = message["action"] as! Bool
        print("Iphone - Messaggio ricevuto")
        print("Iphone - Messaggio ricevuto: \(messageReceived)")
    }
}
