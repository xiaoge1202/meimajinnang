//
//  huiFu_Cell.m
//  美妈锦囊
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "huiFu_Cell.h"
#import "PrefixHeader.pch"

@implementation huiFu_Cell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //初始化布局
        
        

        
        //体检时间的图片
        self.titleImage=[[UIImageView alloc]init];
        self.titleImage.image=[UIImage imageNamed:@"测试头像"];
        [self.contentView addSubview:self.titleImage];
        self.titleImage.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleImage
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:7.5]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleImage
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleImage
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:0
                                                                      constant:75]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleImage
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:60]];
        

        //标题
        self.title=[[UILabel alloc]init];
        self.title.textColor = [UIColor blackColor];
        self.title.text=@"宝宝第一次体检";
        self.title.textColor=RGBA(63, 62, 61, 1);
        self.title.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:17];
        self.title.textAlignment=NSTextAlignmentLeft;
        
        [self.contentView addSubview:self.title];
        
        self.title.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.title
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:20]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.title
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.titleImage
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.title
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:20]];
        
        //备注
        self.remark=[[UILabel alloc]init];
        self.remark.textColor = [UIColor blackColor];
        self.remark.text=@"宝宝第一次体检";
        self.remark.textColor=RGBA(163, 162, 161, 1);
        self.remark.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        self.remark.textAlignment=NSTextAlignmentLeft;
        
        [self.contentView addSubview:self.remark];
        
        self.remark.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.remark
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.title
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.remark
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.titleImage
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.remark
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:12]];
        
        
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);

    
    //下分割线
    CGContextSetStrokeColorWithColor(context,RGBA(224, 225, 225, 1).CGColor);
    CGContextStrokeRect(context, CGRectMake(5, rect.size.height, rect.size.width - 10, 1));
}
@end
