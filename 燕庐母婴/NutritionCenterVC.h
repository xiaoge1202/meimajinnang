//
//  NutritionCenterVC.h
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/7/14.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "AFHTTPRequestOperationManager.h"
@interface NutritionCenterVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *yingyangArr;
@property (nonatomic,strong) NSString* idStr;
@property (nonatomic,strong) NSString *biaotiStr;
@property (nonatomic,strong) NSString *imgStr;

@property (nonatomic,strong) NSDictionary *zhuliaoDic;
@property (nonatomic,strong) NSDictionary *fuliaoDic;
@property (nonatomic,strong) NSDictionary *buzouDic;
@property (nonatomic,strong) NSDictionary *buzoutupianDic;


@property (nonatomic,strong) NSMutableArray *labelArr1;
@property (nonatomic,strong) NSMutableArray *labelArr2;
@property (nonatomic,strong) NSMutableArray *labelArr3;
@property (nonatomic,strong) NSMutableArray *labelArr4;

@property (nonatomic,strong) NSMutableArray *labelArr5;
@property (nonatomic,strong) NSMutableArray *labelArr6;
@property (nonatomic,strong) NSMutableArray *labelArr7;
@property (nonatomic,strong) NSMutableArray *labelArr8;


@property (nonatomic,strong) NSMutableArray *zhuliaoStrArr;
@property (nonatomic,strong) NSMutableArray *fuliaoStrArr;

@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end
