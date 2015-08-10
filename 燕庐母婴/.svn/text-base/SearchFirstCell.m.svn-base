//
//  SearchFirstCell.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/7/3.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "SearchFirstCell.h"

@implementation SearchFirstCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.moviePlayerCtl = [[MPMoviePlayerController alloc]init];
        //设置属性
        self.moviePlayerCtl.allowsAirPlay = YES;
        //设置
        self.moviePlayerCtl.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth/16*9);
        //设置缩放模式
        [self.moviePlayerCtl setScalingMode:MPMovieScalingModeAspectFit];
        //设置属性风格
        self.moviePlayerCtl.controlStyle = MPMovieControlStyleEmbedded;
        //添加到本试图控制器视图
        [self.contentView addSubview:self.moviePlayerCtl.view];
        
        
        
        self.imgView = [[UIImageView alloc] initWithFrame:self.moviePlayerCtl.view.frame];
        [self.moviePlayerCtl.view addSubview:self.imgView];
        
        
        //播放按钮
        self.PlayerBtn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth-70)/2,(ScreenWidth/16*9-70)/2, 70, 70)];
        //设置按钮背景图片
        [self.PlayerBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.PlayerBtn];

    }
    return self;
}
@end
