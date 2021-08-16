//
//  Card.swift
//  SetGame
//
//  Created by marah anabtawi on 10/08/2021.
//

import Foundation

struct Card: Hashable{
  
  static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.cardID == rhs.cardID
    }
  
  var cardID: Int
  let shape: Shape
  let color: Color
  let shade: Shade
  let number: Number

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
  
 
