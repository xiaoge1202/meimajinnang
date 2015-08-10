//
//  CircleCell.h
//  滚动视图
//
//  Created by 董飞剑 on 15/5/28.
//  Copyright (c) 2015年 侯泽彭. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
@interface CircleCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headImg;//圈子头像

@property (nonatomic,strong) UILabel *circleNameLabel;//圈子名称

@property (nonatomic,strong) UIImageView *peopleNumImg;//人数图片
@property (nonatomic,strong) UILabel *peopleNumLabel;//人数

@property (nonatomic,strong) UIImageView *speakNumImg;//话题图片
@property (nonatomic,strong) UILabel *speakNumLabel;//话题数量

@property (nonatomic,strong) UIButton *saveBtn;//收藏按钮
@property (strong,nonatomic) UIView *view2;
@property (nonatomic,strong) UIButton *saveBtn1;//圈成员
@property (nonatomic,strong) UIButton *saveBtn2;//圈管理
@property (nonatomic,strong) UIButton *saveBtn3;//圈精华
@end
