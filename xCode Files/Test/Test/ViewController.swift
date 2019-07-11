//
//  ViewController.swift
//  Test
//
//  Created by Francesco Chiarello on 06/07/2019.
//  Copyright © 2019 Francesco Chiarello. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController,  WCSessionDelegate{
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    var session: WCSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*
        sleep(10)
        if WCSession.isSupported() {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
        */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if WCSession.isSupported() {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?){
        switch activationState {
        case WCSessionActivationState.activated:
            DispatchQueue.main.async {
                self.label1.text = "session activated"
            }
        case WCSessionActivationState.notActivated:
            DispatchQueue.main.async {
                self.label1.text = "session not activated"
            }
        default:
            DispatchQueue.main.async {
                self.label1.text = "unknown session state"
            }
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {}
   

    @IBAction func sendButton(_ sender: UIButton) {
        if session.activationState == WCSessionActivationState.activated{
            session.sendMessage(["payload": "ciao Francesco"], replyHandler: nil, errorHandler: nil)
        }
        else{
            label1.text = "unable to send message"
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]){
        DispatchQueue.main.async {
            self.label2.text = ((message["payload"] as! String))
        }
    }
}

