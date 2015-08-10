//
//  Baby-ViewController.h
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/7/1.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
@interface Baby_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *tableArr;

@property (strong,nonatomic) NSArray *tixingArr;
@property (strong,nonatomic) NSArray *yingyangArr;
@property (strong,nonatomic) NSArray *knowledgeArr;
@property (strong,nonatomic) NSArray *mustPrepareArr;
@property (strong,nonatomic) NSArray *sameAgeArr;

//@property (strong,nonatomic) UISearchBar *searchBar;
@property (strong,nonatomic) UITextField *searchText;

@property (strong,nonatomic) UIScrollView *scrollView;

@property (strong,nonatomic) NSUserDefaults *ud;
@end
