//
//  GroupBuyingViewController.h
//  ZHSQ
//
//  Created by 赵贺 on 15-2-9.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"

@interface GroupBuyingViewController : AXHBaseViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
{
    NSMutableArray *GroupBuyingGoodArr;
    BOOL y;

}
@property (nonatomic,strong) UICollectionView *_collectionView;

@end
