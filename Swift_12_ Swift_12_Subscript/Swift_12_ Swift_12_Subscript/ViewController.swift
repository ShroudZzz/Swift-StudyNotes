//
//  ViewController.swift
//  Swift_12_ Swift_12_Subscript
//
//  Created by VermouthC on 2017/9/4.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /**
     section 下标 --> Subscript
     (1) 下标允许你通过在实例名称后面的方括号中传入一个或者多个索引值来对实例进行存取
     (2) 定义下标使用subscript关键字，指定一个或多个输入参数和返回类型
     (3) 下标可以设定为读写或只读。这种行为由 getter 和 setter 实现，有点类似计算型属性：
     */
    
    struct TimesTable {
        let multiplier: Int
        subscript(index:Int)->Int{
           return multiplier*index
        }
    }
    
    struct Matrix {
        let rows: Int, columns: Int
        var grid: [Double]
        init(rows: Int, columns: Int) {
            self.rows = rows
            self.columns = columns
            grid = Array(repeatElement(0.0, count: rows*columns))
        }
        func indexIsValidForRow(row: Int, column: Int) -> Bool {
            return row >= 0 && row < rows && column >= 0 && column < columns
        }
        subscript(row: Int, column: Int) -> Double {
            get {
                assert(indexIsValidForRow(row: row, column: column), "Index out of range")
                return grid[(row * columns) + column]
            }
            set {
                assert(indexIsValidForRow(row: row, column: column), "Index out of range")
                grid[(row * columns) + column] = newValue
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let threeTimesTable = TimesTable(multiplier:4)
        print(threeTimesTable[6])
        
        var matrix = Matrix(rows: 2, columns: 2)
        //row和column的值传入下标来为矩阵设值，下标的入参使用逗号分隔
        matrix[0, 1] = 1.5
        matrix[1, 0] = 3.2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

