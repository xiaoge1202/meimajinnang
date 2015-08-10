//
//  Play-VC.h
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/12.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Second-Cell.h"
#import "AFHTTPRequestOperationManager.h"
@interface Play_VC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSURL *fileURL;
    CGSize size;
    CGSize size1;
    CGSize size2;
    CGSize size3;
    
    NSUserDefaults *_user;
    NSString *_userId;
    
    Second_Cell *secondCell;
}
@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *dataArr;
@property (strong,nonatomic) NSString *listID;
@property (strong,nonatomic) NSString *canshuStr;

@property (strong,nonatomic) UIButton *backBtn;
@property (strong,nonatomic) UIButton *shareBtn;
@property (strong,nonatomic) NSMutableArray *aboutArr;//相关视频

@end
