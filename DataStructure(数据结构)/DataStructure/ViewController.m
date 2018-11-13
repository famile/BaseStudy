//
//  ViewController.m
//  DataStructure
//
//  Created by 李涛 on 2018/7/3.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *arr = @[@3,@4,@5,@1,@2];
    
//    [self bubbleSortWithArr:arr];
//    [self chooseSortWithArr:arr];
//    [self insertSortWithArr:arr];
//    [self getMaxCommonDivisorWithNum1:4 num2:4];
    [self binarySearchWithArray:@[@"1",@"2",@"3",@"4"] withSearchNum:3];
    
//    NSInteger count = [self recursionFactorialWithNum:2];
//    NSLog(@"%@",@(count));
    
//    NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:arr];
//    [self quickSortWithArr:mutableArr left:0 right:4];
//    NSLog(@"%@",mutableArr);
//
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"%@",[NSThread currentThread]);
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            NSLog(@"%@",[NSThread currentThread]);
//        }];
//    }];
//    [op addExecutionBlock:^{
//        NSLog(@"%@",[NSThread currentThread]);
//    }];
//    [queue addOperation:op];
    
    char a = 'a';
    char b[] = {'a','b'};
    NSLog(@"%lu,%lu,%lu,%lu",sizeof(a),sizeof(char *),sizeof(b),sizeof(&b));
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 冒泡排序
 */
- (void)bubbleSortWithArr:(NSArray *)arr{
    NSMutableArray *newArr = [NSMutableArray arrayWithArray:arr];
    NSInteger count = newArr.count;
    for (int i = 0; i<count-1; i++) {
        for (int j = 0; j<count-1-i; j++) {
            if ([newArr[j] integerValue] > [newArr[j+1] integerValue]) {
                [newArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSLog(@"%@",newArr);
}


/**
 选择排序

 @param arr <#arr description#>
 */
- (void)chooseSortWithArr:(NSArray *)arr{
    NSMutableArray *newArr = [NSMutableArray arrayWithArray:arr];
    NSInteger count = newArr.count;
    for (int i = 0; i<count-1; i++) {
        for (int j = i+1; j<count-1; j++) {
            if ([newArr[i] integerValue] > [newArr[j] integerValue]) {
                [newArr exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    NSLog(@"%@",newArr);
}

/**
 插入排序

 @param arr <#arr description#>
 */
- (void)insertSortWithArr:(NSArray *)arr{
    NSMutableArray *newArr = [NSMutableArray arrayWithArray:arr];
    NSInteger count = newArr.count;
    for (int i = 1; i<count; i++) {
        
        for (int j = i; j>0 && [newArr[j] integerValue] < [newArr[j-1] integerValue]; j--) {
            
            [newArr exchangeObjectAtIndex:j withObjectAtIndex:j-1];
        }
        
    }
    NSLog(@"%@",newArr);
}

/**
 快速排序

 @param arr <#arr description#>
 @param left <#left description#>
 @param right <#right description#>
 */
- (void)quickSortWithArr:(NSMutableArray *)arr left:(NSInteger)left right:(NSInteger)right{
    if (left >= right) return;
    NSInteger i = left;
    NSInteger j = right;
    NSInteger key = [arr[i] integerValue];
    while (i<j) {
        while (i<j && [arr[j] integerValue] >= key) {//从右侧找到第一个比key小的
            j--;
        }
        arr[i] = arr[j];
        while (i<j && [arr[i] integerValue] <= key) {//从左边找到第一个比key大的
            i++;
        }
        arr[j] = arr[i];
    }
    arr[i] = [NSNumber numberWithInteger:key];
    [self quickSortWithArr:arr left:left right:i-1];
    [self quickSortWithArr:arr left:i+1 right:right];
}


/**
 最大公约数

 @param num1 <#num1 description#>
 @param num2 <#num2 description#>
 */
- (void)getMaxCommonDivisorWithNum1:(NSInteger)num1 num2:(NSInteger)num2{
    NSInteger temp = 0;
    if (num1 < num2) {
        temp = num1;
        num1 = num2;
        num2 = temp;
    }
    while (num2 != 0) {
        temp = num1 % num2;
        num1 = num2;
        num2 = temp;
    }
    NSLog(@"最大公约数为：%@",@(num1));
}


/**
 二分查找

 @param arr <#arr description#>
 @param num <#num description#>
 */
- (void)binarySearchWithArray:(NSArray *)arr withSearchNum:(NSInteger)num{
    NSInteger low = 0;
    NSInteger high = arr.count - 1;
    while (low <= high) {
        NSInteger middle = (high - low)/2 + low;
        if (num == [arr[middle] integerValue]) {
            NSLog(@"下标为：%@",@(middle));
            break;
        }else if ([arr[middle] integerValue] > num){
            high = middle - 1;
        }else{
            low = middle + 1;
        }
    }
}




/**
 N的阶乘（递归）

 @param num <#num description#>
 */
- (NSInteger)recursionFactorialWithNum:(NSInteger)num{
    if (num == 0) {
        return 1;
    }else{
        return num * [self recursionFactorialWithNum:num-1];
    }
}

@end
