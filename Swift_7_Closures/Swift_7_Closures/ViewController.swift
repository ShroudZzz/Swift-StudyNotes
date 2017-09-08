//
//  ViewController.swift
//  Swift_7_Closures
//
//  Created by VermouthC on 2017/9/2.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /**
     section Closures --> 闭包
     (1) 闭包是自包含的函数代码块，可以在代码中被传递和使用。Swift 中的闭包与 C 和 Objective-C 中的代码块（blocks）以及其他一些编程语言中的匿名函数比较相似
     (2) 闭包可以捕获和存储其所在上下文中任意常量和变量的引用。被称为包裹常量和变量。 Swift 会为你管理在捕获过程中涉及到的所有内存操作。
     (3)闭包表达式
     { (parameters) -> returnType in
        statements
     }
     (4)闭包表达式参数 可以是 in-out 参数，但不能设定默认值。也可以使用具名的可变参数（译者注：但是如果可变参数不放在参数列表的最后一位的话，调用闭包的时时编译器将报错。可参考这里）。元组也可以作为参数和返回值。
     */
    
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }
    
    /*尾随闭包*/
    //使用尾随闭包来增强函数的可读性。尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用
    func someFunctionThatTakesAClosure(closure: () -> Void) {
        // 函数体部分
    }
    
    /*逃逸闭包*/
    //当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。当你定义接受闭包作为参数的函数时，你可以在参数名之前标注 @escaping，用来指明这个闭包是允许“逃逸”出这个函数的。
    var completionHandlers : [()->Void] = []
    func someFunctionWithEscapingClosure(completionHandler: @escaping () ->Void){
        completionHandlers.append(completionHandler)
    }
    func someFunctionWithNonescapingClosure(closure: () -> Void) {
        closure()
    }
    class someClass {
        var x = 10
        func doSomething() {
            //someFunctionWithEscapingClosure { self.x = 100 }
            //someFunctionWithNonescapingClosure { x = 200 }
        }
    }
    /*自动闭包*/
    //自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。这种便利语法让你能够省略闭包的花括号，用一个普通的表达式来代替显式的闭包。
    //自动闭包让你能够延迟求值，因为直到你调用这个闭包，代码段才会被执行。延迟求值对于那些有副作用（Side Effect）和高计算成本的代码来说是很有益处的，因为它使得你能控制代码的执行时机。
    func test() {
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count)
        // 打印出 "5"
        
        let customerProvider = { customersInLine.remove(at: 0) }
        print(customersInLine.count)
        // 打印出 "5"
        
        print("Now serving \(customerProvider())!")
        // Prints "Now serving Chris!"
        print(customersInLine.count)
        // 打印出 "4"
        
        // customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
        func serve(customer customerProvider: () -> String) {
            print("Now serving \(customerProvider())!")
        }
        serve(customer: { customersInLine.remove(at: 0) } )
        // 打印出 "Now serving Alex!"
        
        //将参数标记为 @autoclosure 来接收一个自动闭包。现在你可以将该函数当作接受 String 类型参数（而非闭包）的函数来调用。customerProvider 参数将自动转化为一个闭包，因为该参数被标记了 @autoclosure 特性
        // customersInLine is ["Ewa", "Barry", "Daniella"]
        func serves(customer customerProvider: @autoclosure () -> String) {
            print("Now serving \(customerProvider())!")
        }
        serves(customer: customersInLine.remove(at: 0))
        // 打印 "Now serving Ewa!"
        //如果你想让一个自动闭包可以“逃逸”，则应该同时使用 @autoclosure 和 @escaping 属性。
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        //一个 String 类型的数组进行排序，因此排序闭包函数类型需为 (String, String) -> Bool。
        //提供排序闭包函数的一种方式是撰写一个符合其类型要求的普通函数，并将其作为 sorted(by:) 方法的参数传入：
        var reversedNames = names.sorted(by: backward)
        
        /*闭包表达式*/
        //闭包的函数体部分由关键字in引入。该关键字表示闭包的参数和返回值类型定义已经完成，闭包函数体即将开始。
        reversedNames = names.sorted(by:
            {
                (s1:String, s2:String) -> Bool in
                 return s1>s2
            }
        )
        
        reversedNames = names.sorted(by: { (s1:String, s2:String) -> Bool in
            return s1>s2
        })
        
        reversedNames = names.sorted(by: {s1,s2 in return s1>s2 })
        
        /*单表达式闭包隐式返回*/
        //单行表达式闭包可以通过省略 return 关键字来隐式返回单行表达式的结果，如上版本的例子可以改写为：
        
        reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
        //在这个例子中，sorted(by:) 方法的参数类型明确了闭包必须返回一个 Bool 类型值。因为闭包函数体只包含了一个单一表达式（s1 > s2），该表达式返回 Bool 类型值，因此这里没有歧义，return 关键字可以省略。
        
        /*参数名缩写*/
        //在闭包表达式中使用参数名称缩写，闭包定义中省略参数列表，并且对应参数名称缩写的类型会通过函数类型进行推断。in关键字也同样可以被省略，因为此时闭包表达式完全由闭包函数体构成：
        reversedNames = names.sorted(by: { $0 > $1 } )
        //在这个例子中，$0和$1表示闭包中第一个和第二个 String 类型的参数。
        
        /*运算符方法*/
        reversedNames = names.sorted(by: >)
        
        /*尾随闭包*/
        
        // 以下是不使用尾随闭包进行函数调用
        someFunctionThatTakesAClosure(closure: {
            // 闭包主体部分
        })
        
        // 以下是使用尾随闭包进行函数调用
        someFunctionThatTakesAClosure() {
            // 闭包主体部分
        }

        reversedNames = names.sorted() { $0 > $1 }
        //闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，你甚至可以把 () 省略掉：
        reversedNames = names.sorted { $0 > $1 }
        
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        
        let strings = numbers.map{
            (number) ->String in
             var number = number
             var output = ""
            repeat {
                output = digitNames[number%10]! + output
                number /= 10
            }while number > 0
            return output
        }
        //字典 digitNames 下标后跟着一个叹号（!），因为字典下标返回一个可选值（optional value），表明该键不存在时会查找失败
        
        
    }

    
    //practice->尾随闭包
    func seporateString(string:String ,handler:(_ str1:Character, _ str2:Character)->Void) -> Bool {
        if string.startIndex<string.endIndex {
            let str1 = string[string.startIndex]
            let str2 = string[string.endIndex]
            handler(str1,str2)
            return true
        }
        return false
    }
    
    func invoke() {
        //调用尾随闭包
        let result =  seporateString(string: "Hello") { (str1, str2) -> Void in
            print(str1)
            print(str2)
        }
        print("invoke \(result) !")
    }
    //practice->逃逸闭包
    var functionArray:[()->Void] = []
    func doSomethings(_ paramClosures:@escaping () -> Void){
        functionArray.append(paramClosures)
    }
    func invokeEscapingClosures(){
        //调用函数
       doSomethings { 
           print("Chen")
        
        }
        
        //调用逃逸闭包
        for item in functionArray {
           item()
        }
    }
    
    func auto_colsures() {
        //practice->自动闭包
        var tempString:String = "你的名字"
        let makeString = { tempString = "chen" }
        
        print(tempString)
        
        //直到调用
        makeString()
        
        print(tempString)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}

