//
//  ViewController.swift
//  RockPaperScissors (No Stack Views)
//
//  Created by  on 11/27/20.
//  Copyright © 2020 ZaCode. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var computerImage: UIImageView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var rockImage: UIImageView!
    @IBOutlet weak var paperImage: UIImageView!
    @IBOutlet weak var scissorsImage: UIImageView!
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    
    // MVP Variables
    var playerChoice = "rock"
    var computerChoice = "scissors"
    
    var playerWin = 0
    var computerWin = 0
    var gameDraw = 0

    
    // Stretch 2 Variables
    var count = 4
    var timer = Timer()
    
    // Stretch 3 Variables
    let picker = UIImagePickerController()
    var imageDoubleTapped = "rock"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Stretch 3 - Double Tap (Part 1)
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(doubleTapped2))
        tap2.numberOfTapsRequired = 2
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(doubleTapped3))
        tap3.numberOfTapsRequired = 2
        rockImage.addGestureRecognizer(tap)
        paperImage.addGestureRecognizer(tap2)
        scissorsImage.addGestureRecognizer(tap3)
        
        // Stretch 4 - Long Press (Part 1)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        let longPress2 = UILongPressGestureRecognizer(target: self, action: #selector(longPressed2))
        let longPress3 = UILongPressGestureRecognizer(target: self, action: #selector(longPressed3))
        rockImage.addGestureRecognizer(longPress)
        paperImage.addGestureRecognizer(longPress2)
        scissorsImage.addGestureRecognizer(longPress3)
        
        picker.delegate = self
    }
    

    // MVP - Game Functions Correctly
    @IBAction func rockTapped(_ sender: UITapGestureRecognizer) {
        playerChoice = "rock"
        playerImage.image = rockImage.image
        computerRandom()
        outcomes()
    }
    
    
    @IBAction func paperTapped(_ sender: UITapGestureRecognizer) {
        playerChoice = "paper"
        playerImage.image = paperImage.image
        computerRandom()
        outcomes()
    }
    
    @IBAction func scissorsTapped(_ sender: UITapGestureRecognizer) {
        playerChoice = "scissors"
        playerImage.image = scissorsImage.image
        computerRandom()
        outcomes()
    }
    
    func computerRandom() {
        let draw = Int.random(in: 1...3)
        if draw == 1 {
            computerChoice = "rock"
            computerImage.image = UIImage(named: "Rock")
            
        }
        if draw == 2 {
            computerChoice = "paper"
            computerImage.image = UIImage(named: "Paper")
        }
        if draw == 3 {
            computerChoice = "scissors"
            computerImage.image = UIImage(named: "Scissors")
        }
    }

    
    func outcomes() {
        if playerChoice == computerChoice {
            resultLabel.text = "Draw, Go again"
            gameDraw += 1
        }
        if playerChoice == "rock" && computerChoice == "paper" {
            resultLabel.text = "Computer Wins"
            computerWin += 1
        }
        if playerChoice == "rock" && computerChoice == "scissors" {
            resultLabel.text = "You Win"
            playerWin += 1
        }
        if playerChoice == "paper" && computerChoice == "rock" {
            resultLabel.text = "You Win"
            playerWin += 1
        }
        if playerChoice == "paper" && computerChoice == "scissors" {
            resultLabel.text = "Computer Wins"
            computerWin += 1
        }
        if playerChoice == "scissors" && computerChoice == "rock" {
            resultLabel.text = "Computer Wins"
            computerWin += 1
        }
        if playerChoice == "scissors" && computerChoice == "paper" {
            resultLabel.text = "You Win"
            playerWin += 1
        }
    }
    
    // Stretch 5 - Segue Scoreboard
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ScoreboardSegue" {
            
            let confirm = segue.destination as? ScoreboardVC
            
            confirm?.myPlayerText = "\(playerWin)"
            confirm?.myComputerText = "\(computerWin)"
            confirm?.myDrawText = "\(gameDraw)"
        }
    }
    
    // Stretch 1 - Webpage About "Rock Paper Scissors" Rules
    @IBAction func ruleBarButton(_ sender: UIBarButtonItem) {
        let urlString = "https://www.wrpsa.com/the-official-rules-of-rock-paper-scissors/"

        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            vc.delegate = self

            present(vc, animated: true)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
    
    
    // Stretch 2 - Countdown Timer
    @IBAction func countdownButton(_ sender: UIButton) {
        playerImage.image = nil
        count = 4
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timerClass), userInfo: nil, repeats: true)
    }
    
    @objc func timerClass() {
        count -= 1
        if count > 0 {
            countdownLabel.text = "Countdown in . . . \(count)"
        }
        if count <= 0 {
            timer.invalidate()
            countdownLabel.text = "Times up!"
            if playerImage.image == nil {
                resultLabel.text = "Computer wins by time out!"
                computerWin += 1
            }
        }
        
    }
    
    
    // Stretch 3 - Double Tap (Part 2)
    
    @objc func doubleTapped() {
        imageDoubleTapped = "rock"
        cameraAlert()
    }
    
    @objc func doubleTapped2() {
        imageDoubleTapped = "paper"
        cameraAlert()
    }
    
    @objc func doubleTapped3() {
        imageDoubleTapped = "scissors"
        cameraAlert()
    }
    
    func cameraAlert() {
        let alert = UIAlertController(title: "Select your image", message: nil, preferredStyle: UIAlertController.Style.alert)
        let libraryAction = UIAlertAction(title: "Photo Library", style: UIAlertAction.Style.default) { (action) in
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        {(action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // Stretch 4 - Long Press (Part 2)
    @objc func longPressed() {
        imageDoubleTapped = "rock"
        cameraAlert2()
    }
    
    @objc func longPressed2() {
        imageDoubleTapped = "paper"
        cameraAlert2()
    }
    
    @objc func longPressed3() {
        imageDoubleTapped = "scissors"
        cameraAlert2()
    }
    
    func cameraAlert2() {
        let alert = UIAlertController(title: "Select your image", message: nil, preferredStyle: UIAlertController.Style.alert)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) { (action) in
            if UIImagePickerController.availableCaptureModes(for: .rear) != nil
            {
                self.picker.sourceType = .camera
                self.present(self.picker, animated: true, completion: nil)
            } else if UIImagePickerController.availableCaptureModes(for: .front) != nil {
                self.picker.sourceType = .camera
                self.present(self.picker, animated: true, completion: nil)
            } else {
                self.noCamera()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        {(action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func noCamera() {
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    
    // Stretch 3 - Double Tap (Part 3)
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let myImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if imageDoubleTapped == "rock" {
                rockImage.image = myImage
            } else if imageDoubleTapped == "paper" {
                paperImage.image = myImage
            } else {
                scissorsImage.image = myImage
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
}

