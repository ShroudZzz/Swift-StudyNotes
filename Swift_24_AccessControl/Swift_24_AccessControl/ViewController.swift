//
//  ViewController.swift
//  Swift_24_AccessControl
//
//  Created by VermouthC on 2017/9/7.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /**
     section 访问控制 --> AccessControl
     (1) 访问控制可以限定其他源文件或模块中的代码对你的代码的访问级别
     (2) 明确地给单个类型（类、结构体、枚举）设置访问级别，也可以给这些类型的属性、方法、构造器、下标等设置访问级别。协议也可以被限定在一定的范围内使用，包括协议里的全局常量、变量和函数
     (3) 在 Swift 中，一个模块可以使用 import 关键字导入另外一个模块
     (4)
         开放访问和公开访问可以访问同一模块源文件中的任何实体，在模块外也可以通过导入该模块来访问源文件里的所有实体。通常情况下，框架中的某个接口可以被任何人使用时，你可以将其设置为开放或者公开访问。
         内部访问可以访问同一模块源文件中的任何实体，但是不能从模块外访问该模块源文件中的实体。通常情况下，某个接口只在应用程序或框架内部使用时，你可以将其设置为内部访问。
         文件私有访问限制实体只能被所定义的文件内部访问。当需要把这些细节被整个文件使用的时候，使用文件私有访问隐藏了一些特定功能的实现细节。
         私有访问限制实体只能在所定义的作用域内使用。需要把这些细节被整个作用域使用的时候，使用文件私有访问隐藏了一些特定功能的实现细节。
         开放访问为最高（限制最少）访问级别，私有访问为最低（限制最多）访问级别
     
     (5)开放访问只作用于类类型和类的成员，它和公开访问的区别如下：
         公开访问或者其他更严访问级别的类，只能在它们定义的模块内部被继承。
         公开访问或者其他更严访问级别的类成员，只能在它们定义的模块内部的子类中重写。
         开放访问的类，可以在它们定义的模块中被继承，也可以在引用它们的模块中被继承。
         开放访问的类成员，可以在它们定义的模块中子类中重写，也可以在引用它们的模块中的子类重写。
         把一个类标记为开放，显式地表明，你认为其他模块中的代码使用此类作为父类，然后你已经设计好了你的类的代码了。
     (6)访问级别基本原则
         不可以在某个实体中定义访问级别更低（更严格）的实体
     (7)通过修饰符 open，public，internal，fileprivate，private 来声明实体的访问级别
     (8)重要
        一个公开类型的所有成员的访问级别默认为内部访问级别，而不是公开级别。如果你想将某个成员指定为公开访问级别，那么你必须显式指定。这样做的好处是，在你定义公共接口的时候，可以明确地选择哪些接口是需要公开的，哪些是内部使用的，避免不小心将内部使用的接口公开。
     (9)元组类型
        元组的访问级别将由元组中访问级别最严格的类型来决定。例如，如果你构建了一个包含两种不同类型的元组，其中一个类型为内部访问级别，另一个类型为私有访问级别，那么这个元组的访问级别为私有访问级别。
         注意
         元组不同于类、结构体、枚举、函数那样有单独的定义。元组的访问级别是在它被使用时自动推断出的，而无法明确指定。
     (10)函数类型
         函数的访问级别根据访问级别最严格的参数类型或返回类型的访问级别来决定
     (11)枚举类型
         枚举成员的访问级别和该枚举类型相同，你不能为枚举成员单独指定不同的访问级别。
     (12)原始值和关联值
        枚举定义中的任何原始值或关联值的类型的访问级别至少不能低于枚举类型的访问级别。例如，你不能在一个 internal 访问级别的枚举中定义 private 级别的原始值类型。
     (13)嵌套类型
        如果在 private 级别的类型中定义嵌套类型，那么该嵌套类型就自动拥有 private 访问级别。如果在 public 或者 internal 级别的类型中定义嵌套类型，那么该嵌套类型自动拥有 internal 访问级别。如果想让嵌套类型拥有 public 访问级别，那么需要明确指定该嵌套类型的访问级别。
     (14)子类
         子类的访问级别不得高于父类的访问级别。例如，父类的访问级别是 internal，子类的访问级别就不能是 public。
         通过重写为继承来的类成员提供更高的访问级别
         在子类中，用子类成员去访问访问级别更低的父类成员，只要这一操作在相应访问级别的限制范围内
     (15)常量、变量、属性、下标
         常量、变量、属性不能拥有比它们的类型更高的访问级别。例如，你不能定义一个 public 级别的属性，但是它的类型却是 private 级别的。同样，下标也不能拥有比索引类型或返回类型更高的访问级别。
         如果常量、变量、属性、下标的类型是 private 级别的，那么它们必须明确指定访问级别为 private：
         private var privateInstance = SomePrivateClass()
     (16)常量、变量、属性、下标的 Getters 和 Setters 的访问级别和它们所属类型的访问级别相同
         Setter 的访问级别可以低于对应的 Getter 的访问级别，这样就可以控制变量、属性或下标的读写权限
         不明确指定存储型属性的 Getter 和 Setter，Swift 也会隐式地为其创建 Getter 和 Setter，用于访问该属性的后备存储
         使用 fileprivate(set)，private(set) 和 internal(set) 可以改变 Setter 的访问级别，这对计算型属性也同样适用。
     struct TrackedString {
         private(set) var numberOfEdits = 0
         var value: String = "" {
         didSet {
             numberOfEdits += 1
         }
       }
     }
     (17)构造器
        自定义构造器的访问级别可以低于或等于其所属类型的访问级别。唯一的例外是必要构造器，它的访问级别必须和所属类型的访问级别相同。
        如同函数或方法的参数，构造器参数的访问级别也不能低于构造器本身的访问级别。
     (18)默认构造器
         默认构造器的访问级别与所属类型的访问级别相同，除非类型的访问级别是 public。如果一个类型被指定为 public 级别，那么默认构造器的访问级别将为 internal。如果你希望一个 public 级别的类型也能在其他模块中使用这种无参数的默认构造器，你只能自己提供一个 public 访问级别的无参数构造器。
     (19)协议
         协议中的每一个要求都具有和该协议相同的访问级别。你不能将协议中的要求设置为其他访问级别。这样才能确保该协议的所有要求对于任意采纳者都将可用。
     注意
     如果你定义了一个 public 访问级别的协议，那么该协议的所有实现也会是 public 访问级别。这一点不同于其他类型，例如，当类型是 public 访问级别时，其成员的访问级别却只是 internal。
     协议继承
     
     如果定义了一个继承自其他协议的新协议，那么新协议拥有的访问级别最高也只能和被继承协议的访问级别相同。例如，你不能将继承自 internal 协议的新协议定义为 public 协议
     
     一个类型可以采纳比自身访问级别低的协议。例如，你可以定义一个 public 级别的类型，它可以在其他模块中使用，同时它也可以采纳一个 internal 级别的协议，但是只能在该协议所在的模块中作为符合该协议的类型使用
     (20)扩展
     扩展成员具有和原始类型成员一致的访问级别。例如，你扩展了一个 public 或者 internal 类型，扩展中的成员具有默认的 internal 访问级别，和原始类型中的成员一致 。如果你扩展了一个 private 类型，扩展成员则拥有默认的 private 访问级别。
     明确指定扩展的访问级别（例如，private extension），从而给该扩展中的所有成员指定一个新的默认访问级别。这个新的默认访问级别仍然可以被单独指定的访问级别所覆盖。
     (21)泛型
     泛型类型或泛型函数的访问级别决于泛型类型或泛型函数本身的访问级别，还需结合类型参数的类型约束的访问级别，根据这些访问级别中的最低访问级别来确定。
     (22)类型别名
     你定义的任何类型别名都会被当作不同的类型，以便于进行访问控制。类型别名的访问级别不可高于其表示的类型的访问级别。例如，private 级别的类型别名可以作为 private，file-private，internal，public或者open类型的别名，但是 public 级别的类型别名只能作为 public 类型的别名，不能作为 internal，file-private，或 private 类型的别名。
     */
    
    public class SomePublicClass {                  // 显式公开类
        public var somePublicProperty = 0            // 显式公开类成员
        var someInternalProperty = 0                 // 隐式内部类成员
        fileprivate func someFilePrivateMethod() {}  // 显式文件私有类成员
        private func somePrivateMethod() {}          // 显式私有类成员
    }
    
    class SomeInternalClass {                       // 隐式内部类
        var someInternalProperty = 0                 // 隐式内部类成员
        fileprivate func someFilePrivateMethod() {}  // 显式文件私有类成员
        private func somePrivateMethod() {}          // 显式私有类成员
    }
    
    fileprivate class SomeFilePrivateClass {        // 显式文件私有类
        func someFilePrivateMethod() {}              // 隐式文件私有类成员
        private func somePrivateMethod() {}          // 显式私有类成员
    }
    
    private class SomePrivateClass {                // 显式私有类
        func somePrivateMethod() {}                  // 隐式私有类成员
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

