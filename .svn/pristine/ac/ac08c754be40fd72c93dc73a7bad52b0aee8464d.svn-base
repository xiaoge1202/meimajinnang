//
//  Top-listCell.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/7/2.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "Top-listCell.h"

@implementation Top_listCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.TVview = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, (ScreenWidth-63)/2, 130)];
        [self.contentView addSubview:self.TVview];
        
        
        self.userHead = [[UIImageView alloc] initWithFrame:CGRectMake(3, 118, 35, 35)];
        self.userHead.layer.masksToBounds = YES;
        self.userHead.layer.cornerRadius = 17.5;
        [self.contentView addSubview:self.userHead];
        
        
        self.userName = [[UILabel alloc] initWithFrame:CGRectMake(self.userHead.frame.size.width+self.userHead.frame.origin.x+5, self.TVview.frame.origin.y+self.TVview.frame.size.height, 75, 15)];
        self.userName.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:11];
        self.userName.textColor = RGBA(89, 87, 87, 1);
        [self.contentView addSubview:self.userName];
        
        
        self.loveNumLab = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-63)/2-40, self.TVview.frame.size.height+self.TVview.frame.origin.y+8, 75, 10)];
        self.loveNumLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:8];
        self.loveNumLab.textColor = RGBA(89, 87, 87, 1);
        [self.contentView addSubview:self.loveNumLab];
        
    }
    return self;
}

@end
