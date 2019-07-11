//
//  ViewController.swift
//  LetsPlay
//
//  Created by Francesco Chiarello on 11/07/2019.
//  Copyright © 2019 Francesco Chiarello. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return loopMargin*chords.count;
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return chords[row%chords.count];
    }

    let loopMargin = 50;
    let chords = ["DO","RE","MI","FA","SOL","LA","SI"];
    
    
    
    @IBOutlet var chordsPicker: [UIPickerView]!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        if let _ = chordsPicker {
        for chPick in chordsPicker{
            chPick.dataSource = self;
            chPick.delegate = self;
        }
        }
        // Do any additional setup after loading the view.
    }


}

