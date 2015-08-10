//
//  reply_Cell.m
//  燕庐母婴
//
//  Created by apple on 15/6/25.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "reply_Cell.h"
#import "PrefixHeader.pch"

@implementation reply_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImage= [[UIImageView alloc] initWithFrame:CGRectMake(6, 8, 35, 35)];
        self.headImage.image = [UIImage imageNamed:@"系统消息"];
        [self.contentView addSubview:self.headImage];
        
        
        //用户昵称
        self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(46,11, 200, 15)];
        self.titleLab.textColor=RGBA(89, 87, 87, 1);

        self.titleLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        [self addSubview:self.titleLab];
        //时间
        self.timeLab=[[UILabel alloc]init];
        self.timeLab.font=[UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        [self addSubview:self.timeLab];
        self.timeLab.textColor=RGBA(137, 137, 137, 1);
        self.timeLab.text=@"6月28日 22：45";
        self.timeLab.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLab
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:11]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLab
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-3]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLab
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:0
                                                                      constant:100]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLab
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:15]];
//主体内容
        self.contentLab = [[UILabel alloc]initWithFrame:CGRectMake(46,self.titleLab.bounds.origin.y+self.titleLab.bounds.size.height+5,SCREEN_WIDTH-62, 34)];
        self.contentLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:17];
        self.contentLab.textColor=RGBA(89, 87, 87, 1);
        [self addSubview:self.contentLab];
        //回复的内容


        self.huifuContent=[[UITextView alloc]init];
         self.huifuContent.font=[UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        self.huifuContent.userInteractionEnabled=NO;
        [self addSubview:self.huifuContent];
//
          }
    return self;
}
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
}

@end
