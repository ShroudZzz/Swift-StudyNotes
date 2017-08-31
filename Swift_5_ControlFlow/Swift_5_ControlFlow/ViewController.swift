//
//  ViewController.swift
//  Swift_5_ControlFlow
//
//  Created by VermouthC on 2017/8/25.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /**
     section Five --> 控制流(Control Flow)
     (1) While循环 if else 语句 Switch语句 for-in循环 控制流跳转位置的break continue
     (2)
     */
    
    //for-in 循环遍历一个集合中的所有元素.
    func For_In() {
        //注:index 是一个每次循环遍历开始时被自动赋值的常量(如果你不需要区间序列内每一项的值，你可以使用下划线（_）替代变量名来忽略这个值)
        for index in 1...5 {
            print("\(index) times 5 is \(index*5)")
        }
        
        let names = ["Anna", "Alex", "Brian", "Jack"]
        for name in names {
            print("Hello, \(name)!")
        }
        
        let numberOfLegs = ["spidwe":8,"ant":6,"cat":4]
        for (animalName,legCount) in numberOfLegs {
            print("\(animalName) have \(legCount) legs")
        }
    }
    
    //While 循环
    func while_control(){
        while true {
            //执行循环
        }
        
        // do while
        repeat{
            
        }while true
    }
    
    //条件语句
    func if_control(){
        var temperatureInFahrenheit = 30
        if temperatureInFahrenheit <= 32 {
            print("It's very cold. Consider wearing a scarf.")
        }else{
             print("It's not that cold. Wear a t-shirt.")
        }
    }
    
    //Switch 注意: 每一个 case 分支都必须包含至少一条语句
    func switch_control() {
        let someCharacter: Character = "z"
        switch someCharacter {
        case "a":
            print("The first letter of the alphabet")
        case "z":
            print("The last letter of the alphabet")
        default:
            print("Some other character")
        }
        
        //单个case同时匹配a和A，可以将这个两个值组合成一个复合匹配，并且用逗号分开：
        let anotherCharacter: Character = "a"
        switch anotherCharacter {
        case "a", "A":
            print("The letter A")
        default:
            print("Not the letter A")
        }
        
        //区间匹配 case 分支模式也可以是一个值的区间
        let approximateCount = 62
        let countedThings = "moons orbiting Saturn"
        var naturalCount : String
        switch approximateCount {
        case 0:
            naturalCount = "no"
        case 1..<5:
            naturalCount = "a few"
        case 5..<12:
            naturalCount = "several"
        case 12..<100:
            naturalCount = "dozens of"
        case 100..<1000:
            naturalCount = "hundreds of"
        default:
            naturalCount = "many"
        }
        
        print("There are \(naturalCount) \(countedThings).")
        
        //元组 元组中的元素可以是值，也可以是区间。另外，使用下划线（_）来匹配所有可能的值。
        let somePoint = (1,1)
        switch somePoint {
        case (0,0):
            print("(0,0) is at the origin")
        case (_,0):
            print("\((somePoint.0),0) is on the x-axis")
        case (0, _):
            print("(0, \(somePoint.1)) is on the y-axis")
        case (-2...2, -2...2):
            print("(\(somePoint.0), \(somePoint.1)) is inside the box")
        default:
            print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
        }
        
        //值绑定 case 分支允许将匹配的值绑定到一个临时的常量或变量，并且在case分支体内使用 —— 这种行为被称为值绑（value binding），因为匹配的值在case分支体内，与临时的常量或变量绑定。
        let anotherPoint = (2,0)
        switch anotherPoint {
        case (let x,0):
            print("on the x-axis with an x value of \(x)")
        case (0, let y):
            print("on the y-axis with a y value of \(y)")
        case let (x, y):
            print("somewhere else at (\(x), \(y))")
        }
        
        //Where  case 分支的模式可以使用where语句来判断额外的条件。
        //注意:这三个 case 都声明了常量x和y的占位符，用于临时获取元组yetAnotherPoint的两个值。这两个常量被用作where语句的一部分，从而创建一个动态的过滤器(filter)。当且仅当where语句的条件为true时，匹配到的 case 分支才会被执行。
        
        let yetAnotherpoint = (1,-1)
        switch yetAnotherpoint {
        case let (x,y) where x == y:
            print("(\(x), \(y)) is on the line x == y")
        case let (x,y) where x == -y:
            print("(\(x), \(y)) is on the line x == -y")
        case let(x,y):
            print("(\(x), \(y)) is just some arbitrary point")
        }
        
        //复合匹配  当多个条件可以使用同一种方法来处理时，可以将这几种可能放在同一个case后面，并且用逗号隔开
        let someCharacters: Character = "e"
        switch someCharacters {
        case "a", "e", "i", "o", "u":
            print("\(someCharacter) is a vowel")
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
             "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            print("\(someCharacter) is a consonant")
        default:
            print("\(someCharacter) is not a vowel or a consonant")
        }
        //复合匹配 值绑定
        let stillAnotherPoint = (9, 0)
        switch stillAnotherPoint {
        case (let distance, 0), (0, let distance):
            print("On an axis, \(distance) from the origin")
        default:
            print("Not on an axis")
        }
        
    }
    
    //控制转移 continue break fallthrough
    //continue语句告诉一个循环体立刻停止本次循环，重新开始下次循环
    func continue_control(){
        let puzzleInput = "great minds think alike"
        var puzzleOutput = ""
        for character in puzzleInput.characters {
            switch character {
            case "a", "e", "i", "o", "u", " ":
                continue
            default:
                puzzleOutput.append(character)
            }
        }
    }
    //break语句会立刻结束整个控制流的执行
    func break_control(){
        let numberSymbol: Character = "三"  // 简体中文里的数字 3
        var possibleIntegerValue: Int?
        switch numberSymbol {
        case "1", "١", "一", "๑":
            possibleIntegerValue = 1
        case "2", "٢", "二", "๒":
            possibleIntegerValue = 2
        case "3", "٣", "三", "๓":
            possibleIntegerValue = 3
        case "4", "٤", "四", "๔":
            possibleIntegerValue = 4
        default:
            break
        }
        if let integerValue = possibleIntegerValue {
            print("The integer value of \(numberSymbol) is \(integerValue).")
        } else {
            print("An integer value could not be found for \(numberSymbol).")
        }
        
        //Swift 中的switch不会从上一个 case 分支落入到下一个 case 分支中。相反，只要第一个匹配到的 case 分支完成了它需要执行的语句，整个switch代码块完成了它的执行
        //C 语言要求你显式地插入break语句到每个 case 分支的末尾来阻止自动落入到下一个 case 分支中(需要 C 风格的贯穿的特性，你可以在每个需要该特性的 case 分支中使用fallthrough关键字)
        //提前退出
        //使用guard语句来要求条件必须为真时，以执行guard语句后的代码。不同于if语句，一个guard语句总是有一个else从句，如果条件不为真则执行else从句中的代码。
        func greet(person: [String: String]) {
            guard let name = person["name"] else {
                return
            }
            print("Hello \(name)")
            guard let location = person["location"] else {
                print("I hope the weather is nice near you.")
                return
            }
            print("I hope the weather is nice in \(location).")
        }
        

     }
    //检测API可用性
        /*
         Swift内置支持检查 API 可用性.
         
         编译器使用 SDK 中的可用信息来验证我们的代码中使用的所有 API 在项目指定的部署目标上是否可用。如果我们尝试使用一个不可用的 API，Swift 会在编译时报错。
         
         我们在if或guard语句中使用可用性条件（availability condition)去有条件的执行一段代码，来在运行时判断调用的API是否可用。编译器使用从可用性条件语句中获取的信息去验证，在这个代码块中调用的 API 是否可用。
         */
    func API() {
        if #available(iOS 10, macOS 10.12, *) {
            //APIs 可用，语句将执行
            // 在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API
            //最后一个参数，*，是必须的，用于指定在所有其它平台中，如果版本号高于你的设备指定的最低版本，if语句的代码块将会运行。
        } else {
            //APIs 不可用，语句将不执行
            // 使用先前版本的 iOS 和 macOS 的 API
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

