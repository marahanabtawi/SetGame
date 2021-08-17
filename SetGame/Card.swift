//
//  Card.swift
//  SetGame
//
//  Created by marah anabtawi on 10/08/2021.
//

import Foundation

struct Card{
  
  var cardID: Int
  let shape: Shape
  let color: Color
  let shade: Shade
  let number: Number

}

extension Card: Hashable{
  static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.cardID == rhs.cardID
    }
}

 enum Number{
    case one 
    case two
    case three
  }
  
  enum Color{
    case red
    case blue
    case green
  }
  
  enum Shade{
    case fill
    case open
    case striped
  }
  enum Shape{
    case circle
    case triangle
    case square
  }
  
 
