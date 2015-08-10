//
//  LoginViewController.m
//  YanLuMuYing
//
//  Created by 赵天韡 on 15/1/16.
//  Copyright (c) 2015年 赵天韡. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
@interface LoginViewController ()
{
    AppDelegate *appDelegate;
}

@end
NSString *pet_name;
NSString *password;
NSString *notarizePassword;
@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    //显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = [UIApplication sharedApplication].delegate;
    
    self.pet_nameField = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, self.view.frame.size.width-60, 40)];
    self.pet_nameField.tag = 1001;
    self.pet_nameField.placeholder = @"账号";
    self.pet_nameField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.pet_nameField];
    
    
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(30, 155, self.view.frame.size.width-60, 40)];
    self.passwordField.tag = 1002;
    self.passwordField.placeholder = @"密码";
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.passwordField];
    
    
    self.notarizePasswordField = [[UITextField alloc] initWithFrame:CGRectMake(30, 210, self.view.frame.size.width-60, 40)];
    self.notarizePasswordField.tag = 1003;
    self.notarizePasswordField.placeholder = @"确认密码";
    self.notarizePasswordField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.notarizePasswordField];
    
    self.putinBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.putinBtn setFrame:CGRectMake(120, 290, 100, 20)];
    [self.view addSubview:self.putinBtn];
    [self.putinBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.putinBtn addTarget:self action:@selector(buttonClickSure)forControlEvents:UIControlEventTouchUpInside];
    [self.putinBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //[self.putinBtn setBackgroundImage:[UIImage imageNamed:@"btn_tasklistitem_n.png"]forState:UIControlStateNormal];
    //设置点击的时候高亮
    self.putinBtn.showsTouchWhenHighlighted = YES;
}


//上传账号密码信息给服务器
-(void)buttonClickSure
{
    [self returnDataToServer];
}


//向服务器上传数据（注册信息）
-(void)returnDataToServer
{
    pet_name = ((UITextField *)[self.view viewWithTag:1001]).text;
    password = ((UITextField *)[self.view viewWithTag:1002]).text;
    notarizePassword = ((UITextField *)[self.view viewWithTag:1003]).text;
    
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
         
         NSString *string  = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSLog(@"%@",string);
         if ([string isEqualToString:@"true"]) {
             [[[UIAlertView alloc] initWithTitle:@"注册结果" message:@"该账号已存在" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
         }else{
             
             [appDelegate.manager POST:@"http://101.200.234.127:8080/YanLu/user/save.do"
                            parameters:self.dic  // 指定请求参数
              // 获取服务器响应成功时激发的代码块
                               success:^(AFHTTPRequestOperation *operation, id responseObject)
              {
                  // 使用UIAlertView显示登录结果
                  
                  [[[UIAlertView alloc] initWithTitle:@"注册结果" message:@"注册成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
                  
                  //点击确定跳转到登录页面
                  [self.navigationController popViewControllerAnimated:YES];
              }
              // 获取服务器响应失败时激发的代码块
                               failure:^(AFHTTPRequestOperation *operation, NSError *error){
                               }];
         }
     }
     // 获取服务器响应失败时激发的代码块
                      failure:^(AFHTTPRequestOperation *operation, NSError *error){
                          NSLog(@"获取服务器响应出错！");
                      }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
