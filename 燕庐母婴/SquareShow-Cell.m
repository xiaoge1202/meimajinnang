//
//  SquareShow-Cell.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/28.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "SquareShow-Cell.h"

@implementation SquareShow_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {

        
        //--------------朗读标志--------------------
        self.voiceBtn = [[UIButton alloc] initWithFrame:CGRectMake(11, 13, 18, 12)];
        [self.voiceBtn setImage:[UIImage imageNamed:@"icon-shengyin"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.voiceBtn];
        
        
        //--------------说明文字-----------------------
        self.showLabel = [[UILabel alloc] init];
        self.showLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        self.showLabel.textColor = RGBA(72, 71, 71, 1);
        [self.contentView addSubview:self.showLabel];
        
        
        //观看次数
        self.lookTime = [[UIButton alloc] init];
        [self.lookTime setImage:[UIImage imageNamed:@"see"] forState:UIControlStateNormal];
        self.lookTime.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        [self.lookTime setTitleColor:RGBA(72, 71, 71, 1) forState:UIControlStateNormal];
        [self.lookTime setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
        [self.contentView addSubview:self.lookTime];
        
        
        //喜欢人数
        self.loveNum = [[UIButton alloc] init];
        [self.loveNum setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
        self.loveNum.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        [self.loveNum setTitleColor:RGBA(72, 71, 71, 1) forState:UIControlStateNormal];
        [self.loveNum setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
        [self.contentView addSubview:self.loveNum];


        //评论条数
        self.reviewNum = [[UIButton alloc] init];
        [self.reviewNum setImage:[UIImage imageNamed:@"回复"] forState:UIControlStateNormal];
        [self.reviewNum setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
        self.reviewNum.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        [self.reviewNum setTitleColor:RGBA(72, 71, 71, 1) forState:UIControlStateNormal];
        [self.contentView addSubview:self.reviewNum];

        
        //红线
        self.redLineView = [[UIView alloc] init];
        self.redLineView.backgroundColor = RGBA(241, 113, 142, 1);
        [self.contentView addSubview:self.redLineView];
        
        
        //更多按钮
        self.moreBtn = [[UIButton alloc] init];
        [self.moreBtn setImage:[UIImage imageNamed:@"icon-gengduo"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.moreBtn];


        //收藏按钮
        self.addBtn = [[UIButton alloc] init];
        [self.contentView addSubview:self.addBtn];

        
        //分享按钮
        self.shareBtn = [[UIButton alloc] init];
        [self.shareBtn setImage:[UIImage imageNamed:@"icon-fenxiang"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.shareBtn];


        //点赞按钮
        self.loveBtn = [[UIButton alloc] init];
        [self.contentView addSubview:self.loveBtn];
    }
    return self;
}

@end
