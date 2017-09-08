//
//  ViewController.swift
//  Swift_23_Generics
//
//  Created by VermouthC on 2017/9/7.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

/*泛型函数*/
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

/*泛型类型*/
//Swift 允许你定义泛型类型。这些自定义类、结构体和枚举可以适用于任何类型，类似于 Array 和 Dictionary
struct Stack<Element>{
    var items = [Element]()
    mutating func push(_ item:Element){
       items.append(item)
    }
    
    mutating func pop() ->Element{
       return items.removeLast()
    }
}

func stack(){
    var stackOfStrings = Stack<String>()
    stackOfStrings.push("uno")
    stackOfStrings.push("dos")
    stackOfStrings.push("tres")
    stackOfStrings.push("cuatro")
}

/*扩展泛型类型*/
extension Stack{
    var topItem:Element?{
        return items.isEmpty ? nil : items[items.count-1]
    }
}

/*类型约束*/
/* 约束语法
 func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
 // 这里是泛型函数的函数体部分
 }
 */
//Swift 标准库中定义了一个 Equatable 协议，该协议要求任何遵循该协议的类型必须实现等式符（==）及不等符(!=)，从而能对该类型的任意两个值进行比较。所有的 Swift 标准类型自动支持 Equatable 协议。

func findIndex<T:Equatable>(ofString valueToFind:T,in array: [T])->Int?{
    for (index,value) in array.enumerated() {
        if value == valueToFind{
           return index
        }
    }
    return nil
}

/*关联类型*/
//关联类型为协议中的某个类型提供了一个占位名（或者说别名），其代表的实际类型在协议被采纳时才会被指定。你可以通过 associatedtype 关键字来指定关联类型。
protocol Container{
   associatedtype ItemType
    mutating func append(_ item: ItemType)
    var count : Int{get}
    subscript(i:Int)->ItemType{get}
}

struct IntStack:Container {
    typealias ItemType = Int
    
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }

    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
    
}

//泛型(Swift 可以据此推断出 Element 的类型即是 ItemType 的类型)
struct Stacks<Element>: Container {
    // Stack<Element> 的原始实现部分
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // Container 协议的实现部分
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

/*泛型 Where 语句*/
func allItemsMatch<c1:Container,c2:Container>(_ someContainer:c1,_ anotherContainer:c2) -> Bool
where c1.ItemType == c2.ItemType, c1.ItemType:Equatable{
    // 检查两个容器含有相同数量的元素
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i]{
            return false
        }
    }
    
    return true
}

class ViewController: UIViewController {
    /**
     section 泛型 --> generics
     (1)
     (2) <#description#>
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var someInt = 3
        var anotherInt = 107
        swapTwoValues(&someInt, &anotherInt)
        // someInt 现在 107, and anotherInt 现在 3
        
        var someString = "hello"
        var anotherString = "world"
        swapTwoValues(&someString, &anotherString)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

