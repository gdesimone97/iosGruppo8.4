//
//  ViewController.swift
//  iGuitar
//
//  Created by Giuseppe De Simone on 10/07/2019.
//  Copyright © 2019 Giuseppe De Simone. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    
    @IBOutlet weak var label: UILabel!
    let session = WCSession.default
    var sessionStatus = WCSessionActivationState.notActivated // Stato della sessione
    var messageReceived: String?
    
    override func viewDidLoad() {
        session.delegate = self
        session.activate()
        sessionStatus = session.activationState
        label.text = "start"
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
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("Messaggio rivecuto")
        messageReceived = message["action"] as! String
        print("Iphone - Messaggio ricevuto: \(messageReceived)")
    }
    
    @IBAction func bottone(_ sender: Any) {
        label.text = "messageReceived"
    }
    
}

