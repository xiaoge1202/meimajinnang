//
//  SameAge-VC.h
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/5.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//
//》》》》》》》》》》》》》》》同龄圈《《《《《《《《《《《《《《
#import <UIKit/UIKit.h>
#import "CircleCell.h"
#import "CircleDetails-VC.h"
#import "PrefixHeader.pch"
@interface SameAge_VC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSUserDefaults *_user;
    NSString *_userId;
    NSString *_quanID;
    NSString *quanzi;

    CircleCell *cell;
}

@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;
@property (strong,nonatomic) UITableView *sameAgeTableView;
@property (strong,nonatomic) NSMutableArray *sameAgeArr;
@property (strong,nonatomic) NSString *leiid;

@property (nonatomic,strong) NSMutableDictionary *dictionary;//关注

@property (nonatomic,strong) UIButton *guanzhuBtn;
@property (nonatomic,strong) UIButton *quxiaoBtn;

@property (strong,nonatomic) NSMutableArray *myCircleArr;

@property (nonatomic,strong) NSString *guanzhuStr;
@property (nonatomic,strong) NSMutableArray *guanzhuArr;

@end
