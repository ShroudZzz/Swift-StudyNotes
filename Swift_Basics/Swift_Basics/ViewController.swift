//
//  ViewController.swift
//  Swift_Basics
//
//  Created by VermouthC on 2017/8/4.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    /** 
     section one --> 声明
     (1)常量和变量必须在使用前声明，用 let 来声明常量，用 var 来声明变量
     (2)声明多个常量和变量 使用都好隔开
    */
    let maxNumberOfLoginCount = 10
    var currentLoginCount = 0
    var x = 0 , y = 1
    
    /**
     section one --> 类型标注
     (1)type annotation 表示可以存储对应的类型
     注: 很少需要写类型标注。声明常量或者变量的时候赋了一个初始值，Swift可以推断出这个常量或者变量的类型
     */
    var welcomeMessage: String = ""
    
    /**
     section one --> 输出
     (1)print(_:separator:terminator:) 是一个用来输出一个或多个值到适当输出区的全局函数
         separator 和 terminator 参数具有默认值，调用这个函数的时候可以忽略它们
     (2)Swift 用字符串插值（string interpolation）的方式把常量名或者变量名当做占位符加入到长字符串中，Swift 会用当前常量或变量的值替换这些占位符。将常量或变量名放入圆括号中，并在开括号前使用反斜杠将其转义
     */
    func p_print(){
        print(maxNumberOfLoginCount)
        print("The current value of friendlyWelcome is \(welcomeMessage)")
    }
    
    /**
     section one --> 整数
     (1) 整数可以是 有符号（正、负、零）或者 无符号（正、零）
     (2) Swift 提供了8，16，32和64位的有符号和无符号整数类型 
          8位无符号整数类型是UInt8，32位有符号整数类型是 Int32
     (3) 整数类型的 min 和 max 属性来获取对应类型的最小值和最大值
     (4) 整数类型Int(无符号类型 UInt)，长度与当前平台的原生字长相同：
          在32位平台上，Int 和 Int32 长度相同。
          在64位平台上，Int 和 Int64 长度相同。
     */
    let minValue = UInt8.min
    let maxValue = UInt8.max
    
    /**
     section one --> 浮点数
     (1) Double表示64位浮点数。当你需要存储很大或者很高精度的浮点数时请使用此类型。
          Float表示32位浮点数。精度要求不高的话可以使用此类型。
     注意：
     Double精确度很高，至少有15位数字，而Float只有6位数字。选择哪个类型取决于你的代码需要处理的值的范围，在两种类型都匹配的情况下，将优先选择 Double
     */
    
    /**
     section one --> 类型安全 类型推断
     (1) 类型安全 ---> 编译代码 进行类型检查
          类型推断 ---> 没有显式指定类型 选择合适的类型  PS: 检查赋值的字面量
    (2) 字面量 赋值 
    (3) 数值类字面量可以包括额外的格式来增强可读性。整数和浮点数都可以添加额外的零并且包含下划线，并不会影响字面量
     */
    let meanOfNumber = 42 // 推断为int
    
    let binaryInteger = 0b10001       // 二进制的17
    let octalInteger = 0o21           // 八进制的17
    let hexadecimalInteger = 0x11     // 十六进制的17
    
    let paddedDouble = 000123.456
    let oneMillion = 1_000_000
    let justOverOneMillion = 1_000_000.000_000_1
    
    /**
     section one --> 转换
     (1)数字类型转换成另一种，用当前值来初始化一个期望类型的新数字，这个数字的类型就是目标类型
     (2)整数和浮点数的转换必须显式指定类型 
     注: 浮点值会被截断。也就是说 4.75 会变成 4，-3.9 会变成 -3
     */
    let twoThousand: UInt16 = 2_000
    let one: UInt8 = 1
    func sum_1() {
        let twoThousandAndOne = twoThousand + UInt16(one)
        print("sum = \(twoThousandAndOne)")
    }
    
    let three = 3
    let pointOneFourOneFiveNine = 0.14159
    func sum_2() {
        //整数-->浮点数
        let pi = Double(three) + pointOneFourOneFiveNine
        print("sum = \(pi)")
        //浮点数-->整数
        let integerPi = Int(pi);
        print("int of pit \(integerPi)")
    }
    
    /**
     section one --> 类型别名 (type aliases)
     (1)现有类型定义另一个名字。你可以使用typealias关键字来定义类型别名。
     */
    
    typealias AudioSample = UInt16
    var maxAmplitudeFound = AudioSample.min
    
    /**
     section one --> 布尔值(Bool)
     (1)true false
     */
    let orangesAreOrange = true
    let appleAreDelicious = false
    
    func control(){
        if orangesAreOrange {
            print("Good")
        }else{
            print("Apple")
        }
    }
    
    //注意 Bool 类型使用非布尔值 
    /*let i = 1
       if i{
           // 编译出错 OC 中可以  Zzz
       }
 */
    func controlBool( ){
        let i = 0
        if i == 1 {
            // OK
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
