//
//  UIBarButtonItem+Extension.h
//  随意
//
//  Created by zhaodeyu on 14/12/9.
//  Copyright (c) 2014年 Random. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+(UIBarButtonItem *)itemWithImageName:(NSString *)ImageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;

@end
