//
//  CollectViewController.h
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/12.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "AFHTTPRequestOperationManager.h"
@interface CollectViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) AFHTTPRequestOperationManager *manager;
@property (strong,nonatomic) UIScrollView *scrollView;

@property (strong,nonatomic) NSArray *tieziArr;
@property (strong,nonatomic) NSArray *zhishiArr;

@property (strong,nonatomic) UIView *titleView;
@property (strong,nonatomic) UIButton *backBtn;
@property (strong,nonatomic) UIButton *tieziBtn;
@property (strong,nonatomic) UIButton *zhishiBtn;
@property (strong,nonatomic) UIView *lineView;
@property (strong,nonatomic) UIView *tiezilineView;
@property (strong,nonatomic) UIView *zhishilineView;
@property (strong,nonatomic) UITableView *tieziTableView;
@property (strong,nonatomic) UITableView *zhishiTableView;

@property (strong,nonatomic) UIImageView *Img;
//帖子标题
@property (nonatomic,strong) UILabel *titleLab;
//人数图片
@property (nonatomic,strong) UIImageView *personImage;
@property (nonatomic,strong) UILabel *nameLabel;
//时间
@property (nonatomic,strong) UIImageView *timeImg;
@property (nonatomic,strong) UILabel *timeLab;
//信息条数
@property (nonatomic,strong) UIImageView *messageImg;
@property (nonatomic,strong) UILabel *messageLab;

@property (nonatomic,strong) UIImageView *zhuanfaImg;
@property (nonatomic,strong) UILabel *zhuanfacountLabel;


@end
