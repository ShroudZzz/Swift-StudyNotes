//
//  ViewController.swift
//  Swift_11_Methods
//
//  Created by VermouthC on 2017/9/4.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /**
     section 方法 --> Methods
     (1) 类、结构体、枚举都可以定义实例方法；实例方法为给定类型的实例封装了具体的任务与功能
     (2) 类、结构体、枚举也可以定义类型方法；类型方法与类型本身相关联。类型方法与 Objective-C 中的类方法（class methods）相似
     */
    
    /*实例方法*/
    //实例方法是属于某个特定类、结构体或者枚举类型实例的方法。实例方法提供访问和修改实例属性的方法或提供与实例目的相关的功能，并以此来支撑实例的功能。实例方法的语法与函数完全一致
    class Counter {
        var count = 0
        func increment() {
            self.count += 1
        }
        func increment(by amount: Int) {
            count += amount
        }
        func reset() {
            count = 0
        }
    }
    
    //使用self消除方法参数和实例属性之间的歧义
    struct Point {
        var x = 0.0, y = 0.0
        func isToTheRightOfX(x: Double) -> Bool {
            return self.x > x
        }
    }
    
    /*实例方法中修改值类型(结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。)*/
    //某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择可变(mutating)行为，然后就可以从其方法内部改变它的属性；并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中
    struct Points {
        var x = 0.0, y = 0.0
        mutating func moveByX(deltaX: Double, y deltaY: Double) {
            x += deltaX
            y += deltaY
        }
    }
    
    /*可变方法中给self赋值*/
    struct Points_mutating {
        var x = 0.0, y = 0.0
        mutating func moveBy(x deltaX: Double, y deltaY: Double) {
            self = Points_mutating(x: x + deltaX, y: y + deltaY)
        }
    }
    
    //枚举的可变方法可以把self设置为同一枚举类型中不同的成员：
    enum TriStateSwitch {
        case Off, Low, High
        mutating func next() {
            switch self {
            case .Off:
                self = .Low
            case .Low:
                self = .High
            case .High:
                self = .Off
            }
        }
    }
    
    /*类型方法(方法的func关键字之前加上关键字static，来指定类型方法)*/
    //类型方法的方法体（body）中，self指向这个类型本身，而不是类型的某个实例。这意味着你可以用self来消除类型属性和类型方法参数之间的歧义
    struct LevelTracker {
        static var highestUnlockedLevel = 1
        var currentLevel = 1
        
        static func unlock(_ level: Int) {
            if level > highestUnlockedLevel { highestUnlockedLevel = level }
        }
        
        static func isUnlocked(_ level: Int) -> Bool {
            return level <= highestUnlockedLevel
        }
        
        @discardableResult //允许在调用advance(to:)时候忽略返回值，不会产生编译警告，所以函数被标注为@ discardableResult属性
        mutating func advance(to level: Int) -> Bool {
            if LevelTracker.isUnlocked(level) {
                currentLevel = level
                return true
            } else {
                return false
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*调用实例方法*/
        let counter = Counter()
        // 初始计数值是0
        counter.increment()
        // 计数值现在是1
        counter.increment(by: 5)
        // 计数值现在是6
        counter.reset()
        // 计数值现在是0
        
        var somePoint = Points(x: 1.0, y: 1.0)
        somePoint.moveByX(deltaX: 2.0, y: 3.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))")
        
        //不能在结构体类型的常量（a constant of structure type）上调用可变方法，因为其属性不能被改变
        //let fixedPoint = Point(x: 3.0, y: 3.0)
        //fixedPoint.moveByX(2.0, y: 3.0)
        // 这里将会报告一个错误
        
        var ovenLight = TriStateSwitch.Low
        ovenLight.next()
        // ovenLight 现在等于 .High
        ovenLight.next()
        // ovenLight 现在等于 .Off
        
        /*类型方法*/

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

