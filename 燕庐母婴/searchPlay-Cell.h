//
//  searchPlay-Cell.h
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/19.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "PrefixHeader.pch"
@interface searchPlay_Cell : UITableViewCell

@property (strong,nonatomic) MPMoviePlayerController *moviePlayerCtl;
//播放按钮
@property (strong,nonatomic) UIButton *PlayerBtn;
@property (strong,nonatomic) UIImageView *img;
@end
