//
//  Card.swift
//  Concentration
//
//  Created by Christy Remigio on 9/12/20.
//  Copyright © 2020 Christy Remigio. All rights reserved.
//

import Foundation

struct Card: Hashable {
    //struct is a value type not a reference type
    var identifier: Int
    var isFaceUp = false
    var isMatched = false
    var flipCount = 0

    
    private static var identifierFactory = 0
        
        private static func getUniqueIdentifier() -> Int {
            Card.identifierFactory += 1
            return identifierFactory
            
        }
        
       
        
        init(){
            self.identifier = Card.getUniqueIdentifier()
        }

    }
    private static func 
    var hashValue: Int {
        return identifier
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    
    
    
    
