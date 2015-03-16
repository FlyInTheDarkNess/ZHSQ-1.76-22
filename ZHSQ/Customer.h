//
//  Customer.h
//  Test Webservice
//
//  Created by Oscar on 10/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "WorkItem.h"

@interface Customer : NSObject
@property (nonatomic, retain) NSString * city_id;
@property (nonatomic, retain) NSArray  * id_list;


@end
