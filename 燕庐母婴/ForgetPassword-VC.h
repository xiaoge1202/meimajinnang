//
//  ForgetPassword-VC.h
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/2.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "SetPsw-VC.h"
@interface ForgetPassword_VC : UIViewController

@property (strong,nonatomic) UITextField *pet_nameField;
//短信验证
@property (strong,nonatomic) UITextField *shortField;
@property (strong,nonatomic) UIButton *shortBtn;

@property (strong,nonatomic) UIButton *putinBtn;

@end
