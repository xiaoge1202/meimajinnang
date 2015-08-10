//
//  Search-VC.h
//  滚动视图
//
//  Created by 董飞剑 on 15/5/28.
//  Copyright (c) 2015年 侯泽彭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iflyMSC/IFlyRecognizerView.h>
#import <iflyMSC/IFlyRecognizerViewDelegate.h>
#import <iflyMSC/IFlySpeechConstant.h>
#import <iflyMSC/IFlySpeechUtility.h>
#import "AFHTTPRequestOperationManager.h"
#import "PrefixHeader.pch"
#import "SearchFirstCell.h"
#import "SearchCell.h"
#import "PlayList-VC.h"
#import "SearchResult-VC.h"
#import "UIImage+Video.h"
@interface Search_VC : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    SearchResult_VC *searchResult;
    SearchFirstCell *firstCell;
}

@property (nonatomic, strong) NSString *result;

@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIView *headView;
@property (strong,nonatomic) UILabel *headTitleLab;


@property (strong,nonatomic) UIView *searchBarBackGroundView;
@property (strong,nonatomic) UISearchBar *searchBar;
@property (strong,nonatomic) UIButton *searchBtn;
@property (strong,nonatomic) UIButton *speechBtn;

@property (strong,nonatomic) NSArray *apperArr;
@property (strong,nonatomic) NSURL *fileURL;

@property (strong,nonatomic) NSArray *dataArr;//存放分类信息

@property (strong,nonatomic) NSString *searchStr;

////播放控制器
//@property (strong,nonatomic) MPMoviePlayerController *moviePlayerCtl;

@end
