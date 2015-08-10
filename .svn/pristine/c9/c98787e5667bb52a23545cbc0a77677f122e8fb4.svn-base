//
//  UIBarButtonItem+Extension.m
//  随意
//
//  Created by zhaodeyu on 14/12/9.
//  Copyright (c) 2014年 Random. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
@implementation UIBarButtonItem (Extension)


+(UIBarButtonItem *)itemWithImageName:(NSString *)ImageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    //自定义UIView
    UIButton *btn=[[UIButton alloc]init];
    
    //设置按钮的背景图片（默认/高亮）
    [btn setBackgroundImage:[UIImage imageNamed:ImageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    
    //设置按钮的尺寸和图片一样大，使用了UIImage的分类
//    btn.size=btn.currentBackgroundImage.size;
    
//    btn.frame.size.widxxth = btn.currentBackgroundImage.size.width;
    
    btn.size = btn.currentBackgroundImage.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}
@end
