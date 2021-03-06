//
//  SquareShow-Cell.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/28.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "SquareShow-Cell.h"

@implementation SquareShow_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {

        
        //--------------朗读标志--------------------
        self.voiceBtn = [[UIButton alloc] initWithFrame:CGRectMake(11, 13, 18, 12)];
        [self.voiceBtn setImage:[UIImage imageNamed:@"icon-shengyin"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.voiceBtn];
        
        
        //--------------说明文字-----------------------
        self.showLabel = [[UILabel alloc] init];
        self.showLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        self.showLabel.textColor = RGBA(72, 71, 71, 1);
        [self.contentView addSubview:self.showLabel];
        
        
        //观看次数
        self.lookTimeImg = [[UIImageView alloc] init];
        [self.contentView addSubview:self.lookTimeImg];
        
        
        self.lookTimeLab = [[UILabel alloc] init];
        self.lookTimeLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        self.lookTimeLab.textAlignment = NSTextAlignmentLeft;

        self.lookTimeLab.textColor = RGBA(72, 71, 71, 1);
        [self.contentView addSubview:self.lookTimeLab];
        
        
        //喜欢人数
        self.loveNumImg = [[UIImageView alloc] init];
        [self.contentView addSubview:self.loveNumImg];

        
        self.loveNumLab = [[UILabel alloc] init];
        self.loveNumLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        self.loveNumLab.textAlignment = NSTextAlignmentLeft;
        self.loveNumLab.textColor = RGBA(72, 71, 71, 1);
        [self.contentView addSubview:self.loveNumLab];
        
        
        //评论条数
        self.reviewNumImg = [[UIImageView alloc] init];
        [self.contentView addSubview:self.reviewNumImg];

        
        self.reviewNumLab = [[UILabel alloc] init];
        self.reviewNumLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        self.reviewNumLab.textAlignment = NSTextAlignmentLeft;
        self.reviewNumLab.textColor = RGBA(72, 71, 71, 1);
        [self.contentView addSubview:self.reviewNumLab];
        
        //红线
        self.redLineView = [[UIView alloc] init];
        self.redLineView.backgroundColor = RGBA(241, 113, 142, 1);
        [self.contentView addSubview:self.redLineView];
        
        
        //更多按钮
        self.moreBtn = [[UIButton alloc] init];
        [self.moreBtn setImage:[UIImage imageNamed:@"icon-gengduo"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.moreBtn];


        //收藏按钮
        self.addBtn = [[UIButton alloc] init];
        [self.contentView addSubview:self.addBtn];

        
        //分享按钮
        self.shareBtn = [[UIButton alloc] init];
        [self.shareBtn setImage:[UIImage imageNamed:@"icon-fenxiang"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.shareBtn];


        //点赞按钮
        self.loveBtn = [[UIButton alloc] init];
        [self.contentView addSubview:self.loveBtn];
    }
    return self;
}

@end
