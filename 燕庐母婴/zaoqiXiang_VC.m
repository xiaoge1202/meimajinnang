//
//  zaoqiXiang_VC.m
//  美妈锦囊
//
//  Created by apple on 15/7/27.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "zaoqiXiang_VC.h"

#import "PrefixHeader.pch"
#import "TYAttributedLabel.h"
#import "TYImageStorage.h"
#import "TYTextStorage.h"
#import "RegexKitLite.h"
#import "UIImageView+AFNetworking.h"

@interface zaoqiXiang_VC ()<UIScrollViewDelegate,TYAttributedLabelDelegate>
@property (nonatomic,weak) TYAttributedLabel *label1;
@property (nonatomic,strong) TYTextContainer *textContainer;
@property (nonatomic,strong) NSAttributedString *attString;
@property (nonatomic,weak) UIScrollView *scrollView;

@end

#define RGB(r,g,b,a)	[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@implementation zaoqiXiang_VC{
    //详情的数据
    NSMutableArray *infoArray;
    UIActivityIndicatorView *loadingIndicator;
    
    UIView *view1;
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //初始化数组
    infoArray=[[NSMutableArray alloc]initWithCapacity:0];
    //导航栏
    
    self.navigationItem.title = @"早期教育详情";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    
    
    //取消导航栏和状态栏的边缘延展效果
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    //返回按钮
    UIButton  * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 16, 12, 20);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    [self addScrollView];
    
    [self addTextAttributedLabel1];
    
    [self addTextAttributedLabel2];
    
    
    //初始化ui
    [self layoutUI];
    
    
}


-(void)layoutUI{
    //标题
    
    
    view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    //view1.backgroundColor=[UIColor redColor];
    [self.view addSubview:view1];
    //标题
    UILabel *titlelb=[[UILabel alloc]initWithFrame:CGRectMake(15, 15,320, 20)];
    titlelb.text=@"我是宝宝辅食的详情";
    titlelb.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:17];
    titlelb.textColor = RGBA(0 , 0, 0, 1);
    
    /// titlelb.backgroundColor=[UIColor redColor];
    [view1 addSubview:titlelb];
    //下面的副标题
    
    UIView *bodys=[[UIView alloc]initWithFrame:CGRectMake(0,50, self.view.frame.size.width, 1)];
    bodys.backgroundColor=RGBA(212, 212, 212, 1);
    
    
    [view1 addSubview:bodys];
    [_scrollView addSubview:view1];
    
    
    
    
}


- (void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-59)];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
}

// appendAttributedText
- (void)addTextAttributedLabel1
{
    TYAttributedLabel *label = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(10, 65, CGRectGetWidth(self.view.frame)-20, 0)];
    label.delegate = self;
    [_scrollView addSubview:label];
    _label1 = label;
    
    NSString *text = @"\t总有一天你将破蛹而出，成长得比人们期待的还要美丽。\n\t但这个过http程会很痛，会很辛苦http，有时候还会觉得灰心。\n\t面对着汹涌而来的现实，觉得自己渺小无力。\n\t但这，也是生命的一部分，做好现在http你能做的，然后，一切都会好的。\n\t我们都将孤独地长大，不要害怕.";
    
    // 分割文本到数组
    NSArray *textArray = [text componentsSeparatedByString:@"http"];
    
    NSInteger index = 0;
    
    
    for (NSString *text in textArray) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];
        
        int a=(int)textArray.count;
        NSLog(@"===%d",a-1);
        if (index != a-1) {
            // 添加属性
            // [attributedString addAttributeTextColor:[UIColor redColor]];
            [attributedString addAttributeFont:[UIFont systemFontOfSize:15]];
            
            // 追加(添加到最后)文本
            [label appendTextAttributedString:attributedString];
            TYImageStorage *imageStorage = [[TYImageStorage alloc]init];
            imageStorage.imageURL =[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/ac345982b2b7d0a2e00ab3fac9ef76094a369a92.jpg"];
            imageStorage.size = CGSizeMake(320, 180);
            [label appendTextStorage:imageStorage];
            
        } else {
            [label appendImageWithName:@"CYLoLi" size:CGSizeMake(320, 0.1)];
            [label appendText:text];
        }
        index++;
    }
    
    
    
    [label sizeToFit];
}

// addAttributedText
- (void)addTextAttributedLabel2
{
    //使用 RegexKitLite，添加 -fno-objc-arc，同时添加 libicucore.dylib
    //其实所有漂泊的人，不过是为了有一天能够不再漂泊，能用自己的力量撑起身后的家人和自己爱的人。
    TYAttributedLabel *label = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_label1.frame) , CGRectGetWidth(self.view.frame), 0)];
    [_scrollView addSubview:label];
    
    [_scrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(label.frame)+10)];
}

#pragma mark - deleagte

- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)textStorage atPoint:(CGPoint)point
{
    NSLog(@"textStorageClickedAtPoint");
}

- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageLongPressed:(id<TYTextStorageProtocol>)textStorage onState:(UIGestureRecognizerState)state atPoint:(CGPoint)point
{
    NSLog(@"textStorageLongPressed");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//返回按钮
-(void)goBack:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
