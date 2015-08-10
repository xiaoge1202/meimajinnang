//
//  TabBar.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/11.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "TabBar.h"
#import "Search-VC.h"
@interface TabBar()

@property (nonatomic, strong) UIButton *plusButton;

@end

@implementation TabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加加号按钮
        [self setupPlusButton];
    }
    return self;
}
/**
 24  *  添加加号按钮
 25  */
- (void)setupPlusButton
{
    UIButton *plusButton = [[UIButton alloc] init];
    // 设置背景
//    [plusButton setBackgroundImage:[UIImage imageWithName:@"播放@2x"] forState:UIControlStateNormal];
//    [plusButton setBackgroundImage:[UIImage imageWithName:@"navigationbar_arrow_down@2x"] forState:UIControlStateHighlighted];
    
    // 设置图标
//    [plusButton setImage:[UIImage imageWithName:@"search.png"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageNamed:@"search@2x"] forState:UIControlStateNormal];
    [plusButton addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
    // 添加
    [self addSubview:plusButton];
    self.plusButton = plusButton;
}

- (void)plusClick
{
    //搜索
//    Search_VC *search = [[Search_VC alloc] init];
//    UINavigationController *searchNav = [[UINavigationController alloc] initWithRootViewController:search];
//    UITabBarItem *searchTab = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"search"] tag:3];
//    searchNav.tabBarItem = searchTab;
//    
//    UITabBarController *tab = [[UITabBarController alloc] init];
//    tab.viewControllers = @[searchNav];
    
    //设置代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickedPlusButton:)]) {
        [self.delegate tabBarDidClickedPlusButton:self];
    }
}

/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置plusButton的frame
    [self setupPlusButtonFrame];
    
    // 设置所有tabbarButton的frame
    [self setupAllTabBarButtonsFrame];
}

/**
 *  设置所有plusButton的frame
 */
- (void)setupPlusButtonFrame
{
    self.plusButton.size = CGSizeMake(60, 60);
    
    self.plusButton.center = CGPointMake(self.width * 0.5, self.height * 0.3);
}

/**
 *  设置所有tabbarButton的frame
 */
- (void)setupAllTabBarButtonsFrame
{
    int index = 0;
    
    // 遍历所有的button
    for (UIView *tabBarButton in self.subviews) {
        // 如果不是UITabBarButton， 直接跳过
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        // 根据索引调整位置
        [self setupTabBarButtonFrame:tabBarButton atIndex:index];
        
        // 遍历UITabBarButton中的所有子控件
        [self setupTabBarButtonTextColor:tabBarButton atIndex:index];
        
        // 索引增加
        index++;
    }
}

/**
 93  *  设置某个按钮的文字颜色
 94  *
 95  *  @param tabBarButton 需要设置的按钮
 96  *  @param index        按钮所在的索引
 97  */

- (void)setupTabBarButtonTextColor:(UIView *)tabBarButton atIndex:(int)index
{
    // 选中按钮的索引
    int selectedIndex = [self.items indexOfObject:self.selectedItem];
    
    for (UILabel *label in tabBarButton.subviews) {
        // 说明不是个Label
        if (![label isKindOfClass:[UILabel class]]) continue;
        
        // 设置字体
        label.font = [UIFont systemFontOfSize:10];
        if (selectedIndex == index) { // 说明这个Button选中, 设置label颜色为橙色
//            label.textColor = RGBA(41, 167, 255, 1);
            label.textColor = [UIColor colorWithRed:41.0f/255.0f green:167.0f/255.0f blue:255.0f/255.0f alpha:1];
        } else { // 说明这个Button没有选中, 设置label颜色为黑色
            label.textColor = [UIColor blackColor];
        }
    }
}

/**
 *  设置某个按钮的frame
 *
 *  @param tabBarButton 需要设置的按钮
 *  @param index        按钮所在的索引
 */
- (void)setupTabBarButtonFrame:(UIView *)tabBarButton atIndex:(int)index
{
    // 计算button的尺寸
    //    CGFloat buttonW = self.width / (self.items.count + 1);
    //    CGFloat buttonH = self.height;
    
    CGFloat buttonW = self.width / (self.items.count + 1);
    CGFloat buttonH = self.height;
    
    tabBarButton.width = buttonW;
    tabBarButton.height = buttonH;
    if (index >= 2) {
        tabBarButton.x = buttonW * (index + 1);
    } else {
        tabBarButton.x = buttonW * index;
    }
    tabBarButton.y = 0;
}

@end
