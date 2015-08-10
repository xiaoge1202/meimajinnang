//
//  SearchFirstCell.h
//  燕庐母婴
//
//  Created by 董飞剑 on 15/7/3.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "PrefixHeader.pch"
@interface SearchFirstCell : UITableViewCell

//播放控制器
@property (strong,nonatomic) MPMoviePlayerController *moviePlayerCtl;
//播放按钮
@property (strong,nonatomic) UIButton *PlayerBtn;
//视频缩略图
@property (strong,nonatomic) UIImageView *imgView;

@end
