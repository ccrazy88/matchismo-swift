//
//  CardGameHistoryViewController.swift
//  Matchismo-Swift
//
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import Foundation
import UIKit

class CardGameHistoryViewController: UIViewController {

    // MARK: -
    // MARK: Public Properties
   
    var history = NSAttributedString()

    // MARK: Outlets

    @IBOutlet private weak var historyTextView: UITextView!

    // MARK: -
    // MARK: View Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        historyTextView.attributedText = history
    }
}
