//
//  ViewController.swift
//  Swift_13_Inheritance
//
//  Created by VermouthC on 2017/9/5.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class Vehicle {
    var currentSpeed = 0.0
    var description: String{
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        
    }
    
}

class Bicycle: Vehicle {
    var hasBasket = false
}

class Train: Vehicle {
    /*重写方法*/
    override func makeNoise() {
        print("Choo Choo")
    }
}

class Car: Vehicle {
    var gear = 1
    override var description: String{
      return super.description+"in gear \(gear)"
    }
    
}

/*重写属性观察器*/
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

class ViewController: UIViewController {
    /**
     section 继承 --> Inheritance
     (1)重写:子类可以为继承来的实例方法，类方法，实例属性，类型属性或下标提供自己定制的实现
     (2)重写定义的前面加上override关键字
     (3)super前缀来访问超类版本的方法，属性或下标
     (4)不可以将一个继承来的读写属性重写为一个只读属性
     (5)不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器。这些属性的值是不可以被设置的，所以，为它们提供willSet或didSet实现是不恰当
     (6)不可以同时提供重写的 setter 和重写的属性观察器
     (7)通过把方法，属性或下标标记为final来防止它们被重写，只需要在声明关键字前加上final修饰符即可（例如：final var，final func，final class func，以及final subscript）
     (8)重写属性中提供了 setter，那么你也一定要提供 getter
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.]
        let someVehicle = Vehicle()
        print("Vehicle: \(someVehicle.description)")
        
        let bicycle = Bicycle()
        bicycle.hasBasket = true
        bicycle.currentSpeed = 15.0
        print("Bicycle: \(bicycle.description)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

