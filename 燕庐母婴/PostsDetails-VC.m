//
//  PostsDetails-VC.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/5/29.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "PostsDetails-VC.h"
#import "PostsDetailsModel.h"
//#import "MBProgressHUD+Add.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "SDPhotoBrowser.h"
#import "fatietuView.h"
#import "UIImageView+AFNetworking.h"

#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"
#import "FacialView.h"

#import "MSImagePickerController.h"
#import <QuickLook/QLPreviewController.h>


#import "UMSocial.h"

//刷新数据
#import "SDRefresh.h"





#define kSTIBDefaultHeight 44
#define kSTLeftButtonWidth 50
#define kSTLeftButtonHeight 30
#define kSTRightButtonWidth 55
#define kSTTextviewDefaultHeight 34
#define kSTTextviewMaxHeight 80
#define kSTIBDefaultHeight 44
#define kSTLeftButtonWidth 50
#define kSTLeftButtonHeight 30
#define kSTRightButtonWidth 55
#define kSTTextviewDefaultHeight 34
#define kSTTextviewMaxHeight 80
#define FACE_ICON_NAME      @"^[0][0-8][0-5]$"

#define kToolBarH 44
#define kTextFieldH 30
#import "SDPhotoItem.h"
#import "SDPhotoGroup.h"

@interface PostsDetails_VC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ASIHTTPRequestDelegate,facialViewDelegate,SDPhotoBrowserDelegate>{
    
    
    NSMutableArray *array;
    //NSMutableDictionary *dic;
    UIButton *btn1;
    BOOL flag;
    BOOL flag1;
    UIView *view2;
    NSInteger counts;
    
    NSInteger imagehight;

    UIImageView *smallimage;
    UIButton *btn;
    UILabel *label;//提示
    BOOL flags;
    BOOL status;
    UIView *_bottomView;
    UIView *view1 ;
    
    BOOL states;

    UIScrollView *_scrollView;
    NSString *hid;
    UILabel *_textWindow;
    NSArray *_names;
    //下拉菜单
    UIActionSheet *myActionSheet;
    UILabel *title1;
    
    UILabel *title2;
    
    //图片2进制路径
    NSString* filePath;
    //回复字典
    NSMutableDictionary *dic;
    NSMutableDictionary *dict;

    
    NSString *shoucangZong;//收藏总数
    UIView *toolBar;
    
    UIButton *keyboardButton;
    //
    int sizes;
    
    UIButton *sendButton;
    UIButton *picterBtn;
    NSData *_data;
    
    //详情
    int contentXiang;
    //回复没有hid
    int content;
    //有hid
    int contents;
    int hidContent;
    
    
    CGFloat hight_text_one;
    UIView *xiaoView;
    
    fatietuView *imageview;
    
    NSMutableArray *imgArr;
    
    
    UIImageView *images2;
     UIImageView *images1;
    
    NSUserDefaults *user;
    NSString *_userIdss;
    
    NSString *times;

    
}
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;

@property (strong,nonatomic) SDPhotoGroup *photoGroup;
@end

@implementation PostsDetails_VC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (iPhone5) {

    }
    else if(iPhone6){

    }else if (iPhone6plus){

        
    }


    [self AFNetWorking];
    
    //刷新表格
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.userId);
    states=NO;
    
    
    user = [NSUserDefaults standardUserDefaults];
    _userIdss = [user objectForKey:@"userid"];
    
    self.navigationItem.title = @"帖子详情";
    
    /*-------------状态栏改变背景颜色-----------*/
    
    self.view.backgroundColor = RGBA(235, 235, 235, 1);
    self.tableView.backgroundColor=[UIColor clearColor];
    
    //转发
    UIButton *rightSend = [UIButton buttonWithType:UIButtonTypeCustom];
    rightSend.frame = CGRectMake(20, 14, 20, 21);
    [rightSend setBackgroundImage:[UIImage imageNamed:@"转发"] forState:UIControlStateNormal];
    [rightSend addTarget:self action:@selector(zhuanFa) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightSend];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //<<<<<<<<<<<<<<<。。。。。。。。。。。。。。。。。。。。
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    view.backgroundColor = RGBA(239, 238, 223, 1);
    [self.view addSubview:view];
    
    UILabel *whereLab = [[UILabel alloc] initWithFrame:CGRectMake(6, 2.5, 150, 15)];
    whereLab.text=[NSString stringWithFormat:@"来自：%@",self.quanName];
    //whereLab.text = @"来自：2015年12月同龄圈";
    whereLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    whereLab.textColor = RGBA(137, 137, 137, 1);
    [view addSubview:whereLab];
    
    
    //回复
    self.huiLab = [[UILabel alloc]init];
    self.huiLab.text =[NSString stringWithFormat:@"%@",self.pinglunnuber];
    self.huiLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    self.huiLab.textColor = RGBA(137, 137, 137, 1);
    [view addSubview:self.huiLab];
    self.huiLab.translatesAutoresizingMaskIntoConstraints = NO;
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.huiLab
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:2.5]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.huiLab
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1
                                                      constant:-10]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.huiLab
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0
                                                      constant:15]];
    self.huiFuImg = [[UIImageView alloc] init];
    self.huiFuImg.image = [UIImage imageNamed:@"回复"];
    [view addSubview:self.huiFuImg];
    self.huiFuImg.translatesAutoresizingMaskIntoConstraints = NO;
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.huiFuImg
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:4]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.huiFuImg
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.huiLab
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:-3]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.huiFuImg
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0
                                                      constant:12]];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.huiFuImg
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:0
                                                      constant:15]];
    
    
    //观看
    
    self.eyesLab = [[UILabel alloc] init];
    //self.eyesLab.text = @"9999";
    self.eyesLab.text=self.chakanzongshu;
    self.eyesLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    self.eyesLab.textColor = RGBA(137, 137, 137, 1);
    [view addSubview:self.eyesLab];
    self.eyesLab.translatesAutoresizingMaskIntoConstraints = NO;
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.eyesLab
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:2.5]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.eyesLab
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.huiFuImg
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:-10]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.eyesLab
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0
                                                      constant:15]];
    self.eyesImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-90, 4, 15, 12)];
    self.eyesImg.image = [UIImage imageNamed:@"观看"];
    [view addSubview:self.eyesImg];

    self.eyesImg.translatesAutoresizingMaskIntoConstraints = NO;
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.eyesImg attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:4]];
    
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.eyesImg
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.eyesLab
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:-3]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.eyesImg
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0
                                                      constant:12]];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.eyesImg
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:0
                                                      constant:15]];

    //时间
    
    self.timeLab = [[UILabel alloc] init];
    NSString *times1=self.time;
    self.timeLab.text= [times1 substringFromIndex:5];
    self.timeLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    self.timeLab.textColor = RGBA(137, 137, 137, 1);
    [view addSubview:self.timeLab];
    self.timeLab.translatesAutoresizingMaskIntoConstraints = NO;
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLab
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:2.5]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLab
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.eyesImg
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:-10]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLab
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0
                                                      constant:15]];
    self.timeImg = [[UIImageView alloc] init];
    self.timeImg.image = [UIImage imageNamed:@"time"];
    [view addSubview:self.timeImg];
    
    self.timeImg.translatesAutoresizingMaskIntoConstraints = NO;
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.timeImg
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:4]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.timeImg
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.timeLab
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:-3]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.timeImg
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0
                                                      constant:12]];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.timeImg
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:0
                                                      constant:15]];
    //>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    //标题
    view1 = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.origin.y+view.frame.size.height, ScreenWidth, 100)];
    [self.view addSubview:view1];
    
    UIImageView *newImg = [[UIImageView alloc] initWithFrame:CGRectMake(11, 12, 16, 16)];
    //newImg.image = [UIImage imageNamed:@"新1"];
    
    
    if([self.zhuangtai isEqualToString:@"0"]){
        //默认的没有图片
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, ScreenWidth-100, 20)];
        title.textColor=RGBA(55, 55, 53, 1);
        title.text = self.title;
        title.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:17];
        [view1 addSubview:title];
    }else if([self.zhuangtai isEqualToString:@"1"]){
        newImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 16, 16)];
        newImg.image = [UIImage imageNamed:@"新1"];
        [view1 addSubview:newImg];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(newImg.frame.origin.x+newImg.frame.size.width+7, 8, ScreenWidth-100, 20)];
        title.textColor=RGBA(55, 55, 53, 1);
        title.text = self.title;
        title.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:17];
        [view1 addSubview:title];
    }else if ([self.zhuangtai isEqualToString:@"2"]){
        newImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 16, 16)];
        newImg.image = [UIImage imageNamed:@"精"];
        [view1 addSubview:newImg];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(newImg.frame.origin.x+newImg.frame.size.width+7, 8, ScreenWidth-100, 20)];
        title.textColor=RGBA(55, 55, 53, 1);
        title.text = self.title;
        title.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:17];
        [view1 addSubview:title];
        
    }else if ([self.zhuangtai isEqualToString:@"3"]){
        newImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 28, 16)];
        newImg.image = [UIImage imageNamed:@"置顶"];

        [view1 addSubview:newImg];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(newImg.frame.origin.x+newImg.frame.size.width+7, 8, ScreenWidth-100, 20)];
        title.textColor=RGBA(55, 55, 53, 1);
        title.text = self.title;
        title.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:17];
        [view1 addSubview:title];
    }

    
    
    
    
    
    //点赞的布局
    
    
    //点赞
    title2=[[UILabel alloc]init];
    title2.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestureTel1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dianzhaner)];
    [title2 addGestureRecognizer:tapGestureTel1];
    title2.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
    title2.textColor=RGBA(148, 148, 149, 1);
    //    title2.text=@"11";
    //title2.text=@"点赞";
    
    [view1 addSubview:title2];
    title2.translatesAutoresizingMaskIntoConstraints = NO;
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:title2
                                                      attribute:NSLayoutAttributeTop
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:view1
                                                      attribute:NSLayoutAttributeTop
                                                     multiplier:1
                                                       constant:12]];
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:title2
                                                      attribute:NSLayoutAttributeRight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:view1
                                                      attribute:NSLayoutAttributeRight
                                                     multiplier:1
                                                       constant:-10]];
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:title2
                                                      attribute:NSLayoutAttributeHeight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:view1
                                                      attribute:NSLayoutAttributeHeight
                                                     multiplier:0
                                                       constant:11]];
    
    
    btn1=[[UIButton alloc]init];
   // [btn1 setBackgroundImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
    
    [btn1 addTarget:self action:@selector(dianzhaner) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:btn1];
    //btn1.backgroundColor=[UIColor redColor];
    btn1.translatesAutoresizingMaskIntoConstraints = NO;
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:btn1
                                                      attribute:NSLayoutAttributeTop
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:view1
                                                      attribute:NSLayoutAttributeTop
                                                     multiplier:1
                                                       constant:12]];
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:btn1
                                                      attribute:NSLayoutAttributeRight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:title2
                                                      attribute:NSLayoutAttributeLeft
                                                     multiplier:1
                                                       constant:-5]];
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:btn1
                                                      attribute:NSLayoutAttributeHeight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:view1
                                                      attribute:NSLayoutAttributeHeight
                                                     multiplier:0
                                                       constant:10]];
    
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:btn1
                                                      attribute:NSLayoutAttributeWidth
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:view1
                                                      attribute:NSLayoutAttributeWidth
                                                     multiplier:0
                                                       constant:12]];
    
    
    //收藏
    
    
    title1=[[UILabel alloc]init];
    //title1.text=@"aaa";
    //label添加tab事件
    UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shouChang)];
    [title1 addGestureRecognizer:tapGestureTel];
    //title1.backgroundColor=[UIColor redColor];
    title1.textColor=RGBA(148, 148, 149, 1);
    title1.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
    [view1 addSubview:title1];
    title1.translatesAutoresizingMaskIntoConstraints = NO;
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:title1
                                                      attribute:NSLayoutAttributeTop
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:view1
                                                      attribute:NSLayoutAttributeTop
                                                     multiplier:1
                                                       constant:12]];
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:title1
                                                      attribute:NSLayoutAttributeRight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:btn1
                                                      attribute:NSLayoutAttributeLeft
                                                     multiplier:1
                                                       constant:-10]];
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:title1
                                                      attribute:NSLayoutAttributeHeight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:view1
                                                      attribute:NSLayoutAttributeHeight
                                                     multiplier:0
                                                       constant:11]];
    btn=[[UIButton alloc]init];
    [btn setBackgroundImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
    //[btn addTarget:self action:@selector(shouChang) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:btn];
    // btn.backgroundColor=[UIColor redColor];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                      attribute:NSLayoutAttributeTop
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:view1
                                                      attribute:NSLayoutAttributeTop
                                                     multiplier:1
                                                       constant:12]];
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                      attribute:NSLayoutAttributeRight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:title1
                                                      attribute:NSLayoutAttributeLeft
                                                     multiplier:1
                                                       constant:-5]];
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                      attribute:NSLayoutAttributeHeight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:view1
                                                      attribute:NSLayoutAttributeHeight
                                                     multiplier:0
                                                       constant:10]];
    
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                      attribute:NSLayoutAttributeWidth
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:view1
                                                      attribute:NSLayoutAttributeWidth
                                                     multiplier:0
                                                       constant:12]];
    
    [btn addTarget:self action:@selector(shouChang) forControlEvents:UIControlEventTouchUpInside];
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    [self.manager GET:panduanshoucangURL parameters:[@{@"userid":self.userId,@"tieziid":_TidCount}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSData *data = responseObject;
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"返回值 = %@",str);
        if ([str isEqualToString:@"false"]) {
            
            [btn setBackgroundImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
            title1.textColor=RGBA(148, 148, 149, 1);
            title1.text=@"收藏";
            
        }else{
            
            [btn setBackgroundImage:[UIImage imageNamed:@"收藏B"] forState:UIControlStateNormal];
            title1.textColor=RGBA(236, 141, 160, 1);
            title1.text=@"取消收藏";
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"失败");
    }];
    
    [view1 addSubview:btn];
    
    //收藏的布局
    //收藏
    
    
    title1.text = @"收藏";
    title1.userInteractionEnabled=YES;
    
    
    ////点赞
    
    [btn1 addTarget:self action:@selector(dianzhaner) forControlEvents:UIControlEventTouchUpInside];

    
    if([self.dianzan isEqualToString:@"1"]){
        [btn1 setBackgroundImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
        //点赞
        
        title2.textColor=RGBA(148, 148, 149, 1);
        title2.text=@"点赞";

    
    }else{
        
        [btn1 setBackgroundImage:[UIImage imageNamed:@"红点赞"] forState:UIControlStateNormal];
        //点赞
        title2.textColor=RGBA(236, 141, 160, 1);
        title2.text=@"取消点赞";
    
    }
   
    //liuxiaofeng
   // title2.text = @"点赞";
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 35, ScreenWidth-20, 1)];
    lineView.backgroundColor = RGBA(221, 221, 221, 1);
    [view1 addSubview:lineView];
    
    NSURL *url = [NSURL URLWithString:@""];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    [self.backBtn setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
    //
    //返回按钮
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(20, 14, 16, 20);
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 51, ScreenWidth,SCREEN_HEIGHT-51-46-70) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];

    
    //***************弹出视图***************
    images2 = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-30)/2, (ScreenHeight-124)/2, 30, 30)];
    images2.backgroundColor = [UIColor lightGrayColor];
    images2.image = [UIImage imageNamed:@"点赞"];
    images2.hidden = YES;//隐藏
    [self.view addSubview:images2];
    //*****************************************************
    //关注
    images1 = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-30)/2, (ScreenHeight-124)/2, 30, 30)];
    images1.backgroundColor = [UIColor lightGrayColor];
    images1.image = [UIImage imageNamed:@"收藏B"];
    images1.hidden = YES;//隐藏
    [self.view addSubview:images1];
    

    
    
    
    [self bottomViewLayoutUI];
    //刷新
    [self setupHeader];
    [self setupFooter];
}


- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


//刷新表格
- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshView];
    
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:self.tableView];
    
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    refreshHeader.beginRefreshingOperation = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [weakRefreshHeader endRefreshing];
        });
    };
    
    // 进入页面自动加载一次数据
    [refreshHeader beginRefreshing];
}


- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshView];
    [refreshFooter addToScrollView:self.tableView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}


- (void)footerRefresh
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.refreshFooter endRefreshing];
    });
}


#pragma mark 键盘事件
//键盘将要出现
- (void)keyboardWillShow:(NSNotification *)notification {
    
    isKeyboardShowing = YES;
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         CGRect frame = self.tableView.frame;
                         frame.size.height += keyboardHeight;
                         frame.size.height -= keyboardRect.size.height;
                         self.tableView.frame = frame;
                         
                         frame = toolBar.frame;
                         frame.origin.y += keyboardHeight;
                         frame.origin.y -= keyboardRect.size.height;
                         toolBar.frame = frame;
                         
                         keyboardHeight = keyboardRect.size.height;
                     }];
    
    if ( isFirstShowKeyboard ) {
        
        isFirstShowKeyboard = NO;
        
        isSystemBoardShow = !isButtonClicked;
    }
    
    if ( isSystemBoardShow ) {
        
        [keyboardButton setBackgroundImage:[UIImage imageNamed:@"表情"] forState:UIControlStateNormal];
    }else {
        
        [keyboardButton setImage:[UIImage imageNamed:@"信封"]
                        forState:UIControlStateNormal];
    }
}


//键盘隐藏
- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         CGRect frame = self.tableView.frame;
                         frame.size.height += keyboardHeight;
                         self.tableView.frame = frame;
                         
                         frame = toolBar.frame;
                         frame.origin.y += keyboardHeight;
                         toolBar.frame = frame;
                         
                         keyboardHeight = 0;
                     }];
}



//隐藏键盘
- (void)keyboardDidHide:(NSNotification *)notification {
    
    isKeyboardShowing = NO;
    
    if ( isButtonClicked ) {
        
        isButtonClicked = NO;
        if(![self.textView.inputView isEqual:@""]){
            isSystemBoardShow = YES;
            
            self.textView.inputView = nil;
        }else{
            isSystemBoardShow = NO;
            
            // self.textView.inputView = faceBoard;
        }
        
        [self.textView becomeFirstResponder];
    }
    //失去键盘
}


#pragma 消息处理
- (void)endEdit
{
    [self.view endEditing:YES];
}



- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    images2.hidden=YES;
   // images1.hidden=YES;
}
- (void)timerFireMethod1:(NSTimer*)theTimer//弹出框
{
    //images.hidden=YES;
     images1.hidden=YES;
}



//收藏
-(void)shouChang{
    if(flag){
        
        [self shoucangURL];
        [self.tableView reloadData];

    }else{
        [self shoucangURL];
        [self.tableView reloadData];

    }
    
    flag=!flag;
}





//点赞
-(void)dianzhaner{
    if(flag1){
        
        [self dianzanURL];
        [self.tableView reloadData];
    }else{
        
        [self dianzanURL];
        [self.tableView reloadData];
    }
    
    flag1=!flag1;
}


//点赞
-(void)dianzanURL{
    NSLog(@"%@",_userId);
    [self.manager GET:panDuantieZiDianzhanURL parameters:[@{@"userid":self.userId,@"tieziid":_TidCount}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"6666666%ld",(long)_TidCount);
        NSData *data = responseObject;
        NSString *str1 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"str111111111:%@",str1);
        if ([str1 isEqualToString:@"false"]) {
            
            [self.manager GET:addtieZiDianzhanURL parameters:[@{@"userid":self.userId,@"tieziid":_TidCount}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
                
                [btn1 setBackgroundImage:[UIImage imageNamed:@"红点赞"] forState:UIControlStateNormal] ;
                
                //title2.text=self.zannumber;
                title2.textColor=RGBA(236, 141, 160, 1);
                title2.text=@"取消点赞";
                images2.hidden = NO;//隐藏
                
                
                [NSTimer scheduledTimerWithTimeInterval:2.0f
                                                 target:self
                                               selector:@selector(timerFireMethod:)
                                               userInfo:images2
                                                repeats:YES];
                // [self.tableView reloadData];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"失败");
            }];
            
        }else{
            
            [self.manager GET:delegetetieZiDianzhanURL parameters:[@{@"userid":self.userId,@"tieziid":_TidCount}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
                
                [btn1 setBackgroundImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
                title2.textColor=RGBA(148, 148, 149, 1);
                title2.text=@"点赞";
                
                NSLog(@"hahhhahah成功啦");
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"失败");
            }];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"失败");
    }];
    

    
}
#pragma mark 收藏
-(void)shoucangURL{
    NSLog(@"%@",_userId);
    [self.manager GET:panduanshoucangURL parameters:[@{@"userid":self.userId,@"tieziid":_TidCount}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSData *data = responseObject;
        NSString *str1 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if ([str1 isEqualToString:@"false"]) {
            
            [self.manager GET:addshoucangURL parameters:[@{@"userid":self.userId,@"tieziid":_TidCount}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
                //[self addbtn];
                //[self AFNetworking];
                [btn setBackgroundImage:[UIImage imageNamed:@"收藏B"] forState:UIControlStateNormal] ;
                title1.textColor=RGBA(236, 141, 160, 1);
                title1.text=@"取消收藏";
                
                images1.hidden = NO;//隐藏
                
                
                [NSTimer scheduledTimerWithTimeInterval:2.0f
                                                 target:self
                                               selector:@selector(timerFireMethod1:)
                                               userInfo:images1
                                                repeats:YES];
                // [self.tableView reloadData];
                NSLog(@"收藏成功");
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"失败");
            }];
            
        }else{
            
            [self.manager GET:delegetshoucangURL parameters:[@{@"userid":self.userId,@"tieziid":_TidCount}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
                
                [btn setBackgroundImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal] ;
                title1.text=@"收藏";
                title1.textColor=RGBA(148, 148, 149, 1);
                
                // [self.tableView reloadData];
                NSLog(@"hahhhahah成功啦");
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"失败");
            }];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"失败");
    }];
}


#pragma mark分享
-(void)zhuanFa
{
    NSString *shareText = @"桥文化餐厅是一款基于020模式打造，致力于提高您的用餐体验质量的一款app。它不仅可以提供餐桌/包间预定、点餐、钱包支付、路线导航、优惠券等实用功能，还可以通过大家说大家推荐频道，使您更好、更放心的引领大家享受美食，同时还可以在爱“桥”欣赏“桥”的圈子里快速便捷的积累及分享个人人脉关系。 http://www.umeng.com/social";             //分享内嵌文字
    UIImage *shareImage = [UIImage imageNamed:@"美妈标志"];          //分享内嵌图片
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"507fcab25270157b37000010" shareText:shareText shareImage:shareImage shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatTimeline,UMShareToWechatSession,nil] delegate:nil];

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIFont *font = [UIFont fontWithName:@"Arial" size:17];
    //帖子详情
    if (indexPath.row == 0) {
        
        static NSString *CellIdentifier = @"aCell";
        
        PostsBodyCell *Cell = (PostsBodyCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(Cell == nil){
            
            Cell = [[PostsBodyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        dict=[_dataArr objectAtIndex:0];
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加图片
        [Cell.userHeadImg setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"touxiang"]] placeholderImage:[UIImage imageNamed:@"头像"]];
        
        //添加昵称
        Cell.userNameLab.text=[dict objectForKey:@"nicheng"];
        Cell.userNameLab.textColor=RGBA(236, 141, 160, 1);
        //动态获取label的宽度和高度
        Cell.userNameLab.numberOfLines = 0;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:Cell.userNameLab.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        size = [Cell.userNameLab.text boundingRectWithSize:CGSizeMake(ScreenWidth-20, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        [Cell.userNameLab setFrame:CGRectMake(Cell.userHeadImg.frame.origin.x+Cell.userHeadImg.frame.size.width+10, 14, size.width, size.height)];
        
        
        
        
        Cell.louZhuImg.frame = CGRectMake(Cell.userNameLab.frame.size.width+Cell.userNameLab.frame.origin.x+7, 17, 19, 10.5);
        Cell.louZhuImg.image = [UIImage imageNamed:@"楼主"];
        
        Cell.timeLab.text=@"孕3周5天";
        
        Cell.timeLab.frame = CGRectMake(Cell.userHeadImg.frame.origin.x+Cell.userHeadImg.frame.size.width+10, Cell.userNameLab.frame.origin.y+Cell.userNameLab.frame.size.height+5, 60, 12);
        //判断图片的高度

        //liuxiaofeng
        Cell.contentLabel.text=self.neirong;
        //动态获取label的宽度和高度
        Cell.contentLabel.numberOfLines = 0;
        
        Cell.contentLabel.frame=CGRectMake(10,CGRectGetMaxY(Cell.userHeadImg.frame)+5, SCREEN_WIDTH-20, [Cell.contentLabel.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(SCREEN_WIDTH-40, 10000) lineBreakMode:NSLineBreakByWordWrapping].height);
        Cell.contentLabel.userInteractionEnabled=NO;
        
        
        contentXiang=Cell.contentLabel.bounds.size.height;
        
//判断是否有路径的字段
        if([[dict allKeys ] count]<17){
            //内容下面的展示内容
            Cell.huiTime.frame = CGRectMake(10,CGRectGetMaxY(Cell.contentLabel.frame)+13, 10, 10);
            Cell.huiTime.layer.masksToBounds = YES;
            Cell.huiTime.layer.cornerRadius = Cell.huiTime.bounds.size.width/2;
            Cell.huiTime.image = [UIImage imageNamed:@"小表"];
            Cell.huiTimeCount.frame = CGRectMake(28,CGRectGetMaxY(Cell.contentLabel.frame)+10, 150, 15);
            
            Cell.huiTimeCount.textAlignment=NSTextAlignmentLeft;
#pragma mark 判断时间
            //判断时间
            if([self.time length]==0){
                Cell.huiTimeCount.text=@"时间丢失";
            }else{
                if([self.time length]==8){
                    //时间格式20140430
                    //解析时间
                    
                    NSDateFormatter *date=[[NSDateFormatter alloc] init];
                    [date setDateFormat:@"yyyyMMddHHmmss"];
                    NSDate *d=[date dateFromString:times];
                    
                    NSTimeInterval late=[d timeIntervalSince1970]*1;
                    
                    
                    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                    NSTimeInterval now=[dat timeIntervalSince1970]*1;
                    NSString *timeString=times;
                    
                    NSTimeInterval cha=now-late;
                    //liuxiaofeng刚刚出不来
                    if(cha/60<1&&cha/60>0) {
                        Cell.huiTimeCount.text=@"刚刚";
                        
                        
                    }
                    NSLog(@"cha is %f",cha);
                    if (cha/3600<1) {
                        timeString = [NSString stringWithFormat:@"%f", cha/60];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                        
                    }
                    if (cha/3600>1&&cha/86400<1) {
                        timeString = [NSString stringWithFormat:@"%f", cha/3600];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                    }
                    if (cha/86400>1)
                    {
                        timeString = [NSString stringWithFormat:@"%f", cha/86400];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=[NSString stringWithFormat:@"%@天前", timeString];
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                        
                    }
                    
                    
                    
                }else{
                    //时间格式2015-12-04 18：39：23
                    //得到当前系统时间
                    //特定时间
                    
                    NSDateFormatter *date=[[NSDateFormatter alloc] init];
                    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSLog(@"%@",self.time);
                    NSDate *d=[date dateFromString:self.time];
                    
                    NSTimeInterval late=[d timeIntervalSince1970]*1;
                    
                    
                    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                    NSTimeInterval now=[dat timeIntervalSince1970]*1;
                    NSString *timeString=self.time;
                    
                    NSTimeInterval cha=now-late;
                    //liuxiaofeng
                    if(cha/60<1 &&cha/60>0) {
                        timeString = [NSString stringWithFormat:@"%f", cha];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=@"刚刚";
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                        
                    }
                    
                    
                    if (cha/3600<1) {
                        timeString = [NSString stringWithFormat:@"%f", cha/60];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                        
                    }
                    if (cha/3600>1&&cha/86400<1) {
                        timeString = [NSString stringWithFormat:@"%f", cha/3600];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                    }
                    if (cha/86400>1)
                    {
                        timeString = [NSString stringWithFormat:@"%f", cha/86400];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=[NSString stringWithFormat:@"%@天前", timeString];
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                        
                    }
                    if([Cell.huiTimeCount.text isEqualToString:@"0分钟前"]){
                        Cell.huiTimeCount.text=@"刚刚";
                    }
                    
                }
                
            }
            
            //回复
            Cell.huiBtn.frame = CGRectMake(self.view.bounds.size.width-35,CGRectGetMaxY(Cell.contentLabel.frame)+10, 35, 15);
            [Cell.huiBtn setTitle:@"回复" forState:UIControlStateNormal];
            [Cell.huiBtn addTarget:self action:@selector(diaohuifu) forControlEvents:UIControlEventTouchUpInside];
            [Cell.huiBtn setTitleColor:RGBA(173, 172, 173, 1) forState:UIControlStateNormal];
            [Cell.huiBtn setFont:[UIFont fontWithName:@"Microsoft Yahei UI" size:10]];
            [Cell.huiBtnimg setBackgroundImage:[UIImage imageNamed:@"回复楼主"] forState:UIControlStateNormal];
            [Cell.huiBtnimg addTarget:self action:@selector(clicksend:) forControlEvents:UIControlEventTouchUpInside];
            
            Cell.huiBtnimg.frame=CGRectMake(CGRectGetMaxX(Cell.huiBtn.frame)-43,CGRectGetMaxY(Cell.contentLabel.frame)+13, 12, 10);

        }
        //判断路径是否为空
        NSString *lujing=[NSString stringWithFormat:@"%@",[dict objectForKey:@"lujing"]];
        NSString *string=[NSString stringWithFormat:@""];
        //判断是否有图片
        if([lujing isEqualToString:string]){
            NSLog(@"为空");
            
            // bodyCell.contentLabel.text = self.neirong;
            //内容下面的展示内容
            Cell.huiTime.frame = CGRectMake(10,CGRectGetMaxY(Cell.contentLabel.frame)+13, 10, 10);
            Cell.huiTime.layer.masksToBounds = YES;
            Cell.huiTime.layer.cornerRadius = Cell.huiTime.bounds.size.width/2;
            Cell.huiTime.image = [UIImage imageNamed:@"小表"];
            Cell.huiTimeCount.frame = CGRectMake(28,CGRectGetMaxY(Cell.contentLabel.frame)+10, 150, 15);
            
            Cell.huiTimeCount.textAlignment=NSTextAlignmentLeft;
#pragma mark 判断时间
            //判断时间
            if([self.time length]==0){
                Cell.huiTimeCount.text=@"时间丢失";
            }else{
                if([self.time length]==8){
                    //时间格式20140430
                    //解析时间
                    
                    NSDateFormatter *date=[[NSDateFormatter alloc] init];
                    [date setDateFormat:@"yyyyMMddHHmmss"];
                    NSDate *d=[date dateFromString:times];
                    
                    NSTimeInterval late=[d timeIntervalSince1970]*1;
                    
                    
                    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                    NSTimeInterval now=[dat timeIntervalSince1970]*1;
                    NSString *timeString=times;
                    
                    NSTimeInterval cha=now-late;
                    //liuxiaofeng刚刚出不来
                    if(cha/60<1&&cha/60>0) {
                        Cell.huiTimeCount.text=@"刚刚";
                        
                        
                    }
                    NSLog(@"cha is %f",cha);
                    if (cha/3600<1) {
                        timeString = [NSString stringWithFormat:@"%f", cha/60];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                        
                    }
                    if (cha/3600>1&&cha/86400<1) {
                        timeString = [NSString stringWithFormat:@"%f", cha/3600];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                    }
                    if (cha/86400>1)
                    {
                        timeString = [NSString stringWithFormat:@"%f", cha/86400];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=[NSString stringWithFormat:@"%@天前", timeString];
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                        
                    }
                    
                    
                    
                }else{
                    //时间格式2015-12-04 18：39：23
                    //得到当前系统时间
                    //特定时间
                    
                    NSDateFormatter *date=[[NSDateFormatter alloc] init];
                    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSDate *d=[date dateFromString:self.time];
                    
                    NSTimeInterval late=[d timeIntervalSince1970]*1;
                    
                    
                    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                    NSTimeInterval now=[dat timeIntervalSince1970]*1;
                    NSString *timeString=self.time;
                    
                    NSTimeInterval cha=now-late;
                    //liuxiaofeng
                    if(cha/60<1 &&cha/60>0) {
                        timeString = [NSString stringWithFormat:@"%f", cha];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=@"刚刚";
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                        
                    }
                    
                    
                    if (cha/3600<1) {
                        timeString = [NSString stringWithFormat:@"%f", cha/60];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                        
                    }
                    if (cha/3600>1&&cha/86400<1) {
                        timeString = [NSString stringWithFormat:@"%f", cha/3600];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                    }
                    if (cha/86400>1)
                    {
                        timeString = [NSString stringWithFormat:@"%f", cha/86400];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=[NSString stringWithFormat:@"%@天前", timeString];
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                        
                    }
                    if([Cell.huiTimeCount.text isEqualToString:@"0分钟前"]){
                        Cell.huiTimeCount.text=@"刚刚";
                    }
                    
                }
                
            }
            
            //回复
            Cell.huiBtn.frame = CGRectMake(self.view.bounds.size.width-35,CGRectGetMaxY(Cell.contentLabel.frame)+10, 35, 15);
            [Cell.huiBtn setTitle:@"回复" forState:UIControlStateNormal];
            [Cell.huiBtn addTarget:self action:@selector(diaohuifu) forControlEvents:UIControlEventTouchUpInside];
            [Cell.huiBtn setTitleColor:RGBA(173, 172, 173, 1) forState:UIControlStateNormal];
            [Cell.huiBtn setFont:[UIFont fontWithName:@"Microsoft Yahei UI" size:10]];
            [Cell.huiBtnimg setBackgroundImage:[UIImage imageNamed:@"回复楼主"] forState:UIControlStateNormal];
            [Cell.huiBtnimg addTarget:self action:@selector(clicksend:) forControlEvents:UIControlEventTouchUpInside];
            
            Cell.huiBtnimg.frame=CGRectMake(CGRectGetMaxX(Cell.huiBtn.frame)-43,CGRectGetMaxY(Cell.contentLabel.frame)+13, 12, 10);

            
        }else{
            //有图片
            //判断路径
            
            

            
            NSString *string = [dict objectForKey:@"lujing"];
            NSArray   *strarray = [string componentsSeparatedByString:@".png"];
            
            imgArr= (NSMutableArray *)strarray;
            if(imgArr.count<2){
            
            }else{
            [imgArr removeLastObject];
            }
            
            
            NSLog(@"%f",Cell.contentLabel.frame.origin.y);
            
             self.photoGroup = [[SDPhotoGroup alloc] initWithFrame:CGRectMake(10, Cell.contentLabel.frame.origin.y + Cell.contentLabel.frame.size.height + 10, 280, 80)];
            NSLog(@"%lf",self.photoGroup.frame.origin.y);
            
            //self.photoGroup = [[SDPhotoGroup alloc] init];
            NSMutableArray *temp = [NSMutableArray array];
            [imgArr enumerateObjectsUsingBlock:^(NSString *src, NSUInteger idx, BOOL *stop) {
                SDPhotoItem *item = [[SDPhotoItem alloc] init];
                item.thumbnail_pic = src;
                [temp addObject:item];
            }];
            
            self.photoGroup.photoItemArray = [temp copy];
            [Cell.contentView addSubview:self.photoGroup];
            
            
            //判断有多少张图片
            if(imgArr.count>0 &&imgArr.count<4){
                imagehight=80;
                //内容下面的展示内容
                Cell.huiTime.frame = CGRectMake(10,CGRectGetMaxY(self.photoGroup.frame)+10, 10, 10);
                Cell.huiTime.layer.masksToBounds = YES;
                Cell.huiTime.layer.cornerRadius =  Cell.huiTime.bounds.size.width/2;
                Cell.huiTime.image = [UIImage imageNamed:@"小表"];
                Cell.huiTimeCount.frame = CGRectMake(28,CGRectGetMaxY(self.photoGroup.frame)+10, 150, 15);
                //Cell.huiTimeCount.text=@"3个小时前";
                Cell.huiTimeCount.textAlignment=NSTextAlignmentLeft;
                
                //回复
                Cell.huiBtn.frame = CGRectMake(self.view.bounds.size.width-35,CGRectGetMaxY(self.photoGroup.frame)+10, 35, 15);
                [Cell.huiBtn setTitle:@"回复" forState:UIControlStateNormal];
                [Cell.huiBtn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
                [Cell.huiBtn setTitleColor:RGBA(173, 172, 173, 1) forState:UIControlStateNormal];
                [Cell.huiBtn setFont:[UIFont fontWithName:@"Microsoft Yahei UI" size:10]];
                [Cell.huiBtnimg setBackgroundImage:[UIImage imageNamed:@"回复楼主"] forState:UIControlStateNormal];
                [Cell.huiBtnimg addTarget:self action:@selector(clicksend:) forControlEvents:UIControlEventTouchUpInside];
                
                Cell.huiBtnimg.frame=CGRectMake(CGRectGetMaxX(Cell.huiBtn.frame)-43,CGRectGetMaxY(self.photoGroup.frame)+10, 12, 10);

                
                //一行的高度
            }else if(imgArr.count>3&&imgArr.count<7){
                //两行
                imagehight=165;
                //内容下面的展示内容
                Cell.huiTime.frame = CGRectMake(10,CGRectGetMaxY(self.photoGroup.frame)+12+80, 10, 10);
                Cell.huiTime.layer.masksToBounds = YES;
                Cell.huiTime.layer.cornerRadius =  Cell.huiTime.bounds.size.width/2;
                Cell.huiTime.image = [UIImage imageNamed:@"小表"];
                Cell.huiTimeCount.frame = CGRectMake(28,CGRectGetMaxY(self.photoGroup.frame)+10+80, 150, 15);
                //Cell.huiTimeCount.text=@"3个小时前";
                Cell.huiTimeCount.textAlignment=NSTextAlignmentLeft;
                
                //回复
                Cell.huiBtn.frame = CGRectMake(self.view.bounds.size.width-35,CGRectGetMaxY(self.photoGroup.frame)+10+80, 35, 15);
                [Cell.huiBtn setTitle:@"回复" forState:UIControlStateNormal];
                [Cell.huiBtn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
                [Cell.huiBtn setTitleColor:RGBA(173, 172, 173, 1) forState:UIControlStateNormal];
                [Cell.huiBtn setFont:[UIFont fontWithName:@"Microsoft Yahei UI" size:10]];
                [Cell.huiBtnimg setBackgroundImage:[UIImage imageNamed:@"回复楼主"] forState:UIControlStateNormal];
                [Cell.huiBtnimg addTarget:self action:@selector(clicksend:) forControlEvents:UIControlEventTouchUpInside];
                
                Cell.huiBtnimg.frame=CGRectMake(CGRectGetMaxX(Cell.huiBtn.frame)-43,CGRectGetMaxY(self.photoGroup.frame)+12+80, 10, 10);

//               
            
            }else if(imgArr.count>6&&imgArr.count<10){
                imagehight=250;
                //内容下面的展示内容
                Cell.huiTime.frame = CGRectMake(10,CGRectGetMaxY(self.photoGroup.frame)+10+160, 10, 10);
                Cell.huiTime.layer.masksToBounds = YES;
                Cell.huiTime.layer.cornerRadius =  Cell.huiTime.bounds.size.width/2;
                Cell.huiTime.image = [UIImage imageNamed:@"小表"];
                Cell.huiTimeCount.frame = CGRectMake(28,CGRectGetMaxY(Cell.contentLabel.frame)+12+160, 150, 15);
                //Cell.huiTimeCount.text=@"3个小时前";
                Cell.huiTimeCount.textAlignment=NSTextAlignmentLeft;
                
                //回复
                Cell.huiBtn.frame = CGRectMake(self.view.bounds.size.width-35,CGRectGetMaxY(self.photoGroup.frame)+10+160, 35, 15);
                [Cell.huiBtn setTitle:@"回复" forState:UIControlStateNormal];
                [Cell.huiBtn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
                [Cell.huiBtn setTitleColor:RGBA(173, 172, 173, 1) forState:UIControlStateNormal];
                [Cell.huiBtn setFont:[UIFont fontWithName:@"Microsoft Yahei UI" size:10]];
                [Cell.huiBtnimg setBackgroundImage:[UIImage imageNamed:@"回复楼主"] forState:UIControlStateNormal];
                [Cell.huiBtnimg addTarget:self action:@selector(clicksend:) forControlEvents:UIControlEventTouchUpInside];
                
                Cell.huiBtnimg.frame=CGRectMake(CGRectGetMaxX(Cell.huiBtn.frame)-43,CGRectGetMaxY(self.photoGroup.frame)+12+160, 10, 10);

               
            
            }
            
            
            
            

            
            //内容图标
#pragma mark 判断时间
            //判断时间
            if([self.time length]==0){
                Cell.huiTimeCount.text=@"时间丢失";
            }else{
                if([self.time length]==8){
                    NSLog(@"ooooo");
                    //时间格式20140430
                    //解析时间
                    
                    NSDateFormatter *date=[[NSDateFormatter alloc] init];
                    [date setDateFormat:@"yyyyMMddHHmmss"];
                    NSDate *d=[date dateFromString:times];
                    
                    NSTimeInterval late=[d timeIntervalSince1970]*1;
                    
                    
                    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                    NSTimeInterval now=[dat timeIntervalSince1970]*1;
                    NSString *timeString=times;
                    
                    NSTimeInterval cha=now-late;
                    //liuxiaofeng刚刚出不来
                    if(cha/60<1&&cha/60>0) {
                        Cell.huiTimeCount.text=@"刚刚";
                        
                        
                    }
                    NSLog(@"cha is %f",cha);
                    if (cha/3600<1) {
                        timeString = [NSString stringWithFormat:@"%f", cha/60];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                        
                    }
                    if (cha/3600>1&&cha/86400<1) {
                        timeString = [NSString stringWithFormat:@"%f", cha/3600];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                    }
                    if (cha/86400>1)
                    {
                        timeString = [NSString stringWithFormat:@"%f", cha/86400];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=[NSString stringWithFormat:@"%@天前", timeString];
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                        
                    }
                    
                    
                    
                }else{
                    //时间格式2015-12-04 18：39：23
                    //得到当前系统时间
                    //特定时间
                    
                    NSDateFormatter *date=[[NSDateFormatter alloc] init];
                    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSDate *d=[date dateFromString:self.time];
                    
                    NSTimeInterval late=[d timeIntervalSince1970]*1;
                    
                    
                    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                    NSTimeInterval now=[dat timeIntervalSince1970]*1;
                    NSString *timeString=self.time;
                    
                    NSTimeInterval cha=now-late;
                    //liuxiaofeng
                    if(cha/60<1 &&cha/60>0) {
                        timeString = [NSString stringWithFormat:@"%f", cha];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=@"刚刚";
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                        
                    }
                    
                    
                    if (cha/3600<1) {
                        timeString = [NSString stringWithFormat:@"%f", cha/60];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                        
                    }
                    if (cha/3600>1&&cha/86400<1) {
                        timeString = [NSString stringWithFormat:@"%f", cha/3600];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                    }
                    if (cha/86400>1)
                    {
                        timeString = [NSString stringWithFormat:@"%f", cha/86400];
                        timeString = [timeString substringToIndex:timeString.length-7];
                        timeString=[NSString stringWithFormat:@"%@天前", timeString];
                        Cell.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                        
                        
                    }
                    if([Cell.huiTimeCount.text isEqualToString:@"0分钟前"]){
                        Cell.huiTimeCount.text=@"刚刚";
                    }
                    
                    
                }
                
            }

           
        }
        
        
        return Cell;
    }else{
        
        NSString *CellIdentifier1 = [NSString stringWithFormat:@"indexPath"];
        
        PostsBodyCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        cell1 = [self.tableView cellForRowAtIndexPath:indexPath];

        if(cell1 == nil)
        {
            cell1 = [[PostsBodyCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
            //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        else
        {
            //删除cell的所有子视图
            while ([cell1.contentView.subviews lastObject] != nil)
            {
                [(UIView*)[cell1.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        dic=[_huiFuArr objectAtIndex:indexPath.row-1];
        [dic objectForKey:@"id"];
        NSString *hids=[NSString stringWithFormat:@"0"];
        NSString *hidString=[NSString stringWithFormat:@"%@",[dic objectForKey:@"hid"]];
        times=[dic objectForKey:@"time"];
        NSLog(@"%@",hidString);
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell1.userHeadImg setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"touxiang"]] placeholderImage:[UIImage imageNamed:@"头像"]];
        
        //判断是否有hid
        if([hidString isEqualToString:hids]){
            //没有hid
            
            //昵称
            cell1.userNameLab.text = [dic objectForKey:@"nicheng"];
           [cell1.userNameLab setFrame:CGRectMake(cell1.userHeadImg.frame.origin.x+cell1.userHeadImg.frame.size.width+10, 14,SCREEN_WIDTH-60 ,15)];
            
            
            //怀孕时间
            cell1.timeLab.text = @"孕15周3天";
            cell1.timeLab.frame = CGRectMake(cell1.userHeadImg.frame.origin.x+cell1.userHeadImg.frame.size.width+10, cell1.userNameLab.frame.origin.y+cell1.userNameLab.frame.size.height+5, 60, 12);
            
            
            
            //《《《《《《《》》》》》》》》》》》》》》》》》》》》》
            
            NSString *text = [[self.huiFuArr objectAtIndex:indexPath.row-1] objectForKey:@"neirong"];
            
            cell1.contentLabel.frame=CGRectMake(10,CGRectGetMaxY(cell1.userHeadImg.frame)+10, SCREEN_WIDTH-20, [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(SCREEN_WIDTH-40, 10000) lineBreakMode:NSLineBreakByWordWrapping].height);
            content=cell1.contentLabel.bounds.size.height;
            NSString *message = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            [arr addObject:self.textView.text];
            
            [self getImageRange:message :arr];
            [cell1.view addSubview:[self assembleMessageAtIndex:arr]];
            
            size3 = CGSizeMake(ScreenWidth-20, 9999.f);
            size3 = [text sizeWithFont:font constrainedToSize:size3 lineBreakMode:NSLineBreakByCharWrapping];
            [cell1.view setFrame:CGRectMake(10, 45, size3.width, size3.height)];
            
            
            cell1.postLab = [[UILabel alloc] initWithFrame:CGRectMake(10, size3.height+8, 12, 12)];
            cell1.timeImg.backgroundColor = [UIColor redColor];
            cell1.timeImg.image = [UIImage imageNamed:@"time"];
            NSString *lujing=[NSString stringWithFormat:@"%@",[dic objectForKey:@"lujing"]];
            NSString *string=[NSString stringWithFormat:@""];
            
            //判断路径是否为空
            if([lujing isEqualToString:string]){
                NSLog(@"为空");
                
                //内容下面的展示内容
                cell1.huiTime.frame = CGRectMake(10,CGRectGetMaxY(cell1.contentLabel.frame)+5, 10, 10);
                cell1.huiTime.layer.masksToBounds = YES;
                cell1.huiTime.layer.cornerRadius =cell1.huiTime.bounds.size.width/2;
                cell1.huiTime.image = [UIImage imageNamed:@"小表"];
                cell1.huiTimeCount.frame = CGRectMake(28,CGRectGetMaxY(cell1.contentLabel.frame)+2, 150, 15);
                
                if([times length]==0){
                    cell1.huiTimeCount.text=@"时间丢失";
                }else{
                    if([times length]==8){
                        NSLog(@"ooooo");
                        //时间格式20140430
                        //解析时间
                        
                        NSDateFormatter *date=[[NSDateFormatter alloc] init];
                        [date setDateFormat:@"yyyyMMddHHmmss"];
                        NSDate *d=[date dateFromString:times];
                        
                        NSTimeInterval late=[d timeIntervalSince1970]*1;
                        
                        
                        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                        NSTimeInterval now=[dat timeIntervalSince1970]*1;
                        NSString *timeString=times;
                        
                        NSTimeInterval cha=now-late;
                        //liuxiaofeng刚刚出不来
                        if(cha/60<1&&cha/60>0) {
                           cell1.huiTimeCount.text=@"刚刚";
                            
                            
                        }
                        NSLog(@"cha is %f",cha);
                        if (cha/3600<1) {
                            timeString = [NSString stringWithFormat:@"%f", cha/60];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        if (cha/3600>1&&cha/86400<1) {
                            timeString = [NSString stringWithFormat:@"%f", cha/3600];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@小时前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                        }
                        if (cha/86400>1)
                        {
                            timeString = [NSString stringWithFormat:@"%f", cha/86400];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@天前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        
                        
                        
                    }else{
                        //时间格式2015-12-04 18：39：23
                        //得到当前系统时间
                        //特定时间
                        
                        NSDateFormatter *date=[[NSDateFormatter alloc] init];
                        [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSDate *d=[date dateFromString:times];
                        
                        NSTimeInterval late=[d timeIntervalSince1970]*1;
                        
                        
                        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                        NSTimeInterval now=[dat timeIntervalSince1970]*1;
                        NSString *timeString=times;
                        
                        NSTimeInterval cha=now-late;
                        //liuxiaofeng
                        if(cha/60<1 &&cha/60>0) {
                            timeString = [NSString stringWithFormat:@"%f", cha];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=@"刚刚";
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        
                        
                        if (cha/3600<1) {
                            timeString = [NSString stringWithFormat:@"%f", cha/60];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        if (cha/3600>1&&cha/86400<1) {
                            timeString = [NSString stringWithFormat:@"%f", cha/3600];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@小时前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                        }
                        if (cha/86400>1)
                        {
                            timeString = [NSString stringWithFormat:@"%f", cha/86400];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@天前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        
                        
                    }
                    
                }

                cell1.huiTimeCount.textAlignment=NSTextAlignmentLeft;
                
                //回复
                cell1.huiBtn.frame = CGRectMake(self.view.bounds.size.width-35,CGRectGetMaxY(cell1.contentLabel.frame)+2, 35, 15);
                [cell1.huiBtn setTitle:@"回复" forState:UIControlStateNormal];
                [cell1.huiBtn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
                [cell1.huiBtn setTitleColor:RGBA(173, 172, 173, 1) forState:UIControlStateNormal];
                [cell1.huiBtn setFont:[UIFont fontWithName:@"Microsoft Yahei UI" size:10]];
                [cell1.huiBtnimg setBackgroundImage:[UIImage imageNamed:@"回复楼主"] forState:UIControlStateNormal];
                [cell1.huiBtnimg addTarget:self action:@selector(clicksend:) forControlEvents:UIControlEventTouchUpInside];
                
                cell1.huiBtnimg.frame=CGRectMake(CGRectGetMaxX(cell1.huiBtn.frame)-43,CGRectGetMaxY(cell1.contentLabel.frame)+5, 12, 12);
                

            }else{
                
                cell1.contentimage.frame = CGRectMake(10,CGRectGetMaxY(cell1.contentLabel.frame)+5, (SCREEN_WIDTH-20)/2, 100);
                cell1.view4.frame = CGRectMake(10,cell1.contentimage.frame.origin.y+cell1.contentimage.frame.size.height+4, SCREEN_WIDTH-20, 2);
                
                //内容
                //内容下面的展示内容
                cell1.huiTime.frame = CGRectMake(10,CGRectGetMaxY(cell1.contentimage.frame)+12, 10, 10);
                cell1.huiTime.layer.masksToBounds = YES;
                cell1.huiTime.layer.cornerRadius =  cell1.huiTime.bounds.size.width/2;
                cell1.huiTime.image = [UIImage imageNamed:@"小表"];
                cell1.huiTimeCount.frame = CGRectMake(28,CGRectGetMaxY(cell1.contentimage.frame)+10, 150, 15);
                //cell1.huiTimeCount.text=@"3个小时前";
                cell1.huiTimeCount.textAlignment=NSTextAlignmentLeft;
                
                //回复
                
                
                
                if([times length]==0){
                    cell1.huiTimeCount.text=@"时间丢失";
                }else{
                    if([times length]==8){
                        NSLog(@"ooooo");
                        //时间格式20140430
                        //解析时间
                        
                        NSDateFormatter *date=[[NSDateFormatter alloc] init];
                        [date setDateFormat:@"yyyyMMddHHmmss"];
                        NSDate *d=[date dateFromString:times];
                        
                        NSTimeInterval late=[d timeIntervalSince1970]*1;
                        
                        
                        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                        NSTimeInterval now=[dat timeIntervalSince1970]*1;
                        NSString *timeString=times;
                        
                        NSTimeInterval cha=now-late;
                        //liuxiaofeng刚刚出不来
                        if(cha/60<1&&cha/60>0) {
                            cell1.huiTimeCount.text=@"刚刚";
                            
                            
                        }
                        NSLog(@"cha is %f",cha);
                        if (cha/3600<1) {
                            timeString = [NSString stringWithFormat:@"%f", cha/60];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        if (cha/3600>1&&cha/86400<1) {
                            timeString = [NSString stringWithFormat:@"%f", cha/3600];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@小时前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                        }
                        if (cha/86400>1)
                        {
                            timeString = [NSString stringWithFormat:@"%f", cha/86400];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@天前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        
                        
                        
                    }else{
                        //时间格式2015-12-04 18：39：23
                        //得到当前系统时间
                        //特定时间
                        
                        NSDateFormatter *date=[[NSDateFormatter alloc] init];
                        [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSDate *d=[date dateFromString:times];
                        
                        NSTimeInterval late=[d timeIntervalSince1970]*1;
                        
                        
                        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                        NSTimeInterval now=[dat timeIntervalSince1970]*1;
                        NSString *timeString=times;
                        
                        NSTimeInterval cha=now-late;
                        //liuxiaofeng
                        if(cha/60<1 &&cha/60>0) {
                            timeString = [NSString stringWithFormat:@"%f", cha];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=@"刚刚";
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        
                        
                        if (cha/3600<1) {
                            timeString = [NSString stringWithFormat:@"%f", cha/60];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        if (cha/3600>1&&cha/86400<1) {
                            timeString = [NSString stringWithFormat:@"%f", cha/3600];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@小时前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                        }
                        if (cha/86400>1)
                        {
                            timeString = [NSString stringWithFormat:@"%f", cha/86400];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@天前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        
                        
                    }
                    
                }

                cell1.huiBtn.frame = CGRectMake(self.view.bounds.size.width-35,CGRectGetMaxY(cell1.contentimage.frame)+10, 35, 15);
                [cell1.huiBtn setTitle:@"回复" forState:UIControlStateNormal];
                [cell1.huiBtn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
                [cell1.huiBtn setTitleColor:RGBA(173, 172, 173, 1) forState:UIControlStateNormal];
                [cell1.huiBtn setFont:[UIFont fontWithName:@"Microsoft Yahei UI" size:10]];
                [cell1.huiBtnimg setBackgroundImage:[UIImage imageNamed:@"回复楼主"] forState:UIControlStateNormal];
                [cell1.huiBtnimg addTarget:self action:@selector(clicksend:) forControlEvents:UIControlEventTouchUpInside];
                
                cell1.huiBtnimg.frame=CGRectMake(CGRectGetMaxX(cell1.huiBtn.frame)-43,CGRectGetMaxY(cell1.contentimage.frame)+12, 10, 10);
                
                //点赞
                

//                
            }
            
            
            
        }else{
            //有回复idf
            
      //      }

    
        

        
        

            NSLog(@"%@",hid);
            //
            //添加昵称
            cell1.userNameLab.text = [dic objectForKey:@"nicheng"];
            [cell1.userNameLab setFrame:CGRectMake(cell1.userHeadImg.frame.origin.x+cell1.userHeadImg.frame.size.width+10, 14,SCREEN_WIDTH-60 ,15)];
            
            
            //怀孕时间
            cell1.timeLab.text = @"孕15周3天";
            cell1.timeLab.frame = CGRectMake(cell1.userHeadImg.frame.origin.x+cell1.userHeadImg.frame.size.width+10, cell1.userNameLab.frame.origin.y+cell1.userNameLab.frame.size.height+5, 60, 12);
            
            //内容
            NSString *text = [[self.huiFuArr objectAtIndex:indexPath.row-1] objectForKey:@"neirong"];
            cell1.contentLabel.frame=CGRectMake(10,CGRectGetMaxY(cell1.userHeadImg.frame)+10, SCREEN_WIDTH-20, [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(SCREEN_WIDTH-40, 10000) lineBreakMode:NSLineBreakByWordWrapping].height);
            
            contents=cell1.contentLabel.bounds.size.height;
            cell1.contentLabel.numberOfLines=0;
            cell1.contentLabel.text=text;
            //判断图片
            NSString *lujing=[NSString stringWithFormat:@"%@",[dic objectForKey:@"lujing"]];
            NSString *string=[NSString stringWithFormat:@""];
            
            
            //判断路径是否为空
            if([lujing isEqualToString:string]){
                NSLog(@"为空");
                //布局
#pragma mark 回复回复的布局
                //有hid需要布局
                //当前详细时间
                NSString *text;
                for(int i=0;i<self.huiFuArr.count;i++){
                    NSString *hidss;
                    NSString *huifuid;
                    for(int j=0;j<self.huiFuArr.count;j++){
                        hidss=[self.huiFuArr [j] objectForKey:@"hid"];
                        huifuid=[self.huiFuArr [i] objectForKey:@"huifuid"];
                        NSLog(@"%@,%@",hidss,huifuid);
                        
                        if([hidss isEqual:huifuid]){
                            // NSLog(@"====%@",array13[j]);
                            
                            text=[[self.huiFuArr objectAtIndex:i] objectForKey:@"neirong"];                        NSLog(@"=======%@",text);
                            NSMutableArray *arrayssss=[[NSMutableArray alloc]initWithCapacity:0];
                            [arrayssss addObject:text];
                            NSLog(@"arrayssss%@",arrayssss);
                            
                            
                            
                        }
                        
                    }
                    
                    
                    
                }

                
                
                
                //NSString *text = [[self.huiFuArr objectAtIndex:indexPath.row-1] objectForKey:@"neirong"];
                
                cell1.huibagimage.userInteractionEnabled=NO;
                cell1.huibagimage.text=text;
                cell1.huibagimage.frame=CGRectMake(10,CGRectGetMaxY(cell1.contentLabel.frame)+5, SCREEN_WIDTH-20, [text sizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:CGSizeMake(SCREEN_WIDTH-40, 10000) lineBreakMode:NSLineBreakByWordWrapping].height+15);
                cell1.huibagimage.backgroundColor=[UIColor redColor];
                hidContent=cell1.huibagimage.bounds.size.height;
                
                UIImageView *imageViews = [[UIImageView alloc] initWithFrame:[cell1.huibagimage bounds]];
                
                imageViews.image = [UIImage imageNamed:@"回帖框"];
                
                [cell1.huibagimage addSubview:imageViews];
                cell1.huibagimage.backgroundColor=[UIColor clearColor];
                
                [cell1.huibagimage sendSubviewToBack:imageViews];

                //内容下面的展示内容
                cell1.huiTime.frame = CGRectMake(10,CGRectGetMaxY(cell1.huibagimage.frame)+12, 10, 10);
                cell1.huiTime.layer.masksToBounds = YES;
                cell1.huiTime.layer.cornerRadius =  cell1.huiTime.bounds.size.width/2;
                cell1.huiTime.image = [UIImage imageNamed:@"小表"];
                cell1.huiTimeCount.frame = CGRectMake(28,CGRectGetMaxY(cell1.huibagimage.frame)+10, 150, 15);
                //cell1.huiTimeCount.text=@"3个小时前";
                
                if([times length]==0){
                    cell1.huiTimeCount.text=@"时间丢失";
                }else{
                    if([times length]==8){
                        NSLog(@"ooooo");
                        //时间格式20140430
                        //解析时间
                        
                        NSDateFormatter *date=[[NSDateFormatter alloc] init];
                        [date setDateFormat:@"yyyyMMddHHmmss"];
                        NSDate *d=[date dateFromString:times];
                        
                        NSTimeInterval late=[d timeIntervalSince1970]*1;
                        
                        
                        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                        NSTimeInterval now=[dat timeIntervalSince1970]*1;
                        NSString *timeString=times;
                        
                        NSTimeInterval cha=now-late;
                        //liuxiaofeng刚刚出不来
                        if(cha/60<1&&cha/60>0) {
                            cell1.huiTimeCount.text=@"刚刚";
                            
                            
                        }
                        NSLog(@"cha is %f",cha);
                        if (cha/3600<1) {
                            timeString = [NSString stringWithFormat:@"%f", cha/60];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        if (cha/3600>1&&cha/86400<1) {
                            timeString = [NSString stringWithFormat:@"%f", cha/3600];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@小时前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                        }
                        if (cha/86400>1)
                        {
                            timeString = [NSString stringWithFormat:@"%f", cha/86400];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@天前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        
                        
                        
                    }else{
                        //时间格式2015-12-04 18：39：23
                        //得到当前系统时间
                        //特定时间
                        
                        NSDateFormatter *date=[[NSDateFormatter alloc] init];
                        [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSDate *d=[date dateFromString:times];
                        
                        NSTimeInterval late=[d timeIntervalSince1970]*1;
                        
                        
                        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                        NSTimeInterval now=[dat timeIntervalSince1970]*1;
                        NSString *timeString=times;
                        
                        NSTimeInterval cha=now-late;
                        //liuxiaofeng
                        if(cha/60<1 &&cha/60>0) {
                            timeString = [NSString stringWithFormat:@"%f", cha];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=@"刚刚";
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        
                        
                        if (cha/3600<1) {
                            timeString = [NSString stringWithFormat:@"%f", cha/60];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        if (cha/3600>1&&cha/86400<1) {
                            timeString = [NSString stringWithFormat:@"%f", cha/3600];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@小时前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                        }
                        if (cha/86400>1)
                        {
                            timeString = [NSString stringWithFormat:@"%f", cha/86400];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@天前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        
                        
                    }
                    
                }

                cell1.huiTimeCount.textAlignment=NSTextAlignmentLeft;
                
                //回复
                cell1.huiBtn.frame = CGRectMake(self.view.bounds.size.width-35,CGRectGetMaxY(cell1.huibagimage.frame)+10, 35, 15);
                [cell1.huiBtn setTitle:@"回复" forState:UIControlStateNormal];
                [cell1.huiBtn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
                [cell1.huiBtn setTitleColor:RGBA(173, 172, 173, 1) forState:UIControlStateNormal];
                [cell1.huiBtn setFont:[UIFont fontWithName:@"Microsoft Yahei UI" size:10]];
                [cell1.huiBtnimg setBackgroundImage:[UIImage imageNamed:@"回复楼主"] forState:UIControlStateNormal];
                [cell1.huiBtnimg addTarget:self action:@selector(clicksend:) forControlEvents:UIControlEventTouchUpInside];
                
                cell1.huiBtnimg.frame=CGRectMake(CGRectGetMaxX(cell1.huiBtn.frame)-43,CGRectGetMaxY(cell1.huibagimage.frame)+12, 10, 10);

                
            }else{
                
                cell1.contentimage.frame = CGRectMake(10,cell1.contentLabel.frame.origin.y+cell1.contentLabel.frame.size.height+5, SCREEN_WIDTH-80, 100);
                
                [cell1.contentimage setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"lujing"]] placeholderImage:[UIImage imageNamed:@"未标题-4-01"]];
#pragma mark 回复回复的布局

                
                NSString *text = [[self.huiFuArr objectAtIndex:indexPath.row-1] objectForKey:@"neirong"];
                cell1.huibagimage.frame=CGRectMake(10,CGRectGetMaxY(cell1.contentimage.frame)+5, SCREEN_WIDTH-20, [text sizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:CGSizeMake(SCREEN_WIDTH-40, 10000) lineBreakMode:NSLineBreakByWordWrapping].height+15);
                cell1.huibagimage.backgroundColor=[UIColor redColor];
                hidContent=cell1.huibagimage.bounds.size.height;
                cell1.huibagimage.userInteractionEnabled=NO;
                cell1.huibagimage.text=text;
                
                UIImageView *imageViews = [[UIImageView alloc] initWithFrame:[cell1.huibagimage bounds]];
                
                imageViews.image = [UIImage imageNamed:@"回帖框"];
                
                [cell1.huibagimage addSubview:imageViews];
                cell1.huibagimage.backgroundColor=[UIColor clearColor];
                
                [cell1.huibagimage sendSubviewToBack:imageViews];

                
                //内容下面的展示内容
                cell1.huiTime.frame = CGRectMake(10,CGRectGetMaxY(cell1.huibagimage.frame)+12, 10, 10);
                cell1.huiTime.layer.masksToBounds = YES;
                cell1.huiTime.layer.cornerRadius =  cell1.huiTime.bounds.size.width/2;
                cell1.huiTime.image = [UIImage imageNamed:@"小表"];
                cell1.huiTimeCount.frame = CGRectMake(28,CGRectGetMaxY(cell1.huibagimage.frame)+10, 150, 15);
                cell1.huiTimeCount.text=[[self.huiFuArr objectAtIndex:indexPath.row-1] objectForKey:@"time"];
                //cell1.huiTimeCount.text=@"3个小时前";
                
                if([times length]==0){
                    cell1.huiTimeCount.text=@"时间丢失";
                }else{
                    if([times length]==8){
                        NSLog(@"ooooo");
                        //时间格式20140430
                        //解析时间
                        
                        NSDateFormatter *date=[[NSDateFormatter alloc] init];
                        [date setDateFormat:@"yyyyMMddHHmmss"];
                        NSDate *d=[date dateFromString:times];
                        
                        NSTimeInterval late=[d timeIntervalSince1970]*1;
                        
                        
                        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                        NSTimeInterval now=[dat timeIntervalSince1970]*1;
                        NSString *timeString=times;
                        
                        NSTimeInterval cha=now-late;
                        //liuxiaofeng刚刚出不来
                        if(cha/60<1&&cha/60>0) {
                            cell1.huiTimeCount.text=@"刚刚";
                            
                            
                        }
                        NSLog(@"cha is %f",cha);
                        if (cha/3600<1) {
                            timeString = [NSString stringWithFormat:@"%f", cha/60];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        if (cha/3600>1&&cha/86400<1) {
                            timeString = [NSString stringWithFormat:@"%f", cha/3600];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@小时前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                        }
                        if (cha/86400>1)
                        {
                            timeString = [NSString stringWithFormat:@"%f", cha/86400];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@天前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        
                        
                        
                    }else{
                        //时间格式2015-12-04 18：39：23
                        //得到当前系统时间
                        //特定时间
                        
                        NSDateFormatter *date=[[NSDateFormatter alloc] init];
                        [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSDate *d=[date dateFromString:cell1.huiTimeCount.text];
                        NSLog(@"%@",cell1.huiTimeCount.text);
                        NSTimeInterval late=[d timeIntervalSince1970]*1;
                        
                        
                        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                        NSTimeInterval now=[dat timeIntervalSince1970]*1;
                        NSString *timeString=times;
                        
                        NSTimeInterval cha=now-late;
                        //liuxiaofeng
                        if(cha/60<1 &&cha/60>0) {
                            timeString = [NSString stringWithFormat:@"%f", cha];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=@"刚刚";
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        
                        
                        if (cha/3600<1) {
                            timeString = [NSString stringWithFormat:@"%f", cha/60];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        if (cha/3600>1&&cha/86400<1) {
                            timeString = [NSString stringWithFormat:@"%f", cha/3600];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@小时前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                        }
                        if (cha/86400>1)
                        {
                            timeString = [NSString stringWithFormat:@"%f", cha/86400];
                            timeString = [timeString substringToIndex:timeString.length-7];
                            timeString=[NSString stringWithFormat:@"%@天前", timeString];
                            cell1.huiTimeCount.text=[NSString stringWithFormat:@"%@",timeString];
                            
                            
                        }
                        
                        
                    }
                    
                }

                cell1.huiTimeCount.textAlignment=NSTextAlignmentLeft;
                
                //回复
                cell1.huiBtn.frame = CGRectMake(self.view.bounds.size.width-35,CGRectGetMaxY(cell1.huibagimage.frame)+10, 35, 15);
                [cell1.huiBtn setTitle:@"回复" forState:UIControlStateNormal];
                [cell1.huiBtn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
                [cell1.huiBtn setTitleColor:RGBA(173, 172, 173, 1) forState:UIControlStateNormal];
                [cell1.huiBtn setFont:[UIFont fontWithName:@"Microsoft Yahei UI" size:10]];
                [cell1.huiBtnimg setBackgroundImage:[UIImage imageNamed:@"回复楼主"] forState:UIControlStateNormal];
                [cell1.huiBtnimg addTarget:self action:@selector(clicksend:) forControlEvents:UIControlEventTouchUpInside];
                
                cell1.huiBtnimg.frame=CGRectMake(CGRectGetMaxX(cell1.huiBtn.frame)-43,CGRectGetMaxY(cell1.huibagimage.frame)+12, 10, 10);


                
            }
        }
        return cell1;
    }
}
//- (void)buttonClick:(UIButton *)button
//{
//    fatietuView *view=[[fatietuView alloc]init];
//    NSLog(@"点击放大");
//    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
//    browser.sourceImagesContainerView = self; // 原图的父控件
//    browser.imageCount = view.images.count; // 图片总数
//    browser.currentImageIndex = button.tag;
//    browser.delegate = self;
//    [browser show];
//    
//}

-(void)goBack:(UIButton *)sender1
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)diaohuifu{
    [_textView becomeFirstResponder];
    flag=YES;
}
-(void)AFNetWorking
{
    //int a=2;
    self.manager =[AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [self getTieZiData];
    [self getHuFuData];

    
}

#pragma mark 加载帖子详细数据
-(void)getTieZiData{
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/tiezi/list.do" parameters:@{@"tid":self.TidCount} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",_TidCount);
        NSData *data = (NSData *)responseObject;
//        NSLog(@"******hahah%@",data);
        self.dataArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"帖子---====---%@",self.dataArr);
//        NSLog(@"=====%ld",(long)[self.dataArr count]);
//        NSLog(@"帖子======%ld",[self.dataArr  count]);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
}
#pragma mark 加载帖子回复的详细信息
-(void)getHuFuData{
    NSLog(@"%@",self.quanziID);
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]initWithCapacity:0];
    [dic1 setObject:self.TidCount forKey:@"tid"];
    //[dic1 setObject:@"1" forKey:@"quanziid"];
    
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/huifu/list.do" parameters:dic1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       // NSLog(@"########====%@",self.TidCount);
        NSData *data = (NSData *)responseObject;
       // NSLog(@"======%@",data);
        self.huiFuArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"回复**************%@",self.huiFuArr);
//        NSLog(@"回复======%ld",[self.huiFuArr  count]);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
}
#pragma  mark回复帖子
-(void)gethuifuTiezi{
    //得到当前时间
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSString *chenggong=_textView.text;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]initWithCapacity:0];

    [dic1 setObject:@"" forKey:@"lujing"];
    [dic1 setObject:self.TidCount forKey:@"tid"];
    //[dic1 setObject:@"1" forKey:@"quanziid"];
    [dic1 setObject:@"1" forKey:@"huifuid"];
    [dic1 setObject:chenggong forKey:@"neirong"];
    NSLog(@"内容是%@",chenggong);
    [dic1 setObject:locationString forKey:@"time"];
    [dic1 setObject:self.TidCount forKey:@"tid"];
    [dic1 setObject:_userIdss forKey:@"userid"];
    NSLog(@"内容是==%@",_textView.text);
    NSLog(@"时间是==%@",locationString);
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/huifu/save.do" parameters:dic1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //   [self goBack];
        NSLog(@"成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
    }];
}
//帖子收藏
-(void)getShoucang{

}
#pragma 回复帖子图片
//回复帖子点击时候实现
-(void)getHuFuTiezi{
   // NSLog(@"%@",self.quanziID);
    //上传图片
    NSString *server_base =@"http://101.200.234.127:8080/YanLu/huifu/upload.do";
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:server_base]];
    
    [request addData:_data  withFileName:[NSString stringWithFormat:@"%d.png",1] andContentType:@"image/jpg" forKey:@"fileName"];
    NSLog(@"%@",_data);
    
//    NSLog(@"request-----%@",request.responseString);
    
    [request setCompletionBlock:^{
        
        NSLog(@"request-----成功%@",request.responseString);
        NSLog(@"@=====成功");

//        NSLog(@"request2-----%@",request.responseData);


    }];
    [request setFailedBlock:^{
        NSLog(@"asi error: %@",request.error.debugDescription);
    }];
    [request startAsynchronous];
    
    
   }


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(self.dataArr.count){
        return self.huiFuArr.count+1;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    counts=indexPath.row;
    
    if(flag){
        [_textView resignFirstResponder];
        
        flag=NO;
        
    }else{
        
        flag=YES;
        
        [UIView beginAnimations:@"Animation" context:nil];
        //设置动画的间隔时间
        [UIView setAnimationDuration:0.20];
        //??使用当前正在运行的状态开始下一段动画
        [UIView setAnimationBeginsFromCurrentState: YES];
        //设置视图移动的位移
        if (indexPath.row == 0) {
            self.tableView.contentOffset = CGPointMake(0, 0);
        }
        else if(indexPath.row == 1)
        {
            self.tableView.contentOffset = CGPointMake(0, size1.height+260);
        }
        else
        {
            CGFloat height = 0;
            for (int i = 0; i<indexPath.row-1; i++) {
                height = size3.height + height;
                //NSLog(@"sssssssss%lf",size1.height);
            }
            //当前的坐标
            self.tableView.contentOffset = CGPointMake(0, (indexPath.row-1)*55+height+size1.height+260);
        }
        //设置动画结束
        [UIView commitAnimations];
        [_textView becomeFirstResponder];
        //liuxiaofeng
        
        if(indexPath.row>0){
            hid=[[_huiFuArr objectAtIndex:indexPath.row-1]objectForKey:@"huifuid"];
            NSLog(@"回复当前点击的时%@",hid);
            
            label.text=[NSString stringWithFormat:@"回复%@：",[[_huiFuArr objectAtIndex:indexPath.row-1] objectForKey:@"nicheng"]];

        }
        
        //self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        //toolBar.frame=CGRectMake(0,0, ScreenWidth,53);
         toolBar.backgroundColor=RGBA(214, 214, 214, 1);
        //    if(xiaoView.frame.size.height>30){
        if(status == NO){
            toolBar.frame=CGRectMake(0, self.view.frame.size.height - (250 + toolBar.frame.size.height), ScreenWidth,53);
        }else{
            toolBar.frame=CGRectMake(0, self.view.frame.size.height - (180 + toolBar.frame.size.height), ScreenWidth,53);
        }
        
        
        
    }
    NSLog(@"%ld",(long)counts);
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {

        NSString *lujing=[NSString stringWithFormat:@"%@",[dict objectForKey:@"lujing"]];
        NSString *string=[NSString stringWithFormat:@""];
        if([lujing isEqualToString:string]){
            return contentXiang+80;
        }else{
            
            
            if(imgArr.count>0 &&imgArr.count<4){
                return 80+60+contentXiang+30;
                
                //一行的高度
            }else if(imgArr.count>3&&imgArr.count<7){
                //两行
                return 165+60+contentXiang+30;
                
            }else if(imgArr.count>6&&imgArr.count<10){
                return 250+60+contentXiang+30;
                
            }

            return contentXiang+80;
        }
        
    }else{

        NSString *lujing=[NSString stringWithFormat:@"%@",[dic objectForKey:@"lujing"]];
        NSString *string=[NSString stringWithFormat:@""];
        NSString *strings=[NSString stringWithFormat:@"0"];
        NSString *uids=[NSString stringWithFormat:@"%@",[dic objectForKey:@"hid"]];
        //判断图片路径
        if([lujing isEqualToString:string]){
            if(![uids isEqualToString:strings]){
                NSLog(@"%d",sizes);
                return contents+hidContent+90;
            }else{
                return content+75;
     
            }
            
            
        }else{
            if(![uids isEqualToString:strings]){
                return contents+hidContent+195;
            }else{
                return content+hidContent+190;
                //return 30;
            }
            
        }
        
    }
}

-(void)bottomViewLayoutUI{
    NSLog(@"---%f",ScreenHeight);
    //底视图

    toolBar =[[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-(60+53), self.view.bounds.size.width, 53)];
    NSLog(@"uiviw is %ld",(long)[UIScreen mainScreen].bounds.size.height);

    [self.view addSubview:toolBar];
    //图片按钮
    keyboardButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    keyboardButton.tag=100;
    [keyboardButton setFrame:CGRectMake(8,toolBar.frame.size.height/2-15, 23, 23)];
     [keyboardButton setBackgroundImage:[UIImage imageNamed:@"表情"] forState:UIControlStateNormal];
    [keyboardButton addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:keyboardButton];
    //照片按钮
    picterBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [picterBtn setFrame:CGRectMake(keyboardButton.bounds.size.width+13, toolBar.frame.size.height/2-15, 26, 22)];
     [picterBtn setBackgroundImage:[UIImage imageNamed:@"拍照"] forState:UIControlStateNormal];
    [picterBtn addTarget:self action:@selector(clickPicker) forControlEvents:UIControlEventTouchUpInside];

    [toolBar addSubview:picterBtn];

    xiaoView=[[UIView alloc]init];
    xiaoView.backgroundColor=[UIColor whiteColor];
    xiaoView.layer.borderColor=[UIColor whiteColor].CGColor;
    xiaoView.layer.borderWidth=1;
    _textView=[[UITextView alloc]init];
    //_textView.


   _textView.delegate=self;
    hight_text_one = [_textView.layoutManager usedRectForTextContainer:_textView.textContainer].size.height;
    
    
    
    xiaoView.frame=CGRectMake(66, 6,toolBar.bounds.size.width-73, hight_text_one+23);
    _textView.frame=CGRectMake(0, 0,xiaoView.bounds.size.width-30, hight_text_one+23);
    xiaoView.backgroundColor=[UIColor whiteColor];
    
    xiaoView.layer.masksToBounds = YES;
    xiaoView.layer.cornerRadius=6;
    //_textView.layer.borderColor=[UIColor blackColor].CGColor;
    
    [xiaoView addSubview:_textView];
    [toolBar addSubview:xiaoView];

    //回复按钮
    sendButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sendButton setFrame:CGRectMake(xiaoView.bounds.size.width+xiaoView.bounds.origin.x-30,toolBar.frame.size.height/2-20, 29, 23)];
    [sendButton setBackgroundImage:[UIImage imageNamed:@"回复楼主"] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(clicksend:) forControlEvents:UIControlEventTouchUpInside];
    sendButton.userInteractionEnabled=YES;
    
   // [sendButton setBackgroundColor:[UIColor blackColor]];
    [xiaoView addSubview:sendButton];

    
    
    isFirstShowKeyboard = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    
    //实现plahold效果
    label = [[UILabel alloc]initWithFrame:CGRectMake(3, 5, 200, 20)];
    label.enabled = YES;
    label.text = @"回复楼主";
    label.font =  [UIFont systemFontOfSize:15];
    label.textColor = RGBA(199, 199, 205, 1);
    [self.textView addSubview:label];

    

}



#pragma mark - text View Delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(![textView hasText] && [text isEqualToString:@""]) {
        return NO;
    }
    if ([text isEqualToString:@"\n"]) {
        //        [self sendMessage];
        return YES;
    }
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView{
    flag = YES;
    [self textViewChangeText:textView];
    
//    if ([textView.text length] == 0) {
//        [label setHidden:NO];
//    }else{
//        [label setHidden:YES];
//    }

}

-(void)textViewChangeText:(UITextView *)textView{
    CGFloat h = [textView.layoutManager usedRectForTextContainer:textView.textContainer].size.height;
    textView.contentSize = CGSizeMake(textView.contentSize.width, h+25);
//    textView.backgroundColor = [UIColor greenColor];
    CGFloat five_h = hight_text_one*4.0f;
    h = h>five_h?five_h:h;
    CGRect frame = textView.frame;
    if (frame.size.height == h+25) {
        if (h == five_h) {
            [textView setContentOffset:CGPointMake(0, textView.contentSize.height - h - 25) animated:NO];
        }
        return;
    }
    
    frame.size.height = h+25;
    textView.frame = frame;
    
    //    [self topLayoutSubViewWithH:(frame.size.height+diff)];
    [textView setContentOffset:CGPointZero animated:YES];
    
    NSLog(@"--%f",textView.frame.size.height);
    
    if(status == NO){
        xiaoView.frame=CGRectMake(xiaoView.frame.origin.x,xiaoView.frame.origin.y, toolBar.bounds.size.width-73, textView.frame.size.height);
        toolBar.frame=CGRectMake(0,self.view.frame.size.height-(251+53),self.view.bounds.size.width,textView.frame.size.height+16);
    }else{
        xiaoView.frame=CGRectMake(xiaoView.frame.origin.x,xiaoView.frame.origin.y, toolBar.bounds.size.width-73, textView.frame.size.height);
        toolBar.frame=CGRectMake(0,self.view.frame.size.height-(180+53),self.view.bounds.size.width,textView.frame.size.height+16);
        
    }

    
    
    
    
    NSLog(@"————————%f",xiaoView.bounds.origin.y);
}
#pragma mark 键盘按钮点击事件

-(void)test:(UIButton*)sender
{
   // states=NO;
    sender.tag=!sender.tag;
    
    if (sender.tag) {
        //得到第一响应者的身份
        self.textView.inputView=nil;
        [self.textView reloadInputViews];
       // [self.textView becomeFirstResponder];
       [self.textView becomeFirstResponder];
            if (status == NO) {

                
                NSLog(@"========");
                toolBar.frame=CGRectMake(0, self.view.frame.size.height - (180 + toolBar.frame.size.height), ScreenWidth,53);
                if(xiaoView.frame.size.height>30){
                toolBar.frame=CGRectMake(0, self.view.frame.size.height - (180 + toolBar.frame.size.height), ScreenWidth,53);
                }
                
                status = YES;

            }else{

                toolBar.frame=CGRectMake(0, self.view.frame.size.height - (251 + toolBar.frame.size.height), ScreenWidth,53);
                if(xiaoView.frame.size.height>30){
                    toolBar.frame=CGRectMake(0, self.view.frame.size.height - (251 + toolBar.frame.size.height), ScreenWidth,53);

                }
                
                NSLog(@"+++++++++");

                status = NO;
            }
        // [self textViewDidBeginEditing:self.textView];
    }else {
        
        
        //放弃第一响应者的身份
        [self.textView resignFirstResponder];
        
        //初始化滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
        for (int i=0; i<4; i++)
        {
            //初始化添加表情的视图
            FacialView *fview = [[FacialView alloc] initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, 180)];
            
            //调用FacialView类中的该方法
            [fview loadFacialView:i size:CGSizeMake(ScreenWidth/7, 45)];
            //添加代理
            fview.delegate = self;
            //将FacialView添加到滚动视图上
            [scrollView addSubview:fview];
        }
        //设置滚动视图的尺寸
        scrollView.contentSize = CGSizeMake(ScreenWidth*4, 180);
        //设置scrollView滚动
        scrollView.pagingEnabled = YES;
        self.textView.inputView = scrollView;
        keyboardHeight=scrollView.frame.size.height;
        //        //获取第一响应者身份
        [self.textView becomeFirstResponder];

        [UIView animateWithDuration:0.35 animations:^{
            if (status == NO) {

                toolBar.frame=CGRectMake(0, self.view.frame.size.height - (180 + toolBar.frame.size.height), ScreenWidth,53);
                if(xiaoView.frame.size.height>30){
                    toolBar.frame=CGRectMake(0, self.view.frame.size.height - (180 + toolBar.frame.size.height), ScreenWidth,53);
                }
                
                status = YES;
                
            }else{
                //self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
                toolBar.frame=CGRectMake(0, self.view.frame.size.height - (251 + toolBar.frame.size.height), ScreenWidth,53);
                if(xiaoView.frame.size.height>30){
                    toolBar.frame=CGRectMake(0, self.view.frame.size.height - (251 + toolBar.frame.size.height), ScreenWidth,53);
                    
                }
                
                NSLog(@"+++++++++");
                
                status = NO;
            }
        }];
        [self textViewDidBeginEditing:self.textView];
        [self.textView becomeFirstResponder];
    }
    
    
}


//点击发送图片
-(void)clickPicker{
    NSLog(@"图片");
    [self openMenu];
    
    
}

//得到键盘
-(void)onClick{
    if(flags){
        [_textView resignFirstResponder];
    }else{
    [_textView becomeFirstResponder];
    }
    flags=!flags;
}
//点击发送
-(void)clicksend:(id)sender{
    
    
    BOOL needReload = NO;
    if ( ![_textView.text isEqualToString:@"" ] || picterBtn.userInteractionEnabled==NO)
    {
        
        needReload = YES;
        //当图片按钮警用的时候说明图片已经选择
        if(picterBtn.userInteractionEnabled==NO)
        {
            NSLog(@"hhhhhhhhh");
            //上传图片路径
            
            //判断是否有hid
            if(counts==0){
                
                //没有hid
                //得到hid
                //上传图片
                NSString *server_base =@"http://101.200.234.127:8080/YanLu/huifu/upload.do";
                
                ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:server_base]];
                
                [request addData:_data  withFileName:[NSString stringWithFormat:@"%d.png",1] andContentType:@"image/jpg" forKey:@"fileName"];
                NSLog(@"%@",filePath);
                
                //    NSLog(@"request-----%@",request.responseString);
                NSString *chenggong=_textView.text;
                NSLog(@"%@ is hhh",chenggong);
                
                
                [request setCompletionBlock:^{
                    
                    NSLog(@"request-----成功%@",request.responseString);
                    NSLog(@"@=====成功");
                    
                    //        NSLog(@"request2-----%@",request.responseData);
                    //得到当前时间
                    NSDate *  senddate=[NSDate date];
                    
                    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                    
                    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                    
                    NSString *  locationString=[dateformatter stringFromDate:senddate];
                    
                    
                    NSString *string=request.responseString;
                    NSLog(@"%@",string);
                    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]initWithCapacity:0];
                    
                    [dic1 setObject:string forKey:@"lujing"];
                    [dic1 setObject:self.TidCount forKey:@"tid"];
                    //[dic1 setObject:@"1" forKey:@"quanziid"];
                    [dic1 setObject:@"1" forKey:@"huifuid"];
                    [dic1 setObject:chenggong forKey:@"neirong"];
                    NSLog(@"内容是%@",chenggong);
                    [dic1 setObject:locationString forKey:@"time"];
                    [dic1 setObject:self.TidCount forKey:@"tid"];
                    [dic1 setObject:_userIdss forKey:@"userid"];
                    NSLog(@"%@",_userId);
                    NSLog(@"内容是==%@",_textView.text);
                    NSLog(@"时间是==%@",locationString);
                    self.manager = [AFHTTPRequestOperationManager manager];
                    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
                    
                    [self.manager POST:@"http://101.200.234.127:8080/YanLu/huifu/save.do" parameters:dic1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        //   [self goBack];
                        NSLog(@"成功");
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"失败");
                    }];
                    
                    
                }];
                [request setFailedBlock:^{
                    NSLog(@"asi error: %@",request.error.debugDescription);
                }];
                [request startAsynchronous];

                
            
            }else{
                //有hid
                //上传图片
                NSString *server_base =@"http://101.200.234.127:8080/YanLu/huifu/upload.do";
                
                ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:server_base]];
                
                [request addData:_data  withFileName:[NSString stringWithFormat:@"%d.png",1] andContentType:@"image/jpg" forKey:@"fileName"];
                NSLog(@"%@",filePath);
                
                //    NSLog(@"request-----%@",request.responseString);
                
                
                
                
                [request setCompletionBlock:^{
                    
                    NSLog(@"request-----成功%@",request.responseString);
                    NSLog(@"@=====成功");
                    
                    //        NSLog(@"request2-----%@",request.responseData);
                    //得到当前时间
                    NSDate *  senddate=[NSDate date];
                    
                    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                    
                    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                    
                    NSString *  locationString=[dateformatter stringFromDate:senddate];
                    NSString *chenggong=_textView.text;
                    NSLog(@"neirong is%@",_textView.text);
                    NSString *string=request.responseString;
                    NSLog(@"%@",string);
                    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]initWithCapacity:0];
                    
                    [dic1 setObject:string forKey:@"lujing"];
                    [dic1 setObject:self.TidCount forKey:@"tid"];
                    //[dic1 setObject:@"1" forKey:@"quanziid"];
                    [dic1 setObject:@"1" forKey:@"huifuid"];
                    [dic1 setObject:hid forKey:@"hid"];
                    [dic1 setObject:chenggong forKey:@"neirong"];
                    [dic1 setObject:[NSString stringWithFormat:@"%@",hid] forKey:@"hid"];
                    NSLog(@"内容是%@",chenggong);
                    [dic1 setObject:locationString forKey:@"time"];
                    [dic1 setObject:self.TidCount forKey:@"tid"];
                    [dic1 setObject:_userIdss forKey:@"userid"];
                    NSLog(@"%@",_userId);
                    NSLog(@"内容是==%@",_textView.text);
                    NSLog(@"时间是==%@",locationString);
                    self.manager = [AFHTTPRequestOperationManager manager];
                    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
                    
                    [self.manager POST:@"http://101.200.234.127:8080/YanLu/huifu/save.do" parameters:dic1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        //   [self goBack];
                        NSLog(@"成功");
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"失败");
                    }];
                    
                    
                }];
                [request setFailedBlock:^{
                    NSLog(@"asi error: %@",request.error.debugDescription);
                }];
                [request startAsynchronous];

            
            }
//            xiaoView.frame=CGRectMake(66, 6,toolBar.bounds.size.width-73, hight_text_one+23);
//            
//            toolBar =[[UIView alloc]initWithFrame:CGRectMake(0,  ScreenHeight-(253 + toolBar.frame.size.height), self.view.bounds.size.width, 53)];

        }else
        {
            //没有图片路径
            NSLog(@"没有图片");
            
            //判断是否有图片
//            NSString *hid1=[NSString stringWithFormat:@"%@",[dic objectForKey:@"hid"]];
//            NSString *string=[NSString stringWithFormat:@"0"];
            // NSLog(@"hid%@",hid);
            // NSString *string=@"0";
            //判断是否有hid
            if(counts==0){
                [self gethuifuTiezi];
                NSLog(@"回复楼主");
                
            }else{
                //得到当前时间
                NSDate *  senddate=[NSDate date];
                
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                
                [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                
                NSString *  locationString=[dateformatter stringFromDate:senddate];
                NSString *chenggong=_textView.text;
              //  NSString *string=request.responseString;
                NSLog(@"%@",locationString);
                NSMutableDictionary *dic1=[[NSMutableDictionary alloc]initWithCapacity:0];
                
                [dic1 setObject:@"" forKey:@"lujing"];
                [dic1 setObject:self.TidCount forKey:@"tid"];
                //[dic1 setObject:@"1" forKey:@"quanziid"];
                [dic1 setObject:@"1" forKey:@"huifuid"];
                [dic1 setObject:chenggong forKey:@"neirong"];
                [dic1 setObject:hid forKey:@"hid"];
                NSLog(@"内容是%@",chenggong);
                [dic1 setObject:locationString forKey:@"time"];
                [dic1 setObject:self.TidCount forKey:@"tid"];
                [dic1 setObject:_userIdss forKey:@"userid"];
                NSLog(@"%@",_userId);
                NSLog(@"内容是==%@",_textView.text);
                NSLog(@"时间是==%@",locationString);
                self.manager = [AFHTTPRequestOperationManager manager];
                self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
                
                [self.manager POST:@"http://101.200.234.127:8080/YanLu/huifu/save.do" parameters:dic1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    xiaoView.frame=CGRectMake(xiaoView.frame.origin.x,xiaoView.frame.origin.y, toolBar.bounds.size.width-73, 40);
                    
                    
                    toolBar.frame=CGRectMake(0, ScreenHeight-toolBar.frame.size.height-50,self.view.bounds.size.width,53);
                    
                    //   [self goBack];
                    NSLog(@"成功");
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"失败");
                }];

                NSLog(@"回复回复");
                NSLog(@"回复%@",hid);
            }

            
        }
        
        
       // [messageRange release];
       [self getHuFuData];
    }
    
    _textView.text = nil;
 //   [self textViewDidChange:_textView];
    
    [_textView resignFirstResponder];
    
    isFirstShowKeyboard = YES;
    
    isButtonClicked = NO;
    
    _textView.inputView = nil;
    
    
    if(status == NO){
        xiaoView.frame=CGRectMake(xiaoView.frame.origin.x,xiaoView.frame.origin.y, toolBar.bounds.size.width-73, 40);
        
        
        toolBar.frame=CGRectMake(0, self.view.frame.size.height-53,self.view.bounds.size.width,53);
    }else{
        xiaoView.frame=CGRectMake(xiaoView.frame.origin.x,xiaoView.frame.origin.y, toolBar.bounds.size.width-73, 40);
        
        
        toolBar.frame=CGRectMake(0, self.view.frame.size.height-53,self.view.bounds.size.width,53);
        
    }
    
    //[keyboardButton setBackgroundIma:[UIImage imageNamed:@"表情"]
     //               forState:UIControlStateNormal];
    [keyboardButton setBackgroundImage:[UIImage imageNamed:@"表情"] forState:UIControlStateNormal];
    
    if ( needReload ) {
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_huiFuArr.count
                                                                   inSection:0]
                               atScrollPosition:UITableViewScrollPositionBottom
                                       animated:NO];
    }
    //移除image视图
    [smallimage removeFromSuperview];
    picterBtn.userInteractionEnabled=YES;
    [self getHuFuData];
    [label setHidden:NO];
    [self.tableView reloadData];


    

}
    
#pragma mark 拍照
-(void)openMenu
{
    //在这里呼出下方菜单按钮项
    myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [myActionSheet showInView:self.view];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == myActionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            [self takePhoto];
            break;
            
        case 1:  //打开本地相册
            [self LocalPhoto];
            break;
    }
}

//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}


//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentModalViewController:picker animated:YES];

}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    UIImage* image;
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        image=[info objectForKey:UIImagePickerControllerOriginalImage];
        UIImageOrientation imageOrientation=image.imageOrientation;
        if(imageOrientation!=UIImageOrientationUp)
        {
            // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
            // 以下为调整图片角度的部分
            UIGraphicsBeginImageContext(image.size);
            [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            // 调整图片角度完毕
        }

    //点击图片之后点击完成
    [picker dismissViewControllerAnimated:true completion:nil];
     NSLog(@"do cancel");
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            _data = UIImageJPEGRepresentation(image, 0.3);
        }
        else
        {
            _data = UIImageJPEGRepresentation(image, 0.5);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
//        //得到一个随机数
        NSDate *  senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"YYYYMMdd HHssmm"];
        
        NSString *  locationString=[dateformatter stringFromDate:senddate];
        
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:[NSString stringWithFormat:@"/image%@.png",locationString]] contents:_data attributes:nil];
       // NSString *string=[NSString ]
      //  NSLog(@"%@",_data);
        
        //得到选择后沙盒中图片的完整路径
        filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath, [NSString stringWithFormat:@"/image%@.png",locationString]];
        NSLog(@"$$$$$$$$$$$$$%@",filePath);
        
        
        //关闭相册界面
        [picker dismissModalViewControllerAnimated:YES];
        [_textView becomeFirstResponder];

        toolBar.frame=CGRectMake(0,ScreenHeight-toolBar.frame.size.height,self.view.bounds.size.width,53);

        
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
        smallimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 26, 23)];

        
        smallimage.image = image;

//        //加在视图中
        if(smallimage){
            [picterBtn addSubview:smallimage];
            picterBtn.userInteractionEnabled=NO;
            
        }//
    }
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissModalViewControllerAnimated:YES];
}


//照片

- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
-(void)sendInfo
{
    
    NSLog(@"图片的路径是：%@", filePath);
    
   // NSLog(@"您输入框中的内容是：%@", _textEditor.text);
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




#pragma mark 表情和键盘

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    //self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
  //  toolBar.frame=CGRectMake(0,0, ScreenWidth,53);
    toolBar.backgroundColor=RGBA(214, 214, 214, 1);
//    if(xiaoView.frame.size.height>30){
//    if(status == NO){
//    toolBar.frame=CGRectMake(0, self.view.frame.size.height - (251 + toolBar.frame.size.height), ScreenWidth,53);
//    }else{
    toolBar.frame=CGRectMake(0, self.view.frame.size.height - (180 + toolBar.frame.size.height), ScreenWidth,53);
//    }
    
    
   // }
    
}


-(UIView *)assembleMessageAtIndex:(NSArray *)arr
{
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    
    NSArray *data = arr;
    UIFont *fon = [UIFont systemFontOfSize:14.0f];
    CGFloat upX = 0;
    CGFloat upY = 0;
    if (data) {
        for (int i=0;i<[data count];i++) {
            NSString *str=[data objectAtIndex:i];
            if ([str hasPrefix:@"["]&&[str hasSuffix:@"]"])
            {
                if (upX > ScreenWidth-30)
                {
                    upY = upY + 24;
                    upX = 0;
                }
                NSString *imageName=[str substringWithRange:NSMakeRange(1, str.length-2)];
                
                //表情imageView
                UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
                
                img.frame = CGRectMake(upX, upY, 24, 24);
                [returnView addSubview:img];
                upX=24+upX;
                
            }else{
                
                for (int j = 0; j<[str length]; j++)
                {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX > ScreenWidth-30)
                    {
                        upY = upY + 24;
                        upX = 0;
                    }
                    CGSize size10=[temp sizeWithFont:fon constrainedToSize:CGSizeMake( ScreenWidth-30, 40)];
                    
                    //文字label
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX, upY,size10.width,size10.height+8)];
                    
                    
                    la.font = fon;
                    la.text = temp;
                    [returnView addSubview:la];
                    
                    upX=upX+size10.width;
                }
            }
        }
    }
    return returnView;
}




//解析获取到的信息
-(void)parserMessage:(NSString*)message
{
    //NSMutableArray *arrayaaa = [[NSMutableArray alloc] init];
    //调用下面的该方法
    [self getImageRange:message :array];
   // [self.huiFuArr addObject:arrayaaa];
    
    
    //刷新页面
    [self.tableView reloadData];
    
    //
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.huiFuArr.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


//获取图片的长度和坐标
-(void)getImageRange:(NSString*)message :(NSMutableArray*)arrays
{
    NSRange range  = [message rangeOfString:@"["];
    NSRange range1 = [message rangeOfString:@"]"];
    //判断当前字符串是否还有表情的标志。
    if (range.length&&range1.length) {
        if (range.location>0) {
            [arrays addObject:[message substringToIndex:range.location]];
            [arrays addObject:[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)]];
            NSString *str=[message substringFromIndex:range1.location+1];
            [self getImageRange:str :array];
        }else {
            NSString *nextstr=[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
            //排除文字是“”的
            if (![nextstr isEqualToString:@""]) {
                [arrays addObject:nextstr];
                NSString *str=[message substringFromIndex:range1.location+1];
                [self getImageRange:str :arrays];
            }else {
                return;
            }
        }
        
    }else {
        [arrays addObject:message];
    }
}


//图片

- (void)imagePickerController:(MSImagePickerController *)picker didFinishPickingImage:(NSArray *)images; {
    self.imageArray = images;
    
    int i = 0;
    for (UIImage* img in images) {
        NSData* data = UIImagePNGRepresentation(img);
        if (data != nil) {
            [data writeToFile:[NSString stringWithFormat:@"%@/Documents/%d.png", NSHomeDirectory(), i++] atomically:true];
        }
    }
    
    [picker dismissViewControllerAnimated:true completion:^{
    }];
}

//选中表情触发该方法
-(void)selectedFacialView:(NSString*)str
{
    [label setHidden:YES];
    NSMutableString *str1=[[NSMutableString alloc] initWithString:@"["];
    [str1 appendString:str];
    [str1 appendString:@"]"];
    
    NSString *str2=[NSString stringWithFormat:@"%@%@",self.textView.text,str1];
    self.textView.text=str2;
}

@end
