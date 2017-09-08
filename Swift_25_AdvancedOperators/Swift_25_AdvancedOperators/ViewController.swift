//
//  ViewController.swift
//  Swift_25_AdvancedOperators
//
//  Created by VermouthC on 2017/9/7.
//  Copyright © 2017年 VermouthC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /**
     section 高级运算符 --> AdvancedOperators
     (1) <#description#>
     (2) <#description#>
     */
    func operation(){
        //按位取反运算符(~)
        let initialBits: UInt8 = 0b00001111
        let invertedBits = ~initialBits // 等于 0b11110000
        //按位与运算符(&)
        let firstSixBits: UInt8 = 0b11111100
        let lastSixBits: UInt8  = 0b00111111
        let middleFourBits = firstSixBits & lastSixBits // 等于 00111100
        //按位或运算符(|)
        let someBits: UInt8 = 0b10110010
        let moreBits: UInt8 = 0b01011110
        let combinedbits = someBits | moreBits // 等于 11111110
        //按位异或运算符(^)
        let firstBits: UInt8 = 0b00010100
        let otherBits: UInt8 = 0b00000101
        let outputBits = firstBits ^ otherBits // 等于 00010001
        //按位左移、右移运算符(<<  >>)
        //对一个数进行按位左移或按位右移，相当于对这个数进行乘以 2 或除以 2 的运算。将一个整数左移一位，等价于将这个数乘以 2，同样地，将一个整数右移一位，等价于将这个数除以 2。
        /*
         无符号整数的移位运算
         
         对无符号整数进行移位的规则如下：
         
         已经存在的位按指定的位数进行左移和右移。
         任何因移动而超出整型存储范围的位都会被丢弃。
         用 0 来填充移位后产生的空白位。
         这种方法称为逻辑移位。
         */
        let shiftBits: UInt8 = 4 // 即二进制的 00000100
        shiftBits << 1           // 00001000
        shiftBits << 2           // 00010000
        shiftBits << 5           // 10000000
        shiftBits << 6           // 00000000
        shiftBits >> 2           // 00000001
        //使用移位运算对其他的数据类型进行编码和解码：
        let pink: UInt32 = 0xCC6699
        let redComponent = (pink & 0xFF0000) >> 16  // redComponent 是 0xCC，即 204
        let greenComponent = (pink & 0x00FF00) >> 8 // greenComponent 是 0x66， 即 102
        let blueComponent = pink & 0x0000FF         // blueComponent 是 0x99，即 153
        
        //溢出运算符
        //数值溢出的时候采取截断处理，而非报错。可以使用 Swift 提供的三个溢出运算符来让系统支持整数溢出运算。这些运算符都是以 & 开头的：
        /*
        溢出加法 &+
        溢出减法 &-
        溢出乘法 &*
        */
     //无符号与有符号整型数值来说，当出现上溢时，它们会从数值所能容纳的最大数变成最小的数。同样地，当发生下溢时，它们会从所能容纳的最小数变成最大的数。
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

