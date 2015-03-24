//
//  JDH.h
//  ZHSQ
//
//  Created by 赵中良 on 15/3/23.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDH : NSObject

/*
 绑定房间ID
 */
@property (nonatomic,strong) NSString *room_id;
/*
 机顶盒表主键id
 */
@property (nonatomic,strong) NSString *boxes_id;
/*
 机顶盒类型
 */
@property (nonatomic,strong) NSString *boxes_type;
/*
 机顶盒号
 */
@property (nonatomic,strong) NSString *boxes_number;
/*
 智能卡号
 */
@property (nonatomic,strong) NSString *smartcard_number;




@end
