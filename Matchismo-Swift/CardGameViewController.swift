//
//  CardGameViewController.swift
//  Matchismo-Swift
//
//  Created by Chrisna Aing on 10/25/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import UIKit

class CardGameViewController: UIViewController {

    @IBOutlet weak var flipsLabel: UILabel!

    var flipsCount: UInt = 0 {
        didSet {
            flipsLabel.text = "Flips: \(flipsCount)"
            println("flipsCount changed to \(flipsCount)")
        }
    };

    @IBAction func touchCardButton(sender: UIButton) {
        if (sender.currentTitle != nil) {
            sender.setBackgroundImage(UIImage(named: "CardBack"), forState: .Normal)
            sender.setTitle(nil, forState: .Normal)
        } else {
            sender.setBackgroundImage(UIImage(named: "CardFront"), forState: .Normal)
            sender.setTitle("A♣︎", forState: .Normal)
        }
        flipsCount++;
    }

}
