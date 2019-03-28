//
//  ViewController.swift
//  FinalOption
//
//  Created by howard lee on 3/24/19.
//  Copyright © 2019 howard lee. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    var timer = Timer()
    var soundURL : URL?
    var soundID : SystemSoundID = 0
    let timeFormatter = DateFormatter()
    var starting = 60
    

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
        let filePath = Bundle.main.path(forResource: "foghorn", ofType: "wav")
        soundURL = URL(fileURLWithPath: filePath!)
        AudioServicesCreateSystemSoundID(soundURL! as CFURL, &soundID)
        
   

        timeLabel.text = "\(starting)"//starting
	}
	
   
    @IBOutlet weak var timeSetter: UITextField!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var reset: UIBarButtonItem!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var pause: UIButton!
    
    @IBAction func resetTime(_ sender: Any) {
        starting = 60
        timeLabel.text = "\(starting)" //starting
        timer.invalidate()
        
    }
    
   // var countDownDuration: TimeInterval { get set }


    @IBAction func setTimer(_ sender: Any) {
        setTime()
    }
    
  
    func setTime(){
            starting = Int(timeSetter.text!) ?? 0
            timeLabel.text = "\(starting)" //starting

    }
    
    
    
    @IBAction func pauseTime(_ sender: Any) {
        timer.invalidate()
    }
    @IBAction func startTime(_ sender: Any) {
        timer.invalidate()
        //starting timer
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
     @objc func timerAction(){
        if starting < 1 {
            //stop time 
            timer.invalidate()
            //alert sound
            AudioServicesPlayAlertSound(soundID)
            //alert view 
            let alertController = UIAlertController(title: "Time!", message:
                "Time's up!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }else{
            starting -= 1
            timeLabel.text = "\(starting)"
            
        }
    }
    


}

