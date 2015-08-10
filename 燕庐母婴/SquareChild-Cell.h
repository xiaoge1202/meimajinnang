//
//  SquareChild-Cell.h
//  燕庐母婴
//
//  Created by 董飞剑 on 15/7/2.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
@interface SquareChild_Cell : UITableViewCell

@property (strong,nonatomic) UIImageView *userHead; //用户头像
@property (strong,nonatomic) UILabel *userName;//用户昵称
@property (strong,nonatomic) UILabel *timelabel;//发布时间
@property (strong,nonatomic) UILabel *sayLab;//说说内容

@end
