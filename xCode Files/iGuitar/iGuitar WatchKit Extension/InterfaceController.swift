//
//  InterfaceController.swift
//  iGuitar WatchKit Extension
//
//  Created by Giuseppe De Simone on 10/07/2019.
//  Copyright © 2019 Giuseppe De Simone. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var stateLabel: WKInterfaceLabel!
    let session = SessionManager.share
    // Stato della connessione, se true può inviare messaggi
    var action = false // Azione dell' utente
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
            if (session.checkConnection()) {
            stateLabel.setText("Connected")
            stateLabel.setTextColor(UIColor.green)
        }
        else {
            stateLabel.setText("Not connected")
            stateLabel.setTextColor(UIColor.red)
        }
    }
    
    @IBAction func button() {
        session.sendMessage(["action": action])
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func Connection() {
        SessionManager.reconnect()
    }
    
    
}
