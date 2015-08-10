//
//  GuideViewController.h
//  美妈锦囊
//
//  Created by 侯泽彭 on 15/7/22.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "EnterViewController.h"

@interface GuideViewController : UIViewController<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView* scrollView;
@end
