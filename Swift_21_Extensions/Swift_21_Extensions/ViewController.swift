//
//  ViewController.swift
//  Swift_21_Extensions
//
//  Created by VermouthC on 2017/9/6.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

  /*计算型属性(扩展可以添加新的计算型属性，但是不可以添加存储型属性，也不可以为已有属性添加属性观察器。)*/
extension Double{
    var km:Double {return self*1_000.0}
    var m : Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

func double_extension(){
    let onInch = 25.4.mm
    let threeFeet = 3.ft
    
}

/*构造器(扩展能为类添加新的便利构造器，但是它们不能为类添加新的指定构造器或析构器)*/
//如果你使用扩展为一个值类型添加构造器，同时该值类型的原始实现中未定义任何定制的构造器且所有存储属性提供了默认值，那么我们就可以在扩展中的构造器里调用默认构造器和逐一成员构造器
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
//因为结构体 Rect 未提供定制的构造器，因此它会获得一个逐一成员构造器。又因为它为所有存储型属性提供了默认值，它又会获得一个默认构造器。

extension Rect{
    init(center:Point,size:Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

/*方法(扩展可以为已有类型添加新的实例方法和类型方法)*/
extension Int{
    func repetitions(task:()->Void){
        for _ in 0..<self {
            task()
        }
    }
}
//这个 repetitions(task:) 方法接受一个 () -> Void 类型的单参数，表示没有参数且没有返回值的函数。
//定义该扩展之后，你就可以对任意整数调用 repetitions(task:) 方法，将闭包中的任务执行整数对应的次数：
func int_extension (){
    3.repetitions({
        print("Hello !")
    })
    //尾随闭方法
    2.repetitions{
        print("GoodBye")
    }
}

/*可变实例变量(通过扩展添加的实例方法也可以修改该实例本身)*/
extension Int {
    mutating func square() {
        self = self * self
    }
}
//结构体和枚举类型中修改 self 或其属性的方法必须将该实例方法标注为 mutating

/*下标*/
extension Int{
    subscript(digitIndex:Int)->Int{
       var decimalBase = 1
        for _ in 0..<digitIndex{
            decimalBase *= 10
        }
        return (self/decimalBase)%10
    }
}


/*嵌套类型(扩展可以为已有的类、结构体和枚举添加新的嵌套类型)*/
extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}

func printIntegerKinds(_ numbers:[Int]) {
    for number in numbers {
        switch number.Kind {
        case .Negative:
            print("- ", terminator: "")
        case .Zero:P
             print("0 ", terminator: "")
        case .Positive:
            print("+ ", terminator: "")
        }
    }
}

class ViewController: UIViewController {
    /**
     section 扩展类型 --> Extensions
     (1) 扩展 就是为一个已有的类、结构体、枚举类型或者协议类型添加新功能。这包括在没有权限获取原始源代码的情况下扩展类型的能力（即  逆向建模 ）。扩展和 Objective-C 中的分类类似。（与 Objective-C 不同的是，Swift 的扩展没有名字。）
     (2) Swift 中的扩展可以：
            添加计算型属性和计算型类型属性
            定义实例方法和类型方法
            提供新的构造器
            定义下标
            定义和使用新的嵌套类型
            使一个已有类型符合某个协议
      (3)扩展语法
           extension SomeType {
               // 为 SomeType 添加的新功能写到这里
           }
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

