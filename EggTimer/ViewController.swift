//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 30, "Medium": 4, "Hard": 7]
    var secondsRemaining: Int = 0
    var boilingTime: Int = 1
    var timer = Timer()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progresBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        secondsRemaining = eggTimes[sender.currentTitle!]!
        boilingTime = eggTimes[sender.currentTitle!]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        

        progresBar.progress = Float(boilingTime-secondsRemaining)/Float(boilingTime)
        
        if(secondsRemaining > 0){
            print("\(secondsRemaining) seconds")
            secondsRemaining -= 1
        }else if(secondsRemaining <= 0){
            titleLabel.text = "Done!"
            //TODO play sound
        }
    }
    
    
    
}
