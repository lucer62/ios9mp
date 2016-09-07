//
//  ViewController.swift
//  retrocalc
//
//  Created by luca on 06/09/16.
//  Copyright © 2016 elleci. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound : AVAudioPlayer!
    
    var runningNumber = ""
    var leftVar = ""
    var rightVar = ""
    var result = ""
    var currentOperation: Operation = Operation.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEgualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightVar = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftVar)! * Double(rightVar)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftVar)! / Double(rightVar)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftVar)! - Double(rightVar)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftVar)! + Double(rightVar)!)"
                }
                leftVar = result
                outputLbl.text = result
                //currentOperation = Operation.Empty
            }
            //print(currentOperation)
            currentOperation = op
        } else {
            leftVar = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
}

