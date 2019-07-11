//
//  InterfaceController.swift
//  Test WatchKit Extension
//
//  Created by Francesco Chiarello on 06/07/2019.
//  Copyright © 2019 Francesco Chiarello. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, MotionManagerDelegate{
    
    var manager: MotionManager!
    
    func updatedRead(pitch: Double, yaw: Double, sum: Double) {
        <#code#>
    }
    
    
   
    @IBAction func stopButton() {
        manager.stopUpdates()
    }
    @IBAction func startButton() {
        manager.startUpdates()
    }
    
//    @IBOutlet weak var label1: WKInterfaceLabel!
    var session: WCSession!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        /*
        if WCSession.isSupported() {
            session = WCSession.default
//            session.delegate = self
            session.activate()
        }
 */
     manager = MotionManager()
    }
    
    /*
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?){
        switch activationState {
        case WCSessionActivationState.activated:
            DispatchQueue.main.async {
                self.label1.setText("session activated")
            }
        case WCSessionActivationState.notActivated:
            DispatchQueue.main.async {
                self.label1.setText("session not activated")
            }
        default:
            DispatchQueue.main.async {
                self.label1.setText("unknown session state")
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]){
        DispatchQueue.main.async {
            self.label1.setText((message["payload"] as! String))
        }
    }
     */
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    /*
    @IBAction func sendButton() {
        if session.activationState == WCSessionActivationState.activated{
            session.sendMessage(["payload": "ciao Francesco"], replyHandler: nil, errorHandler: nil)
        }
        else{
            label1.setText("unable to send message")
        }
    }
     */
}
