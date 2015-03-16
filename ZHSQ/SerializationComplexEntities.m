//
//  SerializationComplexEntities.m
//  
//
//  Created by haoero on 10/12.
//  Copyright (c) 2012 __haoero__. All rights reserved.
//

#import "SerializationComplexEntities.h"
#import <Foundation/NSObjCRuntime.h>
#import <objc/runtime.h>
#import "CJSONSerializer.h"
#import "JSONAutoSerializer.h"


@implementation SerializationComplexEntities

static SerializationComplexEntities *_sharedSerializer = nil;

//
//  serializeObjectWithChildObjectsAndComplexArray
//  参数：complexObject, 需要序列化的复杂实体类对象
//  参数：childSimpleClasses，所有嵌套的简单实体类的类型，形如【NSString class】
//  参数：childSimpleClassInArray，所有嵌套在数组里的简单实体类类型，形如【NSString class】
//  Created by haoero on 2012-10
//  
//
- (NSString *)serializeObjectWithChildObjectsAndComplexArray:(id)complexObject childSimpleClasses:(NSArray*)childSimpleClasses childSimpleClassInArray:(NSArray*) childSimpleClassInArray
{
    NSString *complexClassName = NSStringFromClass([complexObject class]);
    
    const char *cComplexClassName = [complexClassName UTF8String];
    id theComplexClass = objc_getClass(cComplexClassName);
    
    unsigned int outCount, i;
    //获取当前实体类中所有属性名
    objc_property_t *properties = class_copyPropertyList(theComplexClass, &outCount);
    
    //存放所有普通类型的属性变量名
    NSMutableArray *propertyNames = [[NSMutableArray alloc] initWithCapacity:1];
    //存放所有数组类型的属性变量名
    NSMutableArray *childArrayPropertyNames = [[NSMutableArray alloc] initWithCapacity:1];
    //存放所有数组类型变量对应的JSON字符串的
    NSMutableArray *childArrayJSONString  = [[NSMutableArray alloc] initWithCapacity:1];
    
    //存放所有数组类型的属性变量名
    NSMutableArray *childClassesPropertyNames = [[NSMutableArray alloc] initWithCapacity:1];
    //存放所有数组类型变量对应的JSON字符串的
    NSMutableArray *childClassesJSONString  = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        
        NSString *propertyNameString =[[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding] ;
        
        SEL tempSelector = NSSelectorFromString(propertyNameString);
        id tempValue = [complexObject performSelector:tempSelector];
        
        
        //如果目标实体类包含了嵌套实体类或者子实体类数组
        if (childSimpleClassInArray!=nil || childSimpleClasses!=nil) {
            
            //如果当前属性类型是数组
            if ([tempValue isKindOfClass:[NSArray class]]) {
                NSArray *tempChildArray = (NSArray*)tempValue;  
                if ([tempChildArray count]>0) {
                    //判断当前数组是否是目标类型数组
                    int flag = 0;
                    for (int j=0; j<[childSimpleClassInArray count]; j++) {
                        //如果是目标类型数组,则改变flag的值
                        if ([[tempChildArray objectAtIndex:0] isKindOfClass:[childSimpleClassInArray objectAtIndex:j]]) {
                            flag = 1;
                            //则将属性变量名添加到childArrayPropertyNames
                            [childArrayPropertyNames addObject:propertyNameString];
                            
                            NSMutableString *tempChildString = [[NSMutableString alloc] init];
                            for (int m=0; m< [tempChildArray count]; m++) {
                                
                                if (m == 0) {
                                    [tempChildString appendFormat:@"["];
                                }
                                
                                //先序列化数组内单独， 在此可以针对不同情况修改第二,三个参数来递归调用
                                NSString *singleJSONStringInArray = [[NSString alloc]init];
                                singleJSONStringInArray = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:[tempChildArray objectAtIndex:m] childSimpleClasses:childSimpleClasses childSimpleClassInArray:childSimpleClassInArray];
                                
                                if (singleJSONStringInArray!=nil) {
                                    [tempChildString appendFormat:singleJSONStringInArray];
                                }
                                
                                if (m!= [tempChildArray count]-1) {
                                    [tempChildString appendFormat:@","];
                                }
                                else {
                                    [tempChildString appendFormat:@"]"];
                                }
                                
                            }
                            //添加到存放子数组JSON字符串的数组里
                            [childArrayJSONString addObject:tempChildString];  
                        }
                    }
                    //如果是普通类型的数组
                    if (flag == 0) {
                        //则将属性变量名添加到propertyNames
                        [propertyNames addObject:propertyNameString];
                    }
                }
                
            }  
            //如果当前属性类型是除数组外的类型
            else {
                int isChildClass = 0;
                for (int p = 0; p < [childSimpleClasses count]; p++) {
                    //判断是否是目标嵌套实体类
                    if ([tempValue isKindOfClass:[childSimpleClasses objectAtIndex:p ]]) {                        
                        isChildClass = 1;
                        [childClassesPropertyNames addObject:propertyNameString];
                        
                        //先序列化嵌套实体类， 在此可以针对不同情况修改第二和第三个参数来递归调用
                        NSString *singleJSONStringInChildClasses = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray :tempValue childSimpleClasses:childSimpleClasses childSimpleClassInArray:childSimpleClassInArray];
                        
                        //添加到存放嵌套实体类的JSON字符串的数组里
                        [childClassesJSONString addObject:singleJSONStringInChildClasses];
                        
                    }
                }
                //如果当前属性类型除数组和目标嵌套子实体类外的普通类型
                if (isChildClass==0) {
                    [propertyNames addObject:propertyNameString];
                }
                
            }
            
        }                 
        //如果目标实体类不包含子实体类数组，则直接添加变量名   
        else {
            [propertyNames addObject:propertyNameString];
        }
    }
    
    //开始构造Dictionary
    NSMutableDictionary *finalDict = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    for(NSString *key in propertyNames)
    {
        SEL selector = NSSelectorFromString(key);
        id value = [complexObject performSelector:selector];
        
        if (value == nil)
        {
            value = [NSNull null];
        }
        
        [finalDict setObject:value forKey:key];
    }
    //没替换字符串的初始JSON字符串
    NSMutableString *jsonString =[[NSMutableString alloc] initWithString: [[CJSONSerializer serializer] serializeDictionary:finalDict]];
    
    int length = [jsonString length];
    
    //插入复杂数组的json字符串
    NSString *tempStringToInsert = [[NSString alloc]init];
    
    //插入复杂数实体类的json字符串
    for(int m=0; m<childClassesJSONString.count; m++)
    {
        if ([childClassesJSONString objectAtIndex:m] !=nil) {
            
            //先要判断length是否为2，由此来决定是否要在插入json之前插入 ,
            if (length>2) 
                tempStringToInsert = [[NSString alloc] initWithFormat:@",\"%@\":%@",[childClassesPropertyNames objectAtIndex:m],[childClassesJSONString objectAtIndex:m]]; 
            
            else 
                tempStringToInsert = [[NSString alloc] initWithFormat:@"\"%@\":%@",[childClassesPropertyNames objectAtIndex:m],[childClassesJSONString objectAtIndex:m]]; 
            
            [jsonString insertString:tempStringToInsert atIndex:length-1];
            
        }      
    }
    //重新获取length
    length = [jsonString length];
    
    for(int m=0; m<childArrayJSONString.count; m++)
    {
        if ([childArrayJSONString objectAtIndex:m] !=nil) {
            
            //先要判断length是否为2，由此来决定是否要在插入json之前插入 ,
            if (length > 2) 
                tempStringToInsert= [[NSString alloc] initWithFormat:@",\"%@\":%@",[childArrayPropertyNames objectAtIndex:m],[childArrayJSONString objectAtIndex:m]]; 
            else 
                tempStringToInsert = [[NSString alloc] initWithFormat:@"\"%@\":%@",[childArrayPropertyNames objectAtIndex:m],[childArrayJSONString objectAtIndex:m]]; 
            
            [jsonString insertString:tempStringToInsert atIndex:length-1];
            
        }      
        
    }
    
    return jsonString;
    
}


+(SerializationComplexEntities*) sharedSerializer{
    
    if (_sharedSerializer == nil)
    {
        _sharedSerializer = [[SerializationComplexEntities alloc] init];
        
    }
    return _sharedSerializer;
    
}
- (id)init
{
    self = [super init];
    
    if (self)
    {
        
    }
    
    return self;
}


@end
