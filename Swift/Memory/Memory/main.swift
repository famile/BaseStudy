//
//  main.swift
//  Memory
//
//  Created by 李涛 on 2019/9/10.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

import Foundation

func add(_ num: Int) -> (Int) -> Int { { $0 + num } }

let num = add(10)(20)
print(num)

/*
 字符串长度 <= 0xF 字符串内容直接存放在str1 变量的内存中
 
 */

var a: Int = 8
print(MemoryLayout.size(ofValue: a))

enum SomeError: Error {
    
    case illegalArg(String)
    case outOfBounds(Int)
    case outOfMemory
}

class Person {
    var name: String = ""
    init(name: String) {
        self.name = name
    }
    
    func divide(_ num1: Int, _ num2: Int) throws -> Int {
        if num2 == 0 {
            throw SomeError.illegalArg("0不能作为参数")
        }
        return num1 / num2
    }
}

var p = Person(name: "")
do {
    try p.divide(1, 0)
} catch let SomeError.illegalArg(msg) {
    print(msg)
} catch {
    
}


class Student: Person {
    var score: Int
    init(score: Int) {
        self.score = score
        super.init(name: "")
    }
}


class Point {
    var x: Double = 0
    var y: Double = 0
    subscript(index: Int) -> Double {
        set {
            if index == 0 {
                x = newValue
            } else {
                y = newValue
            }
        }
        get {
            if index == 0 {
                return x
            } else {
                return y
            }
        }
    }
}



