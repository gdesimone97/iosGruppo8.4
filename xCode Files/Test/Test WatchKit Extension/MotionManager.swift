//
//  MotionManager.swift
//  Test WatchKit Extension
//
//  Created by Francesco Chiarello on 11/07/2019.
//  Copyright © 2019 Francesco Chiarello. All rights reserved.
//

import Foundation
import CoreMotion
import WatchKit

/**
 `MotionManagerDelegate` exists to inform delegates of motion changes.
 These contexts can be used to enable application specific behavior.
 */
protocol MotionManagerDelegate: class {
    func updatedRead(pitch: Double, yaw: Double, sum: Double)
}

class MotionManager {
    // MARK: Properties
    
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    
    var buffer_yaw = RunningBuffer(size: 50)
    var buffer_pitch = RunningBuffer(size: 50)
    
    var flag: Bool = false
    
    
    // MARK: Application Specific Constants
    
    /*
    // These constants were derived from data and should be further tuned for your needs.
    let yawThreshold = 1.95 // Radians
    let rateThreshold = 5.5 // Radians/sec
 
    let resetThreshold = 5.5 * 0.05 // To avoid double counting on the return swing.
    */
    
    // The app is using 50hz data and the buffer is going to hold 1s worth of data.
    let sampleInterval = 1.0 / 50
    
    weak var delegate: MotionManagerDelegate?
    
    
    // MARK: Initialization
    
    init() {
        // Serial queue for sample handling and calculations.
        queue.maxConcurrentOperationCount = 1
        queue.name = "MotionManagerQueue"
    }
    
    // MARK: Motion Manager
    
    func startUpdates() {
        if !motionManager.isDeviceMotionAvailable {
            print("Device Motion is not available.")
            return
        }
        
        motionManager.deviceMotionUpdateInterval = sampleInterval
        motionManager.startDeviceMotionUpdates(to: queue) { (deviceMotion: CMDeviceMotion?, error: Error?) in
            if error != nil {
                print("Encountered error: \(error!)")
            }
            
            if let data = deviceMotion?.rotationRate {
                let x = data.x
                let z = data.z
                
                if(!self.flag && x > 1 && z < -1) {
                    self.flag = true
                }
                
                if self.flag && deviceMotion != nil {
                    self.processDeviceMotion(deviceMotion!)
                }
            }
        }
    }
    
    func stopUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.stopDeviceMotionUpdates()
        }
    }
    
    // MARK: Motion Processing
    
    func processDeviceMotion(_ deviceMotion: CMDeviceMotion) {
        let rotationRate = deviceMotion.rotationRate
        
        let yaw = rotationRate.z
        let pitch = rotationRate.x
//        let sum = -rotationRate.x + rotationRate.z
        
        
        buffer_yaw.addSample(yaw)
        buffer_pitch.addSample(pitch)
        
        if !buffer_yaw.isFull() {
            return
        }
        flag = false
        
        let yawMin = buffer_yaw.min()
        let yawMax = buffer_yaw.max()
        let yawAvg = buffer_yaw.sum()/50
        let pitchMin = buffer_pitch.min()
        let pitchMax = buffer_pitch.max()
        let pitchAvg = buffer_pitch.sum()/50
        
        buffer_yaw.reset()
        buffer_pitch.reset()
        
        delegate!.updatedRead(pitch: pitch, yaw: yaw, sum: sum)
        
//        print("yawMin: " + String(format: "%.3f", yawMin) + " yawMax: " + String(format: "%.3f", yawMax) + " yawAvg: " + String(format: "%.3f", yawAvg) + " - pitchMin: " + String(format: "%.3f", pitchMin) + " pitchMax: " + String(format: "%.3f", pitchMax) + " pitchAvg: " + String(format: "%.3f", pitchAvg))
       
        
    }
    
}
