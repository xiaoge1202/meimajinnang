//
//  Feeling-VC.h
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/5.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//
//》》》》》》》》》》》》》》》情感《《《《《《《《《《《《《《
#import <UIKit/UIKit.h>
#import "CircleCell.h"
#import "CircleDetails-VC.h"
#import "PrefixHeader.pch"
@interface Feeling_VC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSUserDefaults *_user;
    NSString *_userId;
    NSString *_quanID;
    CircleCell *cell;
    NSString *quanzi;
}
@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;
@property (strong,nonatomic) UITableView *feelingTableView;
@property (strong,nonatomic) NSMutableArray *feelingArr;
@property (strong,nonatomic) NSString *leiid;
@property (nonatomic,strong) NSMutableDictionary *dictionary;//关注

@end
