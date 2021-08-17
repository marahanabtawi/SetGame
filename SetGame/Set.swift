//
//  Set.swift
//  SetGame
//
//  Created by marah anabtawi on 10/08/2021.
//

import Foundation

class Set {
  
  private(set) var score = 0
  
  var maxNumberOfBoardCards: Int
  var cardDeck: [Card] = []
  
  private let shades = [Shade.fill, Shade.open, Shade.striped]
  
  private let colors = [Color.red, Color.blue, Color.green]
  
  private let shapes = [Shape.triangle, Shape.circle, Shape.square]
  
  private let numbers = [Number.one, Number.two, Number.three]
  
  var selectedCards: [Card] = []
  var matchedCards: [Card] = []
  var boardCards: [Card] = []
  var validSet = false
  
  init(maxNumberOfBoardCards: Int) {
    self.maxNumberOfBoardCards = maxNumberOfBoardCards
    initDeck()
  }
  
  func initDeck(){
    var index = 0
    for color in colors {
      for shade in shades {
        for number in numbers {
          for shape in shapes {
            let card = Card(cardID: index, shape: shape, color: color, shade: shade, number: number)
            cardDeck.append(card)
            index += 1
          }
        }
      }
    }
    cardDeck.shuffle()
    
    for i in 0...11 {
      boardCards.append(cardDeck.remove(at: i))
    }
    
  }
  
  func chooseCard(_ card: Card) {
    if selectedCards.count < 3, !selectedCards.contains(card) {
      selectedCards.append(card)
    } else {
      if let selectedCardID = selectedCards.firstIndex(of: card){
        selectedCards.remove(at: selectedCardID)
      }
    }
    if selectedCards.count == 3 {
      validSet = checkValidSet(firstCard: selectedCards[0], secondCard: selectedCards[1], thirdCard: selectedCards[2])
      if validSet{
        for card in selectedCards{
          boardCards.removeAll(where: { $0 == card })
        }
        matchedCards += selectedCards
        score += 3
      } else {
        score -= 3
      }
    }
  }
  
  func drawThreeMoreCards(){
    if boardCards.count < maxNumberOfBoardCards && cardDeck.count >= 3 {
      for i in 0...2 {
          boardCards.append(cardDeck.remove(at: i))
      }
    }
  }
  
  func checkValidSet(firstCard: Card, secondCard: Card, thirdCard: Card) -> Bool {
    let setColor = ((firstCard.color == secondCard.color) && (secondCard.color == thirdCard.color))  ||
      ((firstCard.color != secondCard.color) && (secondCard.color != thirdCard.color) && (firstCard.color != thirdCard.color))
    
    let setShape = (firstCard.shape == secondCard.shape) && (secondCard.shape == thirdCard.shape) ||
      ((firstCard.shape != secondCard.shape) && (secondCard.shape != thirdCard.shape) && (firstCard.shape != thirdCard.shape))
    
    let setShade = (firstCard.shade == secondCard.shade) && (secondCard.shade == thirdCard.shade) ||
      ((firstCard.shade != secondCard.shade) && (secondCard.shade != thirdCard.shade) && (firstCard.shade != thirdCard.shade))
    
    let setNumber = (firstCard.number == secondCard.number) && (secondCard.number == thirdCard.number) ||
      ((firstCard.number != secondCard.number) && (secondCard.number != thirdCard.number) && (firstCard.number != thirdCard.number))
    
    return setColor && setShape && setShade && setNumber
  }
  
  func reset() {
    score = 0
    selectedCards = []
    matchedCards = []
    boardCards = []
    
    for i in 0...11 {
      if cardDeck.count >= 3{
        boardCards.append(cardDeck.remove(at: i))
      }
    }
  }
  
}
