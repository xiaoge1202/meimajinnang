//
//  SetBirthDateViewController.h
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/15.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "AFHTTPRequestOperationManager.h"
#import "TabBar-VC.h"
@interface SetBirthDateViewController : UIViewController
@property (strong,nonatomic) AFHTTPRequestOperationManager *manager;
@property (strong,nonatomic) UIButton *backBtn;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong,nonatomic) UILabel *dayLabel;
@property (strong,nonatomic) NSArray *dataArr;
@property (strong,nonatomic) NSMutableDictionary *dic;

@property (strong,nonatomic) NSString *nameString;
@end
