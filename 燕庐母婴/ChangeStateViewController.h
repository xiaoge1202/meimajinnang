//
//  ChangeStateViewController.h
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/15.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "AFHTTPRequestOperationManager.h"
#import "SetDueDateViewController.h"
#import "SetBirthDateViewController.h"
#import "TabBar-VC.h"

@protocol ChangeStateViewControllerDelegate <NSObject>

-(void)getMesArr:(NSArray*)mesArr;

@end

@interface ChangeStateViewController : UIViewController

@property (nonatomic,strong) id<ChangeStateViewControllerDelegate>delegate;

@property (strong,nonatomic) AFHTTPRequestOperationManager *manager;

@property (strong,nonatomic) NSArray *dataArr;
@property (strong,nonatomic) UIButton *backBtn;

@property (strong,nonatomic) UIButton *beiyunBtn;
@property (strong,nonatomic) UIButton *huaiyunBtn;
@property (strong,nonatomic) UIButton *chushengBtn;
@property (strong,nonatomic) NSMutableDictionary *dic;

@property (nonatomic,strong) NSString *nameString;

@property (nonatomic,strong) NSArray *messageArr;
@end
