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
    var welcomeMessage: String = "Welcome Sunshine"
    
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
    
    /**
     section one --> 元组(tuples)
     (1)元组把多个值组合成一个复合值.元组内的值是任意类型
     (2)可以在定义元组的时候给单个元素命名
     */
    let http404Error = (404,"Not Found");
    let http200Status = (statusCode: 200, description: "OK")
    //将一个元组的内容分解单独的常量和变量
    //如果只需要一部分元组值,分解的时候可以吧忽略的部分用下划线(_)标记
    //可以通过下标来访问元组中的单个元素 从0开始
    func decompose() {
        let (statusCode,statusMessage) = http404Error
        print("The StatusCode is \(statusCode)")
        print("The StatusMessage is \(statusMessage)")
        
        let (justTheStatusCode,_) = http404Error
        print("The StatusCode is \(justTheStatusCode)")
        
        print("The StatusCode is \(http404Error.0)")
        print("The StatusCOde is \(http200Status.statusCode)")
    }
    
    /**
     section one --> 可选类型(optionals)
     (1) 使用可选类型处理值可能确实的状况
     (2) 可选类型表示 有值 x 或者 没有值
     (3) 可以给可选变量赋值为nil ,表示他没有值.但是 nil 不可以给费可选的常量和变量赋值(OC 区别)
     (4) 声明一个可选类型但是没有赋值,会自动设置为nil(OC 区别)
     */
    
    func stringToInt() {
        let possibleNumber = "123"
        let convertedNumber = Int(possibleNumber) //Int() 构造器 String -> Int  返回值是一个可选类型 字符串可能转换为Int 也可能不会
        
        var serverResponseCode: Int? = 404 //表示变量serverResponseCode 包含一个可选的Int值 404
        serverResponseCode = nil //现在它不包含值
    }
    
    /**
     section one --> if语句以及强制解析
     (1) 使用if 和nil 判断一个可选值是否包含值
     (2) 确定(可选类型 一定有值)可选类型包含值,可以在可选的名字后面加一个感叹号(!)来获取值(否则 运行出错)  这叫强制解析
     */
    func compareOptionals() {
        let possibleNumber = "123"
        let convertedNumber = Int(possibleNumber)
        if  convertedNumber != nil{
            print("convertedNumber contains integer value")
            print("convertedNumber contains integer value of \(convertedNumber!)")
        }
    }
    
    /**
     section one --> 可选绑定(optional binding)
     (1)  使用可选绑定 来判断可选类型是否包含值,如果包含就把值赋给一个临时常量或者变量
     (2)  包含多个可选绑定或者多个布尔条件在一个if语句里,使用逗号分开.只要任意一个可选绑定的值为nil,或者布尔值为false,则整条语句都为false
     */
    func optionalBinding() {
        let possibleNumber = "123"
        if let actualNumber = Int(possibleNumber) {
            print("actualNumber is \(actualNumber))")
        }
        
        
        if let firstNumber = Int("4") {
            if let secondNumber = Int("42") {
                if firstNumber < secondNumber && secondNumber < 100 {
                    print("\(firstNumber) < \(secondNumber) < 100")
                }
            }
        }
    }
    
    /**
     section one --> 隐式解析可选类型
     (1) 可选类型确定总会有值,可以使用(!)声明一个隐式解析可选类型
     (2) 隐式解析可选类型当做普通的可选类型进行判断
     (3) 可选绑定中使用隐式解析可选类型来检查并解析它的值
     */
    
    func implicitlyUnwrappedOptionals(){
        let possibleString: String? = "An optional string ."
        let forcedString: String = possibleString! //使用! 强制解析取值
        
        let assumedString: String! = "An implicitly unwrapped optional string."
        let implicitString: String = assumedString //不需要感叹号
        
        if assumedString != nil {
            print(assumedString)
        }
        
        if let definiteString = assumedString {
            print(definiteString)
        }
    }
    
    /**
     section one --> 错误处理(error handing)
     (1)  处理程序执行中可能会遇到的错误条件
     (2)  一个函数可以通过在声明中添加throws关键词来抛出错误消息。当你的函数能抛出错误消息时, 你应该在表达式中前置try关键词。
     */
    func canThrowAnError() throws {
        //该函数可能抛出错误
    }
    
    func invoke(){
        do{
            try canThrowAnError()
            //没有错无出现
        }catch{
            //错误抛出
        }
    }
    
    /**
     section one --> 断言
     (1) 判断一个条件是否为真
     (2) 断言条件为false的时候 断言被触发,终止应用
     */
    
    func assertFunc() {
        let age = -3
        assert(age >= 0,"A person age cannot be less than zero")
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
