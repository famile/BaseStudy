//
//  LTBaseDemo.m
//  BaseStudy
//
//  Created by 李涛 on 2019/8/19.
//  Copyright © 2019 Tao_Lee. All rights reserved.
//

#import "LTBaseDemo.h"

@interface LTBaseDemo()

@property (nonatomic, assign) int money;
@property (nonatomic, assign) int ticketsCount;

@end

@implementation LTBaseDemo

/**
 存钱，取钱
 */
- (void)moneyTest {
    self.money = 100;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self __saveMoney];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self __drawMoney];
        }
    });
    
}

- (void)__saveMoney {
    
    int oldMoney = self.money;
    sleep(.2);
    oldMoney += 50;
    self.money = oldMoney;
    NSLog(@"存50，还剩%d元",oldMoney);
    
}

- (void)__drawMoney {
    
    int oldMoney = self.money;
    sleep(.2);
    oldMoney -= 20;
    self.money = oldMoney;
    NSLog(@"取20，还剩%d元",oldMoney);
    
}


/**
 卖票
 */
- (void)ticketTest {
    self.ticketsCount = 15;
    dispatch_queue_t queue = dispatch_queue_create("ticket_queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self __saleTicket];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self __saleTicket];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self __saleTicket];
        }
    });
}

- (void)__saleTicket {
    // 加锁
    int oldTicketsCount = self.ticketsCount;
    sleep(.2);
    oldTicketsCount--;
    self.ticketsCount = oldTicketsCount;
    NSLog(@"还剩%d张票", oldTicketsCount);
    // 解锁
}

@end

