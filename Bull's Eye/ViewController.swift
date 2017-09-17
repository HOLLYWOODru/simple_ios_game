//
//  ViewController.swift
//  Bull's Eye
//
//  Created by Aleksey Rodionov on 18.09.17.
//  Copyright © 2017 HOLLYWOOD Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var roundNumber: Int = 1
    var score: Int = 0
    var currentTarget: Int = 0
    
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var slider: UISlider!
    @IBOutlet var roundLabel: UILabel!
    
    // IBAction methods
    @IBAction func hitMeTapped(_ sender: Any) {
        let currentSliderValue = Int(floor(100*slider.value))
        var resultLabel = ""
        
        if (abs(currentSliderValue - currentTarget) >= 10) {
            resultLabel = "Sorry, you don't get any points.."
        } else {
            let points = 10 - abs(currentSliderValue - currentTarget)
            
            score += points
            resultLabel = "Great! You was so close and got \(points) points"
        }
        
        updateScore()
        
        let alertController = UIAlertController(title: "Bull's Eye", message: "Your number is \(currentSliderValue). \(resultLabel). Your score is \(score).", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: {
            (alert: UIAlertAction!) in
                self.roundNumber += 1
            
                self.startNewRound()
        })
        
        alertController.addAction(alertAction)
        
        show(alertController, sender: self)
    }
    
    @IBAction func retryTapped(_ sender: Any) {
        score = 0
        roundNumber = 1
        
        updateScore()
        startNewRound()
    }
    
    @IBAction func infoTapped(_ sender: Any) {
    }
    
    // UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let thumbImageNormal = UIImage.init(named: "SliderThumb-Normal")
        let thumbImageHighlighted = UIImage.init(named: "SliderThumb-Highlighted")
        
        slider.setThumbImage(thumbImageNormal, for: .normal)
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        startNewRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Private methods
    private func startNewRound() {
        let randomNumber = 1 + Int(arc4random()%100)
        
        currentTarget = randomNumber
        
        targetLabel.text = "\(randomNumber)"
        roundLabel.text = "\(roundNumber)"
    }
    
    private func updateScore() {
        scoreLabel.text = "\(score)"
    }
}

