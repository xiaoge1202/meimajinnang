//
//  NotPregnant-VC.h
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/7/15.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "AFHTTPRequestOperationManager.h"
#import "ArticlDetailsViewController.h"
#import "PostsDetails-VC.h"
#import "NutritionCenterVC.h"
#import "ChangeStateViewController.h"
#import "Search-VC.h"
#import "Message_VC.h"
#import "Beiyun-VC.h"
#import "MoreZhishi-VC.h"
@interface NotPregnant_VC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UISearchBarDelegate,UITextViewDelegate>

@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *tableArr;
@property (strong,nonatomic) NSArray *imgArr;
@property (strong,nonatomic) NSArray *textArr;


@property (strong,nonatomic) NSArray *knowledgeArr;
@property (strong,nonatomic) NSArray *mustPrepareArr;
@property (strong,nonatomic) NSArray *sameAgeArr;


//@property (strong,nonatomic) UISearchBar *searchBar;
@property (strong,nonatomic) UIButton *searchText;

@property (strong,nonatomic) UIScrollView *titleScrollView;

@property (strong,nonatomic) UISearchBar *searchBar;

@property (strong,nonatomic) NSMutableDictionary *dataDic;
@property (strong,nonatomic) NSArray *dataArr;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic) CGFloat viewSize;

@property (nonatomic,strong) NSString *t_id;

@end
