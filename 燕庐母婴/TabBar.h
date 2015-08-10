//
//  TabBar.h
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/11.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Extension.h"
#import "UIView+Extension.h"

@class TabBar;
@protocol TabBarDelegate <NSObject>
-(void)tabBarDidClickedPlusButton:(TabBar *)tabBar;

@end
@interface TabBar : UITabBar

@property(nonatomic,weak)id <TabBarDelegate> delegate;

@end
