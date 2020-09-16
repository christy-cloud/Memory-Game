//
//  Concentration.swift
//  Concentration
//
//  Created by Christy Remigio on 9/12/20.
//  Copyright © 2020 Christy Remigio. All rights reserved.
//

import Foundation

class Concentration{
    
    var cards = [Card]()
    var matches = 0
    var score = 0
    
    private(set) var flipCount = 0 {
         didSet{
             
            }
     }
    private(set) var indexOfOneAndOnlyFaceUpCard : Int?
    
    //create a method for the cards chosen to check if two cards are by comparing their ids
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    matches += 1
                    score += 2
                }
                else if cards[index].flipCount > 0 || cards[matchIndex].flipCount > 0 {
                    score -= 1
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                cards[matchIndex].flipCount += 1
                
            }else {
                // 0 or 2 cards are faceUp
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                    
                    
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
                
                       
            }
            
          
       }
        
    }
    //call method to refresh the cards at the start of new game
    func renewCards() {
            cards.removeAll()
    }
    
    init(numberOfPairsOfCards: Int) {
        
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
            
        }
        
         //TODO: method to shuffle cards each time a new game begins
        for _ in cards {
            let randomIndex = cards.count.arc4random
            let randomCard = cards.remove(at: randomIndex)
            cards.append(randomCard)
            
               
           }
        
    }
    
   
    
    
}
