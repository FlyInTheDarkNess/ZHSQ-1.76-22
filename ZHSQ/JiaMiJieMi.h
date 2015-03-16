//
//  JiaMiJieMi.h
//  ZHSQ
//
//  Created by yanglaobao on 14-10-23.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JiaMiJieMi : NSObject

// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString;
//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string;
@end
