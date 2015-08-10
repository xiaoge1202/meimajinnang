//
//  Baby-VC.h
//  滚动视图
//
//  Created by 董飞剑 on 15/5/28.
//  Copyright (c) 2015年 侯泽彭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "ArticlDetailsViewController.h"
#import "UserModel.h"
#import "TodayMustReadData.h"
#import "ASIDownloadCache.h"
#import "ASIHTTPRequest.h"
#import "AppDelegate.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]
@interface Baby_VC : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (strong,nonatomic)AFHTTPRequestOperationManager *manager;
@property (strong,nonatomic) UILabel *weekLabel;
@property (strong,nonatomic) UILabel *dayLabel;
@property (strong,nonatomic) UILabel *weekdayLabel;

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSArray *tableArr;
@property (strong,nonatomic) NSArray *dataArr;//服务器获取数据得数组
@property (strong,nonatomic) NSArray *babyGrowArr;
@property (strong,nonatomic) NSArray *todayMustDoArr;
@property (strong,nonatomic) NSArray *todayMustReadArr;
@property (strong,nonatomic) NSArray *todayMustReadImgArr;
@property (strong,nonatomic) NSArray *weekMustPrePareArr;
@property (strong,nonatomic) NSArray *weekAttentionArr;
@property (strong,nonatomic) NSArray *todayRecordArr;

@property (strong,nonatomic) NSUserDefaults *ud;

@end
