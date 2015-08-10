//
//  ChangeStateViewController.m
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/15.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "ChangeStateViewController.h"

@interface ChangeStateViewController ()

@end

@implementation ChangeStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选 择 您 当 前 的 状 态";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //返回按钮
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(20, 14, 16, 20);
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    backgroundView.userInteractionEnabled = YES;
    backgroundView.multipleTouchEnabled = YES;
    backgroundView.image = [UIImage imageNamed:@"页面背景"];
    [self.view addSubview:backgroundView];
    
    self.beiyunBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.beiyunBtn.frame = CGRectMake(156, 88, 106, 91);
    [self.beiyunBtn setImage:[UIImage imageNamed:@"备孕中"] forState:UIControlStateNormal];
    [self.beiyunBtn addTarget:self action:@selector(clickStateBtn1:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:self.beiyunBtn];
    
    self.huaiyunBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.huaiyunBtn.frame = CGRectMake(40, 172, 106, 91);
    [self.huaiyunBtn setImage:[UIImage imageNamed:@"已怀孕"] forState:UIControlStateNormal];
    [self.huaiyunBtn addTarget:self action:@selector(clickStateBtn2:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:self.huaiyunBtn];
    
    self.chushengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chushengBtn.frame = CGRectMake(ScreenWidth-155, ScreenHeight-309, 106, 91);
    [self.chushengBtn setImage:[UIImage imageNamed:@"宝宝已出生"] forState:UIControlStateNormal];
    [self.chushengBtn addTarget:self action:@selector(clickStateBtn3:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:self.chushengBtn];
    
    // Do any additional setup after loading the view.
}

-(void)goBack:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickStateBtn1:(UIButton*)sender
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *huaiyuntimeDic = [[NSMutableDictionary alloc] init];
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *zhanghao = [ud objectForKey:@"username"];
    NSString *huaiyuntime = [formatter stringFromDate:[NSDate date]];
    [huaiyuntimeDic setObject:zhanghao forKey:@"username"];
    [huaiyuntimeDic setObject:huaiyuntime forKey:@"huaiyuntime"];
    
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/user/update.do" parameters:huaiyuntimeDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
             [ud setObject:huaiyuntime forKey:@"huaiyuntime"];
             [ud setObject:[[self.dataArr objectAtIndex:0] objectForKey:@"huaiyuntianshu"] forKey:@"huaiyuntianshu"];
             [ud synchronize];
             NSLog(@"huaiyuntinshu:%@",self.dataArr);
         }
         // 获取服务器响应失败时激发的代码块
                   failure:^(AFHTTPRequestOperation *operation, NSError *error){
                       NSLog(@"获取服务器响应出错！");
                   }];
        //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取服务器失败");
        [[[UIAlertView alloc] initWithTitle:@"修改失败" message:@"网络错误，请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }];
    
    NSMutableDictionary *zhuangtaiDic = [[NSMutableDictionary alloc] init];
    [zhuangtaiDic setObject:zhanghao forKey:@"username"];
    [zhuangtaiDic setObject:@"备孕中" forKey:@"zhuangtai"];
    
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/user/update.do" parameters:zhuangtaiDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"获取成功");
        
        NSData *data = (NSData*)responseObject;
        
        self.dataArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud removeObjectForKey:@"zhuangtai"];
        [ud setObject:@"备孕中" forKey:@"zhuangtai"];
        [ud synchronize];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取服务器失败");
        [[[UIAlertView alloc] initWithTitle:@"修改失败" message:@"网络错误，请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }];
}

-(void)clickStateBtn2:(UIButton*)sender
{
    SetDueDateViewController *setDueVC = [[SetDueDateViewController alloc] init];
    [self.navigationController pushViewController:setDueVC animated:YES];
}

-(void)clickStateBtn3:(UIButton*)sender
{
    SetBirthDateViewController *setBirthVC = [[SetBirthDateViewController alloc] init];
    [self.navigationController pushViewController:setBirthVC animated:YES];
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
