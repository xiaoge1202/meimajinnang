//
//  SetBirthDateViewController.m
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/15.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "SetBirthDateViewController.h"

@interface SetBirthDateViewController ()

@end

@implementation SetBirthDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设 置 宝 宝 出 生 日 期";
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    
    /*-------------状态栏改变背景颜色-----------*/
//    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
//    head.backgroundColor = [UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1];
//    [self.navigationController.view addSubview:head];
    
    self.view.backgroundColor = RGBA(235, 235, 235, 1);

    
    //返回按钮
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(20, 14, 16, 20);
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *setupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setupBtn.frame = CGRectMake(ScreenWidth-32, 16, 43, 24);
    [setupBtn setImage:[UIImage imageNamed:@"完成"] forState:UIControlStateNormal];
    [setupBtn addTarget:self action:@selector(clickFinishBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:setupBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UILabel *birthLabel = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-70)/2, 37, 70, 11)];
    birthLabel.text = @"宝宝出生日期";
    birthLabel.textAlignment = NSTextAlignmentCenter;
    birthLabel.textColor = RGBA(137, 137, 137, 1);
    birthLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:11];
    [self.view addSubview:birthLabel];
    
    self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-186)/2, birthLabel.frame.origin.y+birthLabel.frame.size.height+24, 186, 30)];
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.dayLabel.text = [formatter stringFromDate:[NSDate date]];
    self.dayLabel.textColor = RGBA(236, 119, 147, 1);
    self.dayLabel.textAlignment = NSTextAlignmentCenter;
    self.dayLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:30];
    [self.view addSubview:self.dayLabel];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.dayLabel.frame.origin.y+self.dayLabel.frame.size.height+54, ScreenWidth, 1)];
    lineView1.backgroundColor = RGBA(205, 205, 205, 1);
    [self.view addSubview:lineView1];
    
    //初始日期选择控件142
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width , 100)];
    self.datePicker.hidden = NO;
    //self.datePicker.layer.borderWidth = 0.1;
    //self.datePicker.backgroundColor = RGBA(230, 230, 230, 1);
    //日期模式
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    //最小日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate *minDate = [dateFormatter dateFromString:@"2015-01-01"];
    //最大日期
    NSDate *maxDate = [dateFormatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    
    //[self.datePicker setMinimumDate:minDate];
    [self.datePicker setMaximumDate:maxDate];
    
    [self.datePicker addTarget:self action:@selector(dataValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.datePicker];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.datePicker.frame.origin.y+self.datePicker.frame.size.height+1, ScreenWidth, 1)];
    lineView2.backgroundColor = RGBA(228, 229, 229, 1);
    [self.view addSubview:lineView2];
    
    
    // Do any additional setup after loading the view.
}

-(void)goBack:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickFinishBtn
{
//    NSArray *array = [self.dayLabel.text componentsSeparatedByString:@"-"];
//    NSLog(@"%@",array);
//    
//    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
//    NSArray *array1 = [dateStr componentsSeparatedByString:@"-"];
//    
//    NSInteger year = [[array objectAtIndex:0] integerValue];
//    NSInteger month = [[array objectAtIndex:1] integerValue];
//    NSInteger date = [[array objectAtIndex:2] integerValue];
//    
//    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
//    {
//        switch (month) {
//            case 1:
//                switch (date) {
//                    case 1:
//                        month = 3;
//                        date = 26;
//                        break;
//                        
//                    default:
//                        break;
//                }
//                break;
//                
//            default:
//                break;
//        }
//    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *selfDic = [[NSMutableDictionary alloc] init];
    
    NSString *zhanghao = [ud objectForKey:@"username"];
    
    [selfDic setObject:zhanghao forKey:@"username"];
    [selfDic setObject:self.dayLabel.text forKey:@"huaiyuntime"];
    
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/user/update.do" parameters:selfDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
             NSLog(@"%@",self.dataArr);
             NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
             [ud removeObjectForKey:@"huaiyuntianshu"];
             [ud removeObjectForKey:@"huaiyuntime"];
             [ud setObject:self.dayLabel.text forKey:@"huaiyuntime"];
             [ud setObject:[[self.dataArr objectAtIndex:0] objectForKey:@"huaiyuntianshu"] forKey:@"huaiyuntianshu"];
             [ud synchronize];
             //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
         }
         // 获取服务器响应失败时激发的代码块
                   failure:^(AFHTTPRequestOperation *operation, NSError *error){
                       NSLog(@"获取服务器响应出错！");
                   }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取服务器失败");
        [[[UIAlertView alloc] initWithTitle:@"修改失败" message:@"网络错误，请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }];
    
    NSMutableDictionary *zhuangtaiDic = [[NSMutableDictionary alloc] init];
    [zhuangtaiDic setObject:zhanghao forKey:@"username"];
    [zhuangtaiDic setObject:@"已出生" forKey:@"zhuangtai"];
    
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/user/update.do" parameters:zhuangtaiDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"获取成功");
        
        NSData *data = (NSData*)responseObject;
        
        self.dataArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud removeObjectForKey:@"zhuangtai"];
        [ud setObject:@"已出生" forKey:@"zhuangtai"];
        [ud synchronize];
        TabBar_VC *tab = [[TabBar_VC alloc]init];
        [self presentViewController:tab animated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取服务器失败");
        [[[UIAlertView alloc] initWithTitle:@"修改失败" message:@"网络错误，请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }];
    
//    if ([self.nameString isEqual:@"1"]) {
//        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//    }
//    else
//    {
    
    //}
}

//datapicker值攺变事件
- (void) dataValueChanged:(UIDatePicker *)sender
{
    UIDatePicker *dataPicker_one = (UIDatePicker *)sender;
    NSDate *date_one = dataPicker_one.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    self.dayLabel.text = [formatter stringFromDate:date_one];
    
    formatter = nil;
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
