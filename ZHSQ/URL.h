//
//  URL.h
//  ZHSQ
//
//  Created by yanglaobao on 14-10-14.
//  Copyright (c) 2014年 lacom. All rights reserved.
//
//
//#import <Foundation/Foundation.h>


/*
#define ipAddress_m1_01         @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m1_01.ashx"       //取ip地址
#define DengLu_m1_04            @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m1_04.ashx"   //登录
#define TianQiYuBao             @"http://www.weather.com.cn/data/cityinfo/101121601.html"               //天气预报
//#define JianChaBanBen           @"https://dn-xiaolian.qbox.me/HappyFace_iphone.plist"//检查版本
//#define AaiXianGengXin          @"itms-services://?action=download-manifest&url=https://www.xiaolianshequ.cn/download/HappyFace_iphone.plist"                            //在线更新
#define JianChaBanBen           @"https://www.xiaolianshequ.cn/download/HappyFace_iphone.plist"//检查版本
#define AaiXianGengXin          @"itms-services://?action=download-manifest&url=https://www.xiaolianshequ.cn/download/HappyFace_iphone.plist"                            //在线更新

#define GongJiJin_m1_04         @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m31_01.ashx"       //公积金
#define SheQuXuanZe_m24_02      @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m24_02.ashx"       //社区选择
#define ChengShiXuanZe_m24_01   @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m24_01.ashx"       //城市选择
#define KuaiJieJiaoFeiZhuJian_m30_01 @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m30_01.ashx"  //快捷缴费主
#define WuYeFei_m30_02          @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m30_02.ashx"       //物业费
#define ShuiFei_m30_03          @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m30_03.ashx"       //水费
#define TingCheFei_m30_05       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m30_05.ashx"           //停车费

#define NuanQiFei_m30_04        @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m30_04.ashx"       //暖气费
#define WeiZhangChaXun_m33_01   @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m33_01.ashx"       //违章查询
#define XiaoQuBiBei_m27_01      @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m27_01.ashx"       //小区必备
#define XiaoQuBiBei_m27_02      @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m27_02.ashx"       //小区必备
#define ZhengFuGongGao_m26_01   @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m26_01.ashx"       //政府公告
#define ZhengFuGongGao_m26_02   @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m26_02.ashx"       //政府公告
#define YingXinWen_m11_01       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m11_01.ashx"       //赢新闻
#define YingXinWen_m11_02       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m11_02.ashx"       //赢新闻
#define SheQuHuDong_m10_02      @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m10_02.ashx"       //社区互动
#define SheQuHuDong_m10_03      @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m10_03.ashx"       //社区互动
#define SheQuHuDong_m10_04      @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m10_04.ashx"       //社区互动
#define SheQuHuDong_m10_05      @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m10_05.ashx"       //社区互动
#define SheQuHuDong_m10_06      @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m10_06.aspx"       //回复帖子
#define SheQuHuDong_m10_07      @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m10_07.aspx"       //发表帖子
#define SheQuDongTai_m7_01      @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m38_01.ashx"        //社区动态
#define SheQuDongTai_m7_02      @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m38_02.ashx"        //社区动态
#define ZhuXiao_m1_05           @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m1_05.ashx"        //注销账号
#define QieHuanXiaoQu_m1_13     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m1_13.ashx"        //切换小区
#define GeRenXinXiWanShan_m1_08 @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m1_08.aspx"        //个人信息完善
#define LouYuHao_m24_07         @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m24_07.ashx"       //我的楼宇号
#define DanYuanHao_m24_08       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m24_08.ashx"       //单元号
#define FangJianHao_m24_09      @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m24_09.ashx"       //房间号
#define BaoCunGeRenXinXi_m24_10 @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m24_10.ashx"       //保存个人
#define BaoCunXiaoQuXinXi_m24_03 @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m24_03.ashx"      //保存小区信息
#define QieHuanZhuZhiXinXi_24_012 @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m24_12.ashx"     //切换住址
#define SheQuFuWu_m3_08         @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m3_08.ashx"        //社区服务
#define SheQuFuWu_m3_03         @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m3_03.ashx"        //社区服务
#define SheQuFuWu_m3_05         @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m3_05.ashx"        //社区服务
#define SheQuFuWu_m3_06         @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m3_06.ashx"        //社区服务
#define SheQuFuWu_m3_02         @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m3_02.ashx"        //社区服务
#define JiaoFei_c1_02           @"http://115.28.149.27:8090/V3.11/WebUI/api/ccbApi/c1_02.ashx"           //缴费支付(单项)
#define ZongHeJiaoFei_c1_05     @"http://115.28.149.27:8090/V3.11/WebUI/api/ccbApi/c1_05.ashx"           //缴费支付(综合)

#define YueShengHuo_c1_03       @"http://115.28.149.27:8090/V3.11/WebUI/api/ccbApi/c1_03.ashx"           //悦生活
#define HuoQuYanZhengMa_m1_12   @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m1_12.ashx"        //获取验证码
#define ZhuCe_m1_02             @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m1_02.ashx"        //注册
#define CongZhiMiMa_m1_07       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m1_07.ashx"        //找回密码
#define XiuGaiMiMa_m1_09        @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m1_09.ashx"        //修改密码
#define SheQuTongZhi_m13_02     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m13_02.ashx"       //社区通知
#define SheQuTongZhi_m13_01     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m13_01.ashx"       //社区通知
#define WuYeTongZhi_m12_01      @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m12_01.ashx"       //物业通知
#define WuYeTongZhi_m12_02      @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m12_02.ashx"       //物业通知
#define ShouShiZhiNan_m8_01     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m8_01.ashx"        //收视指南
#define ShouShiZhiNan_m8_02     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m8_02.ashx"        //收视指南
#define WeiZhangChaXun_m33_01   @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m33_01.ashx"       //违章查询
#define YongHuBangDingXinXi_m1_17   @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m1_17.ashx"    //用户绑定信息
#define YongHuBangDingXinXi_m1_13   @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m1_13.ashx"    //用户绑定信息
#define ChangTuKeYun_m32_01     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m32_01.ashx"       //长途客运
#define ChangTuKeYun_m32_02     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m32_02.ashx"       //长途客运
#define CheLiangXinXi_m1_14     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m1_14.ashx"        //车辆信息
#define ZiXunXinXi_m38_01       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m38_01.ashx"       //资讯信息
#define ZiXunXinXi_m38_02       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m38_02.ashx"       //资讯信息
#define YouHuiZhiXu_m40_1       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m40_01.ashx"       //优惠资讯
#define YouHuiZhiXu_m40_2       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m40_02.ashx"       //优惠资讯
#define TopXinXi_m39_01         @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m39_01.ashx"       //Top商品信息
#define MyMessage_21_02         @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m21_02.ashx"       //我的消息主键id
#define MyMessage_21_03         @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m21_03.ashx"       //我的消息定键值信息
#define YiJianFanKui_23_01      @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m23_01.ashx"       //意见反馈
#define YiJianFanKui_23_02      @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m23_02.ashx"       //意见反馈列表
#define MyReply_m22_01          @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m22_01.ashx"       //我的回复主键id
#define MyReply_m22_02          @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m22_02.ashx"       //我的回复信息
#define MyPosts_m10_08          @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m10_08.ashx"       //我的帖子主键id
#define MyPosts_m10_11          @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m10_11.ashx"       //我的帖子信息
#define HitRecommend_m29_01     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m29_01.ashx"       //热推荐主键id
#define HitRecommend_m29_02     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m29_02.ashx"       //热推荐主键信息
#define HitRecommend_m29_03     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m29_03.ashx"       //热推荐频道信息
#define WoDeXiaoLianBi_m19_01     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m19_01.ashx"       //我的笑脸币收入主键id
#define WoDeXiaoLianBi_m19_02     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m19_02.ashx"       //我的笑脸币收入列表信息
#define WoDeXiaoLianBi_m19_03     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m19_03.ashx"       //我的笑脸币合计总数
#define WoDeXiaoLianBi_m19_04     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m19_04.ashx"       //我的笑脸币消费主键id
#define WoDeXiaoLianBi_m19_05     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m19_05.ashx"       //我的笑脸币消费列表信息
#define WoDeShouCang_m28_03     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m28_03.ashx"       //我的收藏主键id
#define WoDeShouCang_m28_04     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m28_04.ashx"       //我的收藏列表信息
#define ZhuYeXiaoQuZiXun_m38_07     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m38_07.ashx"   //主页-小区资讯信息
#define ZhuYeXiaoQuZiXun_m38_08     @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m38_08.ashx"   //主页-小区资讯信息条数
#define YinHangKa_m1_21         @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m1_21.ashx"   //绑定银行卡
#define YinHangKa_m1_22         @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m1_22.ashx"   //取得银行卡绑定信息
#define YinHangKa_m1_23         @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m1_23.ashx"   //解除银行卡绑定
 
#define ZiXunXinXi_m38_09       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m38_09.ashx"       //取得小区画面上的资讯栏目信息。返回资讯栏目信息最新一条数据
#define ZiXunXinXi_m38_10       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m38_10.ashx"       //对于资讯栏目信息，取得上次浏览之后新的资讯条数，显示在画面上提醒用户
#define ZiXunXinXi_m38_11       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m38_11.ashx"       //取得一个栏目中资讯信息的主键id
#define TuanGou_m40_10       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m40_10.ashx"       //取得团购商品主键列表id
#define TuanGou_m40_11       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m40_11.ashx"       //取得团购商品简略信息
#define TuanGou_m40_12       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m40_12.ashx"       //取得团购商品详细信息
#define TuanGou_m40_13       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m40_13.ashx"       //团购商品提交
#define BaoLiao_m44_08       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m44_08.ashx"       //我得爆料主键id
#define BaoLiao_m44_03       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m44_03.ashx"       //我得爆料信息
#define SheQuHuDong_m10_09   @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m10_09.ashx"       //删除帖子
#define SheQuFuWu_m3_10      @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m3_10.ashx"        //删除商家回复
#define QieHuanXiaoQu_m24_06      @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m24_06.ashx"        //切换地址
 #define BaoLiao_m45_01       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m45_01.ashx"       //新版缴费列表主键
 #define BaoLiao_m45_02       @"http://115.28.149.27:8090/V3.11/WebUI/api/serverApi/m45_02.ashx"       //新版缴费列表内容

*/

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



#define ipAddress_m1_01         @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m1_01.ashx"       //取ip地址

#define DengLu_m1_04            @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m1_04.ashx"       //登录
#define TianQiYuBao             @"http://www.weather.com.cn/data/cityinfo/101121601.html"               //天气预报

#define JianChaBanBen           @"https://www.xiaolianshequ.cn/download/HappyFace_iphone.plist"//检查版本
#define AaiXianGengXin          @"itms-services://?action=download-manifest&url=https://www.xiaolianshequ.cn/download/HappyFace_iphone.plist"                            //在线更新
#define GongJiJin_m1_04         @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m31_01.ashx"       //公积金
#define SheQuXuanZe_m24_02      @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m24_02.ashx"       //社区选择
#define ChengShiXuanZe_m24_01   @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m24_01.ashx"       //城市选择
//修改
/*
 */
#define KuaiJieJiaoFeiZhuJian_m30_01 @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m30_01.ashx"  //快捷缴费主键
#define WuYeFei_m30_02          @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m30_02.ashx"       //物业费
#define ShuiFei_m30_03          @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m30_03.ashx"       //水费
#define TingCheFei_m30_05       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m30_05.ashx"           //停车费

#define NuanQiFei_m30_04        @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m30_04.ashx"       //暖气费
#define WeiZhangChaXun_m33_01   @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m33_01.ashx"       //违章查询
#define XiaoQuBiBei_m27_01      @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m27_01.ashx"       //小区必备
#define XiaoQuBiBei_m27_02      @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m27_02.ashx"       //小区必备
#define ZhengFuGongGao_m26_01   @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m26_01.ashx"       //政府公告
#define ZhengFuGongGao_m26_02   @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m26_02.ashx"       //政府公告
#define YingXinWen_m11_01       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m11_01.ashx"       //赢新闻
#define YingXinWen_m11_02       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m11_02.ashx"       //赢新闻
#define SheQuHuDong_m10_02      @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m10_02.ashx"       //社区互动
#define SheQuHuDong_m10_03      @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m10_03.ashx"       //社区互动
#define SheQuHuDong_m10_04      @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m10_04.ashx"       //社区互动
#define SheQuHuDong_m10_05      @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m10_05.ashx"       //社区互动
#define SheQuHuDong_m10_06      @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m10_06.aspx"       //回复帖子
#define SheQuHuDong_m10_07      @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m10_07.aspx"       //发表帖子
#define SheQuHuDong_m10_09      @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m10_09.ashx"       //删除帖子
#define SheQuDongTai_m7_01      @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m38_11.ashx"        //社区动态
#define SheQuDongTai_m7_02      @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m38_02.ashx"        //社区动态
#define ZhuXiao_m1_05           @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m1_05.ashx"        //注销
#define QieHuanXiaoQu_m1_13     @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m1_13.ashx"        //切换小区
#define GeRenXinXiWanShan_m1_08 @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m1_08.aspx"        //个人信息完善
#define LouYuHao_m24_07         @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m24_07.ashx"       //我的楼宇号
#define DanYuanHao_m24_08       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m24_08.ashx"       //单元号
#define FangJianHao_m24_09      @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m24_09.ashx"       //房间号
#define BaoCunGeRenXinXi_m24_10 @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m24_10.ashx"       //保存个人信息
#define BaoCunXiaoQuXinXi_m24_03 @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m24_03.ashx"       //保存小区信息
/*
 修改时间 3.16
 修改原因 切换住址接口变化
 */
#define QieHuanZhuZhiXinXi_24_012 @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m24_12.ashx"    //切换住址
#define SheQuFuWu_m3_10         @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m3_10.ashx"        //删除商家回复
#define SheQuFuWu_m3_08         @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m3_08.ashx"        //社区服务
#define SheQuFuWu_m3_03         @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m3_03.ashx"        //社区服
#define SheQuFuWu_m3_05         @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m3_05.ashx"        //社区服务
#define SheQuFuWu_m3_06         @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m3_06.ashx"        //社区服务
#define SheQuFuWu_m3_02         @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m3_02.ashx"        //社区服务
#define JiaoFei_c1_02           @"http://114.215.147.74:8088/V3.11/WebUI/api/ccbApi/c1_02.ashx"           //支付缴费(单项)
#define ZongHeJiaoFei_c1_05     @"http://114.215.147.74:8088/V3.11/WebUI/api/ccbApi/c1_05.ashx"           //缴费支付(综合)

#define HuoQuYanZhengMa_m1_12   @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m1_12.ashx"        //获取验证码
#define ZhuCe_m1_02             @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m1_02.ashx"        //注册
#define CongZhiMiMa_m1_07       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m1_07.ashx"        //找回密码
#define XiuGaiMiMa_m1_09        @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m1_09.ashx"        //修改密码
#define SheQuTongZhi_m13_02     @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m13_02.ashx"       //社区通知
#define SheQuTongZhi_m13_01     @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m13_01.ashx"       //社区通知
#define WuYeTongZhi_m12_01      @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m12_01.ashx"       //物业通知
#define WuYeTongZhi_m12_02      @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m12_02.ashx"       //物业通知
#define ShouShiZhiNan_m8_01     @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m8_01.ashx"        //收视指南
#define ShouShiZhiNan_m8_02     @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m8_02.ashx"        //收视指南
#define YongHuBangDingXinXi_m1_17   @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m1_17.ashx"    //用户绑定信息
#define YongHuBangDingXinXi_m1_13   @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m1_13.ashx"    //用户绑定信息
//#define ZiXunXinXi_m38_01       @"http://114.215.147.74:8088/V3.8/WebUI/api/serverApi/m38_01.ashx"       //房产业务
//#define ZiXunXinXi_m38_02       @"http://114.215.147.74:8088/V3.8/WebUI/api/serverApi/m38_02.ashx"       //房产业务
#define ChangTuKeYun_m32_01     @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m32_01.ashx"       //长途客运
#define ChangTuKeYun_m32_02     @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m32_02.ashx"       //长途客运
#define CheLiangXinXi_m1_14     @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m1_14.ashx"        //车辆信息
#define ZiXunXinXi_m38_01       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m38_01.ashx"       //资讯信息
#define ZiXunXinXi_m38_02       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m38_02.ashx"       //资讯信息
#define YouHuiZhiXu_m40_1       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m40_01.ashx"       //优惠资讯
#define YouHuiZhiXu_m40_2       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m40_02.ashx"       //优惠资讯
#define TopXinXi_m39_01         @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m39_01.ashx"       //Top商品信息
#define YueShengHuo_c1_03       @"http://114.215.147.74:8088/V3.11/WebUI/api/ccbApi/c1_03.ashx"           //悦生活
#define MyMessage_21_02         @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m21_02.ashx"       //我的消息主键id
#define MyMessage_21_03         @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m21_03.ashx"       //我的消息定键值信息
#define YiJianFanKui_23_01      @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m23_01.ashx"       //意见反馈
#define YiJianFanKui_23_02      @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m23_02.ashx"       //意见反馈列表
#define MyReply_m22_01          @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m22_01.ashx"       //我的回复主键id
#define MyReply_m22_02          @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m22_02.ashx"       //我的回复信息
#define MyPosts_m10_08          @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m10_08.ashx"       //我的帖子主键id
#define MyPosts_m10_11          @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m10_11.ashx"       //我的帖子信息
#define HitRecommend_m29_01     @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m29_01.ashx"       //热推荐主键id
#define HitRecommend_m29_02     @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m29_02.ashx"       //热推荐主键信息
#define HitRecommend_m29_03     @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m29_03.ashx"       //热推荐频道信息
#define WoDeXiaoLianBi_m19_01   @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m19_01.ashx"       //我的笑脸币收入主键id
#define WoDeXiaoLianBi_m19_02   @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m19_02.ashx"       //我的笑脸币收入列表信息
#define WoDeXiaoLianBi_m19_03   @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m19_03.ashx"       //我的笑脸币合计总数
#define WoDeXiaoLianBi_m19_04   @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m19_04.ashx"       //我的笑脸币消费主键id
#define WoDeXiaoLianBi_m19_05   @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m19_05.ashx"       //我的笑脸币消费列表信息
#define WoDeShouCang_m28_03     @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m28_03.ashx"       //我的收藏主键id
#define WoDeShouCang_m28_04     @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m28_04.ashx"       //我的收藏列表信息

#define ZhuYeXiaoQuZiXun_m38_07     @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m38_07.ashx"   //主页-小区资讯信息
#define ZhuYeXiaoQuZiXun_m38_08     @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m38_08.ashx"   //主页-小区资讯信息条数

#define YinHangKa_m1_21         @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m1_21.ashx"   //绑定银行卡
#define YinHangKa_m1_22         @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m1_22.ashx"   //取得银行卡绑定信息
#define YinHangKa_m1_23         @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m1_23.ashx"   //解除银行卡绑定

#define ZiXunXinXi_m38_09       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m38_09.ashx"       //取得小区画面上的资讯栏目信息。返回资讯栏目信息最新一条数据
#define ZiXunXinXi_m38_10       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m38_10.ashx"       //对于资讯栏目信息，取得上次浏览之后新的资讯条数，显示在画面上提醒用户
#define ZiXunXinXi_m38_11       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m38_11.ashx"       //取得一个栏目中资讯信息的主键id
#define TuanGou_m40_10       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m40_10.ashx"       //取得团购商品主键列表id
#define TuanGou_m40_11       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m40_11.ashx"       //取得团购商品简略信息
#define TuanGou_m40_12       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m40_12.ashx"       //取得团购商品详细信息
#define TuanGou_m40_13       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m40_13.ashx"       //团购商品提交
#define BaoLiao_m44_08       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m44_08.ashx"       //我得爆料主键id
#define BaoLiao_m44_03       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m44_03.ashx"       //我得爆料信息
#define JiaoFei_m45_01       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m45_01.ashx"       //新版缴费列表主键
#define JiaoFei_m45_02       @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m45_02.ashx"       //新版缴费列表内容

#define QieHuanXiaoQu_m24_06      @"http://114.215.147.74:8088/V3.11/WebUI/api/serverApi/m24_06.ashx"        //切换地址
 
@interface URL : NSObject

@end
