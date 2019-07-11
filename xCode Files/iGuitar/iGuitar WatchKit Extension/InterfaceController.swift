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

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    let session = WCSession.default
    var sessionStatus = WCSessionActivationState.notActivated
    var connectionStatus: Bool = false // Stato della connessione, se true può inviare messaggi
    var action = false // Azione dell' utente
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Watch - Connessione conclusa con successo")
    }
    
    
    func ckeckConnection(_ sessionStatus: WCSessionActivationState,_ session: WCSession) -> Bool{
        
        var stateConnection = false // Controlla se la connessione è disponibile
        var reachable = false // Controlla che l'iphone sia sbloccato
        
        if sessionStatus == WCSessionActivationState.activated{
            print("Watch - Connessione disponibile")
            stateConnection = true
        }
        else {
            print("Watch - Connessione non disponibile")
        }
        
        if stateConnection && session.isReachable {
            reachable = true
        }
            
        else {
            if stateConnection && session.iOSDeviceNeedsUnlockAfterRebootForReachability {
                print("Sblocca iphone")
            }
        }
        return reachable && stateConnection
    }
    
    func sendMessage(){
        if connectionStatus {
            print("Messaggio inviato")
            session.sendMessage(["action": "action"], replyHandler: nil, errorHandler: nil)
        }
        else {
            print("Messaggio non inviato")
        }
    }
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if WCSession.isSupported() {
            print("Watch - Conessione supportata")
            session.delegate = self
            session.activate()
            sessionStatus = session.activationState
            print("Status: ",sessionStatus)
        }
        else {
            print("Watch - Connessione non supportata")
        }
        
        connectionStatus = ckeckConnection(sessionStatus, session)
        
    }
    
    @IBAction func button() {
        sendMessage()
    }
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
