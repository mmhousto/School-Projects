//
//  SecondViewController.swift
//  A3_P1_Houston_Morgan
//
//  Created by Morgan Houston on 9/29/19.
//  Copyright © 2019 Morgan Houston. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate {
    
    //Variables
    var laps: [String] = []
    var currentTime: String = ""
    var timeString: String = ""
    var timer = Timer()
    var totalTimer = Timer()
    var minutes: Int = 0
    var seconds:Int = 0
    var fractions:Int = 0
    var totalMinutes: Int = 0
    var totalSeconds:Int = 0
    var totalFractions:Int = 0
    var tableView: UITableView!
    
    var startedStopWatch:Bool = false
    var addedLap:Bool = false
    
    //Outlets
    @IBOutlet weak var currentLap: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var numLaps: UILabel!
    @IBOutlet weak var startStop: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var lapButton: UIButton!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var statsButton: UIBarButtonItem!
    
    @IBAction func start(_ sender: UIButton) {
        //creates the current time and total time timers
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        totalTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateTotalTime), userInfo: nil, repeats: true)
        //sets the start button to hidden and shows the stop button
        startedStopWatch = true
        startStop.isHidden = true
        stopButton.isHidden = false
        //reset and lap become enabled
        resetButton.isEnabled = true
        statsButton.isEnabled = false
        lapButton.isEnabled = true
        lapButton.alpha = 1
        numLaps.text = "1"
        addedLap = true
    }
    
    @IBAction func stop(_ sender: UIButton) {
        //stops both the timers
        timer.invalidate()
        totalTimer.invalidate()
        laps.insert(currentTime, at: 0)
        startedStopWatch = false
        //stop is hidden and start is shown
        startStop.isHidden = false
        stopButton.isHidden = true
        //show stats button is enabled and lap button disabled
        resetButton.isEnabled = true
        statsButton.isEnabled = true
        lapButton.isEnabled = false
        lapButton.alpha = 0.5
    }
    
    //function to create our reset alert
    func createAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        //if choose yes, resets all stats and layout
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
            self.resetButton.isEnabled = false
            self.startStop.isHidden = false
            self.stopButton.isHidden = true
            self.statsButton.isEnabled = false
            self.lapButton.isEnabled = false
            self.lapButton.alpha = 0.5
            
            self.timer.invalidate()
            self.totalTimer.invalidate()
            self.fractions = 0
            self.seconds = 0
            self.totalMinutes = 0
            self.totalFractions = 0
            self.totalSeconds = 0
            self.minutes = 0
            self.currentTime = "00:00.00"
            self.timeString = "00:00.00"
            self.currentLap.text = self.currentTime
            self.totalTime.text = self.timeString
            self.laps.removeAll(keepingCapacity: false)
            self.numLaps.text = "0"
        }))
        
        //if choose no, returns and timers continue
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
            return
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func reset(_ sender: UIBarButtonItem) {
        //when reset is clicked prompts you with alert
        createAlert(title: "Reset Timer", message: "Are you sure you want to reset?")
    }
    
    @IBAction func newLap(_ sender: UIButton) {
        //inserts current time into laps array then restarts current time
        laps.insert(currentTime, at: 0)
        timer.invalidate()
        fractions = 0
        seconds = 0
        minutes = 0
        currentTime = "00:00.00"
        currentLap.text = currentTime
        numLaps.text = "\(laps.count+1)"
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        
            
    }
    
    @objc func updateTime() {
        //function that updates the current time
        //youtube.com/watch?v=JwQvh4CnVJo (Haroon Pasha)
        fractions += 1
        if fractions == 100 {
            seconds += 1
            fractions = 0
        }
        
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        currentTime = "\(minutesString):\(secondsString).\(fractionsString)"
        currentLap.text = currentTime

    }
    
    @objc func updateTotalTime() {
        //function that updates the totalTime
        totalFractions += 1
        if totalFractions == 100 {
            totalSeconds += 1
            totalFractions = 0
        }
        
        if totalSeconds == 60 {
            minutes += 1
            totalSeconds = 0
        }
        
        let fractionsString = totalFractions > 9 ? "\(totalFractions)" : "0\(totalFractions)"
        let secondsString = totalSeconds > 9 ? "\(totalSeconds)" : "0\(totalSeconds)"
        let minutesString = totalMinutes > 9 ? "\(totalMinutes)" : "0\(totalMinutes)"
        

        timeString = "\(minutesString):\(secondsString).\(fractionsString)"
        totalTime.text = timeString
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //sets the default layout and stats on load
        lapButton.isEnabled = false
        lapButton.alpha = 0.5
        startStop.isHidden = false
        stopButton.isHidden = true
        resetButton.isEnabled = false
        statsButton.isEnabled = false
        currentLap.text = "00:00.00"
        totalTime.text = "00:00.00"
        numLaps.text = "0"
    }
    
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(true)
        // Hide the navigation bar and toolbar.
            self.navigationController?.setToolbarHidden( true, animated: true)
        self.navigationController?.setNavigationBarHidden(true,animated: true)
        
    }
    
    @IBAction func myUnwindAction(segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TableViewController
        //sets lapStats array in TVC to laps array in VC2
        if segue.identifier == "toStats" {
                destination.lapStats = laps
        }
    }
}
