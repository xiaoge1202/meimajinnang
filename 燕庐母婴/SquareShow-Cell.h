//
//  SquareShow-Cell.h
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/28.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
@interface SquareShow_Cell : UITableViewCell

@property (strong,nonatomic) UIButton *voiceBtn;  //朗诵按钮
@property (strong,nonatomic) UILabel *showLabel;  //说明内容


@property (strong,nonatomic) UIButton *lookTime;  //观看次数
@property (strong,nonatomic) UIButton *loveNum;   //喜欢人数
@property (strong,nonatomic) UIButton *reviewNum; //评论条数

@property (strong,nonatomic) UIView *redLineView;  //红线

@property (strong,nonatomic) UIButton *moreBtn;   //更多按钮
@property (strong,nonatomic) UIButton *addBtn;    //添加按钮
@property (strong,nonatomic) UIButton *shareBtn;  //分享按钮
@property (strong,nonatomic) UIButton *loveBtn;   //点赞按钮

@end
