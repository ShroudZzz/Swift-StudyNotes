//
//  ViewController.swift
//  Swift_18_Error
//
//  Created by VermouthC on 2017/9/6.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /**
     section 错误处理 --> Error handling
     (1) 错误处理（Error handling）是响应错误以及从错误中恢复的过程
     (2) 在 Swift 中，错误用符合Error协议的类型的值来表示。这个空协议表明该类型可以用于错误处理
     (3) 抛出错误使用throw关键字。
     (4) 用 throwing 函数传递错误,一个函数、方法或构造器可以抛出错误，在函数声明的参数列表之后加上throws关键字,有throws关键字的函数被称作throwing 函数,一个 throwing 函数可以在其内部抛出错误，并将错误传递到函数被调用时的作用域。
     */
    
    enum VendingMachineError: Error {
        case invalidSelection                     //选择无效
        case insufficientFunds(coinsNeeded: Int) //金额不足
        case outOfStock                             //缺货
    }
    
    struct Item {
        var price: Int
        var count: Int
    }
    
    class VendingMachine {
        var inventory = [
            "Candy Bar": Item(price: 12, count: 7),
            "Chips": Item(price: 10, count: 4),
            "Pretzels": Item(price: 7, count: 11)
        ]
        var coinsDeposited = 0
        func dispenseSnack(snack: String) {
            print("Dispensing \(snack)")
        }
        
        func vend(itemNamed name: String) throws {
            guard let item = inventory[name] else {
                throw VendingMachineError.invalidSelection
            }
            
            guard item.count > 0 else {
                throw VendingMachineError.outOfStock
            }
            
            guard item.price <= coinsDeposited else {
                throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
            }
            
            coinsDeposited -= item.price
            
            var newItem = item
            newItem.count -= 1
            inventory[name] = newItem
            
            print("Dispensing \(name)")
        }
    }
    let favoriteSnacks = [
        "Alice": "Chips",
        "Bob": "Licorice",
        "Eve": "Pretzels",
        ]
    
    func buyFavoriteSnack(customer person: String, vendingMachine: VendingMachine) throws {
        let snackName = favoriteSnacks[person] ?? "Candy Bar"
        try vendingMachine.vend(itemNamed: snackName)
    }
    /*将错误转换成可选值(可以使用try?通过将错误转换成一个可选值来处理错误)*/
    /*
     func someThrowingFunction() throws -> Int {
     // ...
     }
     
     let x = try? someThrowingFunction()
     
     let y: Int?
     do {
        y = try someThrowingFunction()
     } catch {
        y = nil
     }
     */
    
    /*禁用错误传递*/
    //某个throwing函数实际上在运行时是不会抛出错误的，在这种情况下，你可以在表达式前面写try!来禁用错误传递，这会把调用包装在一个不会有错误抛出的运行时断言中。如果真的抛出了错误，你会得到一个运行时错误
    
    /*指定清理操作*/
    //使用defer语句在即将离开当前代码块时执行一系列语句。该语句让你能执行一些必要的清理工作，不管是以何种方式离开当前代码块的——无论是由于抛出错误而离开，还是由于诸如return或者break的语句
    //执行的操作会按照它们被指定时的顺序的相反顺序执行
    /*
    func processFile(filename: String) throws {
        if exists(filename) {
            let file = open(filename)
            defer {
                close(file)  //清理文件收尾操作
            }
            while let line = try file.readline() {
                // 处理文件。
            }
            // close(file) 会在这里被调用，即作用域的最后。
        }
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*do-catch(如果在do子句中的代码抛出了一个错误，这个错误会与catch子句做匹配，从而决定哪条子句能处理它)*/
        var vendingMachine = VendingMachine()
        vendingMachine.coinsDeposited = 8
        do {
            try buyFavoriteSnack(customer:"Alice", vendingMachine: vendingMachine)
        } catch VendingMachineError.invalidSelection {
            print("Invalid Selection.")
        } catch VendingMachineError.outOfStock {
            print("Out of Stock.")
        } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
            print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
        } catch {
            //未知错误
            print("Some other error occured")
        }
        // 打印 “Insufficient funds. Please insert an additional 2 coins.”
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

