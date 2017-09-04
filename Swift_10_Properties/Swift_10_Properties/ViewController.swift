//
//  ViewController.swift
//  Swift_10_Properties
//
//  Created by VermouthC on 2017/9/4.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    /**
     section 属性 --> Properties
     (1)存储属性存储常量或变量作为实例的一部分，而计算属性计算（不是存储）一个值。计算属性可以用于类、结构体和枚举，存储属性只能用于类和结构体。
     (2)属性也可以直接作用于类型本身，这种属性称为类型属性。
     (3)定义属性观察器来监控属性值的变化，以此来触发一个自定义的操作。属性观察器可以添加到自己定义的存储属性上，也可以添加到从父类继承的属性上
     (4)Swift 中的属性没有对应的实例变量，属性的后端存储也无法直接访问。
     */
    
    /*存储属性*/
    struct FixedLengthRange {
        var firstValue:Int
        let length: Int
    }
    
    /*延迟存储属性*/
    //延迟存储属性是指第一次被调用的时候才会计算其初始值的属性 在属性声明前使用 lazy 来标示一个延迟存储属性
    /*注意: (1)必须将延迟存储属性声明成变量（使用 var 关键字），因为属性的初始值可能在实例构造完成之后才会得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性。
              (2)如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。
    */
    class DataImporter {
        var fileName = "data.txt"
    }
    
    class DataManager {
        lazy var importer = DataManager()
        var data = [String]()
    }
    
    /*计算属性*/
    //类、结构体和枚举可以定义计算属性。计算属性不直接存储值，而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值
    struct Point {
        var x = 0.0, y = 0.0
    }
    struct Size {
        var width = 0.0, height = 0.0
    }
    
    struct Rect {
        var origin = Point()
        var size = Size()
        var center : Point{
            get{
                let centerX = origin.x + (size.width/2)
                let centerY = origin.y + (size.height/2)
                return Point(x:centerX,y:centerY)
            }
            
            set(newCenter){
                origin.x = newCenter.x - (size.width / 2)
                origin.y = newCenter.y - (size.height / 2)
            }
        }
        
    }
    
    //计算属性的 setter 没有定义表示新值的参数名，则可以使用默认名称 newValue
    struct AlternativeRect {
        var origin = Point()
        var size = Size()
        var center: Point {
            get {
                let centerX = origin.x + (size.width / 2)
                let centerY = origin.y + (size.height / 2)
                return Point(x: centerX, y: centerY)
            }
            set {
                origin.x = newValue.x - (size.width / 2)
                origin.y = newValue.y - (size.height / 2)
            }
        }
    }
    
    //只读计算属性 只有 getter 没有 setter 的计算属性就是只读计算属性。只读计算属性总是返回一个值，可以通过点运算符访问，但不能设置新的值 ,只读计算属性的声明可以去掉 get 关键字和花括号：
    struct Cuboid {
        var width = 0.0, height = 0.0, depth = 0.0
        var volume: Double {
            return width * height * depth
        }
    }
   
    /*属性观察器*/
    /*(1)属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器
     (2)注意
     父类的属性在子类的构造器中被赋值时，它在父类中的 willSet 和 didSet 观察器会被调用，随后才会调用子类的观察器。在父类初始化方法调用之前，子类给属性赋值时，观察器不会被调用
     (3)注意:
     如果将属性通过 in-out 方式传入函数，willSet 和 didSet 也会调用。这是因为 in-out 参数采用了拷入拷出模式：即在函数内部使用的是参数的 copy，函数结束后，又对参数重新赋值
     (4)全局的常量或变量都是延迟计算的，跟延迟存储属性相似，不同的地方在于，全局的常量或变量不需要标记lazy修饰符。
     局部范围的常量或变量从不延迟计算
     */
    
    //willSet 在新的值被设置之前调用   didSet 在新的值被设置之后立即调用
    class StepCounter {
        var totalSteps :Int = 0{
            willSet(newTotalSteps){
               print("About to set totalSteps to \(newTotalSteps)")
            }
            
            didSet{
                if totalSteps > oldValue  {
                    print("Added \(totalSteps - oldValue) steps")
                }
            }
        }
        
    }
    
    /* 类型属性*/
    //类型本身定义属性，无论创建了多少个该类型的实例，这些属性都只有唯一一份
    //存储型类型属性可以是变量或常量，计算型类型属性跟实例的计算型属性一样只能定义成变量属性。
    //关键字 static 来定义类型属性。在为类定义计算型类型属性时，可以改用关键字 class 来支持子类对父类的实现进行重写
    /*注意:
    跟实例的存储型属性不同，必须给存储型类型属性指定默认值，因为类型本身没有构造器，也就无法在初始化过程中使用构造器给类型属性赋值。
    存储型类型属性是延迟初始化的，它们只有在第一次被访问的时候才会被初始化。即使它们被多个线程同时访问，系统也保证只会对其进行一次初始化，并且不需要对其使用 lazy 修饰符
     */
    
    struct SomeStructure {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 1
        }
    }
    
    enum SomeEnumeration {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 6
        }
    }
    
    class SomeClass {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 27
        }
        class var overrideableComputedTypeProperty: Int {
            return 107
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var rangeOfThreeItems = FixedLengthRange(firstValue:0,length:3)
        rangeOfThreeItems.firstValue = 6
        //当用let声明,则无法修改实例的任何属性
        let letRangeOfThreeItems = FixedLengthRange(firstValue:0,length:4)
        //letRangeOfThreeItems.firstValue = 9 //报错
        //结构体（struct）属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量。属于引用类型的类（class）则不一样。把一个引用类型的实例赋给一个常量后，仍然可以修改该实例的变量属性
        
        let manager = DataManager()
        manager.data.append("Some  data")
        manager.data.append("Some more data")

        //只有当第一次使用importer属性的时候才会创建相应的实例
        print(manager.importer);
        
        /*计算属性*/
        var square = Rect(origin:Point(x:0.0,y:0.0),size:Size(width:10.0,height:10.0))
        let intitalSquareCenter = square.center
        square.center = Point(x: 15.0, y: 15.0)
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
        
        let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
        print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
        
        /*获取和设置类型属性的值*/
        print(SomeStructure.storedTypeProperty)
        // 打印 "Some value."
        SomeStructure.storedTypeProperty = "Another value."
        print(SomeStructure.storedTypeProperty)
        // 打印 "Another value.”
        print(SomeEnumeration.computedTypeProperty)
        // 打印 "6"
        print(SomeClass.computedTypeProperty)
        // 打印 "27"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

