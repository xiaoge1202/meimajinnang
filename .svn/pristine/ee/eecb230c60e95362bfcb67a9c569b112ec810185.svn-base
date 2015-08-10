//
//  Self-VC.h
//  滚动视图
//
//  Created by 董飞剑 on 15/5/28.
//  Copyright (c) 2015年 侯泽彭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "AFNetworking.h"
#import "ASIFormDataRequest.h"
#import "SelfMessageViewController.h"
#import "SetupViewController.h"
#import "CollectViewController.h"
#import "MyreturnTieziViewController.h"
#import "MyTieziViewController.h"
#import "TouxiangData.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface Self_VC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong,nonatomic) AFHTTPRequestOperationManager *manager;

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) NSMutableArray *textArr;
@property (strong,nonatomic) NSArray *textArr1;
@property (strong,nonatomic) NSArray *textArr2;

@property (strong,nonatomic) NSArray *imgViewArr1;
@property (strong,nonatomic) NSArray *imgViewArr2;

@property (strong,nonatomic) UIButton *titleImgView;
@property (strong,nonatomic) UIButton *touxiangBtn;
@property (strong,nonatomic) UILabel *userName;
@property (strong,nonatomic) UILabel *zhuangtaiLabel;

@property (strong,nonatomic) NSUserDefaults *ud;
@property(nonatomic,strong)UIImagePickerController *picker;

@end
