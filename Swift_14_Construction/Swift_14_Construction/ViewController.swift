//
//  ViewController.swift
//  Swift_14_Construction
//
//  Created by VermouthC on 2017/9/5.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /**
     section  构造过程--> Construction
     (1) 构造器
     (2) 构造过程中的任意时间点给常量属性指定一个值，只要在构造过程结束时是一个确定的值。一旦常量属性被赋值，它将永远不可更改
     (3) 类的实例来说，它的常量属性只能在定义它的类的构造过程中修改；不能在子类中修改
     
     注意:
     存储型属性设置默认值或者在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观察者。
     */
    /*构造器(关键字init命名)*/
    struct Fahrenheit {
        var temperature: Double
        init() {
            temperature = 32.0
        }
    }
    //构造参数(构造参数也拥有一个在构造器内部使用的参数名字和一个在调用构造器时使用的外部参数名字)
    struct Celsius {
        var temperatureInCelsius: Double
        init(fromFahrenheit fahrenheit: Double) {
            temperatureInCelsius = (fahrenheit - 32.0) / 1.8
        }
        init(fromKelvin kelvin: Double) {
            temperatureInCelsius = kelvin - 273.15
        }
        //外部名用_代替
        init(_ celsius: Double){
            temperatureInCelsius = celsius
        }
        //调用时: let bodyTemperature = Celsius(35.8)
    }
    
    struct Color {
        let red,green,blue:Double
        init(red: Double,green: Double, blue: Double) {
            self.red = red
            self.green = green
            self.blue = blue
        }
        
        init(white: Double) {
            red   = white
            green = white
            blue  = white
        }
    }
    
    //可选类型
    //QurveyQuestion实例化时，response 它将自动赋值为nil，表明此字符串暂时还没有值
    class SurveyQuestion {
        var text: String
        var response: String?
        init(text: String) {
            self.text = text
        }
        func ask() {
            print(text)
        }
    }
    
    /*默认构造器
     (结构体或类的所有属性都有默认值，同时没有自定义的构造器，那么 Swift 会给这些结构体或类提供一个默认构造器（default initializers）。这个默认构造器将简单地创建一个所有属性值都设置为默认值的实例)*/
    
    /*结构体的逐一成员构造器
     (1.结构体没有提供自定义的构造器，它们将自动获得一个逐一成员构造器，即使结构体的存储型属性没有默认值
      2.调用逐一成员构造器时，通过与成员属性名相同的参数名进行传值来完成对成员属性的初始赋值
     struct Size {
     var width = 0.0, height = 0.0
     }
     let twoByTwo = Size(width: 2.0, height: 2.0)
     )
     */
    
    /*值类型的构造器代理*/
    /*
    struct Rect {
        var origin = Point()
        var size = Size()
        init() {}
        init(origin: Point, size: Size) {
            self.origin = origin
            self.size = size
        }
        init(center: Point, size: Size) {
            let originX = center.x - (size.width / 2)
            let originY = center.y - (size.height / 2)
            self.init(origin: Point(x: originX, y: originY), size: size)
        }
    }
    */
    
    /*类的继承和构造过程(指定构造器和便利构造器)*/
    //指定构造器(主要):指定构造器将初始化类中提供的所有属性，并根据父类链往上调用父类的构造器来实现父类的初始化,每一个类都必须拥有至少一个指定构造器
    class One {
        var one:String
        init(one:String) {
            self.one = one
        }
    }
    //便利构造器:类中比较次要的、辅助型的构造器。定义便利构造器来调用同一个类中的指定构造器，并为其参数提供默认值。你也可以定义便利构造器来创建一个特殊用途或特定输入值的实例。
    class Two {
        var two:String
        init(two:String) {
            self.two = two
        }
        
        convenience init(input:String) {
            self.init(two: input)
        }
    }
    //代理规则
    /*
    规则 1
    指定构造器必须调用其直接父类的的指定构造器。
    规则 2
    便利构造器必须调用同类中定义的其它构造器。
    规则 3
    便利构造器必须最终导致一个指定构造器被调用。
 */
    
    /*可失败构造器*/
    //注意:(1)可失败构造器的参数名和参数类型，不能与其它非可失败构造器的参数名，及其参数类型相同(2)通过return nil语句来表明可失败构造器在何种情况下应该“失败”
    struct Animal {
        let species: String
        init?(species: String) {
            if species.isEmpty { return nil }
            self.species = species
        }
    }
    //枚举可失败构造器
    enum TemperatureUnit {
        case Kelvin, Celsius, Fahrenheit
        init?(symbol: Character) {
            switch symbol {
            case "K":
                self = .Kelvin
            case "C":
                self = .Celsius
            case "F":
                self = .Fahrenheit
            default:
                return nil
            }
        }
    }
    //带原始值的枚举类型的可失败构造器
    //带原始值的枚举类型会自带一个可失败构造器init?(rawValue:)，该可失败构造器有一个名为rawValue的参数，其类型和枚举类型的原始值类型一致，如果该参数的值能够和某个枚举成员的原始值匹配，则该构造器会构造相应的枚举成员，否则构造失败。
    
    /*重写一个可失败构造器*/
    //如同其它的构造器，你可以在子类中重写父类的可失败构造器。或者你也可以用子类的非可失败构造器重写一个父类的可失败构造器。这使你可以定义一个不会构造失败的子类，即使父类的构造器允许构造失败。
    
    //注意:(1)当你用子类的非可失败构造器重写父类的可失败构造器时，向上代理到父类的可失败构造器的唯一方式是对父类的可失败构造器的返回值进行强制解包。
        //(2)你可以用非可失败构造器重写可失败构造器，但反过来却不行。
    class Document {
        var name: String?
        // 该构造器创建了一个 name 属性的值为 nil 的 document 实例
        init() {}
        // 该构造器创建了一个 name 属性的值为非空字符串的 document 实例
        init?(name: String) {
            self.name = name
            if name.isEmpty { return nil }
        }
    }
    
    class AutomaticallyNamedDocument: Document {
        override init() {
            super.init()
            self.name = "[Untitled]"
        }
        override init(name: String) {
            super.init()
            if name.isEmpty {
                self.name = "[Untitled]"
            } else {
                self.name = name
            }
        }
    }
    
    /*
     可失败构造器 init!
     通常来说我们通过在init关键字后添加问号的方式（init?）来定义一个可失败构造器，但你也可以通过在init后面添加惊叹号的方式来定义一个可失败构造器（init!），该可失败构造器将会构建一个对应类型的隐式解包可选类型的对象。
     你可以在init?中代理到init!，反之亦然。你也可以用init?重写init!，反之亦然。你还可以用init代理到init!，不过，一旦init!构造失败，则会触发一个断言。
     */
    
    /*必要构造器*/
    //在类的构造器前添加required修饰符表明所有该类的子类都必须实现该构造器：
    /*class SomeSubclass: SomeClass {
        required init() {
            // 构造器的实现代码
        }
    }
    */
    
    
    /*通过闭包或函数设置属性的默认值*/
    class SomeClass {
        let someProperty: Int = {
            // 在这个闭包中给 someProperty 创建一个默认值
            // 返回值 必须和  类型相同
            return 1
        }()
    }
    //注意闭包结尾的大括号后面接了一对空的小括号。这用来告诉 Swift 立即执行此闭包。如果你忽略了这对括号，相当于将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。
    
    struct Checkerboard {
        let boardColors: [Bool] = {
            var temporaryBoard = [Bool]()
            var isBlack = false
            for i in 1...8 {
                for j in 1...8 {
                    temporaryBoard.append(isBlack)
                    isBlack = !isBlack
                }
                isBlack = !isBlack
            }
            return temporaryBoard
        }()
        func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
            return boardColors[(row * 8) + column]
        }
    }
    //每当一个新的Checkerboard实例被创建时，赋值闭包会被执行，boardColors的默认值会被计算出来并返回。上面例子中描述的闭包将计算出棋盘中每个格子对应的颜色，并将这些值保存到一个临时数组temporaryBoard中，最后在构建完成时将此数组作为闭包返回值返回。这个返回的数组会保存到boardColors中，并可以通过工具函数squareIsBlackAtRow来查询：

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        enum TemperatureUnit: Character {
            case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
        }
        
        let fahrenheitUnit = TemperatureUnit(rawValue: "F")
        if fahrenheitUnit != nil {
            print("This is a defined temperature unit, so initialization succeeded.")
        }
        // 打印 "This is a defined temperature unit, so initialization succeeded."
        
        let unknownUnit = TemperatureUnit(rawValue: "X")
        if unknownUnit == nil {
            print("This is not a defined temperature unit, so initialization failed.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

