//
//  SearchResult-VC.h
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/15.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
#import "PrefixHeader.pch"
#import "Play-VC.h"
#import <iflyMSC/IFlyRecognizerView.h>
#import <iflyMSC/IFlyRecognizerViewDelegate.h>
#import <iflyMSC/IFlySpeechConstant.h>
#import <iflyMSC/IFlySpeechUtility.h>

@interface SearchResult_VC : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,IFlyRecognizerViewDelegate>

@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;

@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;
@property (nonatomic, strong) NSString *result;

@property (strong,nonatomic) UIButton *backBtn;
@property (strong,nonatomic) UITableView *tableView;


@property (strong,nonatomic) UIView *searchBarBackGroundView;
@property (strong,nonatomic) UISearchBar *searchBar;
@property (strong,nonatomic) UIButton *speechBtn;


@property (strong,nonatomic) NSMutableArray *resultArr;
@property (strong,nonatomic) NSString *searchStr;

@end
