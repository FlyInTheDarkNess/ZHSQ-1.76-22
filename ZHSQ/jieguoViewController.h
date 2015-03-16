//
//  jieguoViewController.h
//  gf
//
//  Created by lacom on 14-7-3.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface jieguoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{

    IBOutlet UILabel *label;
}
@property (strong, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)fanhui:(id)sender;

@end
