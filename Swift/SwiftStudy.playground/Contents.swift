//: Playground - noun: a place where people can play

import UIKit

var str = "hello world"
//var vc = UIViewController.init()


var occupations = [
    "Malcolm": "Captain",
    "Kaylee": 13,
    ] as [String : Any]

print(occupations)


for i in 0..<4{
    print(i)
}


let http404Error = (404,"Not Found")
let (statusCode,statusMessage) = http404Error
print(statusCode,statusMessage)


let test = {(_ name:String) -> () in
    print(name)
}

test("测试")

let test2 = {()->() in
    print("测试2")
}

test2()
