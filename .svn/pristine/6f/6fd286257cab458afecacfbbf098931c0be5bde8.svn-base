//
//  PlayList-Cell.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/16.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "PlayList-Cell.h"
#import "PrefixHeader.pch"
@implementation PlayList_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        //视频缩略图
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(13, 5, 65, 55)];
        [self.contentView addSubview:self.img];
        
        
        //视频标题
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(self.img.frame.size.width+20, 15, ScreenWidth-self.img.frame.size.width-30, 16)];
        self.titleLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:16];
        [self.contentView addSubview:self.titleLab];
        
        //发布时间
        self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(self.img.frame.size.width+20, 43, 120, 10)];
        self.timeLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        [self.contentView addSubview:self.timeLab];
        
        
//        self.shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-141, 44, 45, 12)];
//        self.shareBtn.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
//        [self.shareBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
//        [self.contentView addSubview:self.shareBtn];
        
        
        self.saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-93, 44, 45, 12)];
        self.saveBtn.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        [self.saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
        [self.contentView addSubview:self.saveBtn];
        
        
        
        self.zanBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-45, 44, 45, 12)];
        self.zanBtn.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        [self.zanBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
        [self.contentView addSubview:self.zanBtn];

    }
    return self;
}


@end
