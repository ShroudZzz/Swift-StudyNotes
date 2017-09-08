//
//  ViewController.swift
//  Swift_16_ARC
//
//  Created by VermouthC on 2017/9/5.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /**
     section 自动引用技术 --> ARC
     (1) 每次创建一个类的新的实例的时候，ARC 会分配一块内存来储存该实例信息。内存中会包含实例的类型信息，以及这个实例所有相关的存储型属性的值
     (2) 实例不再被使用时，ARC 释放实例所占用的内存，并让释放的内存能挪作他用
     (3) ARC 会跟踪和计算每一个实例正在被多少属性，常量和变量所引用。哪怕实例的引用数为1，ARC都不会销毁这个实例
     */
    
    class Person {
        let name: String
        init(name: String) {
            self.name = name
            print("\(name) is being initialized")
        }
        deinit {
            print("\(name) is being deinitialized")
        }
    }
    
    /*类实例之间的循环强引用*/
    //产生
    class Persons {
        let name: String
        init(name:String) {
            self.name = name
        }
        var apartment:Apartment?
        deinit {
            print("\(name) is being deinitialized")
        }
    }
    class Apartment{
        let unit: String
        init(unit: String) { self.unit = unit }
        var tenant: Person?
        deinit { print("Apartment \(unit) is being deinitialized") }
    }
    
    /*解决实例之间的循环强引用(弱引用和无主引用允许循环引用中的一个实例引用而另外一个实例不保持强引用):1.弱应用(weak关键字表明这是一个弱引用) 2.无主引用(unowned表示这是一个无主引用)*/
    //原则: 实例有更短的生命周期时，使用弱引用 实例有相同的或者更长生命周期时，请使用无主引用
    //ARC 中，一旦值的最后一个强引用被移除，就会被立即销毁
    /*弱引用
     class Apartment {
     let unit: String
     init(unit: String) { self.unit = unit }
     weak var tenant: Person?
     deinit { print("Apartment \(unit) is being deinitialized") }
     }
     
     */
    /*无主引用*/
    /*重要
    使用无主引用，你必须确保引用始终指向一个未销毁的实例。
    如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误。
    */
    class Customer {
        let name: String
        var card: CreditCard?
        init(name: String) {
            self.name = name
        }
        deinit { print("\(name) is being deinitialized") }
    }
    
    class CreditCard {
        let number: UInt64
        unowned let customer: Customer
        init(number: UInt64, customer: Customer) {
            self.number = number
            self.customer = customer
        }
        deinit { print("Card #\(number) is being deinitialized") }
    }
    
    /*无主引用以及隐式解析可选属性*/
    /*
     (1)Person和Apartment的例子展示了两个属性的值都允许为nil，并会潜在的产生循环强引用。这种场景最适合用弱引用来解决。
     (2)Customer和CreditCard的例子展示了一个属性的值允许为nil，而另一个属性的值不允许为nil，这也可能会产生循环强引用。这种场景最适合通过无主引用来解决。
     (3)两个属性都必须有值，并且初始化完成后永远不会为nil。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性。
    */
    class Country {
        let name: String
        var capitalCity: City!
        init(name: String, capitalName: String) {
            self.name = name
            self.capitalCity = City(name: capitalName, country: self)
        }
    }
    
    class City {
        let name: String
        unowned let country: Country
        init(name: String, country: Country) {
            self.name = name
            self.country = country
        }
    }
    
    /*闭包引起的循环强引用*/
    //循环强引用还会发生在当你将一个闭包赋值给类实例的某个属性，并且这个闭包体中又使用了这个类实例时。这个闭包体中可能访问了实例的某个属性
    //产生
    class HTMLElement {
        let name: String
        let text:String?
        
        lazy var asHTML:(void)->String = {
            if let text = self.text {
                return "<\(self.name)>\(text)</\(self.name)>"
            } else {
                return "<\(self.name) />"
            }
        }
        
        init(name: String, text: String? = nil) {
            self.name = name
            self.text = text
        }
        
        deinit {
            print("\(name) is being deinitialized")
        }
    }
    //解决
    //在定义闭包时同时定义捕获列表作为闭包的一部分，通过这种方式可以解决闭包和类实例之间的循环强引用。捕获列表定义了闭包体内捕获一个或者多个引用类型的规则。跟解决两个类实例间的循环强引用一样，声明每个捕获的引用为弱引用或无主引用，而不是强引用。应当根据代码关系来决定使用弱引用还是无主引用。
    //定义捕获列表
    //捕获列表中的每一项都由一对元素组成，一个元素是weak或unowned关键字，另一个元素是类实例的引用（例如self）或初始化过的变量（如delegate = self.delegate!）。这些项在方括号中用逗号分开。
    
   // 如果闭包有参数列表和返回类型，把捕获列表放在它们前面：
    
    lazy var someClosure: (Int, String) -> String = {
        [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
        // 这里是闭包的函数体
    }
    //如果闭包没有指明参数列表或者返回类型，即它们会通过上下文推断，那么可以把捕获列表和关键字in放在闭包最开始的地方：
    
    lazy var someClosure: Void -> String = {
        [unowned self, weak delegate = self.delegate!] in
        // 这里是闭包的函数体
    }
    
    //在闭包和捕获的实例总是互相引用并且总是同时销毁时，将闭包内的捕获定义为无主引用。
    //相反的，在被捕获的引用可能会变为nil时，将闭包内的捕获定义为弱引用。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为nil
    /*
     class HTMLElement {
     
     let name: String
     let text: String?
     
     lazy var asHTML: Void -> String = {
     [unowned self] in
     if let text = self.text {
     return "<\(self.name)>\(text)</\(self.name)>"
     } else {
     return "<\(self.name) />"
     }
     }
     
     init(name: String, text: String? = nil) {
     self.name = name
     self.text = text
     }
     
     deinit {
     print("\(name) is being deinitialized")
     }
     
     }
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var reference1: Person?
        var reference2: Person?
        var reference3: Person?
        
        reference1 = Person(name: "Chen")
        reference2 = reference1
        reference3 = reference1
        
        reference1 = nil
        reference2 = nil
        //此时仅留下一个强引用
        reference3 = nil//析构函数执行
        
        //循环引用
        var john: Person?
        var unit4A: Apartment?
        
        //变量john现在有一个指向Person实例的强引用，而变量unit4A有一个指向Apartment实例的强引用
        john = Person(name: "John Appleseed")
        unit4A = Apartment(unit: "4A")
        //实例关联
        john!.apartment = unit4A
        unit4A!.tenant = john
        //此时即便是
        john = nil
        unit4A = nil //内存不会释放内存
        /*
         原因:
         Person实例现在有了一个指向Apartment实例的强引用，而Apartment实例也有了一个指向Person实例的强引用。因此，当你断开john和unit4A变量所持有的强引用时，引用计数并不会降为0，实例也不会被 ARC 销毁
         */
        
        var chen: Customer?
        chen = Customer(name: "John Appleseed")
        chen!.card = CreditCard(number: 1234_5678_9012_3456, customer: chen!)
        //Customer实例持有对CreditCard实例的强引用，而CreditCard实例持有对Customer实例的无主引用。
        
        chen = nil
        // 打印 “John Appleseed is being deinitialized”
        // 打印 ”Card #1234567890123456 is being deinitialized”
        
        /*无主引用以及隐式解析可选属性*/
        //意义在于你可以通过一条语句同时创建Country和City的实例，而不产生循环强引用，并且capitalCity的属性能被直接访问，而不需要通过感叹号来展开它的可选值：
        var country = Country(name: "Canada", capitalName: "Ottawa")
        print("\(country.name)'s capital city is called \(country.capitalCity.name)")
        // 打印 “Canada's capital city is called Ottawa”
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

