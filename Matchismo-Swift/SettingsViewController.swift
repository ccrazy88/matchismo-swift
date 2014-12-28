//
//  SettingsViewController.swift
//  Matchismo-Swift
//
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: -
    // MARK: Outlets

    @IBOutlet private weak var choiceTextField: UITextField!
    @IBOutlet private weak var matchTextField: UITextField!
    @IBOutlet private weak var mismatchTextField: UITextField!

    // MARK: -
    // MARK: View Lifecycle

    override func viewDidLoad() {
        choiceTextField.placeholder = "\(Constant.choice)"
        matchTextField.placeholder = "\(Constant.match)"
        mismatchTextField.placeholder = "\(Constant.mismatch)"
    }

    override func viewWillAppear(animated: Bool) {
        updateUI()
    }

    // MARK: -
    // MARK: Utility

    private func getCurrentValue(key: String) -> String? {
        if let value = NSUserDefaults.standardUserDefaults().objectForKey(key) as? Int {
            return "\(value)"
        } else {
            return nil
        }
    }

    private func changeValue(sender: UITextField, key: String) {
        if let newValue = sender.text.toInt() {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: key)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

    // MARK: -
    // MARK: Change Settings

    @IBAction func changeChoice(sender: UITextField) {
        changeValue(sender, key: Constant.choiceKey)
        updateUI()
    }

    @IBAction func changeMatch(sender: UITextField) {
        changeValue(sender, key: Constant.matchKey)
        updateUI()
    }

    @IBAction func changeMismatch(sender: UITextField) {
        changeValue(sender, key: Constant.mismatchKey)
        updateUI()
    }

    // MARK: -
    // MARK: UI

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        view.endEditing(true)
    }

    private func updateUI() {
        choiceTextField.text = getCurrentValue(Constant.choiceKey)
        matchTextField.text = getCurrentValue(Constant.matchKey)
        mismatchTextField.text = getCurrentValue(Constant.mismatchKey)
    }
}
