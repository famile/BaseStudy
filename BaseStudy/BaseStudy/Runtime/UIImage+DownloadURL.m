//
//  UIImage+DownloadURL.m
//  BaseStudy
//
//  Created by 李涛 on 2018/11/13.
//  Copyright © 2018年 Tao_Lee. All rights reserved.
//

#import "UIImage+DownloadURL.h"

#import <objc/runtime.h>

static char const * objectKey;

@implementation UIImage (DownloadURL)


/*
 const char *p; //*p是const,p可变：const 后面紧跟的是char，所以*p是一个char字符，不可变
 
 const (char *) p;//p是const,*p可变：const 后面紧跟的是（char *）这个整体，所以p是char*类型，不可变。
 
 char* const p; //p是const,*p可变:const 后面紧跟的是p,所以p不可变
 
 const char* const p; //p和*p都是const：第一个const后面紧跟的是char,所以char类型的字符*p不可变；第二个const后面紧跟的是p,所以p不可变。
 
 char const * p;// *p是const,p可变：const后面紧跟的是*,但是单独的*不能表明修饰的内容，所以将*p看成一个整体，所以const修饰的是*p,*p不可变。
 
 (char*) const p;//p是const,*p可变：const紧跟的是p,所以p不可变。
 
 char* const p;// p是const,*p可变：const紧跟的是p,所以p不可变。
 
 char const* const p;// p和*p都是const：第一个const紧跟的是*,不能表明修饰的内容，将后面整体的（* const p）看成一个整体，那就说明*p不可变，第二个const后面紧跟的是p,所以p不可变。
 
 const char *a
 char * const a
 char const *a
 const char * const a
 
 1、const char *a a是可变的，但是只能指向char
 2、char *const a 声明（*const a）a被一个解引用运算符和一个const关键词修饰,故a是个不可修改的指针，但可通过指针a所指向的数据
 3、char const *a 和 const char *a是同一个意思
 4、如果既不允许a被修改，也不允许a指向的内容修改，就声明const char * const a
 
 */

- (void)setDownLoadURL:(NSString *)downLoadURL{
    objc_setAssociatedObject(self, objectKey, downLoadURL, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)downLoadURL{
    return objc_getAssociatedObject(self, objectKey);
}


@end
