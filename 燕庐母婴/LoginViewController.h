//
//  LoginViewController.h
//  YanLuMuYing
//
//  Created by 赵天韡 on 15/1/16.
//  Copyright (c) 2015年 赵天韡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong,nonatomic) UITextField *pet_nameField;
@property (strong,nonatomic) UITextField *passwordField;
@property (strong,nonatomic) UITextField *notarizePasswordField;
@property (strong,nonatomic) UIButton *putinBtn;
@property (strong,nonatomic) UIButton *gotoBtn;

@property (strong,nonatomic) NSMutableDictionary *dic;

@end
