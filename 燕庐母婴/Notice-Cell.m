//
//  Notice-Cell.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/7/5.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "Notice-Cell.h"

@implementation Notice_Cell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.TVview = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, (ScreenWidth-49)/2-6, 165)];
        [self.contentView addSubview:self.TVview];
        
        
        self.userHead = [[UIImageView alloc] initWithFrame:CGRectMake(3, 157, 45, 45)];
        self.userHead.layer.masksToBounds = YES;
        self.userHead.layer.cornerRadius = 22.5;
        [self.contentView addSubview:self.userHead];
        
        
        self.userName = [[UILabel alloc] initWithFrame:CGRectMake(self.userHead.frame.size.width+self.userHead.frame.origin.x+5, self.TVview.frame.origin.y+self.TVview.frame.size.height+3, 75, 15)];
        self.userName.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:11];
        self.userName.textColor = RGBA(89, 87, 87, 1);
        [self.contentView addSubview:self.userName];
        
        
        self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(self.userHead.frame.size.width+self.userHead.frame.origin.x+5, self.userName.frame.size.height+self.userName.frame.origin.y+3, 75, 10)];
        self.timeLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:8];
        self.timeLab.textColor = RGBA(89, 87, 87, 1);
        [self.contentView addSubview:self.timeLab];
    }
    return self;
}

@end
