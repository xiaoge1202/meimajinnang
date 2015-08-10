//
//  MoreZhishi-VC.m
//  美妈锦囊
//
//  Created by 侯泽彭 on 15/8/7.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "MoreZhishi-VC.h"

@interface MoreZhishi_VC ()

@end

@implementation MoreZhishi_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"知识库";
    
    self.view.backgroundColor = RGBA(235, 235, 235, 1);
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 16, 12, 20);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setFrame:CGRectMake(ScreenWidth*0.0625, ScreenWidth*0.05, ScreenWidth*0.225, ScreenWidth*0.08)];
    [button1 setImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(clickbutton1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, button1.frame.size.width, button1.frame.size.height)];
    label1.text = @"备孕常识";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
    label1.textColor = RGBA(89, 87, 87, 1);
    [button1 addSubview:label1];
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setFrame:CGRectMake(button1.frame.origin.x+button1.frame.size.width+ScreenWidth*0.1, ScreenWidth*0.05, ScreenWidth*0.225, ScreenWidth*0.08)];
    [button2 setImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(clickbutton2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, button2.frame.size.width, button2.frame.size.height)];
    label2.text = @"孕前调养";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
    label2.textColor = RGBA(89, 87, 87, 1);
    [button2 addSubview:label2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setFrame:CGRectMake(button2.frame.origin.x+button2.frame.size.width+ScreenWidth*0.1, ScreenWidth*0.05, ScreenWidth*0.225, ScreenWidth*0.08)];
    [button3 setImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(clickbutton3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, button3.frame.size.width, button3.frame.size.height)];
    label3.text = @"孕前检查";
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
    label3.textColor = RGBA(89, 87, 87, 1);
    [button3 addSubview:label3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button4 setFrame:CGRectMake(ScreenWidth*0.0625, button1.frame.origin.y+button1.frame.size.height+ScreenWidth*0.06, ScreenWidth*0.225, ScreenWidth*0.08)];
    [button4 setImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(clickbutton4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, button4.frame.size.width, button4.frame.size.height)];
    label4.text = @"受孕技巧";
    label4.textAlignment = NSTextAlignmentCenter;
    label4.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
    label4.textColor = RGBA(89, 87, 87, 1);
    [button4 addSubview:label4];
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button5 setFrame:CGRectMake(button4.frame.origin.x+button4.frame.size.width+ScreenWidth*0.1, button1.frame.origin.y+button1.frame.size.height+ScreenWidth*0.06, ScreenWidth*0.225, ScreenWidth*0.08)];
    [button5 setImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [button5 addTarget:self action:@selector(clickbutton5) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, button5.frame.size.width, button5.frame.size.height)];
    label5.text = @"不孕不育";
    label5.textAlignment = NSTextAlignmentCenter;
    label5.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
    label5.textColor = RGBA(89, 87, 87, 1);
    [button5 addSubview:label5];
    
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-ScreenWidth*0.177-64, ScreenWidth, ScreenWidth*0.177)];
    View.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:View];
    
    UIButton *beiyunBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [beiyunBtn setFrame:CGRectMake(ScreenWidth*0.3/4, ScreenWidth*0.016, View.frame.size.width*0.7, View.frame.size.width*0.7)];
    [beiyunBtn setImage:[UIImage imageNamed:@"备孕"] forState:UIControlStateNormal];
    [View addSubview:beiyunBtn];
    
    UILabel *beiyunLabel = [[UILabel alloc] initWithFrame:CGRectMake(beiyunBtn.frame.origin.x+beiyunBtn.frame.size.width, beiyunBtn.frame.origin.y+beiyunBtn.frame.size.height+2, beiyunBtn.frame.size.width, 10)];
    beiyunLabel.text = @"备孕";
    beiyunLabel.textAlignment = NSTextAlignmentCenter;
    beiyunLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
    beiyunLabel.textColor = RGBA(137, 137, 137, 1);
    [View addSubview:beiyunLabel];
    
    // Do any additional setup after loading the view.
}

-(void)backViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickbutton1
{
    Beiyun_VC *beiyunVC = [[Beiyun_VC alloc] init];
    beiyunVC.title = @"备孕常识";
    [self.navigationController pushViewController:beiyunVC animated:YES];
}

-(void)clickbutton2
{
    Beiyun_VC *beiyunVC = [[Beiyun_VC alloc] init];
    beiyunVC.title = @"孕前调养";
    [self.navigationController pushViewController:beiyunVC animated:YES];
}

-(void)clickbutton3
{
    Beiyun_VC *beiyunVC = [[Beiyun_VC alloc] init];
    beiyunVC.title = @"孕前检查";
    [self.navigationController pushViewController:beiyunVC animated:YES];
}

-(void)clickbutton4
{
    Beiyun_VC *beiyunVC = [[Beiyun_VC alloc] init];
    beiyunVC.title = @"受孕技巧";
    [self.navigationController pushViewController:beiyunVC animated:YES];
}

-(void)clickbutton5
{
    Beiyun_VC *beiyunVC = [[Beiyun_VC alloc] init];
    beiyunVC.title = @"不孕不育";
    [self.navigationController pushViewController:beiyunVC animated:YES];
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
