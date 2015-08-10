//
//  BeiyunTableViewCell.m
//  美妈锦囊
//
//  Created by 侯泽彭 on 15/8/7.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "BeiyunTableViewCell.h"

@implementation BeiyunTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 60, 50)];
        [self addSubview:self.imgView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.frame.origin.x+self.imgView.frame.size.width+15, 20, ScreenWidth-(self.imgView.frame.origin.x+self.imgView.frame.size.width+15), 12)];
        self.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        self.titleLabel.textColor = RGBA(89, 87, 87, 1);
        [self addSubview:self.titleLabel];
        
        self.nameImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.imgView.frame.origin.x+self.imgView.frame.size.width+15, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+12, 10, 12)];
        self.nameImg.image = [UIImage imageNamed:@"人数"];
        [self addSubview:self.nameImg];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameImg.frame.origin.x+self.nameImg.frame.size.width+5, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+15, 60, 9)];
        self.nameLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
        self.nameLabel.textColor = RGBA(137, 137, 137, 1);
        [self addSubview:self.nameLabel];
        
        self.liulanImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.nameLabel.frame.origin.x+self.nameLabel.frame.size.width+50, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+15, 12, 9)];
        self.liulanImg.image = [UIImage imageNamed:@"see"];
        [self addSubview:self.liulanImg];
        
        self.liulanLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.liulanImg.frame.origin.x+self.liulanImg.frame.size.width+5, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+15, 30, 9)];
        self.liulanLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
        self.liulanLabel.textColor = RGBA(137, 137, 137, 1);
        [self addSubview:self.liulanLabel];
        
    }
    
    return self;
}

@end
