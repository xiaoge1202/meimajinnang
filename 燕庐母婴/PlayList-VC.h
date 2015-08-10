//
//  PlayList-VC.h
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/12.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import <iflyMSC/IFlyRecognizerView.h>
#import <iflyMSC/IFlyRecognizerViewDelegate.h>
#import <iflyMSC/IFlySpeechConstant.h>
#import <iflyMSC/IFlySpeechUtility.h>
#import "AFHTTPRequestOperationManager.h"
#import "PlayList-Cell.h"
#import "UIImage+Video.h"
@interface PlayList_VC : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,IFlyRecognizerViewDelegate>
{
    NSUserDefaults *_user;
    NSString *_userId;
    BOOL isSearch;
}
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;

@property (strong,nonatomic) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) NSString *result;

@property (strong,nonatomic) UIView *searchBarBackGroundView;
@property (strong,nonatomic) UISearchBar *searchBar;
@property (strong,nonatomic) UIButton *speechBtn;


@property (strong,nonatomic) UITableView *tableView;


@property (strong,nonatomic) NSArray *dataArr;
@property (strong,nonatomic) NSString *titleStr;
@property (strong,nonatomic) NSString *canShuStr;
@property (strong,nonatomic) NSArray *searchArr;
@property (strong,nonatomic) NSMutableArray *biaotiArr;

@property (strong,nonatomic) NSURL *shipinURL;
@end
