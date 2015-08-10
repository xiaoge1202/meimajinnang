//
//  Second-Cell.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/12.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "Second-Cell.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
@implementation Second_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.guideAuthorLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, 200, 18)];
        self.guideAuthorLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        [self addSubview:self.guideAuthorLab];
    
        
        self.moviePlayerCtl = [[MPMoviePlayerController alloc]init];
        //设置属性
        self.moviePlayerCtl.allowsAirPlay = YES;
        //设置
        self.moviePlayerCtl.view.frame = CGRectMake(13, 41, ScreenWidth-26, 222);
        //设置缩放模式
        [self.moviePlayerCtl setScalingMode:MPMovieScalingModeAspectFit];
        //设置属性风格
        self.moviePlayerCtl.controlStyle = MPMovieControlStyleEmbedded;
        //添加到本试图控制器视图
        [self.contentView addSubview:self.moviePlayerCtl.view];
        
        
        //视频缩略图
        self.imgView = [[UIImageView alloc] initWithFrame:self.moviePlayerCtl.view.frame];
        [self.contentView addSubview:self.imgView];
        
        
        
        //播放按钮
        self.PlayerBtn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth-70)/2, 112, 70, 70)];
        [self.contentView addSubview:self.PlayerBtn];

        
        //收藏
        self.saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-115, self.moviePlayerCtl.view.frame.size.height+self.moviePlayerCtl.view.frame.origin.y+10, 50, 18)];
        self.saveBtn.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        [self.contentView addSubview:self.saveBtn];
        
        
        //点赞
        self.zanBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-55, self.moviePlayerCtl.view.frame.size.height+self.moviePlayerCtl.view.frame.origin.y+10, 50, 18)];
        self.zanBtn.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        [self addSubview:self.zanBtn];

    }
    return self;
}

@end
