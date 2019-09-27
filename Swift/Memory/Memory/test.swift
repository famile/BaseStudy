//
//  test.swift
//  Memory
//
//  Created by 李涛 on 2019/9/17.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

import Foundation

struct Circle {
    static var name: String = "" /// 类属性（全局属性）
    
    var radius: Int { /// 存储属性
        willSet {   /// 属性观察器
            print(newValue)
        }
        didSet {
            print(oldValue, radius)
        }
    }
    var diameter: Int { /// 计算属性
        set {
            radius = newValue / 2
        }
        get {
            return radius * 2
        }
    }
    lazy var area: Int = { /// 延迟存储属性，闭包表达式  是能使用var
        return 3 * radius * radius
    }()
}


func testCircle() {
    var c = Circle(radius: 10, area: nil)
    c.radius = 12
    c.diameter = 20
    /*
     延迟存储属性
     */

}


/*
 结构体和类的本质区别：
 结构体是值类型（枚举也是值类型），类是引用类型（指针类型）
 值类型赋值给var let或者函数传参，是直接将内容copy一份
 引用类型赋值给var let或者函数参数时，是将内存地址拷贝一份
 
 */

func testClassAndStruct() {
    class Size {
        var width = 1
        var height = 2
    }
    
    struct Point {
        var x = 3
        var y = 4
    }
    
    var size = Size()
    //    var point = Point()
}

//testClassAndStruct()

/*
 枚举值 和 关联值
 原始值 rawValue 是只读计算属性
 */
enum TestEnum {
    case test1(Int, Int)
    case test2(Int)
    case test3
}
/*
 rip存储的是指令的地址
 CPU要执行的下一条指令地址就存储在rip中
 */
var t = TestEnum.test1(1,2)
//print(Mems.ptr(ofVal: &t))
//t = .test2(2)
//t = .test3
//
//print(MemoryLayout<TestEnum>.size)// 实际占用
//print(MemoryLayout<TestEnum>.stride)// 实际分配
//print(MemoryLayout<TestEnum>.alignment)// 对齐单位
