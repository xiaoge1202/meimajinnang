//
//  EnterViewController.m
//  帖子列表
//
//  Created by 董飞剑 on 15/1/10.
//  Copyright (c) 2015年 DongFeiJian. All rights reserved.
//

#import "EnterViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

  /*************************登录页面**************************/
@interface EnterViewController ()
{
    AppDelegate *appDelegate;
    NSString *pet_name;
    NSString *password;

}
@property (strong,nonatomic) UITextField *pet_nameField;
@property (strong,nonatomic) UITextField *passwordField;
@property (strong,nonatomic) UIButton *putinBtn;
@property (strong,nonatomic) NSMutableArray *arr;
@property (strong,nonatomic) NSMutableDictionary *dic;

@end

@implementation EnterViewController


-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = [UIApplication sharedApplication].delegate;
    
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"YES||NO"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    self.dic = [NSMutableDictionary dictionary];
    
    //头像图片
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(130, 60, 120, 120)];
    [button setBackgroundImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button.layer setCornerRadius:5.0];
    
    
    //账号输入框
    self.pet_nameField = [[UITextField alloc] initWithFrame:CGRectMake(30, 200, self.view.frame.size.width-60, 40)];
    self.pet_nameField.tag = 1003;
    self.pet_nameField.placeholder = @"账号";
    self.pet_nameField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.pet_nameField];
    [self.pet_nameField resignFirstResponder];
    
    //密码输入框
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(30, 260, self.view.frame.size.width-60, 40)];
    self.passwordField.tag = 1004;
    self.passwordField.placeholder = @"密码";
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.passwordField];
    [self.passwordField resignFirstResponder];
    
    //设置登录按钮样式
    self.putinBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //设置按钮大小
    [self.putinBtn setFrame:CGRectMake(30, 350, self.view.frame.size.width-60, 40)];
    //将按钮添加到页面上
    [self.view addSubview:self.putinBtn];
    //为按钮设置标题
    [self.putinBtn setTitle:@"登录" forState:UIControlStateNormal];
    //给按钮添加事件
    [self.putinBtn addTarget:self action:@selector(buttonClickSure)forControlEvents:UIControlEventTouchUpInside];
    //设置按钮字体颜色
    [self.putinBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //给按钮设置背景图片
    [self.putinBtn setBackgroundColor:[UIColor colorWithRed:0 green:100 blue:200 alpha:1]];
    //设置点击的时候高亮
    self.putinBtn.showsTouchWhenHighlighted = YES;
    
    
    
    //忘记密码
    UIButton* memory = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    memory.frame = CGRectMake(10, 470, 100, 20);
    [memory setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [memory setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [memory addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:memory];
    
    //新用户(注册按钮)
    UIButton *login = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    login.frame = CGRectMake(200, 470, 100, 20);
    [login setTitle:@"新用户注册" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [login addTarget:self action:@selector(loginView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    
}

-(void)changeUser
{
    
}

//点击登录按钮
-(void)buttonClickSure
{
    [self postDataFromServer];
}

-(void)postDataFromServer
{ 
    
    pet_name = ((UITextField *)[self.view viewWithTag:1003]).text;
    password = ((UITextField *)[self.view viewWithTag:1004]).text;
    
    self.dic = [[NSMutableDictionary alloc]init];
    [self.dic setObject:pet_name forKey:@"username"];
    [self.dic setObject:password forKey:@"password"];
    
    ////////////////////////////////////////////
    // 使用AFHTTPRequestOperationManager发送POST请求
    [appDelegate.manager POST:@"http://101.200.234.127:8080/YanLu/user/list.do"
                   parameters:self.dic  // 指定请求参数
     // 获取服务器响应成功时激发的代码块
                      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         // 当使用HTTP响应解析器时，服务器响应数据被封装在NSData中
         // 此处将NSData转换成NSString、并使用UIAlertView显示登录结果
         NSData *data = responseObject;
         NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
          NSLog(@"-------%@",str);
         if ([str isEqualToString:@"true"]) {
             
               [self jumpToTieZiListView];
         }
         else
         {
             [[[UIAlertView alloc]initWithTitle:@"登录结果" message:@"账号或密码错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil]show];
         }
     }
     // 获取服务器响应失败时激发的代码块
        failure:^(AFHTTPRequestOperation *operation, NSError *error){
                    NSLog(@"获取服务器响应出错！");
        }];
}

-(void)loginView
{
    LoginViewController *login = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
}


-(void)jumpToTieZiListView
{
    MainTabbarViewController *viewNav = [[MainTabbarViewController alloc]init];
    [self.navigationController pushViewController:viewNav animated:YES];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
