//
//  ViewController.swift
//  Swift_2_BasicOperators
//
//  Created by VermouthC on 2017/8/9.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    /**
     section two --> 基本运算符
     (1) 运算符分为一元、二元和三元运算符:
     (2) 一元运算符对单一操作对象操作（如 -a）。一元运算符分前置运算符和后置运算符，前置运算符需紧跟在操作对象之前（如 !b），后置运算符需紧跟在操作对象之后（如 c!）。
          二元运算符操作两个操作对象（如 2 + 3），是中置的，因为它们出现在两个操作对象之间。
          三元运算符操作三个操作对象，和 C 语言一样，Swift 只有一个三元运算符，就是三目运算符（a ? b : c）。
          受运算符影响的值叫操作数，在表达式 1 + 2 中，加号 + 是二元运算符，它的两个操作数是值 1 和 2。
     */
    
    //赋值运算符
    func equal() {
        let b = 10
        var a = 5
        a = b
        
        //元组赋值
        let(x,y) = (1,2) // x = 1 y = 2
    }
    
    //算数运算符 + - * /
    func add() {
        //加法用于拼接依旧有效
        var sumString = "hello" + "world"
    }
    
    //求余运算
    // a % b 和 a % -b 的结果是相同的。a%b 和 -a%b 不同
    
    //组合赋值运算
    func function() {
        var a = 1
        a += 2
    }
    
    //比较运算符
    //注意: Swift 也提供恒等（===）和不恒等（!==）这两个比较符来判断两个对象是否引用同一个对象实例。
    //元组比较大小 按照从左到右 逐值比较的方式
    // 注意：Swift 标准库只能比较七个以内元素的元组比较函数。如果你的元组元素超过七个时，你需要自己实现比较运算符。
    
    //三目运算符
    func three() {
        let contentheight = 40
        let hasHeader = true
        let  rowHeight = contentheight+(hasHeader ? 50:20)
    }
    
    /**
     section two --> 空合运算符(Nil Coalescing Operator)
     (1) 空合运算符(a ?? b)将对可选类型a进行空判断,如果a包含一个值就进行解封,否则返回一个默认值b 表达式 a 必须是 Optional 类型。默认值 b 的类型必须要和 a 存储值的类型保持一致。
     */
    
    func color(){
        let defaultColorName = "red"
        var userDefinedColorName: String? // 默认值为nil
        
        var colorNameToUse = userDefinedColorName ?? defaultColorName
    }
    
    /**
     section two --> 区间运算符(Range Operators)
     (1) 闭区间运算符 (a...b) 定义一个包含从a 到 b (包括a和b)的所有值的区间 for-in循环应用
     (2) 半开区间运算符(a..<b)定义一个从a到b 但是不包括b的区间 数组应用
     */
    
    func range(){
        for index in 1...5 {
            print("\(index) *5 = \(index*5)")
        }
        
        let names = ["Anne","Alex","Bob","Jack"]
        let count = names.count
        for i in 0..<count {
            print("\(names[i])")
        }
    }
    
    //逻辑运算符  逻辑运算符的操作对象是逻辑布尔值  主要有 !  &&  ||
    //逻辑非运算符（!a）对一个布尔值取反，使得 true 变 false，false 变 true。
    //逻辑与运算符（a && b）表达了只有 a 和 b 的值都为 true 时，整个表达式的值才会是 true。
    //逻辑或运算符（a || b）是一个由两个连续的 | 组成的中置运算符。它表示了两个逻辑表达式的其中一个为 true，整个表达式就为 true。
    //注意: Swift 逻辑操作符 && 和 || 是左结合的，这意味着拥有多元逻辑操作符的复合表达式优先计算最左边的子表达式。可以通过括号调整顺序
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

