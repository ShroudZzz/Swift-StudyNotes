//
//  ViewController.swift
//  Swift_20_NestedType
//
//  Created by VermouthC on 2017/9/6.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

struct BlackjackCard {
    enum Suit: Character{
        case Spades = "♠",Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
    
    //嵌套Rank枚举
    enum Rank:Int {
        case Two = 2,Three,Four,Five,Six,Seven,Eight,Nine,Ten
        case Jack,Queen,King,Ace
        
        struct Values{
            let first: Int,second:Int?
        }
        
        var values: Values{
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard 的属性和方法
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
    
    //引用嵌套类型
    let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue
}

class ViewController: UIViewController {
    /**
     section 嵌套类型 --> Nested Type
     (1) <#description#>
     (2) <#description#>
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
        print("theAceOfSpades: \(theAceOfSpades.description)")
        
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

