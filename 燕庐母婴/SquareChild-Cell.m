//
//  SquareChild-Cell.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/7/2.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "SquareChild-Cell.h"

@implementation SquareChild_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.userHead = [[UIImageView alloc] initWithFrame:CGRectMake(9, 4, 30, 30)];
        self.userHead.layer.masksToBounds = YES;
        self.userHead.layer.cornerRadius = 15;
        [self.contentView addSubview:self.userHead];
        
        
        self.userName = [[UILabel alloc] initWithFrame:CGRectMake( self.userHead.frame.origin.x+self.userHead.frame.size.width+5, 8, 80, 20)];
        self.userName.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
        self.userName.textColor = RGBA(59, 57, 57, 1);
        [self.contentView addSubview:self.userName];
        
        
        self.timelabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-98, 7, 80, 20)];
        self.timelabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
        self.timelabel.textColor = RGBA(59, 57, 57, 1);
        self.timelabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.timelabel];
        
        
        self.sayLab = [[UILabel alloc] init];
        self.sayLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        self.sayLab.textColor = RGBA(59, 57, 57, 1);
        [self.contentView addSubview:self.sayLab];
    }
    return self;
}

@end
