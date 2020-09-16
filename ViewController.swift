//
//  ViewController.swift
//  Concentration
//
//  Created by Christy Remijio on 9/5/20.
//  Copyright © 2020 Christy Remijio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
    // you cannot have a didSet for lazy variables
    
    //theme setting attributes
    private var emoji = Dictionary<Int, String>()
    var themeBGcolor: UIColor?
    var themeCardColor: UIColor?
    var themeCardEmojis: [String]!
    
        //Extra Credit: change the background color and card color to match the theme
    let natureTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), cardColor: #colorLiteral(red: 0.03230615064, green: 0.4015544041, blue: 0.02831091213, alpha: 1), cardEmojis: ["🌳", "🌵", "🌼", "🌹", "🌾", "🌻", "🌺", "🍂", "💐", "🌲"])
    let sportsTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), cardColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), cardEmojis: ["🏈", "⚽️", "🎾", "🏐", "🏀", "🥎", "⚾️", "🏉", "🏒", "🥍"])
    let summerTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.5890205091, green: 0.7837039401, blue: 0.9041450777, alpha: 0.9577464789), cardColor: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), cardEmojis: ["☀️", "🏖", "🥵", "👙", "🩳", "🕶", "🏄🏼‍♀️", "🏊🏽‍♂️", "🏝", "😎"])
    let valentineTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), cardColor: #colorLiteral(red: 1, green: 0.6239124392, blue: 0.7693241279, alpha: 1), cardEmojis: ["💌", "💐", "💝", "🥰", "😍", "❤️", "🥂", "💘", "💋", "👠"])
    let farmAnimalsTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), cardColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), cardEmojis: ["🐓", "🐑", "🐖", "🐎", "🐄", "🦃", "🐐", "🦙", "🦆", "🐥"])
    let flagsTheme = Theme.init(backgroundColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), cardColor: #colorLiteral(red: 0.12857798, green: 0.432642487, blue: 0.09801317687, alpha: 1), cardEmojis: ["🇵🇷", "🇺🇸", "🇬🇭", "🇲🇽", "🇮🇹", "🇯🇵", "🇧🇷", "🇩🇴", "🇯🇲", "🇵🇭"])
    

    // (!) --> optional variable: variable that is not necessarily initialized//
    @IBOutlet private var cardButtons: [UIButton]!
    //optional array of optionl values of UIButton
    
    //Score and Match Labels
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet private weak var matchLabel: UILabel!
    
    @IBOutlet private weak var newGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeSettings()
        updateViewFromModel()
        newGameButton.backgroundColor = themeCardColor
        
    }

    @IBAction private func touchCard(_ sender: UIButton) {

        //using "let" defines cardNumber as a constant (the value doesn't change)
        //whenever you want to unwrap an optional you want to do within an 'if' statement
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            matchLabel.text = "Matches: \(game.matches)"
            scoreLabel.text = "Score: \(game.score)"
        
        }else{
            print("Chosen card was not in cardButtons")
            
        }
        
    }
    //Extra Credit: change the background color and card color to match the theme
    private func themeSettings(){
        let themes = [natureTheme, sportsTheme, summerTheme, valentineTheme, farmAnimalsTheme, flagsTheme]
        let randomTheme = themes.count.arc4random
        themeBGcolor = themes[randomTheme].backgroundColor
        themeCardColor = themes[randomTheme].cardColor
        themeCardEmojis = themes[randomTheme].cardEmojis
        view.backgroundColor = themeBGcolor
        scoreLabel.textColor = themeBGcolor
        scoreLabel.backgroundColor = themeCardColor
        matchLabel.textColor = themeBGcolor
        matchLabel.backgroundColor = themeCardColor
        newGameButton.backgroundColor = themeCardColor
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp{
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                } else {
                    button.setTitle("", for: UIControl.State.normal)
                
                if card.isMatched {
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                    
                } else {
                    button.backgroundColor = themeCardColor
                    
                }
                
            }
          
        }
        
    }
    
    //button to start a new game
    @IBAction func newGameButton(_ sender: UIButton) {
        //when New Game button is pressed, we want to reload the cards, shuffled,
        //remove all emojis, display a different theme each new game, update View, reset Score card & number of matches
        
        
        game.renewCards()
        game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
        emoji.removeAll()
        themeSettings()
        updateViewFromModel()
        scoreLabel.text = "Score: \(game.score)"
        matchLabel.text = "Matches: \(game.matches)"
        
        
    }
    private func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, themeCardEmojis.count > 0 {
            emoji[card.identifier] = themeCardEmojis!.remove(at: themeCardEmojis!.count.arc4random)
                
            }
            
        return emoji[card.identifier] ?? "?"
        
    }
            
        
}



    extension Int {

        var arc4random: Int {
            if self > 0 {
                return Int(arc4random_uniform(UInt32(self)))
                
            } else if self < 0 {
                return -Int(arc4random_uniform(UInt32(abs(self))))
            } else {
                return 0
            }
        }
}
    




