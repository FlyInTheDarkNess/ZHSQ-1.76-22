//
//  DengLuHouZhuYeViewController.h
//  ZHSQ
//
//  Created by lacom on 14-4-14.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMD5.h"
#import "BangDingXinXi.h"
#import "PushAlertViewDelegate.h"
#import "shouyeViewController.h"
@interface DengLuHouZhuYeViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,PushAlertViewDelegate>
{
    
    
    UIImageView *beijingimage;
    UIImageView * tianqiimage;
    UIImageView *image1;
    UIImageView *image2;
    UIImageView *image3;
    UIImageView *image4;
    UIImageView *image5;
    UIImageView *image6;
    UIImageView *image7;
    UIImageView *image8;
    UIImageView *image9;
    UIImageView *image10;
    UIImageView *image11;
    UIImageView *image12;
    UIImageView *image13;
    UIImageView *image14;
    UIImageView *image15;
    UIImageView *image16;
    UIImageView *image17;

    UILabel *label_banben;
    UILabel *tit_label;
    UILabel *label_beijingse;
    UILabel *label_shequfuwu;
    UILabel *label_xiaoqubibei;
    UILabel *label_wodezhoubian;
    UILabel *label_kuaijiejiaofei;
    UILabel *label_gengduoyingyong;
    UILabel *label_shequdongtai;
    UILabel *label_shequtongzhi;
    UILabel *label_shizhengxinwen;
    UILabel *label_shoushizhinan;
    UILabel *label_shequhudong;
    UILabel *label_zhengfugonggao;
    UILabel *label_gongjijinchaxun;
    UILabel *label_shebaochaxun;
    UILabel *label_weizhangchaxun;
    UILabel *label_ditudaohang;
    UILabel *label_shipinyaopin;
    UILabel *label_changtukeyunchaxun;
    UILabel *label_gongjiaoxianlu;
    UILabel *label_yinhangfuwu;
    UILabel *label_fangchanyewu;
    UILabel *label_kanzhibo;
    UILabel *label_rennidian;
    UILabel *label_juyouli;
    UILabel *label_baoxinxian;
    UILabel *label_rebotuijian;
    UILabel *label_tuangouyouhui;
    UILabel *label_shiyunqi;
    //隐藏菜单
    UIButton *ShouYeBtn;                     //首页                  +
    UIButton *ShiZhengXinWenBtn;             //市政新闻
    UIButton *SheQuTongZhiBtn;               //社区通知
    UIButton *SheQuDongTaiBtn;               //社区动态
    UIButton *SheQuFuWuBtn;                  //社区服务
    UIButton *SheQuZhouBianBtn;              //社区周边
    UIButton *SheQuHuDongBtn;                //社区互动
    UIButton *KuaiJieJiaoFeiBtn;             //快捷缴费
    UIButton *ShouShiZhiNanBtn_cemian;
    UIButton *TuanGouYouHuiBtn;              //团购优惠
    
    //主页
    UILabel *label_title;
    UIButton *CaiDanBtn;                     //隐藏菜单按钮            +
    UIButton *XiaoXiBtn;                     //我的消息
    UIButton *XiaoQuFuWuBtn;                 //社区服务-主页           +
    UIButton *ZhouBianBtn;                   //我的周边-主页           +
    UIButton *KuaiJieJiaoFeiBtn_zhuye;       //快捷缴费-主页
    UIButton *FuWuYingYongBtn;               //更多应用-主页
    UIButton *dongtaiBtn;                    //社区动态-主页           +
    UIButton *TongZhiBtn;                    //社区通知-主页
    UIButton *XinWenBtn;                     //市政新闻-主页           +
    UIButton *ShouShiZhiNanBtn;              //收视指南-主页
    UIButton *SheQuHuDongBtn_zhuye;          //社区互动-主页
    UIButton *XiaoQuBiBeiBtb;                //小区必备
    UIButton *ZhengFuGongGaoBtn;             //政府公告
    UIButton *GongJiJinChaXunBtn;            //公积金查询
    UIButton *SheBaoChaXunBtn;               //社保查询
    UIButton *WeiZhangChaXunBtn;             //违章查询
    UIButton *DiTuDaoHangBtn;                //地图导航
    UIButton *ShiPinYaoPinBtn;               //食品药品
    UIButton *ChangTuKeYunChaXunBtn;         //长途客运查询
    UIButton *GongJiaoXianLuBtn;             //公交线路
    UIButton *YinHangFuWuBtn;                //银行服务
    UIButton *FangChanYeWu;                  //房产业务
    UIButton *KanZhiBoBtn;                   //看直播
    UIButton *RenNiDianBtn;                  //任你点
    UIButton *JuYouLiBtb;                    //剧有礼
    UIButton *BaoXinXianBtn;                 //报新鲜
    UIButton *ReBoTuiJianBtn;                //热播推荐
    UIButton *ShiYunQiBtn;                     //试运气

//    UIView *view_wode;
//    UIView *view_zhoubian;
//    UIView *view_xiaoqu;
    UIButton *wode;
    UIButton *zhoubian;
    UIButton *xiaoqu;
    UIImageView *imageview1;
    UIImageView *imageview2;
    UIImageView *imageview3;
    UIImageView *imageview4;
    
    UIButton *Btn_Seckill;
    UIButton *Btn_GroupBuying;
    UIButton *Btn_Preferential;
    UIImageView *imageview_Community;
    UIImageView *imageview_Me;
    UILabel *label_miaosha;
    UILabel *label_youhui;
    UILabel *label_tuangou;
    UIButton *Btn_YouHuiQuan;                                      //优惠券
    UIButton *Btn_ErShou;                                          //二手
    UIButton *Btn_WeiXiu;                                          //美食
    UIButton *Btn_MeiShi;                                          //维修
    UIButton *Btn_JiaZheng;                                        //家政
    UIButton *Btn_YiLiao;                                          //医疗
    UIButton *Btn_YuLe;                                            //娱乐
    UIButton *Btn_PeiXun;                                          //培训
    UIButton *Btn_LuYou;                                           //旅游
    UIButton *Btn_JianShen;                                        //健身
    UIButton *Btn_JiuDian;                                         //酒店
    UIButton *Btn_GengDuo;                                         //更多
    UILabel *label_BulletinNotice;
    UILabel *label_bill;
    UILabel *label_Speak;
    UILabel *label_LifeHelp;
    UIButton *Btn_BulletinNotice;
    UIButton *Btn_bill;
    UIButton *Btn_Speak;
    UIButton *Btn_LifeHelp;
    UIButton *Btn_Logout;
    UIButton *Btn_ForgotPassword;
    UIButton *Btn_MyFaceMoney;
    UIButton *Btn_MyProfile;
    UIImageView *imageview_BulletinNotice;
    UIImageView *imageview_bill;
    UIImageView *imageview_Speak;
    UIImageView *imageview_LifeHelp;
    UILabel *label_bai;
    UILabel *label_wodeziliao_beijing;
    UILabel *label_AvailableFaceMoney;
    UILabel *label_AvailableFaceMoneyNumber;
    UILabel *label_Registration;
    UILabel *label_FaceMoneyExchange;
    UIButton *Btn_MyFaceMoneyDetails;
    UIButton *Btn_EARNFaceMoney;
    UIButton *Btn_zhoubian_beijing1;
    UIButton *Btn_zhoubian_beijing2;
    UIButton *Btn_xiaoqu_beijing;
    //周边---优惠资讯信息
    UIImageView *imageview_AddPreferentialMessageDateUp;
    UIImageView *imageview_AddPreferentialMessageDateNext;
    UIImageView *imageview_miaosha;
    UIImageView *imageview_tuangou;
    UIImageView *imageview_youhuishangpin;
    
    UILabel *label_PreferentialMessageTitle;
    UILabel *label_AddPreferentialMessageDateTitle;
    UILabel *label_AddPreferentialMessageDateContent;
    UILabel *label_AddPreferentialMessageDateTime;
    UILabel *label_AddPreferentialMessageDateSource;
    NSMutableArray *arr;
    //小区---优惠资讯信息
    UIImageView *imageview_AddCommunityPreferentialMessageDate;
    UILabel *label_AddCommunityPreferentialMessageDateTitle;
    UILabel *label_AddCommunityPreferentialMessageDateContent;
    UILabel *label_AddCommunityPreferentialMessageDateTime;
    UILabel *label_AddCommunityPreferentialMessageDateSource;
    //我---优惠资讯信息
    UIImageView *imageview_AddMePreferentialMessageDate;
    UILabel *label_AddMePreferentialMessageDateTitle;
    UILabel *label_AddMePreferentialMessageDateContent;
    UILabel *label_AddMePreferentialMessageDateTime;
    UILabel *label_AddMePreferentialMessageDateSource;
    UILabel *label_NickName;
    UILabel *label_Member;
    NSArray *arr_Community;
    NSArray *arr_News;
    NSArray *arr_HeaderTitle;
    NSMutableArray *arr_xinxi;
    UIImageView *imageview_HeadPortraits;
    
    UIButton *DengLuBtn;                    //登录按钮
    UIButton *guanyuwomen;
    UIButton *DingDanBtn;                    //我的账单
    UIButton *ShouCangBtn;                   //我的收藏
    UIButton *WoDeXiaoXiBtn;                 //我的消息--右侧
    UIButton *WoDeYinHangKaBtn;              //我的银行卡
    UIButton *XiTongSheZhiBtn;               //系统设置
    UIButton *YiJianFanKiuBtn;               //意见反馈
    UIButton *SheQuXuanZeBtn;                //社区选择
    UILabel *label_MemberGrade;
    UILabel *label_AvailableHappyFaceMoney;
    UIImageView *imageview_RightArrow;
    UIView *youceview_beijing;
    UILabel *label_youce;
    
    
    
    UIButton *tuichuBtn;                     //
    
    NSMutableArray *viewsArray;
    int timeCount;
    UIScrollView *scrollview_Advertisement;
    UIScrollView *scrollview_zhoubian;
    UIScrollView *scrollview_xiaoqu;
    UIScrollView *scrollview_wode;
    UIView *view_wode;
    UIView *myView;
    UILabel *label;
    
    UITableView *tableview;
    NSArray *arr_imagelistOfSectionOne;
    NSArray *arr_imagelistOfSectionTwo;
    NSArray *arr_imagelistOfSectionThree;
    NSArray *arr_imagelistOfSectionFour;
    NSArray *arr_imagelistOfSectionFive;
    NSMutableArray *arr_strlistOfSectionOne;
    NSMutableArray *arr_imageUrlList;
    NSArray *arr_strlistOfSectionTwo;
    NSArray *arr_strlistOfSectionThree;
    NSArray *arr_strlistOfSectionFour;
    NSArray *arr_strlistOfSectionFive;
    int Section;
    int Tag;
    
    NSMutableArray *arr_count;
    
    UIActivityIndicatorView *activityIndicator;
    NSString *outString;
    NSString *city;
    NSString *weather;
    NSString *temperature1;
    NSString *temperature2;
    
    
    
    UILabel *citylabel;
    UILabel *timelabel;
    UILabel *weatherlabel;
    UILabel *Date_label;
    UILabel *templabel;
    UILabel *templabel2;
    UILabel *templabel3;
    NSString *str_gongjijin;
    NSMutableArray *arr_info;
    NSMutableArray *arr_infoa;
    NSString *mima;
    
    NSString *_intString;
    int Article_type_id;
 }
@property (strong, nonatomic) NSMutableArray *viewsArray;
@property (strong, nonatomic) UIScrollView *scrollview_zhoubian;
@property (strong, nonatomic) UIScrollView *scrollview_xiaoqu;

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@end
