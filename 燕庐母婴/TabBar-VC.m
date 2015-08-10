//
//  TabBar-VC.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/11.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "TabBar-VC.h"
@interface TabBar_VC () <TabBarDelegate,ChangeStateViewControllerDelegate>

@end

@implementation TabBar_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Baby_ViewController *baby = [[Baby_ViewController alloc] init];
    NotPregnant_VC *notPrVC = [[NotPregnant_VC alloc] init];
    AlreadyBaby_ViewController *alreadyVC = [[AlreadyBaby_ViewController alloc] init];
    self.ud = [NSUserDefaults standardUserDefaults];
    NSString *zhuangtai = [NSString stringWithFormat:@"%@",[self.ud objectForKey:@"zhuangtai"]];
    
    if ([zhuangtai isKindOfClass:[NSNull class]])
    {
        [self addOneChildVc:notPrVC title:@"宝宝" imageName:@"宝宝@2x" selectedImageName:@"tab-baby-sel"];
        
    }
    else
    {
        if ([zhuangtai isEqualToString:@"3"])
        {
            [self addOneChildVc:alreadyVC title:@"宝宝" imageName:@"宝宝@2x" selectedImageName:@"tab-baby-sel"];
        }
        else if([zhuangtai isEqualToString:@"2"])
        {
            [self addOneChildVc:baby title:@"宝宝" imageName:@"宝宝@2x" selectedImageName:@"tab-baby-sel"];
        }
        else
        {
            [self addOneChildVc:notPrVC title:@"宝宝" imageName:@"宝宝@2x" selectedImageName:@"tab-baby-sel"];
        }
    }
    
    
    //圈子
    Circle_VC *circle = [[Circle_VC alloc] init];
    [self addOneChildVc:circle title:@"圈子" imageName:@"圈子@2x" selectedImageName:@"tab-circle-sel"];
    
    
    
    //搜索
    Search_VC *search = [[Search_VC alloc] init];
    [self addOneChildVc:search title:@"" imageName:@"" selectedImageName:@""];
    
    
    
    //发现
    Find_VC *find = [[Find_VC alloc] init];
    [self addOneChildVc:find title:@"发现" imageName:@"发现@2x" selectedImageName:@"tab-find-sel"];
    
    
    //个人
    Self_VC *mySelf = [[Self_VC alloc] init];
    [self addOneChildVc:mySelf title:@"个人" imageName:@"个人@2x" selectedImageName:@"tab-self-sel"];
    
    TabBar *customTabBar = [[TabBar alloc] init];
    
    //设置代理
    customTabBar.delegate=self;
    // 更换系统自带的tabbar
    [self setValue:customTabBar forKeyPath:@"tabBar"];
}

-(void)getMesArr:(NSArray *)mesArr
{
    ChangeStateViewController *changeVC = [[ChangeStateViewController alloc] init];
    changeVC.delegate = self;
    NSLog(@"houzepeng     =%@",mesArr);
}

- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 强制重新布局子控件（内部会调用layouSubviews）
    [self.tabBar setNeedsLayout];
    
    //设置标题
    childVc.title = title;  //相当于设置了后两者的标题
    
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    
    //设置tabBarItem普通状态下文字的颜色
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor]=[UIColor blackColor];
    textAttrs[UITextAttributeFont]=[UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置tabBarItem选中状态下文字的颜色
    NSMutableDictionary *selectedtextAttrs = [NSMutableDictionary dictionary];
    selectedtextAttrs[UITextAttributeTextColor]= RGBA(41, 167, 255, 1);
    [childVc.tabBarItem setTitleTextAttributes:selectedtextAttrs forState:UIControlStateSelected];
    
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childVc.tabBarItem.selectedImage = selectedImage;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
}

-(void)tabBarDidClickedPlusButton:(TabBar *)tabBar
{
}

@end
