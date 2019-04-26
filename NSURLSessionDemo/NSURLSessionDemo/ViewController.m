//
//  ViewController.m
//  NSURLSessionDemo
//
//  Created by 李涛 on 2017/4/20.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()<NSURLSessionDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgv;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self requestStudentList];
    [self afnRequest];
    
    [_imgv sd_setImageWithURL:[NSURL URLWithString:@"http://www.pptok.com/wp-content/uploads/2012/08/xunguang-7.jpg"] placeholderImage:nil];
    
}

/**
 
 */
- (void)requestStudentList{
//    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    /**
     NSURLSessionTask 是session中task的基类，它们只能由session或者session的子类创建
     */
    
    NSURLSessionDataTask *jsonData = [session dataTaskWithURL:[NSURL URLWithString:@"http://182.92.192.206:8080/jeesite/rest/student/tips"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",data);
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",dic);
    }];
    [jsonData resume];
    [jsonData suspend];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [jsonData resume];
//    });
    
    
}

- (void)afnRequest{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLSessionDataTask *dataTask1 = [manager GET:@"http://182.92.192.206:8080/jeesite/rest/student/tips" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"--progress:%@--",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    NSLog(@"%lu",(unsigned long)dataTask1.taskIdentifier);
    
    
    NSURLSessionDataTask *dataTask2 = [manager POST:@"http://182.92.192.206:8080/jeesite/rest/student/list" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"--progress:%@--",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    NSLog(@"%lu",(unsigned long)dataTask2.taskIdentifier);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
