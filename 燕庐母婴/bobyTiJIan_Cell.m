//
//  bobyTiJIan_Cell.m
//  美妈锦囊
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "bobyTiJIan_Cell.h"
#import "PrefixHeader.pch"

@implementation bobyTiJIan_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //初始化布局
        
        
        //竖着的线

        self.xian=[[UIButton alloc]init];
        //self.lbSegment.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"蓝线条"]];
        self.xian.backgroundColor=RGBA(73, 73, 72, 0.8);
        [self.contentView addSubview:self.xian];
        self.xian.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.xian
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:6]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.xian
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.xian
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:0
                                                                      constant:2]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.xian
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:68]];


        //标题
        self.lbTitle=[[UILabel alloc]init];
        self.lbTitle.textColor = [UIColor blackColor];
        self.lbTitle.text=@"宝宝第一次体检";
        self.lbTitle.textColor=RGBA(63, 62, 61, 1);
        self.lbTitle.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:17];
        self.lbTitle.textAlignment=NSTextAlignmentLeft;

        [self.contentView addSubview:self.lbTitle];
        
        self.lbTitle.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbTitle
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:15]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbTitle
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.xian
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:15]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbTitle
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:20]];
        

        
        
        //出生天数
        self.lbchushengday=[[UILabel alloc]init];
        self.lbchushengday.textColor = [UIColor blackColor];
        self.lbchushengday.text=@"宝宝出生";
        self.lbchushengday.textColor=RGBA(142, 142, 142, 1);
        self.lbchushengday.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:13];
        //self.lbchushengday.backgroundColor=[UIColor redColor];
        self.lbchushengday.textAlignment=NSTextAlignmentLeft;
        //self.lbchushengday=[]
        [self.contentView addSubview:self.lbchushengday];
        
        self.lbchushengday.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbchushengday
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.lbTitle
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:15]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbchushengday
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.xian
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:15]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbchushengday
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:12]];
        
        
        //体检时间的图片
        self.imgTime=[[UIImageView alloc]init];
        //self.backgroundColor=[UIColor whiteColor];
        self.imgTime.image=[UIImage imageNamed:@"正常时间1"];
        //self.lbInfoContentimage.frame=CGRectMake(0, 0, 40, 40);
        [self.contentView addSubview:self.imgTime];
        self.imgTime.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.imgTime
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.lbTitle
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1
                                                                   constant:15]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.imgTime
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.lbchushengday
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1
                                                                   constant:30]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.imgTime
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.contentView
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:0
                                                                   constant:12]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.imgTime
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.contentView
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:0
                                                                   constant:12]];
        

        //体检时间
        self.lbtijianTime=[[UILabel alloc]init];
        self.lbtijianTime.textColor = [UIColor blackColor];
        self.lbtijianTime.text=@"体检状态和时间";
        self.lbtijianTime.textColor=RGBA(142, 142, 142, 1);
        self.lbtijianTime.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:13];
        self.lbtijianTime.textAlignment=NSTextAlignmentLeft;
        
        [self.contentView addSubview:self.lbtijianTime];
        
        self.lbtijianTime.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbtijianTime
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.lbTitle
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:15]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbtijianTime
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.imgTime
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:5]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbtijianTime
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:12]];

        
        //按钮
        self.btnstate=[[UIButton alloc]init];
        
        self.btnstate.layer.borderColor=RGBA(54, 52, 52, 1).CGColor;
        self.btnstate.layer.borderWidth=2;
        self.btnstate.layer.masksToBounds = YES;
        self.btnstate.backgroundColor=[UIColor whiteColor];
        // 设置圆角角度
        self.btnstate.layer.cornerRadius = 15;
        //[self.btnSegmentrect setBackgroundColor:[UIColor redColor]];
        //[self.btnSegmentrect setBackgroundImage:[UIImage imageNamed:@"蓝色圈"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.btnstate];
        self.btnstate.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnstate
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:25]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnstate
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-15]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnstate
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:0
                                                                      constant:30]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnstate
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:30]];
        
        
        //按钮前面的线
        self.xina2=[[UIButton alloc]init];
        //self.lbSegment.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"蓝线条"]];
        self.xina2.backgroundColor=RGBA(239, 239, 239, 1);
        [self.contentView addSubview:self.xina2];
        self.xina2.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.xina2
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:24]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.xina2
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.btnstate
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:-15]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.xina2
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:0
                                                                      constant:1]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.xina2
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:32]];
        


    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //下分割线
    CGContextSetStrokeColorWithColor(context,RGBA(241, 240, 241, 1).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width , 1));
}



@end
