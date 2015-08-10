//
//  AlreadyBaby-ViewController.h
//  燕庐母婴
//
//  Created by zhaodeyu on 15/7/15.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "AFHTTPRequestOperationManager.h"
#import "ArticlDetailsViewController.h"
#import "PostsDetails-VC.h"
#import "NutritionCenterVC.h"
#import "Search-VC.h"
#import "MomTV-VC.h"
#import "Message_VC.h"
@interface AlreadyBaby_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UISearchBarDelegate,UITextViewDelegate>


@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *tableArr;
@property (strong,nonatomic) NSArray *imgArr;
@property (strong,nonatomic) NSArray *textArr;

@property (strong,nonatomic) NSArray *tixingArr;
@property (strong,nonatomic) NSArray *yingyangArr;
@property (strong,nonatomic) NSArray *knowledgeArr;
@property (strong,nonatomic) NSArray *mustPrepareArr;
@property (strong,nonatomic) NSArray *sameAgeArr;
@property (strong,nonatomic) NSArray *chengzhangArr;

//@property (strong,nonatomic) UISearchBar *searchBar;
@property (strong,nonatomic) UIButton *searchText;

@property (strong,nonatomic) UIScrollView *titleScrollView;

@property (strong,nonatomic) NSUserDefaults *ud;

@property (strong,nonatomic) UISearchBar *searchBar;

@property (strong,nonatomic) NSMutableDictionary *dataDic;
@property (strong,nonatomic) NSArray *dataArr;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic) CGFloat viewSize;

@property (nonatomic,strong) NSMutableArray *titleArr;
@property (nonatomic,strong) NSMutableArray *sizesArr;

@property (nonatomic,strong) NSString *t_id;

@end
