//
//  GuideViewController.m
//  美妈锦囊
//
//  Created by 侯泽彭 on 15/7/22.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

-(UIScrollView*)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        //开启分页功能
        _scrollView.pagingEnabled = YES;
        //隐藏滚动指示条
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        //设置它的内容视图大小
        
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width *4, 1);
        //设置代理
        _scrollView.delegate = self;
        //添加子控件
        for (int i = 0; i<4; i++) {
            UIImageView* imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0+ScreenWidth*i, 0, ScreenWidth, ScreenHeight)];
            imageview.tag = i;
            imageview.userInteractionEnabled = YES;
            imageview.multipleTouchEnabled = YES;
            imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"欢迎%d.png",i+1]];
            
            [_scrollView addSubview:imageview];
            //给最后一个图形添加按钮控件
            if (i == 3) {
                UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button.frame =  CGRectMake(ScreenWidth*3+ScreenWidth*0.33, ScreenHeight*0.8, ScreenWidth*0.33, 40);
                //[button setCenter:CGPointMake(self.view.center.x, self.view.center.y+100)];
                button.layer.masksToBounds = YES;
                button.layer.borderWidth = 2;
                button.layer.borderColor = [UIColor whiteColor].CGColor;
                button.layer.cornerRadius = 10;
                [button setTitle:@"开始体验" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                [button addTarget:self action:@selector(buttonPressToMainVC:) forControlEvents:UIControlEventTouchUpInside];
                [_scrollView addSubview:button];
            }
            
        }
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    // Do any additional setup after loading the view.
}

-(void)buttonPressToMainVC:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"welcome"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    EnterViewController *enterVc = [[EnterViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:enterVc];
    //[UIView animateWithDuration:2 animations:^{
    [self presentViewController:nav animated:YES completion:nil];
    //}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
