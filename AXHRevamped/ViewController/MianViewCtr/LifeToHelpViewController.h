//
//  LifeToHelpViewController.h
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/17.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"

@interface LifeToHelpViewController : AXHBaseViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *_LTHelpCollectionView;

@end
