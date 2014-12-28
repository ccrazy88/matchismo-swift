//
//  HighScoresViewController.swift
//  Matchismo-Swift
//
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import Foundation
import UIKit

class HighScoresViewController: UIViewController {

    // MARK: -
    // MARK: Private Properties

    private var currentSortType: sortType = .StartTime
    private enum sortType {
        case Score
        case StartTime
        case Duration
    }

    // MARK: Outlets

    @IBOutlet private weak var highScoresTextView: UITextView!
    @IBOutlet private weak var sortedLabel: UILabel!

    // MARK: -
    // MARK: View Lifecycle

    override func viewWillAppear(animated: Bool) {
        updateUI()
    }

    // MARK: -
    // MARK: Utilities

    private func getScores() -> [AnyObject]? {
        return NSUserDefaults.standardUserDefaults().arrayForKey(Constant.scoresKey)
    }

    private func getSortedScores() -> [AnyObject]? {
        if let scores = getScores() {
            switch currentSortType {
            case .StartTime: return scores
            case .Duration: return getSortedArray(scores, key: Constant.durationKey, ascending: true)
            case .Score: return getSortedArray(scores, key: Constant.scoreKey, ascending: false)
            }
        } else {
            return nil
        }
    }

    private func getSortedArray(array: [AnyObject], key: String, ascending: Bool) -> [AnyObject] {
        let array = array as NSArray
        let descriptor = NSSortDescriptor(key: key, ascending: ascending)
        return array.sortedArrayUsingDescriptors([descriptor])
    }

    // MARK: -
    // MARK: UI

    @IBAction private func clearHighScores() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(Constant.scoresKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        updateUI()
    }

    @IBAction private func sortHighScores() {
        switch currentSortType {
        case .StartTime: currentSortType = .Duration
        case .Duration: currentSortType = .Score
        case .Score: currentSortType = .StartTime
        }
        updateUI()
    }

    private func updateUI() {
        if let scores = getSortedScores() {
            var text = NSMutableAttributedString()
            for score in scores {
                let type = score[Constant.typeKey] as String
                let startTime = score[Constant.startTimeKey] as NSDate
                let seconds = score[Constant.durationKey] as Int
                let points = score[Constant.scoreKey] as Int

                let startTimeString = NSDateFormatter.localizedStringFromDate(startTime,
                    dateStyle: .ShortStyle, timeStyle: .ShortStyle)
                let pointsString = "\(points) point" + (abs(points) != 1 ? "s" : "")
                let durationString = "\(seconds) second" + (seconds != 1 ? "s" : "")

                let scoreString = "- [\(type)] \(startTimeString): \(pointsString) in \(durationString)"

                text.appendAttributedString(NSAttributedString(string: scoreString))
                text.appendAttributedString(NSAttributedString(string: "\n"))
            }
            text.addAttribute(NSFontAttributeName,
                value: UIFont.preferredFontForTextStyle(UIFontTextStyleBody),
                range: NSMakeRange(0, text.length))
            highScoresTextView.attributedText = text
        } else {
            highScoresTextView.attributedText = nil
        }

        switch currentSortType {
        case .StartTime: sortedLabel.text = "Sorted by: Start Time"
        case .Duration: sortedLabel.text = "Sorted by: Duration"
        case .Score: sortedLabel.text = "Sorted by: Score"
        }
    }

}
