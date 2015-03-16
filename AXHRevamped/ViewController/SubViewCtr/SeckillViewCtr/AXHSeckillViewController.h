//
//  AXHSeckillViewController.h
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/18.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "AXHYHGoodsHttpService.h"
#import "MZTimerLabel.h"
#import "LPLabel.h"
@interface AXHSeckillViewController : AXHBaseViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,MZTimerLabelDelegate>
@property (nonatomic,strong) UICollectionView *seckillCollectionView;

@end
