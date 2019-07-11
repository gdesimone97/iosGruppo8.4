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
    var session: WCSession?
    var sessionStatus = WCSessionActivationState.notActivated // Stato della sessione
    var messageReceived: String?
    var count: Int = 0
    

    
    override func viewDidLoad() {
//        session.delegate = self
//        session.activate()
//        sessionStatus = session.activationState
        label.text = "start"
        session = Session.retriveSession()
        session!.delegate = self
        sessionStatus = session!.activationState
        print(sessionStatus == WCSessionActivationState.activated)
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
        self.count+=1
        DispatchQueue.main.async {
            self.label.text = self.messageReceived! + " " + String(self.count)
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        self.label.text = "start"
        count = 0
    }
    
}

