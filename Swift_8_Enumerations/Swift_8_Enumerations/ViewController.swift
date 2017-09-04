//
//  ViewController.swift
//  Swift_8_Enumerations
//
//  Created by VermouthC on 2017/9/4.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /**
     section 枚举 --> Enumerations
     (1) 使用case关键字定义一个新的枚举成员值
     (2) <#description#>
     */
    
    enum CompassPoint {
        case north
        case south
        case east
        case west
    }
    /*
     注意
     与 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值
     */
    
    enum Planet {
        case mercury,venus,earth,mars,jupiter,saturn,uranus,meptune
    }
    
    var directionToHead = CompassPoint.west
    func enum_func() {
        //一旦directionToHead被声明为CompassPoint类型，你可以使用更简短的点语法将其设置为另一个CompassPoint的值
        directionToHead = .north
        /* 使用Switch语句匹配枚举值 (提供一个default分支来涵盖所有未明确处理的枚举成员)*/
        
        switch directionToHead {
        case .north:
            print("Lots of planets have a north")
        case .south:
            print("Watch out for penguins")
        case .east:
            print("Where the sun rises")
        case .west:
            print("Where the skies are blue")
        }
    }
    
    /*关联值*/
    //这个定义不提供任何Int或String类型的关联值，它只是定义了，当Barcode常量和变量等于Barcode.upc或Barcode.qrCode时，可以存储的关联值的类型
    enum Barcode {
        case upc(Int,Int,Int,Int)
        case qrCode(String)
    }
    
    func enum_func_unions() {
        var produceBarcode = Barcode.upc(8, 100, 90, 34)
        produceBarcode = .qrCode("Chen")
        
        switch produceBarcode {
        case .upc(let numberSystem, let manufacturer, let product, let check):
            print("UPC:\(numberSystem),\(manufacturer),\(product),\(check)")
        case .qrCode(let productCode) :
            print("QR: \(productCode)")
        default:
            break
        }
        //如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量,可以只在成员名称前标注一个let或者var
        /*
         switch productBarcode {
         case let .upc(numberSystem, manufacturer, product, check):
             print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
         case let .qrCode(productCode):
             print("QR code: \(productCode).")
         }
         */
    }
    
    /*原始值*/
    //原始值可以是字符串，字符，或者任意整型值或浮点型值。每个原始值在枚举声明中必须是唯一的。
    enum ASCIIControlCharacter: Character {
        case tab = "\t"
        case lineFeed = "\n"
        case carriageReturn = "\r"
    }
    //原始值的隐式赋值,使用整数作为原始值时，隐式赋值的值依次递增1。如果第一个枚举成员没有设置原始值，其原始值将为0
    enum NumberOfPlanet : Int {
        case one = 1,two,three
    }
    //用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称
    enum StringOfCompassPoint:String {
        case north,south,east,west
    }
    func rawValue(){
        //枚举成员的rawValue属性可以访问该枚举成员的原始值
        let earthsOrder = NumberOfPlanet.one.rawValue
        let sunsetDirection = StringOfCompassPoint.west.rawValue
    }
    
    /* 使用原始值初始化枚举实例*/
    let possiblePlanet = NumberOfPlanet(rawValue:7)//返回可选类型
    
    /* 递归枚举*/
    //递归枚举是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值。使用递归枚举时，编译器会插入一个间接层。你可以在枚举成员前加上indirect来表示该成员可递归
//    enum ArithmeticExpression {
//        case number(Int)
//        indirect case addition(ArithmeticExpression, ArithmeticExpression)
//        indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
//    }
    
    indirect enum ArithmeticExpression {
        case number(Int)
        case addition(ArithmeticExpression, ArithmeticExpression)
        case multiplication(ArithmeticExpression, ArithmeticExpression)
    }
    //(5+4)*2
    func indirect(){
        let five = ArithmeticExpression.number(5)
        let four = ArithmeticExpression.number(4)
        let sum = ArithmeticExpression.addition(five, four)
        let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
    }
    
    func evaluate(_ expression: ArithmeticExpression) -> Int {
        switch expression {
        case let .number(value):
            return value
        case let .addition(left, right):
            return evaluate(left) + evaluate(right)
        case let .multiplication(left, right):
            return evaluate(left) * evaluate(right)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let number = evaluate(ArithmeticExpression.multiplication(ArithmeticExpression.number(5), ArithmeticExpression.number(4)))
        print("Result is \(number)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

