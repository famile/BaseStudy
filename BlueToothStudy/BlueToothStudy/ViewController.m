//
//  ViewController.m
//  BlueToothStudy
//
//  Created by 李涛 on 2017/5/17.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>

/**
 中心管理者
 */
@property (nonatomic, strong) CBCentralManager *centerManager;

/**
 连接到的外设
 */
@property (nonatomic, strong) CBPeripheral *peripheral;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _centerManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];

}

#pragma mark - CBCentralManagerDelegate
//只要中心管理者初始化 就会触发次代理方法 判断手机蓝牙状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case 0:
            NSLog(@"CBManagerStateUnknown");
            break;
        case 1:
            NSLog(@"CBManagerStateResetting");
            break;
        case 2:
            NSLog(@"CBManagerStateUnsupported");//不支持蓝牙
            break;
        case 3:
            NSLog(@"CBManagerStateUnauthorized");
            break;
        case 4:
            NSLog(@"CBManagerStatePoweredOff");//蓝牙未开启
            break;
        case 5:
            NSLog(@"CBManagerStatePoweredOn");//蓝牙已开启
            //在中心管理者成功开启后再进行一些操作
            //搜索外设
            [self.centerManager scanForPeripheralsWithServices:nil// 通过某些服务筛选外设
                                                    options:nil];// dict,条件
            //搜索成功后，会调用我们找到外设的代理方法
            //- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI; //找到外设
            
            break;
        default:
            break;
    }
    
}
//发现外设后调用的方法
- (void)centralManager:(CBCentralManager *)central//中心管理者
 didDiscoverPeripheral:(CBPeripheral *)peripheral//外设
     advertisementData:(NSDictionary<NSString *, id> *)advertisementData//外设携带的数据
                  RSSI:(NSNumber *)RSSI//外设发出的蓝牙信号强度
{
//    NSLog(@"%s, line = %d, cetral = %@,peripheral = %@, advertisementData = %@, RSSI = %@", __FUNCTION__, __LINE__, central, peripheral, advertisementData, RSSI);
    NSLog(@"cetral = %@,\n peripheral = %@, advertisementData = %@, RSSI = %@", central, peripheral, advertisementData, RSSI);
    
   
        self.peripheral = peripheral;
        [_centerManager connectPeripheral:peripheral options:nil];
    
}

//中心管理者连接外设
- (void)centralManager:(CBCentralManager *)central
  didConnectPeripheral:(CBPeripheral *)peripheral{
    
    //连接成功之后可以进行服务和特征的发现
    //  设置外设的代理
    self.peripheral.delegate = self;
    
    //外设发现服务，传nil代表不过滤
    //这里会触发外设的代理方法 - (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
    [self.peripheral discoverServices:nil];
    
}
// 外设连接失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%s, line = %d, %@=连接失败", __FUNCTION__, __LINE__, peripheral.name);
}

// 丢失连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%s, line = %d, %@=断开连接, 原因=%@", __FUNCTION__, __LINE__, peripheral.name,error);
}

#pragma mark - CBPeripheralDelegate
// 发现外设服务里的特征的时候调用的代理方法(这个是比较重要的方法，你在这里可以通过事先知道UUID找到你需要的特征，订阅特征，或者这里写入数据给特征也可以)
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    for (CBCharacteristic *cha in service.characteristics) {
        NSLog(@"char = %@", cha);
        
    }
}

//从外围设备读数据
// 更新特征的value的时候会调用 （凡是从蓝牙传过来的数据都要经过这个回调，简单的说这个方法就是你拿数据的唯一方法） 你可以判断是否
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"%s, line = %d", __FUNCTION__, __LINE__);
    if ([characteristic isEqual: @""]) {
        //characteristic.value就是你要的数据
        
    }
}

#pragma mark - httpRequest

#pragma mark - click

#pragma mark - init

- (CBCentralManager *)centerManager{
    if (!_centerManager) {
        _centerManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return _centerManager;
}














@end
