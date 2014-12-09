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
        get {
            return _rank ?? 0
        }
        set (newRank) {
            if newRank <= Utility.maxRank {
                _rank = newRank
            }
        }
    }

    var suit: String {
        get {
            return _suit ?? "?"
        }
        set (newSuit) {
            if contains(Utility.validSuits, newSuit) {
                _suit = newSuit
            }
        }
    }
    
    override var contents: String {
        get {
            return "\(Utility.rankStrings[Int(rank)])\(self.suit)"
        }
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

    // MARK: -
    // MARK: Card Matching

    override func match(otherCards: [Card]) -> Int {
        var score = 0
        if otherCards.count == 1 {
            if let otherCard = otherCards.first as? PlayingCard {
                if rank == otherCard.rank {
                    score = 4
                } else if suit == otherCard.suit {
                    score = 1
                }
            }
        }
        return score
    }

}