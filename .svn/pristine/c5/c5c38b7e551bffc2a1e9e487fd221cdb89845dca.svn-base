//
//  MyCircle-VC.h
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/5.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//
//》》》》》》》》》》》》》》》我的圈《《《《《《《《《《
#import <UIKit/UIKit.h>
#import "CircleCell.h"
#import "CircleDetails-VC.h"
#import "PrefixHeader.pch"
#import "AFHTTPRequestOperationManager.h"

@interface MyCircle_VC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSUserDefaults *_user;
    NSString *_userId;
    NSString *_quanID;
}
@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;
@property (strong,nonatomic) UITableView *myCircleTableView;
@property (strong,nonatomic) NSArray *myCircleArr;
@property (nonatomic,strong) NSMutableDictionary *dictionary;//关注
@property (strong,nonatomic) NSMutableArray *jieshouArr;
-(void)getDataFromServer;
@end
