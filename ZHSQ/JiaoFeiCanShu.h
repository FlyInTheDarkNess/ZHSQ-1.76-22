//
//  JiaoFeiCanShu.h
//  ZHSQ
//
//  Created by yanglaobao on 14-11-18.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "WorkItem.h"

@interface JiaoFeiCanShu : NSObject

@property (nonatomic, retain) NSString *session;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *flag;
@property (nonatomic, retain) NSString *date_start;
@property (nonatomic, retain) NSString *date_end;
@property (nonatomic, retain) NSString *address_id;

@end
