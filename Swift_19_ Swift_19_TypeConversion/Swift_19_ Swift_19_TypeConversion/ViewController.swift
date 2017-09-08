//
//  ViewController.swift
//  Swift_19_ Swift_19_TypeConversion
//
//  Created by VermouthC on 2017/9/6.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class MediaItem{
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director:String
    init(name:String,director:String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}


class ViewController: UIViewController {
    /**
     section 类型转换 --> Type Conversion
     (1) 类型转换 可以判断实例的类型，也可以将实例看做是其父类或者子类的实例
     (2) 类型转换在 Swift 中使用 is 和 as 操作符实现
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let library = [
            Movie(name: "Casablanca", director: "Michael Curtiz"),
            Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
            Movie(name: "Citizen Kane", director: "Orson Welles"),
            Song(name: "The One And Only", artist: "Chesney Hawkes"),
            Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
        ]
        
        // 数组 library 的类型被推断为 [MediaItem]
        
        /*类型检查 类型检查操作符（is）来检查一个实例是否属于特定子类型 返回 true or false*/
        var movieCount = 0
        var songCount = 0
        for item in library {
            if item is Movie{
                movieCount += 1
            }else if item is Song{
                songCount += 1
            }
        }
        
        /*向下转型*/
        //某类型的一个常量或变量可能在幕后实际上属于一个子类。当确定是这种情况时，你可以尝试向下转到它的子类型，用类型转换操作符（as? 或 as!）
        for item in library{
            if let movie = item as? Movie{
               print("Movie: '\(movie.name)', dir. \(movie.director)")
            }else if let song = item as? Song{
              print("Song: '\(song.name)', by \(song.artist)")
            }
        }
        
        /*Any 和 AnyObject 的类型转换*/
        /*
            Swift 为不确定类型提供了两种特殊的类型别名：
            Any 可以表示任何类型，包括函数类型。
            AnyObject 可以表示任何类类型的实例
         */
        var things = [Any]()
        things.append(0)
        things.append(0.0)
        things.append(42)
        things.append(3.14159)
        things.append("hello")
        things.append((3.0, 5.0))
        things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
        things.append({ (name:String) -> String in "Hello,\(name)"})
        
        for thing in things{
            switch thing {
            case 0 as Int:
                print("Zero as am Int")
            case 0 as Double:
                print("zero as a Double")
            case let someInt as Int:
                print("an integer value of \(someInt)")
            case let someDouble as Double where someDouble > 0:
                print("a positive double value of \(someDouble)")
            case is Double:
                print("some other double value that I don't want to print")
            case let someString as String:
                print("a string value of \"\(someString)\"")
            case let (x, y) as (Double, Double):
                print("an (x, y) point at \(x), \(y)")
            case let movie as Movie:
                print("a movie called '\(movie.name)', dir. \(movie.director)")
            case let stringConverter as (String) -> String:
                print(stringConverter("Michael"))
            default:
                print("something else")
            }
        }
    }
   /*注意
     (1)Any类型可以表示所有类型的值，包括可选类型
     (2)用Any类型来表示一个可选值的时候，给你一个警告。如果你确实想使用Any类型来承载可选值，你可以使用as操作符显式转换为Any
     
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        var things = [Any]()
        
        let optionalNumber: Int? = 3
        things.append(optionalNumber)        // 警告
        things.append(optionalNumber as Any) // 没有警告
    }


}

