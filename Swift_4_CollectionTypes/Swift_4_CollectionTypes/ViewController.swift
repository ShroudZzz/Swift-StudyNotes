//
//  ViewController.swift
//  Swift_4_CollectionTypes
//
//  Created by VermouthC on 2017/8/16.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /**
     section Four --> 集合类型 数组(Arrays)
     */
    
    func initArrays() {
        /**初始化一个空数组*/
        var someInts = [Int]()
        print("someInts is of type [Int] with \(someInts.count) items.")
        // 代码上下文中已经提供了类型信息，例如一个函数参数或者一个已经定义好类型的常量或者变量，我们可以使用空数组语句创建一个空数组，它的写法很简单：[]（一对空方括号）：
        someInts.append(3)
        someInts = [ ]
        
        /**初始化一个带有默认值的数组*/
        var threeDoubles = Array(repeating:0.0,count:3) // 等价于[0.0 ,0.0, 0.0]
        print(threeDoubles)
        //初始化通过两个数组相加创建一个数组
        var anotherThreeDoubles = Array(repeatElement(2.5, count: 3))
        var sixDoubles = threeDoubles + anotherThreeDoubles
        print(sixDoubles)
        
        //用数组字面量构造数组
        var shoppingList: [String] = ["Eggs","Milk"] // var shopping = ["Eggs","Milk"]
        if shoppingList.contains("Eggs"){
           print("Shopping List contains Eggs")
        }
        /**访问和修改数组*/
        // 数组大小
        let count = shoppingList.count
        // 使用 isEmpty 检查count属性是否为0
        if shoppingList.isEmpty{
           print("ShoppingList Array is Empty .")
        }
        
        //数组添加
        shoppingList.append("Flour")
        //使用 += 添加一个或者多个相同类型的数据项
        shoppingList += ["Baking Powder"]
        shoppingList += ["Chocolate Spread","Cheese","Butter"]
        //数组获取 下标
        var firstItem = shoppingList[0]
        //通过数组下标改变已有索引值对应的数据值
        shoppingList[0] = "Six Eggs"
        //使用下标一次改变一系列的数据值
        shoppingList[4...6] = ["Bananas","Apples"]
        
        //数组插值
        shoppingList.insert("Maple Syrup", at: 0) // 第一项插值
        //移除数组元素
        shoppingList.remove(at: 0)
        shoppingList.removeLast()// 移除最后一个  
        //shoppingList.removeAll()// 全部移除
        shoppingList.removeFirst() // 移除第一个
        
        /** 数组遍历*/
        for item in shoppingList {
            print(item)
        }
        //如果需要每一项数据的索引值和数据项的值 可以使用enumerated()方法来进行数组遍历。enumerated()返回一个由每一个数据项索引值和数据值组成的元组。我们可以把这个元组分解成临时常量或者变量来进行遍历：
        for (index,value) in shoppingList.enumerated(){
           print("Item \(String(index+1)):\(value)")
        }
        
        
    }
    
    /**
     section Four --> 集合类型 集合(Sets)
     (1) 集合(Set)用来存储相同类型并且没有确定顺序的值。当集合元素顺序不重要时或者希望确保每个元素只出现一次时可以使用集合而不是数组。
     (2) Swift 中的Set类型被写为Set<Element>，这里的Element表示Set中允许存储的类型，和数组不同的是，集合没有等价的简化形式。
     */
    
    func initSets() {
        /** 初始化Set*/
        var letters = Set<Character>()
        print("letters is of type Set<Character> with \(letters.count) items.")
        //如果上下文提供了类型信息，比如作为函数的参数或者已知类型的变量或常量，我们可以通过一个空的数组字面量创建一个空的Set
        letters.insert("a")
        letters = [ ]  //letters 为空的Set
        //数组字面量构造集合
        var favoriteGenres :Set <String> = ["Rock","Classical","Hip hop"]
        /**注意
           一个Set类型不能从数组字面量中被单独推断出来，因此Set类型必须显式声明。然而，由于 Swift 的类型推断功能，如果你想使用一个数组字面量构造一个Set并且该数组字面量中的所有元素类型相同，那么你无须写出Set的具体类型。
         */
        var favoriteGenresNew:Set = ["Rock","Classical","Hip hop"]
        
        /** 访问和修改集合*/
        let favoriteSetCount =  favoriteGenres.count //获取集合大小
        //使用布尔属性isEmpty作为一个缩写形式去检查count属性是否为0：
        if favoriteGenres.isEmpty {
            print("As far as music goes, I'm not picky.")
        } else {
            print("I have particular music preferences.")
        }
        //集合插值
        favoriteGenres.insert("Jazz")
        //集合移除元素 全部移除 removeAll()
        if let removeGenre = favoriteGenres.remove("Rock") {
            print("\(removeGenre) ? I am over it .")
        }else{
            print("I never much cared for that")
        }
        
        //集合是否包含某个值
        if favoriteGenres.contains("Funk") {
            print("Set contains it .")
        }
        
        /** 遍历集合*/
        for genre in favoriteGenres{
           print("\(genre)")
        }
        //Swift 的Set类型没有确定的顺序，为了按照特定顺序来遍历一个Set中的值可以使用sorted()方法，它将返回一个有序数组，这个数组的元素排列顺序由操作符'<'对元素进行比较的结果来确定.
        for genre in favoriteGenres.sorted(){
            print("\(genre)")
        }
        /** 集合操作
         使用intersection(_:)方法根据两个集合中都包含的值创建的一个新的集合。求交集
         使用symmetricDifference(_:)方法根据在一个集合中但不在两个集合中的值创建一个新的集合。求交集的反
         使用union(_:)方法根据两个集合的值创建一个新的集合。//求并集
         使用subtracting(_:)方法根据不在该集合中的值创建一个新的集合。//求前者交集的反
         */
       
        let oddDigits: Set = [1,3,5,7,9]
        let evenDigits:Set = [0,2,4,6,8]
        let singDigitPrimeNumber:Set = [2,3,5,7]
        
        oddDigits.intersection(evenDigits).sorted() // []
        oddDigits.union(evenDigits).sorted() // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        oddDigits.subtracting(singDigitPrimeNumber).sorted() // [1, 9]
        oddDigits.symmetricDifference(singDigitPrimeNumber).sorted() // [1, 2, 9]
        
        /** 集合成员关系和相等
         使用“是否相等”运算符(==)来判断两个集合是否包含全部相同的值。
         使用isSubset(of:)方法来判断一个集合中的值是否也被包含在另外一个集合中。
         使用isSuperset(of:)方法来判断一个集合中包含另一个集合中所有的值。
         使用isStrictSubset(of:)或者isStrictSuperset(of:)方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
         使用isDisjoint(with:)方法来判断两个集合是否不含有相同的值(是否没有交集)。
         
         */
        let houseAnimals: Set = ["🐶", "🐱"]
        let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
        let cityAnimals: Set = ["🐦", "🐭"]
        
        houseAnimals.isSubset(of: farmAnimals)
        // true
        farmAnimals.isSuperset(of: houseAnimals)//所有值是否包含
        // true
        farmAnimals.isDisjoint(with: cityAnimals)
        // true
    }
    
    /**
     section Four --> 字典(Dictionary)
     (1) Swift 的字典使用Dictionary<Key, Value>定义，其中Key是字典中键的数据类型，Value是字典中对应于这些键所存储值的数据类型
     (2) 用[Key: Value]这样简化的形式去创建一个字典类型.
     */
    
    func initDictionary() {
        /** 创建一个字典*/
        var namesOfIntegers = [Int :String]()
        //如果上下文已经提供了类型信息，我们可以使用空字典字面量来创建一个空字典，记作[:]（中括号中放一个冒号）：
        namesOfIntegers[16] = "sixteen"
        // namesOfIntegers 现在包含一个键值对
        namesOfIntegers = [:]
        // namesOfIntegers 又成为了一个 [Int: String] 类型的空字典
        
        //用字面量创建新的字典
        var airports:[String : String] = ["YYZ":"Toronto Pearson","DUB":"Dublin"]
        //和数组一样，我们在用字典字面量构造字典时，如果它的键和值都有各自一致的类型，那么就不必写出字典的类型。 airports字典也可以用这种简短方式定义：
        //var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"] 类型推断
        
        /** 访问和修改字典*/
        let dictionaryCount = airports.count //字典大小
        if airports.isEmpty {
            print("Diction is Empt .")
        }
        
        //使用下标添加新的元素
        airports["LHR"] = "London"  //同理 亦可以修改对应的值
        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print("Old Value id \(oldValue)")
        }
        //我们也可以使用下标语法来在字典中检索特定键对应的值。因为有可能请求的键没有对应的值存在，字典的下标访问会返回对应值的类型的可选值。如果这个字典包含请求键所对应的值，下标会返回一个包含这个存在值的可选值，否则将返回nil：
        
        if  let airportName = airports["DUB"] {
            print("The name of airport is \(airportName)")
        }else{
            print("Not Exist")
        }
        
        //通过下标语法将某个键对应的值赋值为nil 移除一个键值对
        airports["APL"] = "Apple Internation"
        airports["APL"] = nil //APL  被移除了
        
        if let removeValue = airports.removeValue(forKey: "DUB") {
            print("The removed airport's name is \(removeValue).")
        } else {
            //返回nil
            print("The airports dictionary does not contain a value for DUB.")
        }
        
        /** 字典遍历*/
        for(airportsCode,airportsName) in airports{
            print("\(airportsCode) : \(airportsName)")
        }
        
        //通过访问keys或者values属性，我们也可以遍历字典的键或者值：
        
        for airportCode in airports.keys {
            print("Airport code: \(airportCode)")
        }
        // Airport code: YYZ
        // Airport code: LHR
        
        for airportName in airports.values {
            print("Airport name: \(airportName)")
        }
        // Airport name: Toronto Pearson
        // Airport name: London Heathrow
        
        let airportCodes = [String](airports.keys)  //字典Key数组
        let airportNames = [String](airports.values) //字典的Value 数组
        //注意: Swift 的字典类型是无序集合类型。为了以特定的顺序遍历字典的键或值，可以对字典的keys或values属性使用sorted()方法。
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initArrays()
        
        initSets()
        
        initDictionary()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

