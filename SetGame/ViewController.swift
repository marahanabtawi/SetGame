//
//  ViewController.swift
//  SetGame
//
//  Created by marah anabtawi on 08/08/2021.
//

import UIKit

class ViewController: UIViewController {
  
  lazy var set = Set(maxNumberOfBoardCards: cardButtons.count)
  let colors = [#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]
  let symbols = ["▲", "■", "●"]
  let numberOfSymbols = [1, 2, 3]
  let fillShade: [NSAttributedString.Key: Any]  = [.strokeWidth: -1]
  let stripedShade: [NSAttributedString.Key: Any] = [.strokeWidth: 3]
  
  @IBOutlet private var cardButtons: [UIButton]!
  @IBOutlet weak var deal3CardsButton: UIButton!
  @IBOutlet weak var scoreLabel: UILabel!
  var buttonsOfCards: [Int: Card] = [:]
  @IBAction func touchDeal3MoreCards(_ sender: UIButton) {
    set.drawThreeMoreCards()
    updateView()
  }
  
  @IBAction func CardButtonPressed(_ sender: UIButton) {
    if let buttonIndex = cardButtons.firstIndex(of: sender), let card = buttonsOfCards[buttonIndex] {
      set.chooseCard(card)
      changeButtonBorde()
      deal3CardsButton.isEnabled = true
      scoreLabel.text = "\(set.score)"
    }
  }
  
  @IBAction func touchNewGame(_ sender: UIButton) {
    set.reset()
    displayCards()
    updateView()
    deal3CardsButton.isEnabled = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    displayCards()
  }
  
  func drawSymbolsOnCard(_ numberOfSymbols: Int, shape: String, button: UIButton, color: UIColor,shadingStyle: Int) {
    
    var stringAttributes = fillShade
    var symbol: String
    
    switch shadingStyle {
    case 1:
      stringAttributes = fillShade
      stringAttributes[.foregroundColor] = color
    case 2:
      stringAttributes = stripedShade
      stringAttributes[.foregroundColor] = color
    case 3:
      stringAttributes = [.foregroundColor: color.withAlphaComponent(0.2)]
    default:
      print("default")
    }
    
    symbol = .init(repeating: shape, count: numberOfSymbols)
    
    button.setAttributedTitle(NSMutableAttributedString.init(string: symbol, attributes: stringAttributes), for: .normal)
  }
  
  func displayCards() {
    for index in set.boardCards.indices {
      let cardSymbol = set.boardCards[index].shape
      let cardColor = set.boardCards[index].color
      let cardNumberOfSymbols = set.boardCards[index].number
      let cardShading = set.boardCards[index].shade
      
      var symbol: String
      var color: UIColor
      var numberOfSymbols: Int
      var shadingStyle: Int
      
      switch cardSymbol {
      case .triangle:
        symbol = symbols[0]
      case .square:
        symbol = symbols[1]
      case .circle:
        symbol = symbols[2]
      }
      
      switch cardColor {
      case .red:
        color = colors[0]
      case .blue:
        color = colors[1]
      case .green:
        color = colors[2]
      }
      
      switch cardNumberOfSymbols {
      case .one:
        numberOfSymbols = 1
      case .two:
        numberOfSymbols = 2
      case .three:
        numberOfSymbols = 3
      }
      
      switch cardShading {
      case .fill:
        shadingStyle = 1
      case .striped:
        shadingStyle = 2
      case .open:
        shadingStyle = 3
      }
      
      drawSymbolsOnCard(numberOfSymbols, shape: symbol, button: cardButtons[index], color: color, shadingStyle: shadingStyle)
      cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      buttonsOfCards[index] = set.boardCards[index]
      cardButtons[index].isEnabled = true
      
    }
  }
  
  func selectCard(button: UIButton) {
    button.layer.borderWidth = 3.0
    button.layer.borderColor = UIColor.blue.cgColor
  }
  
  func matchedCard(button: UIButton) {
    button.layer.borderWidth = 3.0
    button.layer.borderColor = UIColor.green.cgColor
  }
  
  func dismatchedCard(button: UIButton) {
    button.layer.borderWidth = 3.0
    button.layer.borderColor = UIColor.red.cgColor
  }
  
  func deselectCard(button: UIButton) {
    button.layer.borderWidth = 0.0
  }
  
  func updateView(){
    for button in cardButtons {
      button.backgroundColor =  #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 0)
      button.setAttributedTitle(NSMutableAttributedString.init(string: "", attributes: [:]), for: .normal)
      button.isEnabled = false
      deselectCard(button: button)
    }
    set.validSet = false
    set.selectedCards = []
    set.matchedCards = []
    displayCards()
    
    if set.boardCards.count == cardButtons.count || set.cardDeck.count < 3 {
      deal3CardsButton.isEnabled = false
    } else {
      deal3CardsButton.isEnabled = true
    }
    
    scoreLabel.text = "\(set.score)"
  }
  
  func changeButtonBorde(){
    for (index,card) in buttonsOfCards{
      if set.selectedCards.contains(card){
        selectCard(button: cardButtons[index])
      } else {
        deselectCard(button: cardButtons[index])
      }
      if set.matchedCards.contains(card) && set.selectedCards.contains(card) {
        matchedCard(button: cardButtons[index])
      }else if set.selectedCards.count == 3 && set.selectedCards.contains(card){
        dismatchedCard(button: cardButtons[index])
      }
    }
  }
  
}
