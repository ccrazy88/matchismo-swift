//
//  CardGameViewController.swift
//  Matchismo-Swift
//
//  Created by Chrisna Aing on 10/25/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import UIKit

class CardGameViewController: UIViewController {

    // MARK: -
    // MARK: Private properties

    private lazy var game: CardMatchingGame = self.createGame()

    // MARK: Outlets

    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var historyLabel: UILabel!
    @IBOutlet private weak var historySlider: UISlider!
    @IBOutlet private weak var modeSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var scoreLabel: UILabel!

    // MARK: -
    // MARK: Utilities

    private func createGame() -> CardMatchingGame {
        // Assumes that there are fewer cardButtons than there are cards in the deck.
        return CardMatchingGame(cardCount: UInt(self.cardButtons.count), deck: self.createDeck())!
    }

    private func createDeck() -> Deck {
        return PlayingCardDeck()
    }

    private func titleForCard(card: Card) -> String? {
        return card.chosen ? card.contents : nil
    }

    private func backgroundImageForCard(card: Card) -> UIImage {
        return UIImage(named: card.chosen ? "CardFront" : "CardBack")!
    }

    private func stringForCards(cards: [Card]) -> String {
        var cardsString = ""
        for card in cards {
            cardsString += card.contents
        }
        return cardsString
    }

    private func stringForMoveAtIndex(index: UInt) -> String {
        // Use the history array provided by CardMatchingGame to generate the final string.
        var moveString = ""
        if index < UInt(game.history.count) {
            let move = game.history[Int(index)]
            let cards = stringForCards(move.cards)
            let score = move.matchScore
            switch (move.matchAttempted, move.matched) {
            case (true, true): moveString = "Matched \(cards) for \(score) point" + (score != 1 ? "s." : ".")
            case (true, false): moveString = "\(cards) don't match! \(score) point penalty!"
            case (false, _): moveString = "\(cards)"
            default: break
            }
        }
        return moveString
    }

    // MARK: -
    // MARK: Game

    @IBAction func startNewGame() {
        let alertController = UIAlertController(title: "Start New Game", message: "Are you sure?", preferredStyle: .Alert)
        let noAction = UIAlertAction(title: "No", style: .Cancel, handler: nil)
        let yesAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
            dispatch_async(dispatch_get_main_queue()) {
                self.game = self.createGame()
                self.resetUI()
            }
        }
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    @IBAction func touchCardButton(sender: UIButton) {
        if modeSegmentedControl.enabled {
            modeSegmentedControl.enabled = false
            switch self.modeSegmentedControl.selectedSegmentIndex {
            case 0: self.game.cardsToMatch = 2
            case 1: self.game.cardsToMatch = 3
            default: break
            }
        }
        // Assumes that all buttons are inside cardButtons.
        let cardButtonIndex = find(cardButtons, sender)!
        game.chooseCardAtIndex(UInt(cardButtonIndex))
        updateUI()
    }

    // MARK: -
    // MARK: UI

    @IBAction func slideThroughHistory(sender: UISlider) {
        let historyIndex = UInt(round(sender.value))
        historyLabel.text = stringForMoveAtIndex(historyIndex)
        historyLabel.alpha = historyIndex < UInt(round(sender.maximumValue)) ? 0.5 : 1.0
    }

    private func resetUI() {
        modeSegmentedControl.enabled = true
        updateUI()
    }

    func updateUI() {
        for cardButton in cardButtons {
            let cardButtonIndex = find(cardButtons, cardButton)!
            let card = game.cardAtIndex(UInt(cardButtonIndex))!
            cardButton.setTitle(titleForCard(card), forState: .Normal)
            cardButton.setBackgroundImage(backgroundImageForCard(card), forState: .Normal)
            cardButton.enabled = !card.matched
        }
        scoreLabel.text = "Score: \(game.score)"
        let maxHistoryIndex = game.history.isEmpty ? 0 : game.history.count - 1
        historySlider.maximumValue = Float(maxHistoryIndex)
        historySlider.enabled = historySlider.minimumValue == historySlider.maximumValue ? false : true
        historySlider.setValue(Float(maxHistoryIndex), animated: true)
        slideThroughHistory(historySlider)
    }

}
