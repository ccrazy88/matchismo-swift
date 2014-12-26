//
//  CardGameHistoryViewController.swift
//  Matchismo-Swift
//
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import Foundation
import UIKit

class CardGameHistoryViewController: UIViewController {

    @IBOutlet weak var historyTextView: UITextView!

    var history = NSAttributedString()

    override func viewWillAppear(animated: Bool) {
        historyTextView.attributedText = history
    }
}
