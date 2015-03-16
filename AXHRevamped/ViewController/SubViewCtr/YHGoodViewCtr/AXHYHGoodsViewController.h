//
//  AXHYHGoodsViewController.h
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/15.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "AXHYHGoodsHttpService.h"

typedef enum {
    //以下是枚举成员
    GoodsTypeDefault = 0,//优惠商品
    GoodsTypeJF,//积分商城
}GoodsType;//枚举名称
@interface AXHYHGoodsViewController : AXHBaseViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *_collectionView;

@property (nonatomic,assign) GoodsType goodsType;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withType:(GoodsType )type;
@end
