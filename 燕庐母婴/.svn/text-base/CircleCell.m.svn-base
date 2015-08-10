//
//  CircleCell.m
//  滚动视图
//
//  Created by 董飞剑 on 15/5/28.
//  Copyright (c) 2015年 侯泽彭. All rights reserved.
//

#import "CircleCell.h"

@implementation CircleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //圈子头像
        self.headImg = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 72, 60)];
        [self.contentView addSubview:self.headImg];
        
        
        //圈子名称
        self.circleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImg.frame.origin.x+self.headImg.frame.size.width+7, 12, 120, 20)];
        self.circleNameLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:14];
        [self.contentView addSubview:self.circleNameLabel];
        
        
        //人数
        self.peopleNumImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.headImg.frame.origin.x+self.headImg.frame.size.width+7, self.circleNameLabel.frame.origin.y+self.circleNameLabel.frame.size.height+15, 15, 16)];
        [self.contentView addSubview:self.peopleNumImg];
        
        
        self.peopleNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.peopleNumImg.frame.origin.x+self.peopleNumImg.frame.size.width+5, self.circleNameLabel.frame.origin.y+self.circleNameLabel.frame.size.height+12, 40, 20)];
        self.peopleNumLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        [self.contentView addSubview:self.peopleNumLabel];
        
        
        //话题
        self.speakNumImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.peopleNumLabel.frame.origin.x+self.peopleNumLabel.frame.size.width+34, self.circleNameLabel.frame.origin.y+self.circleNameLabel.frame.size.height+12, 18, 16)];
        [self.contentView addSubview:self.speakNumImg];
        
        
        self.speakNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.speakNumImg.frame.origin.x+self.speakNumImg.frame.size.width+5, self.circleNameLabel.frame.origin.y+self.circleNameLabel.frame.size.height+12, 50, 20)];
        self.speakNumLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        [self.contentView addSubview:self.speakNumLabel];
        
        //关注按钮
        self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.saveBtn.layer.masksToBounds = YES;
        self.saveBtn.layer.cornerRadius = 3;
        self.saveBtn.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:11];
        [self addSubview:self.saveBtn];
        
        
    }
    return self;
}

@end










////
////  CircleCell.m
////  滚动视图
////
////  Created by 董飞剑 on 15/5/28.
////  Copyright (c) 2015年 侯泽彭. All rights reserved.
////
//
//#import "CircleCell.h"
//#define FONT_SIZE(size)             [UIFont systemFontOfSize:size]
//@implementation CircleCell
//
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    
//    if (self) {
//        
////        //圈子头像
////        self.headImg = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 72, 60)];
////        [self.contentView addSubview:self.headImg];
//       [self initLayout];
////        
////      //  圈子名称
////        self.circleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImg.frame.origin.x+self.headImg.frame.size.width+7, 12, 120, 20)];
////        self.circleNameLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:14];
////        [self.contentView addSubview:self.circleNameLabel];
////        
////        
//////        //人数
////        self.peopleNumImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.headImg.frame.origin.x+self.headImg.frame.size.width+7, self.circleNameLabel.frame.origin.y+self.circleNameLabel.frame.size.height+15, 15, 16)];
////        [self.contentView addSubview:self.peopleNumImg];
////
////        
////        self.peopleNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.peopleNumImg.frame.origin.x+self.peopleNumImg.frame.size.width+5, self.circleNameLabel.frame.origin.y+self.circleNameLabel.frame.size.height+12, 40, 20)];
////        self.peopleNumLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
////        [self.contentView addSubview:self.peopleNumLabel];
////        
////        
////       // 话题
////        self.speakNumImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.peopleNumLabel.frame.origin.x+self.peopleNumLabel.frame.size.width+34, self.circleNameLabel.frame.origin.y+self.circleNameLabel.frame.size.height+12, 18, 16)];
////        [self.contentView addSubview:self.speakNumImg];
////        
////        
////        self.speakNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.speakNumImg.frame.origin.x+self.speakNumImg.frame.size.width+5, self.circleNameLabel.frame.origin.y+self.circleNameLabel.frame.size.height+12, 50, 20)];
////        self.speakNumLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
////        [self.contentView addSubview:self.speakNumLabel];
////        
////        //关注按钮
////        self.saveBtn = [[UIButton alloc] init];
////        [self.contentView addSubview:self.saveBtn];
//        
//    }
//    return self;
//}
//-(void)initLayout{
//    //头像
//    // self.personImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 35, 15, 16)];
//    //[self addSubview:self.personImage];
//    
//    self.headImg = [[UIImageView alloc] initWithFrame:CGRectMake(16, 20, 65, 65)];
//    self.headImg.layer.masksToBounds = YES;
//    self.headImg .layer.cornerRadius = 30;
//    self.headImg.backgroundColor=[UIColor redColor];
//    [self.contentView addSubview:self.headImg];
//    //        self.circleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImg.frame.origin.x+self.headImg.frame.size.width+7, 12, 120, 20)];
//    //        self.circleNameLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:14];
//    //        [self.contentView addSubview:self.circleNameLabel];
//
//        self.circleNameLabel=[[UILabel alloc]init];
//        [self.contentView addSubview:self.circleNameLabel];
//        self.circleNameLabel.text=@"圈子名称";
//        self.circleNameLabel.textColor=[UIColor redColor];
//        self.circleNameLabel.font=FONT_SIZE(14);
//        self.circleNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
//        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.circleNameLabel
//                                                        attribute:NSLayoutAttributeTop
//                                                        relatedBy:NSLayoutRelationEqual
//                                                           toItem:self.contentView
//                                                        attribute:NSLayoutAttributeTop
//                                                       multiplier:1
//                                                         constant:39]];
//        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.circleNameLabel
//                                                        attribute:NSLayoutAttributeLeft
//                                                        relatedBy:NSLayoutRelationEqual
//                                                           toItem:self.headImg
//                                                        attribute:NSLayoutAttributeRight
//                                                       multiplier:1
//                                                         constant:14]];
////        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.circleNameLabel
////                                                        attribute:NSLayoutAttributeWidth
////                                                        relatedBy:NSLayoutRelationEqual
////                                                           toItem:self.contentView
////                                                        attribute:NSLayoutAttributeWidth
////                                                       multiplier:0
////                                                         constant:65]];
//        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.circleNameLabel
//                                                        attribute:NSLayoutAttributeHeight
//                                                        relatedBy:NSLayoutRelationEqual
//                                                           toItem:self.contentView
//                                                        attribute:NSLayoutAttributeHeight
//                                                       multiplier:0
//                                                         constant:15]];
//    
//    
//    //人数
//    self.peopleNumImg=[[UIImageView alloc]init];
//    [self.contentView addSubview:self.peopleNumImg];
////    self.peopleNumImg.layer.masksToBounds = YES;
////    self.peopleNumImg .layer.cornerRadius = 5;
////    self.peopleNumImg.backgroundColor=[UIColor redColor];
//    
//    self.peopleNumImg.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.peopleNumImg
//                                                     attribute:NSLayoutAttributeTop
//                                                     relatedBy:NSLayoutRelationEqual
//                                                        toItem:self.circleNameLabel
//                                                     attribute:NSLayoutAttributeBottom
//                                                    multiplier:1
//                                                      constant:17]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.peopleNumImg
//                                                     attribute:NSLayoutAttributeLeft
//                                                     relatedBy:NSLayoutRelationEqual
//                                                        toItem:self.headImg
//                                                     attribute:NSLayoutAttributeRight
//                                                    multiplier:1
//                                                      constant:14]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.peopleNumImg
//                                                     attribute:NSLayoutAttributeWidth
//                                                     relatedBy:NSLayoutRelationEqual
//                                                        toItem:self.contentView
//                                                     attribute:NSLayoutAttributeWidth
//                                                    multiplier:0
//                                                      constant:10]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.peopleNumImg
//                                                     attribute:NSLayoutAttributeHeight
//                                                     relatedBy:NSLayoutRelationEqual
//                                                        toItem:self.contentView
//                                                     attribute:NSLayoutAttributeHeight
//                                                    multiplier:0
//                                                      constant:15
//                         ]];
//    self.peopleNumLabel=[[UILabel alloc]init];
//    [self.contentView addSubview:self.peopleNumLabel];
//    self.peopleNumLabel.text=@"12345";
//    //self.peopleNumLabel.textColor=[UIColor redColor];
//    self.peopleNumLabel.font=FONT_SIZE(12);
//    self.peopleNumLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.peopleNumLabel
//                                                                 attribute:NSLayoutAttributeTop
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.circleNameLabel
//                                                                 attribute:NSLayoutAttributeBottom
//                                                                multiplier:1
//                                                                  constant:20]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.peopleNumLabel
//                                                                 attribute:NSLayoutAttributeLeft
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.peopleNumImg
//                                                                 attribute:NSLayoutAttributeRight
//                                                                multiplier:1
//                                                                  constant:3]];
//    //        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.circleNameLabel
//    //                                                        attribute:NSLayoutAttributeWidth
//    //                                                        relatedBy:NSLayoutRelationEqual
//    //                                                           toItem:self.contentView
//    //                                                        attribute:NSLayoutAttributeWidth
//    //                                                       multiplier:0
//    //                                                         constant:65]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.peopleNumLabel
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                multiplier:0
//                                                                  constant:11]];
//    //话题
//    self.speakNumImg=[[UIImageView alloc]init];
//    [self.contentView addSubview:self.speakNumImg];
//    //    self.peopleNumImg.layer.masksToBounds = YES;
//    //    self.peopleNumImg .layer.cornerRadius = 5;
//    //    self.peopleNumImg.backgroundColor=[UIColor redColor];
//    
//    self.speakNumImg.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.speakNumImg
//                                                                 attribute:NSLayoutAttributeTop
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.circleNameLabel
//                                                                 attribute:NSLayoutAttributeBottom
//                                                                multiplier:1
//                                                                  constant:17]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.speakNumImg
//                                                                 attribute:NSLayoutAttributeLeft
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.peopleNumLabel
//                                                                 attribute:NSLayoutAttributeRight
//                                                                multiplier:1
//                                                                  constant:15]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.speakNumImg
//                                                                 attribute:NSLayoutAttributeWidth
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeWidth
//                                                                multiplier:0
//                                                                  constant:10]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.speakNumImg
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                multiplier:0
//                                                                  constant:15
//                                     ]];
//    self.speakNumLabel=[[UILabel alloc]init];
//    [self.contentView addSubview:self.speakNumLabel];
//    self.speakNumLabel.text=@"12345";
//    //self.peopleNumLabel.textColor=[UIColor redColor];
//    self.speakNumLabel.font=FONT_SIZE(12);
//    self.speakNumLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.speakNumLabel
//                                                                 attribute:NSLayoutAttributeTop
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.circleNameLabel
//                                                                 attribute:NSLayoutAttributeBottom
//                                                                multiplier:1
//                                                                  constant:20]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.speakNumLabel
//                                                                 attribute:NSLayoutAttributeLeft
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.speakNumImg
//                                                                 attribute:NSLayoutAttributeRight
//                                                                multiplier:1
//                                                                  constant:3]];
//    //        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.circleNameLabel
//    //                                                        attribute:NSLayoutAttributeWidth
//    //                                                        relatedBy:NSLayoutRelationEqual
//    //                                                           toItem:self.contentView
//    //                                                        attribute:NSLayoutAttributeWidth
//    //                                                       multiplier:0
//    //                                                         constant:65]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.speakNumLabel
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                multiplier:0
//                                                                  constant:11]];
//    //化线
//    UIView *view=[[UIView alloc]init];
//    [self.contentView addSubview:view];
//    view.backgroundColor=[UIColor redColor];
//    view.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:view
//                                                                 attribute:NSLayoutAttributeTop
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.headImg
//                                                                 attribute:NSLayoutAttributeBottom
//                                                                multiplier:1
//                                                                  constant:15]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:view
//                                                                 attribute:NSLayoutAttributeLeft
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeLeft
//                                                                multiplier:1
//                                                                  constant:10]];
//            [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:view
//                                             
//                                                            attribute:NSLayoutAttributeRight
//                                                            relatedBy:NSLayoutRelationEqual
//                                                               toItem:self.contentView
//                                                            attribute:NSLayoutAttributeRight
//                                                           multiplier:1
//                                                             constant:-10]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:view
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                multiplier:0
//                                                                  constant:1]];
//
//  //关注
//    self.saveBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [self.saveBtn setTitle:@"关注" forState:UIControlStateNormal];
//    //[_share setFont:FONT_SIZE(15)];
//    [self.saveBtn setBackgroundColor:[UIColor redColor]];
//    self.saveBtn.layer.borderWidth=1;
//    self.saveBtn.layer.borderColor=[UIColor redColor].CGColor;
//    //[self.saveBtn setTitleColor:RGB(54, 145, 242) forState:UIControlStateNormal];
//    [self.contentView addSubview:self.saveBtn];
//    self.saveBtn.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.saveBtn
//                                                                 attribute:NSLayoutAttributeTop
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeTop
//                                                                multiplier:1
//                                                                  constant:45]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.saveBtn
//                                                                 attribute:NSLayoutAttributeRight
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeRight
//                                                                multiplier:1
//                                                                  constant:-22]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.saveBtn
//                                                                 attribute:NSLayoutAttributeLeft
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.circleNameLabel
//                                                                 attribute:NSLayoutAttributeRight
//                                                                multiplier:1
//                                                                  constant:96]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.saveBtn
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                multiplier:0
//                                                                  constant:20]];
//    //圈成员
//    self.saveBtn1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [self.saveBtn1 setTitle:@"圈成员" forState:UIControlStateNormal];
//    //[_share setFont:FONT_SIZE(15)];
//    [self.saveBtn1 setBackgroundColor:[UIColor whiteColor]];
////    self.saveBtn1.layer.borderWidth=1;
////    self.saveBtn1.layer.borderColor=[UIColor redColor].CGColor;
//    //[self.saveBtn setTitleColor:RGB(54, 145, 242) forState:UIControlStateNormal];
//    [self.contentView addSubview:self.saveBtn1];
//    self.saveBtn1.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.saveBtn1
//                                                                 attribute:NSLayoutAttributeTop
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:view
//                                                                 attribute:NSLayoutAttributeBottom
//                                                                multiplier:1
//                                                                  constant:0]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.saveBtn1
//                                                                 attribute:NSLayoutAttributeLeft
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeLeft
//                                                                multiplier:1
//                                                                  constant:0]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.saveBtn1
//                                                                 attribute:NSLayoutAttributeWidth
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeWidth
//                                                                multiplier:0
//                                                                  constant:(SCREEN_WIDTH-2)/3]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.saveBtn1
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                multiplier:0
//                                                                  constant:36]];
//    //化线
//    UIView *view1=[[UIView alloc]init];
//    [self.contentView addSubview:view1];
//    view1.backgroundColor=[UIColor blackColor];
//    view1.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:view1
//                                                                 attribute:NSLayoutAttributeTop
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:view
//                                                                 attribute:NSLayoutAttributeBottom
//                                                                multiplier:1
//                                                                  constant:8]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:view1
//                                                                 attribute:NSLayoutAttributeWidth
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeWidth
//                                                                multiplier:0
//                                                                  constant:1]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:view1
//                                     
//                                                                 attribute:NSLayoutAttributeLeft
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.saveBtn1
//                                                                 attribute:NSLayoutAttributeRight
//                                                                multiplier:1
//                                                                  constant:0]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:view1
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                multiplier:0
//                                                                  constant:24]];
//    //圈管理
//    self.saveBtn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [self.saveBtn2 setTitle:@"圈管理" forState:UIControlStateNormal];
//    //[_share setFont:FONT_SIZE(15)];
//    [self.saveBtn2 setBackgroundColor:[UIColor whiteColor]];
////    self.saveBtn2.layer.borderWidth=1;
////    self.saveBtn2.layer.borderColor=[UIColor redColor].CGColor;
//    //[self.saveBtn setTitleColor:RGB(54, 145, 242) forState:UIControlStateNormal];
//    [self.contentView addSubview:self.saveBtn2];
//    self.saveBtn2.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.saveBtn2
//                                                                 attribute:NSLayoutAttributeTop
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:view
//                                                                 attribute:NSLayoutAttributeBottom
//                                                                multiplier:1
//                                                                  constant:0]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.saveBtn2
//                                                                 attribute:NSLayoutAttributeLeft
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:view1
//                                                                 attribute:NSLayoutAttributeRight
//                                                                multiplier:1
//                                                                  constant:0]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.saveBtn2
//                                                                 attribute:NSLayoutAttributeWidth
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeWidth
//                                                                multiplier:0
//                                                                  constant:(SCREEN_WIDTH-2)/3]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.saveBtn2
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                multiplier:0
//                                                                  constant:36]];
//    //化线
//    UIView *view2=[[UIView alloc]init];
//    [self.contentView addSubview:view2];
//    view2.backgroundColor=[UIColor blackColor];
//    view2.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:view2
//                                                                 attribute:NSLayoutAttributeTop
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:view
//                                                                 attribute:NSLayoutAttributeBottom
//                                                                multiplier:1
//                                                                  constant:8]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:view2
//                                                                 attribute:NSLayoutAttributeWidth
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeWidth
//                                                                multiplier:0
//                                                                  constant:1]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:view2
//                                     
//                                                                 attribute:NSLayoutAttributeLeft
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.saveBtn2
//                                                                 attribute:NSLayoutAttributeRight
//                                                                multiplier:1
//                                                                  constant:0]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:view2
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                multiplier:0
//                                                                  constant:24]];
//    
//    //圈精华
//    self.saveBtn3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [self.saveBtn3 setTitle:@"圈精华" forState:UIControlStateNormal];
//    //[_share setFont:FONT_SIZE(15)];
//    [self.saveBtn3 setBackgroundColor:[UIColor whiteColor]];
////    self.saveBtn3.layer.borderWidth=1;
////    self.saveBtn3.layer.borderColor=[UIColor redColor].CGColor;
//    //[self.saveBtn setTitleColor:RGB(54, 145, 242) forState:UIControlStateNormal];
//    [self.contentView addSubview:self.saveBtn3];
//    self.saveBtn3.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.saveBtn3
//                                                                 attribute:NSLayoutAttributeTop
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:view
//                                                                 attribute:NSLayoutAttributeBottom
//                                                                multiplier:1
//                                                                  constant:0]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.saveBtn3
//                                                                 attribute:NSLayoutAttributeRight
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeRight
//                                                                multiplier:1
//                                                                  constant:0]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.saveBtn3
//                                                                 attribute:NSLayoutAttributeWidth
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeWidth
//                                                                multiplier:0
//                                                                  constant:(SCREEN_WIDTH-2)/3]];
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.saveBtn3
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                multiplier:0
//                                                                  constant:36]];
//
////    self.peopleNumImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.headImg.frame.origin.x+self.headImg.frame.size.width+7, self.circleNameLabel.frame.origin.y+self.circleNameLabel.frame.size.height+15, 15, 16)];
////    [self.contentView addSubview:self.peopleNumImg];
////
////
////    self.peopleNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.peopleNumImg.frame.origin.x+self.peopleNumImg.frame.size.width+5, self.circleNameLabel.frame.origin.y+self.circleNameLabel.frame.size.height+12, 40, 20)];
////    self.peopleNumLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
////    [self.contentView addSubview:self.peopleNumLabel];
//   // [self.contentView addSubview:self.headImg];
//   
//    
////    self.headImg.translatesAutoresizingMaskIntoConstraints = NO;
////    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.headImg
////                                                     attribute:NSLayoutAttributeTop
////                                                     relatedBy:NSLayoutRelationEqual
////                                                        toItem:self.contentView
////                                                     attribute:NSLayoutAttributeTop
////                                                    multiplier:1
////                                                      constant:24]];
////    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.headImg
////                                                     attribute:NSLayoutAttributeRight
////                                                     relatedBy:NSLayoutRelationEqual
////                                                        toItem:self.contentView
////                                                     attribute:NSLayoutAttributeRight
////                                                    multiplier:1
////                                                      constant:30]];
////    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.headImg
////                                                     attribute:NSLayoutAttributeWidth
////                                                     relatedBy:NSLayoutRelationEqual
////                                                        toItem:self.contentView
////                                                     attribute:NSLayoutAttributeWidth
////                                                    multiplier:0
////                                                      constant:30]];
////    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.headImg
////                                                     attribute:NSLayoutAttributeHeight
////                                                     relatedBy:NSLayoutRelationEqual
////                                                        toItem:self.contentView
////                                                     attribute:NSLayoutAttributeHeight
////                                                    multiplier:0
////                                                      constant:30
////                         ]];
//    
//    //     self.personImage = [[UIImageView alloc] initWithFrame:CGRectMake(16, 48, 25, 25)];
//    //     self.personImage.layer.masksToBounds = YES;
//    //     self.personImage .layer.cornerRadius = 5;
//    //     self.personImage .image = [UIImage imageNamed:@"bb.jpg"];
//    //    [self addSubview: self.personImage ];
//    
//    //    lab=[[UILabel alloc]init];
//    //    [_sc addSubview:lab];
//    //    lab.text=@"日志类型";
//    //    lab.textColor=[UIColor blackColor];
//    //    lab.font=FONT_SIZE(17);
//    //    lab.translatesAutoresizingMaskIntoConstraints = NO;
//    //    [_sc addConstraint:[NSLayoutConstraint constraintWithItem:lab
//    //                                                    attribute:NSLayoutAttributeTop
//    //                                                    relatedBy:NSLayoutRelationEqual
//    //                                                       toItem:_sc
//    //                                                    attribute:NSLayoutAttributeTop
//    //                                                   multiplier:1
//    //                                                     constant:15]];
//    //    [_sc addConstraint:[NSLayoutConstraint constraintWithItem:lab
//    //                                                    attribute:NSLayoutAttributeLeft
//    //                                                    relatedBy:NSLayoutRelationEqual
//    //                                                       toItem:_sc
//    //                                                    attribute:NSLayoutAttributeLeft
//    //                                                   multiplier:1
//    //                                                     constant:10]];
//    //    [_sc addConstraint:[NSLayoutConstraint constraintWithItem:lab
//    //                                                    attribute:NSLayoutAttributeWidth
//    //                                                    relatedBy:NSLayoutRelationEqual
//    //                                                       toItem:_sc
//    //                                                    attribute:NSLayoutAttributeWidth
//    //                                                   multiplier:1
//    //                                                     constant:55]];
//    //    [_sc addConstraint:[NSLayoutConstraint constraintWithItem:lab
//    //                                                    attribute:NSLayoutAttributeHeight
//    //                                                    relatedBy:NSLayoutRelationEqual
//    //                                                       toItem:_sc
//    //                                                    attribute:NSLayoutAttributeHeight
//    //                                                   multiplier:0
//    //                                                     constant:15]];
//    
//    
//    
//}
////lab=[[UILabel alloc]init];
////[_sc addSubview:lab];
////lab.text=@"日志类型";
////lab.textColor=[UIColor blackColor];
////lab.font=FONT_SIZE(17);
////lab.translatesAutoresizingMaskIntoConstraints = NO;
////[_sc addConstraint:[NSLayoutConstraint constraintWithItem:lab
////                                                attribute:NSLayoutAttributeTop
////                                                relatedBy:NSLayoutRelationEqual
////                                                   toItem:_sc
////                                                attribute:NSLayoutAttributeTop
////                                               multiplier:1
////                                                 constant:15]];
////[_sc addConstraint:[NSLayoutConstraint constraintWithItem:lab
////                                                attribute:NSLayoutAttributeLeft
////                                                relatedBy:NSLayoutRelationEqual
////                                                   toItem:_sc
////                                                attribute:NSLayoutAttributeLeft
////                                               multiplier:1
////                                                 constant:10]];
////[_sc addConstraint:[NSLayoutConstraint constraintWithItem:lab
////                                                attribute:NSLayoutAttributeWidth
////                                                relatedBy:NSLayoutRelationEqual
////                                                   toItem:_sc
////                                                attribute:NSLayoutAttributeWidth
////                                               multiplier:1
////                                                 constant:55]];
////[_sc addConstraint:[NSLayoutConstraint constraintWithItem:lab
////                                                attribute:NSLayoutAttributeHeight
////                                                relatedBy:NSLayoutRelationEqual
////                                                   toItem:_sc
////                                                attribute:NSLayoutAttributeHeight
////                                               multiplier:0
////                                                 constant:15]];
//////日报
////btn1=[[UIButton alloc]init];
////[_sc addSubview:btn1];
////btn1.tag=1;
////reportType=@"10";
////[btn1 setBackgroundColor:[UIColor whiteColor]];
////[btn1 setBackgroundImage:[UIImage imageNamed:@"gongzuorizhi-ribaolan"] forState:UIControlStateSelected];
////[btn1 setBackgroundImage:[UIImage imageNamed:@"gongzuorizhi-ribaohui"] forState:UIControlStateNormal];
////btn1.selected=YES;
////
////[btn1 addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
////btn1.translatesAutoresizingMaskIntoConstraints = NO;
////
////[_sc addConstraint:[NSLayoutConstraint constraintWithItem:btn1
////                                                attribute:NSLayoutAttributeLeft
////                                                relatedBy:NSLayoutRelationEqual
////                                                   toItem:_sc
////                                                attribute:NSLayoutAttributeLeft
////                                               multiplier:1
////                                                 constant:10]];
////[_sc addConstraint:[NSLayoutConstraint constraintWithItem:btn1
////                                                attribute:NSLayoutAttributeTop
////                                                relatedBy:NSLayoutRelationEqual
////                                                   toItem:lab
////                                                attribute:NSLayoutAttributeTop
////                                               multiplier:1
////                                                 constant:30]];
////[_sc addConstraint:[NSLayoutConstraint constraintWithItem:btn1
////                                                attribute:NSLayoutAttributeWidth
////                                                relatedBy:NSLayoutRelationEqual
////                                                   toItem:_sc
////                                                attribute:NSLayoutAttributeWidth
////                                               multiplier:0
////                                                 constant:(SCREEN_WIDTH/2-25)/2]];
////[_sc addConstraint:[NSLayoutConstraint constraintWithItem:btn1
////                                                attribute:NSLayoutAttributeHeight
////                                                relatedBy:NSLayoutRelationEqual
////                                                   toItem:_sc
////                                                attribute:NSLayoutAttributeHeight
////                                               multiplier:0
////                                                 constant:25]];
//
//@end
