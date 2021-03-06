//
//  MyTieziViewController.h
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/18.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "AFHTTPRequestOperationManager.h"
#import "MyTieziTableViewCell.h"
#import "TouxiangData.h"
#import "ASIDownloadCache.h"
#import "ASIHTTPRequest.h"
#import "AppDelegate.h"
@interface MyTieziViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) AFHTTPRequestOperationManager *manager;
@property (strong,nonatomic) UIButton *backBtn;
@property (strong,nonatomic) NSArray *dataArr;
@property (strong,nonatomic) UITableView *mytieziTableView;
@property (strong,nonatomic) NSArray *imgArr;
@end
