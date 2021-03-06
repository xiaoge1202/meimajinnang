//
//  UIImage+Extension.m
//  随意
//
//  Created by zhaodeyu on 14/12/9.
//  Copyright (c) 2014年 Random. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)imageWithName:(NSString *)name
{
    UIImage *image = nil;
    //if (iOS7) { // 处理iOS7的情况
    NSString *newName = [name stringByAppendingString:@"_os7"];
    image = [UIImage imageNamed:newName];
    //  }

    if (image == nil) {
    image = [UIImage imageNamed:name];
    }
    return image;
}

//以长度的一半，高度的一半为中心进行拉伸。
+ (UIImage *)resizedImage:(NSString *)name
{
     UIImage *image = [UIImage imageWithName:name];
     return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}



@end
