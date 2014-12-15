//
//  CardMatchingGameResult.swift
//  Matchismo-Swift
//
//  Created by Chrisna Aing on 12/14/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import Foundation

struct CardMatchingGameResult {
    let cards: [Card]
    let matchAttempted: Bool
    let matched: Bool
    let matchScore: Int
}