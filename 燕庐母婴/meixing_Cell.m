//
//  meixing_Cell.m
//  美妈锦囊
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "meixing_Cell.h"
#import "PrefixHeader.pch"
@implementation meixing_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //初始化布局
        
        

        //标题
        self.title=[[UILabel alloc]init];
        self.title.textColor = [UIColor blackColor];
        self.title.text=@"产后注意事项";
        self.title.textColor=RGBA(95, 94, 94, 1);
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
                                                                      constant:15]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.title
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.title
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:20]];

        
        //作者的图片
        self.zuozheImage=[[UIImageView alloc]init];
        self.zuozheImage.image=[UIImage imageNamed:@"作者"];
        [self.contentView addSubview:self.zuozheImage];
        self.zuozheImage.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.zuozheImage
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.title
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.zuozheImage
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.zuozheImage
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:0
                                                                      constant:9]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.zuozheImage
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:12]];

        //作者的名称
        self.zuozheName=[[UILabel alloc]init];
        self.zuozheName.textColor = [UIColor blackColor];
        self.zuozheName.text=@"产后注意事项";
        self.zuozheName.textColor=RGBA(95, 94, 94, 1);
        self.zuozheName.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:13];
        self.zuozheName.textAlignment=NSTextAlignmentLeft;
        
        [self.contentView addSubview:self.zuozheName];
        
        self.zuozheName.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.zuozheName
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.title
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.zuozheName
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.zuozheImage
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:5]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.zuozheName
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:13]];

        
        
        //观看数量
        self.guankannumber=[[UILabel alloc]init];
        self.guankannumber.textColor = [UIColor blackColor];
        self.guankannumber.text=@"宝宝第一次体检";
        self.guankannumber.textColor=RGBA(63, 62, 61, 1);
        self.guankannumber.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:13];
        self.guankannumber.textAlignment=NSTextAlignmentLeft;
        
        [self.contentView addSubview:self.guankannumber];
        
        self.guankannumber.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.guankannumber
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.title
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.guankannumber
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-15]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.guankannumber
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:12]];
        
        //观看图片
        self.guankanImage=[[UIImageView alloc]init];
        self.guankanImage.image=[UIImage imageNamed:@"观看"];
        [self.contentView addSubview:self.guankanImage];
        self.guankanImage.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.guankanImage
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.title
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:12]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.guankanImage
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.guankannumber
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:-5]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.guankanImage
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:0
                                                                      constant:12]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.guankanImage
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:8]];
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    
    //下分割线
    CGContextSetStrokeColorWithColor(context,RGBA(218, 218, 218, 1).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width , 1));
}



@end
