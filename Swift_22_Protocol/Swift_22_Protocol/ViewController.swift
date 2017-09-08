//
//  ViewController.swift
//  Swift_22_Protocol
//
//  Created by VermouthC on 2017/9/7.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit
/*属性要求*/
/*
 (1)协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性
 (2)协议不指定属性是存储型属性还是计算型属性，它只指定属性的名称和类型
 (3)协议还指定属性是可读的还是可读可写的
 */
protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}
//类类型
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    //协议表示，任何遵循 FullyNamed 的类型，都必须有一个可读的 String 类型的实例属性 fullName
    var fullName: String
}

/*方法要求*/
/*
 (1)协议可以要求遵循协议的类型实现某些指定的实例方法或类方法
 (2)方法作为协议的一部分，像普通方法一样放在协议的定义中，但是不需要大括号和方法体
 (3)可以在协议中定义具有可变参数的方法，和普通方法的定义方式相同
 (4)不支持为协议中的方法的参数提供默认值
 (5)实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字。而对于结构体和枚举，则必须写 mutating 关键字。
 */
protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}

/*构造器要求*/
/*
 (1)协议可以要求遵循协议的类型实现指定的构造器
 (2)遵循协议的类中实现构造器，无论是作为指定构造器，还是作为便利构造器,必须为构造器实现标上 required 修饰符(使用 required 修饰符可以确保所有子类也必须提供此构造器实现，从而也能符合协议)
 (3)子类重写了父类的指定构造器，并且该构造器满足了某个协议的要求，那么该构造器的实现需要同时标注 required 和 override 修饰符
 */

protocol SomeProtocols {
    init(someParameter: Int)
}

class SomeClass: SomeProtocols {
    required init(someParameter: Int) {
        // 这里是构造器的实现部分
    }
}

/*协议作为类型(协议本身并未实现任何功能，但是协议可以被当做一个成熟的类型来使用)*/
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator //任何遵循了 RandomNumberGenerator 协议的类型的实例都可以赋值给 generator，除此之外并无其他要求
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

/*委托(代理)模式*/
protocol DiceGame {
    var dice: Dice{ get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    var dice: Dice = Dice(sides:6,generator:LinearCongruentialGenerator())
    var square = 0
    var board : [Int]
    init() {
        board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

/*通过扩展添加协议一致性(无法修改源代码，依然可以通过扩展令已有类型遵循并符合协议)*/
protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

/*通过扩展遵循协议(当一个类型已经符合了某个协议中的所有要求，却还没有声明遵循该协议时，可以通过空扩展体的扩展来遵循该协议)*/
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}

/*协议类型集合(协议类型可以在数组或者字典这样的集合中使用)*/
let things: [TextRepresentable] = []

/*协议的继承*/
/*
 protocol InheritingProtocol: SomeProtocol, AnotherProtocol {

 }
 */
protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

/*类类型专属协议(通过添加 class 关键字来限制协议只能被类类型遵循，而结构体或枚举不能遵循该协议)*/
/*
 protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol {
 // 这里是类类型专属协议的定义部分
 }
 */

/*协议合成(多个协议采用 SomeProtocol & AnotherProtocol 这样的格式进行组合，称为 协议合成（protocol composition）)*/
protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Persons: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    //Named & Aged。这意味着它不关心参数的具体类型，只要参数符合这两个协议即可
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

/*检查协议的一致性(使用类型转换中描述的 is 和 as 操作符来检查协议一致性，即是否符合某协议，并且可以转换到指定的协议类型)*/
/*
 is 用来检查实例是否符合某个协议，若符合则返回 true，否则返回 false。
 as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回 nil。
 as! 将实例强制向下转换到某个协议类型，如果强转失败，会引发运行时错误。
 */
protocol HasArea {
    var area:Double{get}
    
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}

class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

func protocol_test(){
    let objects: [AnyObject] = [
        Circle(radius: 2.0),
        Country(area: 243_610),
        Animal(legs: 4)
    ]
    
    for object in objects {
        if let objectWithArea = object as? HasArea {
            print("Area is \(objectWithArea.area)")
        } else {
            print("Something that doesn't have an area")
        }
    }
    // Area is 12.5663708
    // Area is 243610.0
    // Something that doesn't have an area
}

/*可选的协议要求(协议可以定义可选要求，遵循协议的类型可以选择是否实现这些要求)*/
@objc protocol CounterDataSource {
    @objc optional func incrementForCount(count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

/*协议扩展(协议可以通过扩展来为遵循协议的类型提供属性、方法以及下标的实现)*/
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

/*协议扩展添加限制条件(扩展协议的时候，可以指定一些限制条件，只有遵循协议的类型满足这些限制条件时，才能获得协议扩展提供的默认实现)*/
//只适用于集合中的元素遵循了 TextRepresentable 协议的情况
extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

class ViewController: UIViewController {
    /**
     section 协议 --> Protocol
     (1) 协议 定义了一个蓝图，规定了用来实现某一特定任务或者功能的方法、属性，以及其他需要的东西
     (2) 类、结构体或枚举都可以遵循协议，并为协议定义的这些要求提供具体实现
     (3) /*
                protocol SomeProtocol {
                    这里是协议的定义部分
                }
           */
     (4) 要让自定义类型遵循某个协议，在定义类型时，需要在类型名称后加上协议名称，中间以冒号（:）分隔。遵循多个协议时，各协议之间用逗号（,）分隔：
         /*
                struct SomeStructure: FirstProtocol, AnotherProtocol {
                     这里是结构体的定义部分
                }
        */
     (5) 拥有父类的类在遵循协议时，应该将父类名放在协议名之前，以逗号分隔：
        /*
                class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
                    这里是类的定义部分
                }
        */
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

