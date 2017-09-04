//
//  ViewController.swift
//  Swift_9_ClassAndStruct
//
//  Created by VermouthC on 2017/9/4.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /**
     section 类和结构体 --> ClassAndStruct
     (1) Swift 中类和结构体有很多共同点。共同处在于：
            定义属性用于存储值
            定义方法用于提供功能
            定义下标操作使得可以通过下标语法来访问实例所包含的值
            定义构造器用于生成初始化值
            通过扩展以增加默认实现的功能
            实现协议以提供某种标准功能
     (2) 结构体相比，类还有如下的附加功能：
            继承允许一个类继承另一个类的特征
            类型转换允许在运行时检查和解释一个类实例的类型
            析构器允许一个类实例释放任何其所被分配的资源
            引用计数允许对一个类的多次引用
     */
    /* 定义*/
    class SomeClass{
        
    }
    
    struct SomeStructure {
        
    }
    
    struct Resolution {
        var width = 0
        var height = 0
    }
    
    class VideoMode {
        var resolution = Resolution()
        var interlaced = false
        var frameRate = 0.0
        var name :String?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*生成实例*/
        //结构体和类都使用构造器语法来生成新的实例。构造器语法的最简单形式是在结构体或者类的类型名称后跟随一对空括号，如Resolution()或VideoMode()
        let someResolution = Resolution()
        let someVideoMode = VideoMode()
        /*属性访问(点语法)*/
        let property = someVideoMode.frameRate
        
        /*结构体类型的成员逐一构造器(类实例没有默认的成员逐一构造器)*/
        //结构体都有一个自动生成的成员逐一构造器，用于初始化新结构体实例中成员的属性。新实例中各个属性的初始值可以通过属性的名称传递到成员逐一构造器之中
        let vga = Resolution(width:640,height:480)
        
        /*结构体和枚举值是值类型*/
        //值类型(基本数据类型 整数 浮点数 布尔值 字符串 字典 数组)被赋予给一个变量 常量或者被传递给一个函数的时候  其值会被拷贝
        let hd = Resolution(width: 1920, height: 1080)
        var cinema = hd
        
        /*类是引用类型*/
        let tenEighty = VideoMode()
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        
        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        //tenEight和alsoTenEight实际上引用的是相同的VideoMode实例
        /*注意:
           tenEighty和alsoTenEighty被声明为常量而不是变量。然而你依然可以改变tenEighty.frameRate和alsoTenEighty.frameRate，因为tenEighty和alsoTenEighty这两个常量的值并未改变。它们并不“存储”这个VideoMode实例，而仅仅是对VideoMode实例的引用。所以，改变的是被引用的VideoMode的frameRate属性，而不是引用VideoMode的常量的值
         */
        
        /*恒等运算符 等价于（===） 不等价于（!==）检测两个常量或者变量是否引用同一个实例*/
        if tenEighty === alsoTenEighty {
            print("tenEighty and alsoTenEighty refer to the same Resolution instance.")
        }
        
        /*注意:
         “等价于”（用三个等号表示，===）与“等于”（用两个等号表示，==）的不同：
         “等价于”表示两个类类型（class type）的常量或者变量引用同一个类实例。
         “等于”表示两个实例的值“相等”或“相同”，判定时要遵照设计者定义的评判标准，因此相对于“相等”来说，这是一种更加合适的叫法。
         */
        
        /*结构体选择:
         该数据结构的主要目的是用来封装少量相关简单数据值。
         有理由预计该数据结构的实例在被赋值或传递时，封装的数据将会被拷贝而不是被引用。
         该数据结构中储存的值类型属性，也应该被拷贝，而不是被引用。
         该数据结构不需要去继承另一个既有类型的属性或者行为。
         */
        
          /*
         字符串、数组、和字典类型的赋值与复制行为
         Swift 中，许多基本类型，诸如String，Array和Dictionary类型均以结构体的形式实现。这意味着被赋值给新的常量或变量，或者被传入函数或方法中时，它们的值会被拷贝。
         
         Objective-C 中NSString，NSArray和NSDictionary类型均以类的形式实现，而并非结构体。它们在被赋值或者被传入函数或方法时，不会发生值拷贝，而是传递现有实例的引用。
         */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

