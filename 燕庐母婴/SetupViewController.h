//
//  SetupViewController.h
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/9.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "EnterViewController.h"
@interface SetupViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) UIButton *backBtn;
@property (nonatomic,strong) UITableView *tableView;
@end
