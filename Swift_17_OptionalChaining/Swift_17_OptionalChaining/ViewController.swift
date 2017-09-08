//
//  ViewController.swift
//  Swift_17_OptionalChaining
//
//  Created by VermouthC on 2017/9/5.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /**
     section 可选链式调用 --> Optional Chaining
     (1) 可选链式调用是一种可以在当前值可能为nil的可选值上请求和调用属性、方法及下标的方法
     (2) 通过在想调用的属性、方法、或下标的可选值后面放一个问号（?），可以定义一个可选链。这一点很像在可选值后面放一个叹号（!）来  强制展开它的值。它们的主要区别在于当可选值为空时可选链式调用只会调用失败，然而强制展开将会触发运行时错误。
     (3)返回结果都是一个可选值
     (4)
     */
    class Person {
        var residence: Residences?
    }
    
    class Residence {
        var numberOfRooms = 1
    }
    
    /*为可选链式调用定义模型类*/
    class Residences {
        var rooms = [Room]()
        var numberOfRooms: Int {
            return rooms.count
        }
        subscript(i: Int) -> Room {
            get {
                return rooms[i]
            }
            set {
                rooms[i] = newValue
            }
        }
        func printNumberOfRooms() {
            print("The number of rooms is \(numberOfRooms)")
        }
        var address: Address?
    }
    
    class Room {
        let name: String
        init(name: String) { self.name = name }
    }
    
    class Address {
        var buildingName: String?
        var buildingNumber: String?
        var street: String?
        func buildingIdentifier() -> String? {
            if buildingName != nil {
                return buildingName
            } else if buildingNumber != nil && street != nil {
                return "\(buildingNumber) \(street)"
            } else {
                return nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //可选链式调用提供了另一种访问numberOfRooms的方式，使用问号（?）来替代原来的叹号（!）：
        var john = Person()
        
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        // 打印 “Unable to retrieve the number of rooms.”
        
        /*通过可选链式调用来设置属性值：*/
        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"
        
        john.residence?.address = someAddress //通过john.residence来设定address属性也会失败，因为john.residence当前为nil
        //值过程是可选链式调用的一部分，这意味着可选链式调用失败时，等号右侧的代码不会被执行
        
        /*通过可选链式调用调用方法(void 类型 返回的是Void?)*/
        if john.residence?.printNumberOfRooms() != nil{
            
        }else{
        
        }
        
        /*通过可选链式调用访问下标*/
        if let firstRoomName = john.residence?[0].name{
        
        }else{
        
        }
        
        john.residence?[0] = Room(name:"BathRoom") //若residence为空nil 则赋值失败
        
        /*访问可选类型的下标*/
        //在下标的结尾括号后面放一个问号来在其可选返回值上进行可选链式调用
        var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
        testScores["Dave"]?[0] = 91
        testScores["Bev"]?[0] += 1
        testScores["Brian"]?[0] = 72
        
        /*在方法的可选返回值上进行可选链式调用*/
        if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
            print("John's building identifier is \(buildingIdentifier).")
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

