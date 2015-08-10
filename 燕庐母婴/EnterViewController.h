//
//  EnterViewController.h
//  帖子列表
//
//  Created by 董飞剑 on 15/1/10.
//  Copyright (c) 2015年 DongFeiJian. All rights reserved.


//》》》》》》》》》》》》》》登陆页面《《《《《《《《《《《《《《《《《《《

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
#import "PrefixHeader.pch"
#import "LoginViewController.h"
#import "ForgetPassword-VC.h"
#import "UserModel.h"
#import "ChangeStateViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
@interface EnterViewController : UIViewController<TencentSessionDelegate>

@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) NSString *username;

@property (strong, nonatomic) TencentOAuth *tencent;
@property (strong, nonatomic) NSArray *permission;
@property (strong,nonatomic) UITextView *textView;
@end
