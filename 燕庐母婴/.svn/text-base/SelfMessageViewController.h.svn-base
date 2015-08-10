//
//  SelfMessageViewController.h
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/9.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "SetNameViewController.h"
#import "ChangeStateViewController.h"
#import "ASIFormDataRequest.h"
#import "AFHTTPRequestOperationManager.h"
@interface SelfMessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong,nonatomic) AFHTTPRequestOperationManager *manager;
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *messageArr;

@property (strong,nonatomic) UIImageView *backImg;
@property (strong,nonatomic) UIImageView *touxiangImg;
@property (strong,nonatomic) UILabel *nameLabel;
@property (strong,nonatomic) UILabel *babybirthLabel;
@property (strong,nonatomic) UILabel *sexLabel;
@property (strong,nonatomic) NSString *touxiang;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) UIImage *back;
@property (strong,nonatomic) NSString *state;

@property (strong,nonatomic) UIButton *backBtn;

@property (nonatomic,strong) UIImagePickerController *picker;
@property (nonatomic,strong) NSMutableDictionary *dic;
@property (nonatomic,strong) NSUserDefaults *ud;
@end
