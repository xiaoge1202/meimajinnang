//
//  SetDueDateViewController.h
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/15.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "AFHTTPRequestOperationManager.h"
@interface SetDueDateViewController : UIViewController<UIScrollViewDelegate>
@property (strong,nonatomic) UIButton *backBtn;
@property (strong,nonatomic) AFHTTPRequestOperationManager *manager;
@property (strong,nonatomic) UIButton *shuruBtn;
@property (strong,nonatomic) UIButton *jisuanBtn;
@property (strong,nonatomic) UIView *shuruView;
@property (strong,nonatomic) UIView *jisuanView;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIView *titleView;
@property (strong,nonatomic) UIView *lineView;
@property (strong,nonatomic) UIView *view1;
@property (strong,nonatomic) UIView *view2;

@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong,nonatomic) UILabel *dayLabel1;
@property (strong,nonatomic) UILabel *dayLabel2;
@property (strong,nonatomic) UILabel *huaiyuntianshuLabel1;
@property (strong,nonatomic) UILabel *huaiyuntianshuLabel2;
@property (strong,nonatomic) NSMutableDictionary *dic;
@property (strong,nonatomic) NSArray *dataArr;
@end
