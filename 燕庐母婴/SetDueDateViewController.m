//
//  SetDueDateViewController.m
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/15.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "SetDueDateViewController.h"

@interface SetDueDateViewController ()
{
    NSString *str;
    NSString *getHuaiyuntime;
    NSString *huaiyuntime;
}
@end

@implementation SetDueDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设 置 预 产 期";
   
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    
    /*-------------状态栏改变背景颜色-----------*/
//    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
//    head.backgroundColor = [UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1];
//    [self.navigationController.view addSubview:head];
    
    self.view.backgroundColor = RGBA(235, 235, 235, 1);

    
    //返回按钮
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(10, 16, 12, 20);
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *setupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setupBtn.frame = CGRectMake(ScreenWidth-32, 16, 43, 24);
    [setupBtn setImage:[UIImage imageNamed:@"完成"] forState:UIControlStateNormal];
    [setupBtn addTarget:self action:@selector(clickFinishBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:setupBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self getStr];
    [self creatView];
    [self creatScrollView];
    [self addView1];
    [self addView2];
    // Do any additional setup after loading the view.
}

-(void)getStr
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    str = [ud objectForKey:@"huaiyuntianshu"];
    getHuaiyuntime = [ud objectForKey:@"huaiyuntime"];
}

-(void)creatView
{
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,ScreenWidth , 32)];
    self.titleView.backgroundColor = RGBA(235, 235, 235, 1);
    [self.view addSubview:self.titleView];
    self.shuruBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.shuruBtn.frame = CGRectMake(47, 9, (ScreenWidth-187)/2, 12);
    [self.shuruBtn setTitle:@"输入预产期" forState:UIControlStateNormal];
    [self.shuruBtn setTitleColor:RGBA(236, 119, 147, 1) forState:UIControlStateNormal];
    [self.shuruBtn.titleLabel setFont:[UIFont fontWithName:@"Microsoft Yahei UI" size:12]];
    [self.shuruBtn addTarget:self action:@selector(clicktieziBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:self.shuruBtn];
    
    self.jisuanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.jisuanBtn.frame = CGRectMake(self.shuruBtn.frame.origin.x+self.shuruBtn.frame.size.width+93, 9, (ScreenWidth-187)/2, 12);
    [self.jisuanBtn setTitle:@"计算预产期" forState:UIControlStateNormal];
    [self.jisuanBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
    [self.jisuanBtn.titleLabel setFont:[UIFont fontWithName:@"Microsoft Yahei UI" size:12]];
    [self.jisuanBtn addTarget:self action:@selector(clickzhishiBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:self.jisuanBtn];
    
    UIView *titlelineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleView.frame.size.height-4, ScreenWidth, 1)];
    titlelineView.backgroundColor = RGBA(137, 137, 137, 1);
    [self.titleView addSubview:titlelineView];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, titlelineView.frame.origin.y+titlelineView.frame.size.height, ScreenWidth, 3)];
    [self.titleView addSubview:self.lineView];
    
    self.shuruView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, (ScreenWidth-80)/2, self.lineView.frame.size.height)];
    self.shuruView.backgroundColor = RGBA(236, 119, 147, 1);
    [self.lineView addSubview:self.shuruView];
    
    self.jisuanView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth-((ScreenWidth-80)/2)-20, 0, (ScreenWidth-80)/2, self.lineView.frame.size.height)];
    [self.lineView addSubview:self.jisuanView];
}

-(void)creatScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.lineView.frame.origin.y+self.lineView.frame.size.height, ScreenWidth, ScreenHeight-self.lineView.frame.origin.y-self.lineView.frame.size.height-64)];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth*2, 1);
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.scrollView.frame.size.height)];
    [self.scrollView addSubview:self.view1];
    
    self.view2 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, self.scrollView.frame.size.height)];
    [self.scrollView addSubview:self.view2];
}

-(void)addView1
{
    UILabel *birthLabel = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-94)/2, 29, 94, 11)];
    birthLabel.text = @"我的预产期";
    birthLabel.textAlignment = NSTextAlignmentCenter;
    birthLabel.textColor = RGBA(137, 137, 137, 1);
    birthLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:11];
    [self.view1 addSubview:birthLabel];
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    self.dayLabel1 = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-186)/2, birthLabel.frame.origin.y+birthLabel.frame.size.height+22, 186, 30)];
    NSDateFormatter *dateformatter = [NSDateFormatter new];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:getHuaiyuntime];
    self.dayLabel1.text =[dateformatter stringFromDate:[date dateByAddingTimeInterval:60 * 60 * 24 * 280]];
    self.dayLabel1.textColor = RGBA(236, 119, 147, 1);
    self.dayLabel1.textAlignment = NSTextAlignmentCenter;
    self.dayLabel1.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:30];
    [self.view1 addSubview:self.dayLabel1];
    
    self.huaiyuntianshuLabel1 = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-84)/2, self.dayLabel1.frame.origin.y+self.dayLabel1.frame.size.height+14, 84, 11)];
    NSInteger weekcount = [str integerValue]/7;
    NSInteger timecount = [str integerValue]%7;
    if (timecount==0) {
        self.huaiyuntianshuLabel1.text = [NSString stringWithFormat:@"(孕%d周)",weekcount];
    }
    else
    {
        self.huaiyuntianshuLabel1.text = [NSString stringWithFormat:@"(孕%d周+%d天)",weekcount,timecount];
    }
    self.huaiyuntianshuLabel1.textColor = RGBA(236, 119, 147, 1);
    self.huaiyuntianshuLabel1.textAlignment = NSTextAlignmentCenter;
    self.huaiyuntianshuLabel1.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:11];
    [self.view1 addSubview:self.huaiyuntianshuLabel1];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.dayLabel1.frame.origin.y+self.dayLabel1.frame.size.height+33, ScreenWidth, 1)];
    lineView1.backgroundColor = RGBA(205, 205, 205, 1);
    [self.view1 addSubview:lineView1];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, lineView1.frame.origin.y+lineView1.frame.size.height+26, ScreenWidth, 1)];
    lineView.backgroundColor = RGBA(205, 205, 205, 1);
    [self.view1 addSubview:lineView];
    
    //初始日期选择控件142
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, lineView.frame.origin.y+lineView.frame.size.height+26, [UIScreen mainScreen].bounds.size.width , 100)];
    self.datePicker.hidden = NO;
    //self.datePicker.layer.borderWidth = 0.1;
    //self.datePicker.backgroundColor = RGBA(230, 230, 230, 1);
    //日期模式
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    //最小日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *minDate = [dateFormatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSDate *myMinDate = [minDate dateByAddingTimeInterval:60 * 60 * 24];
    //最大日期
    NSDate *myDate = [dateFormatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSDate *maxDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * 279];
    
    [self.datePicker setMinimumDate:myMinDate];
    [self.datePicker setMaximumDate:maxDate];
    
    [self.datePicker addTarget:self action:@selector(dataValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view1 addSubview:self.datePicker];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.datePicker.frame.origin.y+self.datePicker.frame.size.height+1, ScreenWidth, 1)];
    lineView2.backgroundColor = RGBA(228, 229, 229, 1);
    [self.view1 addSubview:lineView2];
}

-(void)addView2
{
    UILabel *birthLabel = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-94)/2, 29, 94, 11)];
    birthLabel.text = @"帮我算出的预产期";
    birthLabel.textAlignment = NSTextAlignmentCenter;
    birthLabel.textColor = RGBA(137, 137, 137, 1);
    birthLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:11];
    [self.view2 addSubview:birthLabel];
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    self.dayLabel2 = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-186)/2, birthLabel.frame.origin.y+birthLabel.frame.size.height+22, 186, 30)];
    //NSInteger date = 300 - [str integerValue];
    //NSInteger a = date/30;
    //NSArray *array = [[formatter stringFromDate:[NSDate date]] componentsSeparatedByString:@"-"];
    self.dayLabel2.text = @"--年--月--日";
    self.dayLabel2.textColor = RGBA(236, 119, 147, 1);
    self.dayLabel2.textAlignment = NSTextAlignmentCenter;
    self.dayLabel2.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:30];
    [self.view2 addSubview:self.dayLabel2];
    
    self.huaiyuntianshuLabel2 = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-84)/2, self.dayLabel2.frame.origin.y+self.dayLabel2.frame.size.height+14, 84, 11)];
    //    NSInteger weekcount = [str integerValue]/7;
    //    NSInteger timecount = [str integerValue]%7;
    //    if (timecount==0) {
    //        self.huaiyuntianshuLabel2.text = [NSString stringWithFormat:@"(孕%d周)",weekcount];
    //    }
    //    else
    //    {
    //        self.huaiyuntianshuLabel2.text = [NSString stringWithFormat:@"(孕%d周+%d天)",weekcount,timecount];
    //    }
    self.huaiyuntianshuLabel2.textColor = RGBA(236, 119, 147, 1);
    self.huaiyuntianshuLabel2.textAlignment = NSTextAlignmentCenter;
    self.huaiyuntianshuLabel2.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:11];
    [self.view2 addSubview:self.huaiyuntianshuLabel2];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.dayLabel2.frame.origin.y+self.dayLabel2.frame.size.height+33, ScreenWidth, 1)];
    lineView1.backgroundColor = RGBA(205, 205, 205, 1);
    [self.view2 addSubview:lineView1];
    
    UILabel *shurudateLabel = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-120)/2, lineView1.frame.origin.y+lineView1.frame.size.height+7, 120, 12)];
    shurudateLabel.text = @"输入末次月经开始日期";
    shurudateLabel.textAlignment = NSTextAlignmentCenter;
    shurudateLabel.textColor = RGBA(137, 137, 137, 1);
    shurudateLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
    [self.view2 addSubview:shurudateLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, lineView1.frame.origin.y+lineView1.frame.size.height+26, ScreenWidth, 1)];
    lineView.backgroundColor = RGBA(205, 205, 205, 1);
    [self.view2 addSubview:lineView];
    
    //初始日期选择控件142
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, lineView.frame.origin.y+lineView.frame.size.height+26, [UIScreen mainScreen].bounds.size.width , 100)];
    self.datePicker.hidden = NO;
    //self.datePicker.layer.borderWidth = 0.1;
    //self.datePicker.backgroundColor = RGBA(230, 230, 230, 1);
    //日期模式
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    //最大日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *maxDate = [dateFormatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSDate *myMaxDate = [maxDate dateByAddingTimeInterval:60 * 60 * (-24)];
    //最小日期
    NSDate *myDate = [dateFormatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSDate *minDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * (-279)];
    
    [self.datePicker setMaximumDate:myMaxDate];
    [self.datePicker setMinimumDate:minDate];
    
    [self.datePicker addTarget:self action:@selector(dataValueChanged1:) forControlEvents:UIControlEventValueChanged];
    [self.view2 addSubview:self.datePicker];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.datePicker.frame.origin.y+self.datePicker.frame.size.height+1, ScreenWidth, 1)];
    lineView2.backgroundColor = RGBA(228, 229, 229, 1);
    [self.view2 addSubview:lineView2];
}

- (void) dataValueChanged:(UIDatePicker *)sender
{
    UIDatePicker *dataPicker_one = (UIDatePicker *)sender;
    NSDate *date_one = dataPicker_one.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    self.dayLabel1.text = [formatter stringFromDate:date_one];
    
    NSDate *myDate = [formatter dateFromString:self.dayLabel1.text];
    NSDate *newDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * (-280)];
    huaiyuntime = [formatter stringFromDate:newDate];
    
    NSDateFormatter * dm = [[NSDateFormatter alloc]init];
    //指定输出的格式   这里格式必须是和上面定义字符串的格式相同，否则输出空
    [dm setDateFormat:@"YYYY-MM-dd"];
    NSDate * newdate = [dm dateFromString:huaiyuntime];
    long dd = (long)[[NSDate date] timeIntervalSince1970] - [newdate timeIntervalSince1970];
    
    NSInteger weekcount = dd/86400/7;
    NSInteger timecount = dd/86400%7;
    NSLog(@"ddddd=%d",weekcount);
    NSLog(@"ddddd=%d",timecount);
    if (timecount==0) {
        self.huaiyuntianshuLabel1.text = [NSString stringWithFormat:@"(孕%d周)",weekcount];
    }
    else
    {
        self.huaiyuntianshuLabel1.text = [NSString stringWithFormat:@"(孕%d周+%d天)",weekcount,timecount];
    }
    
    formatter = nil;
}

- (void) dataValueChanged1:(UIDatePicker *)sender
{
    UIDatePicker *dataPicker_one = (UIDatePicker *)sender;
    NSDate *date_one = dataPicker_one.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *myDate = [dateFormatter dateFromString:[formatter stringFromDate:date_one]];
    NSDate *newDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * 280];
    
    self.dayLabel2.text = [formatter stringFromDate:newDate];
    huaiyuntime = [formatter stringFromDate:date_one];
    
    NSDateFormatter * dm = [[NSDateFormatter alloc]init];
    //指定输出的格式   这里格式必须是和上面定义字符串的格式相同，否则输出空
    [dm setDateFormat:@"YYYY-MM-dd"];
    NSDate * newdate = [dm dateFromString:huaiyuntime];
    long dd = (long)[[NSDate date] timeIntervalSince1970] - [newdate timeIntervalSince1970];
    
    NSInteger weekcount = dd/86400/7;
    NSInteger timecount = dd/86400%7;
    NSLog(@"ddddd=%d",weekcount);
    NSLog(@"ddddd=%d",timecount);
    if (timecount==0) {
        self.huaiyuntianshuLabel2.text = [NSString stringWithFormat:@"(孕%d周)",weekcount];
    }
    else
    {
        self.huaiyuntianshuLabel2.text = [NSString stringWithFormat:@"(孕%d周+%d天)",weekcount,timecount];
    }
    
    formatter = nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.scrollView.contentOffset.x==0) {
        //[self clickBtn1];
        [self clicktieziBtn];
    }
    else
    {
        //[self clickBtn2];
        [self clickzhishiBtn];
    }
}

-(void)clicktieziBtn
{
    self.scrollView.contentOffset = CGPointMake(0, 1);
    [self.shuruBtn setTitleColor:RGBA(236, 119, 147, 1) forState:UIControlStateNormal];
    [self.jisuanBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
    self.shuruView.backgroundColor = RGBA(236, 119, 147, 1);
    self.jisuanView.backgroundColor = RGBA(235, 235, 235, 1);
}

-(void)clickzhishiBtn
{
    self.scrollView.contentOffset = CGPointMake(ScreenWidth, 1);
    [self.jisuanBtn setTitleColor:RGBA(236, 119, 147, 1) forState:UIControlStateNormal];
    [self.shuruBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
    self.jisuanView.backgroundColor = RGBA(236, 119, 147, 1);
    self.shuruView.backgroundColor = RGBA(235, 235, 235, 1);
}

-(void)goBack:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickFinishBtn
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *zhuangtaiDict = [[NSMutableDictionary alloc] init];
    NSString *zhanghao = [ud objectForKey:@"username"];
    
    [zhuangtaiDict setObject:zhanghao forKey:@"username"];
    [zhuangtaiDict setObject:huaiyuntime forKey:@"huaiyuntime"];
    
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/user/update.do" parameters:zhuangtaiDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"获取成功");
        
        self.dic = [[NSMutableDictionary alloc]init];
        [self.dic setObject:[ud objectForKey:@"username"] forKey:@"username"];
        [self.dic setObject:[ud objectForKey:@"password"] forKey:@"password"];
        
        ////////////////////////////////////////////
        // 使用AFHTTPRequestOperationManager发送POST请求
        [self.manager POST:@"http://101.200.234.127:8080/YanLu/user/list.do" parameters:self.dic  // 指定请求参数
         // 获取服务器响应成功时激发的代码块
                   success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             // 当使用HTTP响应解析器时，服务器响应数据被封装在NSData中
             // 此处将NSData转换成NSString、并使用UIAlertView显示登录结果
             self.dataArr = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:0 error:nil];
             NSLog(@"1111%@",self.dataArr);
             NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
             [ud removeObjectForKey:@"huaiyuntianshu"];
             [ud removeObjectForKey:@"huaiyuntime"];
             [ud setObject:huaiyuntime forKey:@"huaiyuntime"];
             [ud setObject:[[self.dataArr objectAtIndex:0] objectForKey:@"huaiyuntianshu"] forKey:@"huaiyuntianshu"];
             [ud synchronize];
             NSLog(@"22222%@",[ud objectForKey:@"huaiyuntianshu"]);
             //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
         }
         // 获取服务器响应失败时激发的代码块
                   failure:^(AFHTTPRequestOperation *operation, NSError *error){
                       NSLog(@"获取服务器响应出错！");
                   }];
        
        //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
        [self setupState];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取服务器失败");
        [[[UIAlertView alloc] initWithTitle:@"修改失败" message:@"网络错误，请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }];
    
    
}

-(void)setupState
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *zhuangtaiDic = [[NSMutableDictionary alloc] init];
    NSString *zhanghao = [ud objectForKey:@"username"];
    [zhuangtaiDic setObject:zhanghao forKey:@"username"];
    [zhuangtaiDic setObject:@"2" forKey:@"zhuangtai"];
    
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/user/update.do" parameters:zhuangtaiDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"获取成功");
        
        //NSData *data = (NSData*)responseObject;
        
        //NSArray *selfArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud removeObjectForKey:@"zhuangtai"];
        [ud setObject:@"2" forKey:@"zhuangtai"];
        [ud synchronize];
        NSLog(@"33333%@",[ud objectForKey:@"zhuangtai"]);
        //        if ([self.nameString isEqual:@"1"]) {
        //            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        //        }
        //        else
        //        {
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        if([[[user objectForKey:@"huaiyuntianshu"] stringValue] isEqualToString:[[selfArr objectAtIndex:0] objectForKey:@"huaiyuntianshu"]])
//        {
            TabBar_VC *tab = [[TabBar_VC alloc]init];
            [self presentViewController:tab animated:YES completion:nil];
        //}
        
        //}
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取服务器失败");
        [[[UIAlertView alloc] initWithTitle:@"修改失败" message:@"网络错误，请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
