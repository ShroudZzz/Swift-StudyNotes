//
//  ViewController.swift
//  Swift_6_Functions
//
//  Created by VermouthC on 2017/8/31.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /**
     section Functions -->函数
     (1) 
     (2)
     */
    //函数定义和调用
    /*
     func 作为前缀。指定函数返回类型时，用返回箭头 ->（一个连字符后跟一个右尖括号）后跟返回类型的名称的方式来表示
     调用 greet(person:) 函数时，在圆括号中传给它一个 String 类型的实参
     */
    func greet(person: String) -> String {
        let greeting = "Hello,  " + person + "!"
        return greeting;
    }
    //多参数函数
    func greet(person: String, alreadyGreeted:Bool) -> String {
        if alreadyGreeted{
           //code
        }else{
           //code
        }
        return "Chen"
    }
    
    // 无返回值函数
    /*
     注意
     严格上来说，虽然没有返回值被定义，greet(person:) 函数依然返回了值。没有定义返回类型的函数会返回一个特殊的Void值。它其实是一个空的元组（tuple），没有任何元素，可以写成()。
     */
    func greetNoReturn(person: String){
        print("Hello, \(person)!")
    }
    
    //多重返回值函数
    func minMax(array: [Int]) -> (min:Int,max:Int) {
        var currentMin = array[0];
        var currentMax = array[0];
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value;
            }else if value>currentMax{
                currentMax = value
            }
        }
        return (currentMin,currentMax)
    }
    
    //可选元组返回类型  如果函数返回的元组类型有可能整个元组都“没有值”，你可以使用可选的（ optional ） 元组返回类型反映整个元组可以是nil的事实
    /*
        注意: 可选元组类型如 (Int, Int)? 与元组包含可选类型如 (Int?, Int?) 是不同的.可选的元组类型，整个元组是可选的，而不只是元组中的每个元素值。
     */
    func minMaxOptional(array: [Int]) -> (min: Int, max: Int)? {
        if array.isEmpty { return nil }
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
    
    //指定参数标签
    //你可以在函数名称前指定它的参数标签，中间以空格分隔：
    /*
        忽略参数标签
        可以使用一个下划线(_)来代替一个明确的参数标签。
     
     func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
     // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
     }
     someFunction(1, secondParameterName: 2)
     如果一个参数有一个标签，那么在调用的时候必须使用标签来标记这个参数。
     */
    //可添加默认参数
    func someFunction(argumentLabel parameterName: Int = 12) {
        // 在函数体内，parameterName 代表参数值 argumentLabel 标签 例子如下
        /*
         func greet(person: String, from hometown: String) -> String {
         return "Hello \(person)!  Glad you could visit from \(hometown)."
         }
         print(greet(person: "Bill", from: "Cupertino"))
         */
    }
    
    //可变参数
    //一个可变参数（variadic parameter）可以接受零个或多个值。函数调用时，你可以用可变参数来指定函数参数可以被传入不确定数量的输入值。通过在变量类型名后面加入（...）的方式来定义可变参数
    //注意： 一个函数最多只能拥有一个可变参数。
    func arithmentMean(_ numbers: Double...) ->Double  {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        
        return total/Double(numbers.count)
    }
    
    //输入输出参数
    /*
        函数参数默认是常量。试图在函数体中更改参数值将会导致编译错误(compile-time error)。这意味着你不能错误地更改参数值。如果你想要一个函数可以修改参数的值，并且想要在这些修改在函数调用结束后仍然存在，那么就应该把这个参数定义为输入输出参数（In-Out Parameters）。
        参数名前加 & 符，表示这个值可以被函数修改
     注意: 1.你只能传递变量给输入输出参数。你不能传入常量或者字面量，因为这些量是不能被修改的。
             2.注意：输入输出参数和返回值是不一样的。上面的 swapTwoInts 函数并没有定义任何返回值，但仍然修改了 someInt 和 anotherInt 的值。输入输出参数是函数对函数体外产生影响的另一种方式。
     */
    func swapTwoInts(_ a: inout Int, _ b:inout Int) {
        let tempA = a
        a = b
        b = tempA
    }
    
    //函数类型 每个函数都有种特定的函数类型，函数的类型由函数的参数类型和返回类型组成。
    //定义一个类型为函数的常量或变量，并将适当的函数赋值给它：
    func founctions_type()  {
        var mathFunction: (Int, Int) -> Int = addTwoInts
    }
    
    func addTwoInts(_ a: Int, _ b: Int)->Int {
        return a+b
    }
    
    //函数类型作为参数类型
    func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
        print("Result: \(mathFunction(a, b))")
    }
    //函数类型作为返回类型 返回箭头（->）后写一个完整的函数类型 获取两个函数中的一个
    func stepForward(_ input: Int) -> Int {
        return input + 1
    }
    func stepBackward(_ input: Int) -> Int {
        return input - 1
    }
    
    func chooseStepFunction(backward: Bool) -> (Int) -> Int {
        return backward ? stepBackward : stepForward
    }
  
    
    //嵌套函数 嵌套函数是对外界不可见的，但是可以被它们的外围函数（enclosing function）调用。一个外围函数也可以返回它的某一个嵌套函数，使得这个函数可以在其他域中被使用。
    func newChooseStepFunction(backward: Bool) -> (Int) -> Int {
        func stepForward(input: Int) -> Int { return input + 1 }
        func stepBackward(input: Int) -> Int { return input - 1 }
        return backward ? stepBackward : stepForward
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let result = greet(person: "Chen")
        print(greet(person: "Anna"))
        
        print(greet(person: "Tim", alreadyGreeted: true))
        
        //因为元组的成员值已被命名，因此可以通过 . 语法来检索找到的最小值与最大值
        let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
        print("min is \(bounds.min) and max is \(bounds.max)")
        
        //可选绑定检查函数返回的是一个存在的元组值还是nil
        if let bouns = minMaxOptional(array: [8, -6, 2, 109, 3, 71]){
          print("min is \(bounds.min) and max is \(bounds.max)")
        }
        
        //可变参数
        var doubleResult = arithmentMean(1, 2, 3, 4, 5)
        
        //输入输出参数
        var someInt = 3
        var anotherInt = 107
        swapTwoInts(&someInt, &anotherInt)
        print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
     
        //函数类型作为参数类型
        printMathResult(addTwoInts, 3, 5)
        //函数类型作为返回类型
        
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

