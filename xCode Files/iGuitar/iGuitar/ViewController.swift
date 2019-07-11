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
    var session = WCSession.default
    var sessionStatus: WCSessionActivationState? // Stato della sessione
    var messageReceived: Bool?
    var count: Int = 0
    
    override func viewDidLoad() {
        session.delegate = self
        session.activate()
        sleep(2)
        sessionStatus = session.activationState
        label.text = "start"
    }
    
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if(activationState == WCSessionActivationState.activated){
            print("Sessione Attivata")
        }
        else {
            print("Sessione non attiva")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) { print("Sessione Inattiva") }
    
    func sessionDidDeactivate(_ session: WCSession) { print("Sessione Disattivata") }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("Messaggio rivecuto")
        messageReceived = message["action"] as! Bool
        self.count+=1
        DispatchQueue.main.async {
            self.label.text = String(self.messageReceived!) + " " + String(self.count)
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        count = 0
        label.text = "start"
        
    }
}

