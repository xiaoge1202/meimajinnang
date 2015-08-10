//
//  Neirong-VC.h
//  美妈锦囊
//
//  Created by 侯泽彭 on 15/8/7.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"
#import "PrefixHeader.pch"
#import "MBProgressHUD.h"
#import "AFHTTPRequestOperationManager.h"

@interface Neirong_VC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (strong,nonatomic) AFHTTPRequestOperationManager *manager;
@end
