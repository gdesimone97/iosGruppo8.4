//
//  ViewController.swift
//  iGuitar
//
//  Created by Giuseppe De Simone on 10/07/2019.
//  Copyright © 2019 Giuseppe De Simone. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController {
    var session = WCSession.default
    
    
    @IBOutlet weak var label: UILabel!
    var messageReceived: Bool?
    var count: Int = 0

    
    @IBAction func reset(_ sender: Any) {
        count = 0
        label.text = "start"
        
    }
}

extension ViewController: WCSessionDelegate {
    
    override func viewDidLoad() {
        label.text = "start"
        session.delegate = self
        session.activate()
        sleep(2)
    }
    
    var sessionStatus: WCSessionActivationState {
        get {
            return session.activationState
        }
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
}
