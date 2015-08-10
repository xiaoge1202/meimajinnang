//
//  zaoqi_Cell.m
//  美妈锦囊
//
//  Created by apple on 15/7/27.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "zaoqi_Cell.h"
#import "PrefixHeader.pch"


@implementation zaoqi_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //初始化布局
        
        //时间轴的时间天数
        self.lbTime=[[UILabel alloc]init];
        self.lbTime.textColor = [UIColor blackColor];
        self.lbTime.text=@"15天";
        self.lbTime.textColor=RGBA(89, 89, 89, 1);
        self.lbTime.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:15];
        self.lbTime.textAlignment=NSTextAlignmentLeft;
        // self.lbTime.frame=CGRectMake(10, 10, 30, 20);
        // self.lbTime.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:self.lbTime];
        self.lbTime.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbTime
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbTime
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:11]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbTime
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:14]];
        //时间轴的线
        self.lbSegment=[[UIButton alloc]init];
        //self.lbSegment.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"蓝线条"]];
        self.lbSegment.backgroundColor=RGBA(122, 165, 217, 0.8);
        [self.contentView addSubview:self.lbSegment];
        self.lbSegment.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbSegment
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbSegment
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:50]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbSegment
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:0
                                                                      constant:1]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbSegment
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:0]];
        
        //时间轴上的小圆圈
        self.btnSegmentrect=[[UIButton alloc]init];
        
        self.btnSegmentrect.layer.borderColor=RGBA(122, 165, 217, 0.8).CGColor;
        self.btnSegmentrect.layer.borderWidth=1;
        self.btnSegmentrect.layer.masksToBounds = YES;
        self.btnSegmentrect.backgroundColor=[UIColor whiteColor];
        // 设置圆角角度
        self.btnSegmentrect.layer.cornerRadius = 5;
        //[self.btnSegmentrect setBackgroundColor:[UIColor redColor]];
        //[self.btnSegmentrect setBackgroundImage:[UIImage imageNamed:@"蓝色圈"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.btnSegmentrect];
        self.btnSegmentrect.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSegmentrect
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSegmentrect
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:45.5]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSegmentrect
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:0
                                                                      constant:10]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSegmentrect
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:10]];
        
        //内容的父视图
        self.infoView =[[UIView alloc]init];
        self.infoView.backgroundColor=[UIColor redColor];
        self.infoView.backgroundColor=[UIColor whiteColor];
        self.infoView.layer.borderColor=RGBA(218, 219, 219, 1).CGColor;
        self.infoView.layer.borderWidth=1;
        self.infoView.layer.masksToBounds = YES;
        // 设置圆角角度
        self.infoView.layer.cornerRadius = 6.0;
        [self.contentView addSubview:self.infoView];
        
        self.infoView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:20]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoView
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.lbSegment
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:20]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoView
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-15]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoView
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:100]];
        
        
        
        //通知的图片
        self.lbInfoContentimage=[[UIImageView alloc]init];
        //self.backgroundColor=[UIColor whiteColor];
        self.lbInfoContentimage.image=[UIImage imageNamed:@"宝宝头像"];
        //self.lbInfoContentimage.frame=CGRectMake(0, 0, 40, 40);
        [self.infoView addSubview:self.lbInfoContentimage];
        self.lbInfoContentimage.translatesAutoresizingMaskIntoConstraints = NO;
        [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbInfoContentimage
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.infoView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1
                                                                   constant:10]];
        [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbInfoContentimage
                                                                  attribute:NSLayoutAttributeRight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.infoView
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1
                                                                   constant:-10]];
        [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbInfoContentimage
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.infoView
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:0
                                                                   constant:80]];
        [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbInfoContentimage
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.infoView
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:0
                                                                   constant:80]];
        //
        //通知内容
        self.lbInfoContent=[[UILabel alloc]init];
        //self.lbInfoContent.backgroundColor=[UIColor grayColor];
        [self.infoView addSubview:self.lbInfoContent];
        
        
        self.lbInfoContent.translatesAutoresizingMaskIntoConstraints = NO;
        [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbInfoContent
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.infoView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1
                                                                   constant:20]];
        [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbInfoContent
                                                                  attribute:NSLayoutAttributeRight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.lbInfoContentimage
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1
                                                                   constant:-5]];
        [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbInfoContent
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.infoView
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:0
                                                                   constant:60]];
        [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.lbInfoContent
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.infoView
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1
                                                                   constant:10]];
        //        //当前时间的选中状态
        //        self.imgclickbg=[[UIImageView alloc]init];
        //        [self.contentView addSubview:self.imgclickbg];
        
        
        
    }
    return self;
}

- (void)deleteDate{
    // lbDate.hidden = YES;
    CGRect timeTemp = self.lbTime.frame;
    timeTemp.origin = CGPointMake(timeTemp.origin.x, 8);
    self.lbTime.frame = timeTemp;
    
    CGRect infoViewTemp = self.infoView.frame;
    infoViewTemp.origin = CGPointMake(infoViewTemp.origin.x, 8);
    self.infoView.frame = infoViewTemp;
}

- (CGFloat)setCellHeight:(NSString *)strInfo isSameDay:(BOOL)isSame{
    /*如果是同一天 则去掉上面的日期*/
    if (isSame) {
        [self deleteDate];
    }
    
    // [self.lbInfoContent setNumberOfLines:0];  //0行，则表示根据文本长度，自动增加行数
    NSString *labelText = strInfo;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5.0f];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.lbInfoContent.attributedText = attributedString;
    [self.lbInfoContent sizeToFit];  //填充
    //NSLog(@"%@",lbInfoContent);
    
    
    //    CGRect infoContentViewTemp = infoContentView.frame;
    //    infoContentViewTemp.size = CGSizeMake(212, self.lbInfoContent.frame.size.height);
    //    infoContentView.frame = infoContentViewTemp;
    
    /*设置手势点击位置*/
    //    CGRect btnTemp = receiveView.frame;
    //    btnTemp.origin = CGPointMake(0, infoContentView.frame.origin.y + infoContentView.frame.size.height + 8 );
    //    receiveView.frame = btnTemp;
    //NSLog(@"%@",receiveView);
    
    /*设置整个infoView高度*/
    CGRect viewTemp = self.infoView.frame;
    viewTemp.size = CGSizeMake(viewTemp.size.width,100);
    self.infoView.frame = viewTemp;
    //NSLog(@"%@",infoView);
    
    self.lbSegment.frame = CGRectMake(self.lbSegment.frame.origin.x, 0, 3, self.infoView.frame.origin.y + self.infoView.frame.size.height + 8);
    NSLog(@"HEight %f",self.infoView.frame.origin.y + self.infoView.frame.size.height + 8);
    return self.infoView.frame.origin.y + self.infoView.frame.size.height + 8;
}



- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
    CGContextSetStrokeColorWithColor(context, RGBA(201, 201, 201, 1).CGColor);
    CGContextStrokeRect(context, CGRectMake(65, -1, rect.size.width - 65, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context,RGBA(201, 201, 201, 1).CGColor);
    CGContextStrokeRect(context, CGRectMake(65, rect.size.height, rect.size.width - 65, 1));
}


@end
