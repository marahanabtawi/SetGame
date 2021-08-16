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
    // FIXME: this nested forloops implementation could be moved to a seperate function (initDeck()), init shouldn't be complicated
    for color in colors {
      for shade in shades {
        for number in numbers {
          for shape in shapes {
            // FIXME: cardID always 0 ?!
            let card = Card(cardID: 0, shape: shape, color: color, shade: shade, number: number)
            cardDeck += [card]  // FIXME: use [].append to add an element instead of concatination
          }
        }
      }
    }
    self.maxNumberOfBoardCards = maxNumberOfBoardCards
    // FIXME: you could've used cardDeck.shuffle()
    cardDeck = shuffleCardDeck()
    
    // FIXME: no need for this loop, find a better way to assign IDs to cards in the nested loop above
    for index in cardDeck.indices {
      cardDeck[index].cardID = index
    }
   
    for i in 0...11 {
      boardCards += [cardDeck[i]]  // FIXME: use [].append to add an element instead of concatination
    }
    // FIXME: you could use in the loop above " boardCards += cardDeck.remove(at: i) to get rid of this v.v
    cardDeck.removeSubrange(ClosedRange(uncheckedBounds: (lower: 0, upper: 11)))
  }
  
  func shuffleCardDeck() -> [Card] {
    var shuffledCardDeck = [Card]()
    for _ in cardDeck.indices {
      let randomIndex = Int(arc4random_uniform(UInt32(cardDeck.count)))
      shuffledCardDeck.append(cardDeck[randomIndex])
      cardDeck.remove(at: randomIndex)
    }
    return shuffledCardDeck
  }
  
  func chooseCard(_ card: Card) {
    if selectedCards.count < 3, !selectedCards.contains(card) {
      selectedCards += [card] // FIXME: use [].append to add an element instead of concatination
    } else {
      if let selectedCardID = selectedCards.firstIndex(of: card), selectedCards.count <= 3 {
        selectedCards.remove(at: selectedCardID)
      }
    }
    if selectedCards.count == 3 {
      validSet = checkValidSet(firstCard: selectedCards[0], secondCard: selectedCards[1], thirdCard: selectedCards[2])
      if validSet{
        matchedCards += selectedCards
        // FIXME: you could just empty selectedCards "= []" or .removeAll
        for card in selectedCards{
          boardCards.removeAll(where: { $0 == card })
        }
        score += 3
      } else {
        score -= 3
        // FIXME: you initialized it again you could just empty by = [] && you will always empty the array so move it to the outer scope
        selectedCards = [Card]()
      }
      
    }
  }
  
  func drawThreeMoreCards() {
    if boardCards.count < maxNumberOfBoardCards && cardDeck.count >= 3 {
      for i in 0...2 {
        boardCards += [cardDeck[i]]//FIXME: use .append(cardDeck.remove(at: i)) instead to get rid of what's after the loop
      }
      cardDeck.removeSubrange(ClosedRange(uncheckedBounds: (lower: 0, upper: 2)))
    }
  }
  
  
  // FIXME: Refactor this
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
  
  // FIXME: No need for this function
  func reset() {
    score = 0
    // FIXME: why re-initialize when you just want to empty the array
    selectedCards = [Card]()
    matchedCards = [Card]()
    boardCards = [Card]()
    
     for i in 0...11 {
      if cardDeck.count >= 3{
       boardCards += [cardDeck[i]]
      }
     }
    cardDeck.removeSubrange(ClosedRange(uncheckedBounds: (lower: 0, upper: 11)))
  }
  
}
