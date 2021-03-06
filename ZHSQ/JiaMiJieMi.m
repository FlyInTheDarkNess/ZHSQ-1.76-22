//
//  JiaMiJieMi.m
//  ZHSQ
//
//  Created by yanglaobao on 14-10-23.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "JiaMiJieMi.h"

@implementation JiaMiJieMi
// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    //NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString; 
    
    
}
//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",[hexStr uppercaseString],newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",[hexStr uppercaseString],newHexStr];
    } 
    return hexStr; 
}
@end
