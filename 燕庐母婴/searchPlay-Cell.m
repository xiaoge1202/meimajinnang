//
//  searchPlay-Cell.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/19.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "searchPlay-Cell.h"

@implementation searchPlay_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.moviePlayerCtl = [[MPMoviePlayerController alloc]init];
        //设置属性
        self.moviePlayerCtl.allowsAirPlay = YES;
        self.moviePlayerCtl.view.backgroundColor = [UIColor cyanColor];
        //设置
        self.moviePlayerCtl.view.frame = CGRectMake(0, 0, ScreenWidth, 165);
        //设置缩放模式
        [self.moviePlayerCtl setScalingMode:MPMovieScalingModeAspectFit];
        //设置属性风格
        self.moviePlayerCtl.controlStyle = MPMovieControlStyleEmbedded;
        //添加到本试图控制器视图
        [self.contentView addSubview:self.moviePlayerCtl.view];
        
        //播放按钮
        self.PlayerBtn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth-70)/2, 47, 70, 70)];
        [self.contentView addSubview:self.PlayerBtn];

        

    }
    return self;
}

@end
