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
    
    @IBOutlet weak var label: UILabel!
    var messageReceived: Bool?
    var count: Int = 0
    
    override func viewDidLoad() {
        
        label.text = "start"
    }
    
    
    @IBAction func reset(_ sender: Any) {
        count = 0
        label.text = "start"
        
    }
}

