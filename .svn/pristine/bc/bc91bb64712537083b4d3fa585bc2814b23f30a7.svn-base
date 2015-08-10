//
//  PostsBodyCell.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/5/29.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "PostsBodyCell.h"
#define MSG_VIEW_LEFT   62

#define MSG_VIEW_RIGHT  260

#define MSG_VIEW_TOP    30

#define MSG_VIEW_BOTTOM 8

@implementation PostsBodyCell{
    UIImageView *haedImage;//最前面的图片
    UILabel *haedTitle;//标题
    //UIButton *dianzanzi//点赞头面的字
    UIImageView *userImage;//头像
    UIImageView *bulids;//标示
    UILabel *badyDays;//宝宝天数
    UILabel *contentText;//主题内容
    UIImageView *contentImage;//主题图片
    UIView *xian;//线
    UIView *xian1;//线1
    

}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.view  = [[UIView alloc] init];
        [self addSubview:self.view];
        
        
        self.userHeadImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 35, 35)];
        self.userHeadImg.layer.masksToBounds = YES;
            self.userHeadImg.layer.cornerRadius = self.userHeadImg.bounds.size.width/2;

        [self addSubview:self.userHeadImg];
        
        self.userNameLab = [[UILabel alloc] init];
        self.userNameLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:13];
        self.userNameLab.textColor = RGBA(236, 141, 160, 1);

        [self addSubview:self.userNameLab];
        
        
        self.louZhuImg = [[UIImageView alloc] init];
        [self addSubview:self.louZhuImg];
        
        
        self.timeLab = [[UILabel alloc] init];
        self.timeLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        self.timeLab.textColor=RGBA(137, 137, 137, 1);
        [self addSubview:self.timeLab];
        
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:13];
        self.contentLabel.textColor = RGBA(73, 72, 72, 1);
        
        [self addSubview:self.contentLabel];
        //中间的图片
        self.contentimage = [[UIImageView alloc] initWithFrame:CGRectMake(10,self.contentLabel.frame.origin.y+self.contentLabel.frame.size.height+4, SCREEN_WIDTH-20, 200)];
        [self addSubview:self.contentimage];
        //线
        self.view4 = [[UIView alloc] initWithFrame:CGRectMake(10,self.contentimage.frame.origin.y+self.contentimage.frame.size.height, SCREEN_WIDTH-20, 1)];

        [self addSubview:self.view4];
        
        
        //发帖时间
        self.timeImg = [[UIImageView alloc] init];
        [self addSubview:self.timeImg];
        
        self.postLab = [[UILabel alloc] init];
        self.postLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        self.postLab.textColor = RGBA(137, 137, 137, 1);
        [self addSubview:self.postLab];
        //        //回复下面的背景
        self.huibagimage=[[UITextView alloc]init];
        // self.huibagimage.backgroundColor=[UIColor redColor];
        self.huibagimage.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        self.huibagimage.textColor = RGBA(137, 137, 137, 1);
        [self addSubview:self.huibagimage];
        //点赞
        self.zanImg = [[UIImageView alloc] init];
        [self addSubview:self.zanImg];
        
        self.zanLab = [[UILabel alloc] init];
        self.zanLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        self.zanLab.textColor = RGBA(137, 137, 137, 1);
        [self addSubview:self.zanLab];
        
        //收藏
        self.shouCangImg = [[UIImageView alloc] init];
        [self addSubview:self.shouCangImg];
        
        
        self.shouCangLab = [[UILabel alloc] init];
        self.shouCangLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        self.shouCangLab.textColor = RGBA(137, 137, 137, 1);
        [self addSubview:self.shouCangLab];
        
        //回复
        self.huifuImg = [[UIImageView alloc] init];
        [self addSubview:self.huifuImg];
        
        
        self.huifuLab = [[UILabel alloc] init];
        self.huifuLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        self.huifuLab.textColor = RGBA(137, 137, 137, 1);
        [self addSubview:self.huifuLab];
        //回复的时间图标合字
        self.huiTime = [[UIImageView alloc] init];
        [self addSubview:self.huiTime];
        
        
        self.huiTimeCount = [[UILabel alloc] init];
        //self.huiTimeCount.text=@"woshidds";
        self.huiTimeCount.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        self.huiTimeCount.textColor =  RGBA(137, 137, 137, 1);
        [self addSubview:self.huiTimeCount];
        
        //回复的点赞图标合字
        self.huiDianzanbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self addSubview:self.huiDianzanbtn];
        
        
        self.huiDianzanNumber = [[UILabel alloc] init];
        self.huiDianzanNumber.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        self.huiDianzanNumber.textColor = RGBA(140, 139, 139, 1);
        [self addSubview:self.huiDianzanNumber];
        
        //回复按钮
        self.huiBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self addSubview:self.huiBtn];
        //回复按钮前面的图标
        self.huiBtnimg = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self addSubview:self.huiBtnimg];



        
        
    }
    
    return self;
}



//自定义表格下划线
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
}


@end
