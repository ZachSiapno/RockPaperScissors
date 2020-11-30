//
//  ScoreboardVC.swift
//  RockPaperScissors (No Stack Views)
//
//  Created by  on 11/27/20.
//  Copyright © 2020 ZaCode. All rights reserved.
//

import UIKit

class ScoreboardVC: UIViewController {

    
    @IBOutlet weak var playerWinLabel: UILabel!
    @IBOutlet weak var computerWinLabel: UILabel!
    @IBOutlet weak var gameDrawLabel: UILabel!
    
    var myPlayerText = ""
    var myComputerText = ""
    var myDrawText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playerWinLabel.text = myPlayerText
        computerWinLabel.text = myComputerText
        gameDrawLabel.text = myDrawText
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
