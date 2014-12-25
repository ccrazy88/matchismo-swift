//
//  PlayingCard.swift
//  Matchismo-Swift
//
//  Created by Chrisna Aing on 10/29/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import Foundation

class PlayingCard: Card {

    // MARK: -
    // MARK: "Class" Properties

    // Hack!
    private struct Utility {
        static let rankStrings = ["?", "A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
        static let validSuits = ["♠️", "♣️", "♥️", "♦️"]
        static let maxRank = UInt(rankStrings.count) - 1
    }

    // MARK: Private Properties

    private var _rank: UInt?
    private var _suit: String?

    // MARK: Public Properties

    var rank: UInt {
        get { return _rank ?? 0 }
        set (newRank) {
            if newRank <= Utility.maxRank {
                _rank = newRank
            }
        }
    }

    var suit: String {
        get { return _suit ?? "?" }
        set (newSuit) {
            if contains(Utility.validSuits, newSuit) {
                _suit = newSuit
            }
        }
    }
    
    override var contents: String {
        get { return "\(Utility.rankStrings[Int(rank)])\(self.suit)" }
        set { }
    }

    // MARK: -
    // MARK: Initializers

    init(rank: UInt, suit: String, chosen: Bool = false, matched: Bool = false) {
        super.init(contents: "", chosen: chosen, matched: matched)
        self.rank = rank
        self.suit = suit
    }

    // MARK: -
    // MARK: Utilities

    class func maxRank() -> UInt {
        return Utility.maxRank
    }

    class func validSuits() -> [String] {
        return Utility.validSuits
    }

    class func rankStrings() -> [String] {
        return Utility.rankStrings
    }

    // TODO: Make generic.

    private func uniqueRanks(cards: [PlayingCard]) -> UInt {
        var ranks = [UInt: UInt]()
        cards.map { ranks.updateValue(1, forKey: $0.rank) }
        return UInt(ranks.count)
    }

    private func uniqueSuits(cards: [PlayingCard]) -> UInt {
        var suits = [String: UInt]()
        cards.map { suits.updateValue(1, forKey: $0.suit) }
        return UInt(suits.count)
    }

    // MARK: -
    // MARK: Card Matching

    override func match(otherCards: [Card]) -> Int {
        var score = 0
        // Matching with one other card and two other cards supported.
        switch otherCards.count {
        case 1:
            if let otherPlayingCard = otherCards.first as? PlayingCard {
                if rank == otherPlayingCard.rank {
                    score = 4
                } else if suit == otherPlayingCard.suit {
                    score = 1
                }
            }
        case 2:
            if let otherPlayingCards = otherCards as? [PlayingCard] {
                let allCards = [self] + otherPlayingCards
                switch (uniqueRanks(allCards), uniqueSuits(allCards)) {
                case (1, _): score = 100 // Three of a kind!
                case (_, 1): score = 4 // Flush!
                case (2, 2): score = 3 // Pair (rank) and pair (suit)!
                case (2, _): score = 2 // Pair (rank)!
                case (_, 2): score = 1 // Pair (suit)!
                default: break
                }
            }
        default: break
        }
        return score
    }

}