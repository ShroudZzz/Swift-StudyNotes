//
//  ViewController.swift
//  Swift_3_StringsAndCharacters
//
//  Created by VermouthC on 2017/8/9.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /**
     section three --> 字符串字面量
     (1) 字符串字面量是由双引号包裹着的具有固定顺序的文本字符集
     (2) 字符串初始化
     */
    let someString = "some string literal value"
    // 声明一个字符
    let exclamationMark: Character = "!"
    
    func initString() {
        //初始化空字符串
        var emptyString  = ""
        var anotherEmptyString = String()
        
        if emptyString.isEmpty {
            print("Empty")
        }
    }
    
    func character() {
        //打印字符
        for character in "Dog!".characters {
            print(character)
        }
    }
    
    //字符串可以通过传递一个值类型为Character的数组作为自变量来初始化
    func characterArrayToString() {
        let catCharacter:[Character] = ["C","a","t","!"]
        let catString = String(catCharacter)
        print(catString)
    }
    
    //字符串拼接字符
    func characterAppendString()  {
        let appendCharacter:Character = "!"
        var message = "Hello Chen"
        message.append(appendCharacter)
    }
    
    //字符串插值 插入的字符串字面量的每一项都在以反斜线为前缀的圆括号中
    //注意: 插值字符串中写在括号中的表达式不能包含非转义反斜杠 (\) 并且不能包含回车或换行符。不过，插值字符串可以包含其他字面量。
    func insertString()  {
        let mutiplier = 3
        let message = "\(mutiplier) times 2.5 is \(Double(mutiplier) * 2.5)"
        print(message)
    }
    
    /**
     section three --> 字符串字面量的特殊字符
     字符串字面量可以包含以下特殊字符：
     (1) 转义字符\0(空字符)、\\(反斜线)、\t(水平制表符)、\n(换行符)、\r(回车符)、\"(双引号)、\'(单引号)
     (2) Unicode 标量，写成\u{n}(u为小写)，其中n为任意一到八位十六进制数且可用的 Unicode 位码。
     */
    
    let wiseWords = "\"Imagination is more important than knowledge \" -Einstein"
    let dollarSign = "\u{24}"  // $ Unicode 标量 U+0024
    let blackHeart = "\u{2665}" // Unicode 标量 U+2665
    let sparkLingHeart = "\u{1F496}" //Unicode 标量 U+1F496
    
    /**
     section three --> 可扩展的字形群集
     (1) 每一个Swif的Character 类型代表一个可扩展的字形群.一个可扩展的字形群是一个或者多个可生成人类可读的字符Unicode标量的有序排列
         例子:
         字母é可以用单一的 Unicode 标量é(LATIN SMALL LETTER E WITH ACUTE, 或者U+00E9)来表示
          一个标准的字母e(LATIN SMALL LETTER E或者U+0065) 加上一个急促重音(COMBINING ACTUE ACCENT)的标量(U+0301)，这样一对标量就表示了同样的字母é
     (2) 可拓展的字符群集可以使包围记号(例如COMBINING ENCLOSING CIRCLE或者U+20DD)的标量包围其他 Unicode 标量，作为一个单一的Character值
     (3)地域性指示符号的 Unicode 标量可以组合成一个单一的Character值，例如REGIONAL INDICATOR SYMBOL LETTER U(U+1F1FA)和REGIONAL INDICATOR SYMBOL LETTER S(U+1F1F8)
     (4)在 Swift 中，使用可拓展的字符群集作为Character值来连接或改变字符串时，并不一定会更改字符串的字符数量。
     */
    
    let eAcute:Character = "\u{E9}"  //é
    let combinedEAcute:Character = "\u{65}\u{301}" //e 后面加上  ́
    let precomposed: Character = "\u{D55C}"                  // 한
    let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
    
    let enclosedEAcute: Character = "\u{E9}\u{20DD}" // enclosedEAcute 是 é⃝
    let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}" // regionalIndicatorForUS 是 🇺🇸
    
    /**
     section three --> 字符串常用方法
     */
    //计算字符数量
    func countOfString()  {
        let unusualMenagerie = "Chen is Vermouth"
        var count = unusualMenagerie.characters.count
        print(count)
    }
    
    /**注意
     可扩展的字符群集可以组成一个或者多个 Unicode 标量。这意味着不同的字符以及相同字符的不同表示方式可能需要不同数量的内存空间来存储。所以 Swift 中的字符在一个字符串中并不一定占用相同的内存空间数量。因此在没有获取字符串的可扩展的字符群的范围时候，就不能计算出字符串的字符数量。如果您正在处理一个长字符串，需要注意characters属性必须遍历全部的 Unicode 标量，来确定字符串的字符数量。
     另外需要注意的是通过characters属性返回的字符数量并不总是与包含相同字符的NSString的length属性相同。NSString的length属性是利用 UTF-16 表示的十六位代码单元数字，而不是 Unicode 可扩展的字符群集。
     
        不同的字符可能会占用不同数量的内存空间，所以要知道Character的确定位置，就必须从String开头遍历每一个 Unicode 标量直到结尾。因此，Swift 的字符串不能用整数(integer)做索引
  */
    
    //字符串索引
    func index() {
        let greeting = "Chen"
        greeting[greeting.startIndex] // startIndex属性可以获取一个String的第一个Character的索引 C
        greeting[greeting.endIndex]  //  使用endIndex属性可以获取最后一个Character的后一个位置的索引 n
        greeting[greeting.index(before: greeting.endIndex)]//index(before:)立即得到前面一个索引 e
        greeting[greeting.index(after: greeting.startIndex)] // index(after:)可以立即得到后面的一个索引 h
        let index = greeting.index(greeting.startIndex, offsetBy: 2) // e
        greeting[index]// 调用 index(_:offsetBy:) 方法来获取对应偏移量的索引，这种方式可以避免多次调用 index(before:) 或    index(after:) 方法
        
        //使用characters属性indices 会创建一个包含全部索引的范围
        for index in greeting.characters.indices {
            print("\(greeting[index])",terminator: "")
        }
    }
    
    //插入和删除
    func insert()  {
        var welcome = "hello"
        //调用 insert(_:at:) 方法可以在一个字符串的指定索引插入一个字符
        welcome.insert("!", at: welcome.endIndex)
        print(welcome)
        //调用 insert(contentsOf:at:) 方法可以在一个字符串的指定索引插入一个段字符串。
        welcome.insert(contentsOf: "there".characters, at: welcome.index(before: welcome.endIndex))
        print(welcome)
    }
    
    func remove() {
        var welcome = "Chen"
        //调用 remove(at:) 方法可以在一个字符串的指定索引删除一个字符
        welcome.remove(at: welcome.index(before: welcome.endIndex))
        //调用 removeSubrange(_:) 方法可以在一个字符串的指定索引删除一个子字符串。
        let range = welcome.index(welcome.endIndex, offsetBy: -2)..<welcome.endIndex
        welcome.removeSubrange(range)
    }
    
    //比较字符串 Swift提供三种方式比较文本值 : 字符串字符相等  前缀相等 后缀相等
    func compare()  {
        let quotation = "Chen"
        let sameQuotation = "Chen"
    
        if quotation == sameQuotation{
            print("equal")
        }
        //两个字符串（或者两个字符）的可扩展的字形群集是标准相等 那么它们就是相等
        let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
        let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
        
        if eAcuteQuestion == combinedEAcuteQuestion {
            print("These two strings are considered equal")
        }
        
        //通过调用字符串的hasPrefix(_:)/hasSuffix(_:)方法来检查字符串是否拥有特定前缀/后缀，两个方法均接收一个String类型的参数，并返回一个布尔值
        
    }
    
    /**
     section three --> Unicode表现形式
     (1) UTF-8 编码格式（编码字符串为8位的代码单元）UTF-8 代码单元集合 (利用字符串的utf8属性进行访问)， UTF-16 编码格式（编码字符串位16位的代码单元）UTF-16 代码单元集合 (利用字符串的utf16属性进行访问)，以及 UTF-32 编码格式（编码字符串32位的代码单元）21位的 Unicode 标量值集合，也就是字符串的 UTF-32 编码格式 (利用字符串的unicodeScalars属性进行访问)
     */
    func unicode() {
        let dogString = "Dog"
        for codeUnit in dogString.utf8{
            print("\(codeUnit)",terminator: "")
        }
        
        for codeUnit in dogString.utf16 {
            print("\(codeUnit) ", terminator: "")
        }
        
        for scalar in dogString.unicodeScalars {
            print("\(scalar.value) ", terminator: "")
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

