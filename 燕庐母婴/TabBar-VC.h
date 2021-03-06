//
//  TabBar-VC.h
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/11.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Nav-Controller.h"
#import "Baby-VC.h"
#import "Circle-VC.h"
#import "Search-VC.h"
#import "Find-VC.h"
#import "Self-VC.h"
#import "TabBar.h"
#import "Baby-ViewController.h"
#import "NotPregnant-VC.h"
#import "AlreadyBaby-ViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "ChangeStateViewController.h"
@interface TabBar_VC : UITabBarController
@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;

@property (nonatomic,strong) NSUserDefaults *ud;
@property (nonatomic,strong) NSMutableDictionary *dataDic;
@property (nonatomic,strong) NSArray *dataArr;
@end
