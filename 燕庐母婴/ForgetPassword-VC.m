//
//  ForgetPassword-VC.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/2.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "ForgetPassword-VC.h"

@interface ForgetPassword_VC ()

@end

@implementation ForgetPassword_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBA(239, 239, 239, 1);

    
//    /*----------导航栏添加图片-----------*/
//    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
//    head.backgroundColor = [UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1];
//    [self.navigationController.view addSubview:head];
    
    //首先创建一个view
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
//    [self.navigationController.view addSubview:view];
//    
//    
//    //然后创建一个Imgview添加到view上
//    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
//    imageV.image = [UIImage imageNamed:@"导航栏"];
//    [view addSubview:imageV];
//    
//    //最后创建一个label添加到imgView上
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-120)/2, 5, 120, 35)];
//    label.textColor = [UIColor whiteColor];
//    label.text = @"忘 记 密 码";
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont systemFontOfSize:22];
//    [imageV addSubview:label];
//
//    
//    //返回按钮
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(20, 14, 16, 20);
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationController.view addSubview:backBtn];
    
    self.title = @"忘记密码";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 16, 12, 20);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.pet_nameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20, 40)];
    self.pet_nameField.tag = 1001;
    self.pet_nameField.placeholder = @"手机号";
    self.pet_nameField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.pet_nameField];
    
    
    self.shortField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.pet_nameField.frame.origin.y+self.pet_nameField.frame.size.height+6, (self.view.frame.size.width-20)/3*2, 40)];
    self.shortField.tag = 1003;
    self.shortField.placeholder = @"输入验证码";
    self.shortField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.shortField];
    
    
    
    self.shortBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.shortBtn setFrame:CGRectMake(self.shortField.frame.origin.x+self.shortField.frame.size.width+6, self.pet_nameField.frame.origin.y+self.pet_nameField.frame.size.height+6, ScreenWidth-self.shortField.frame.size.width-26, 40)];
    [self.shortBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.shortBtn.layer.borderWidth = 1;
    self.shortBtn.layer.masksToBounds = YES;
    self.shortBtn.layer.cornerRadius = 5;
    self.shortBtn.layer.borderColor = RGBA(226, 226, 226, 1).CGColor;
    [self.shortBtn addTarget:self action:@selector(shortBtnIsClick)forControlEvents:UIControlEventTouchUpInside];
    [self.shortBtn setTitleColor:RGBA(183, 184, 184, 1) forState:UIControlStateNormal];
    self.shortBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.shortBtn];

    
    self.putinBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.putinBtn setFrame:CGRectMake(10, self.shortField.frame.origin.y+self.shortField.frame.size.height +6 , ScreenWidth-20, 40)];
    [self.view addSubview:self.putinBtn];
    [self.putinBtn setTitle:@"确      定" forState:UIControlStateNormal];
    [self.putinBtn addTarget:self action:@selector(buttonClickSure)forControlEvents:UIControlEventTouchUpInside];
    [self.putinBtn setTitleColor:RGBA(46, 44, 42, 1) forState:UIControlStateNormal];
    self.putinBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.putinBtn setBackgroundColor:RGBA(241, 118, 146, 1)];
    self.putinBtn.layer.borderWidth = 1;
    self.putinBtn.layer.masksToBounds = YES;
    self.putinBtn.layer.cornerRadius = 5;
    self.putinBtn.layer.borderColor = RGBA(226, 226, 226, 1).CGColor;
}


//返回上一页
-(void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//获取短信
-(void)shortBtnIsClick
{
    
}

//确定按钮
-(void)buttonClickSure
{
    SetPsw_VC *setPsw = [[SetPsw_VC alloc] init];
    UINavigationController *setPswNVC = [[UINavigationController alloc] initWithRootViewController:setPsw];
    [self presentViewController:setPswNVC animated:YES completion:nil];
}
@end
