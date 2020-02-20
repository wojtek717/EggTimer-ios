//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    var soundPlayed: Bool = false
    
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
        soundPlayed = false
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        progresBar.progress = Float(boilingTime-secondsRemaining)/Float(boilingTime)
        
        if(secondsRemaining > 0){
            print("\(secondsRemaining) seconds")
            secondsRemaining -= 1
        }else if(secondsRemaining <= 0){
            titleLabel.text = "Done!"
            if !soundPlayed {
                playSound()
                soundPlayed = true
            }
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    
}
