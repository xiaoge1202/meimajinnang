//
//  SetNameViewController.m
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/15.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "SetNameViewController.h"

@interface SetNameViewController ()

@end

@implementation SetNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"更 改 昵 称";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //返回按钮
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(20, 14, 16, 20);
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *setupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setupBtn.frame = CGRectMake(ScreenWidth-32, 16, 18, 18);
    [setupBtn setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    [setupBtn addTarget:self action:@selector(clickFinishBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:setupBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.nameText = [[UITextField alloc] initWithFrame:CGRectMake(22, 25, ScreenWidth-44, 18)];
    self.nameText.text = self.nameStr;
    NSLog(@"%@",self.nameStr);
    self.nameText.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:18];
    self.nameText.textColor = RGBA(89, 87, 87, 1);
    [self.view addSubview:self.nameText];
    
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(18, self.nameText.frame.origin.y+self.nameText.frame.size.height+8, ScreenWidth-36, 1)];
    lineImg.backgroundColor = RGBA(236, 117, 147, 1);
    [self.view addSubview:lineImg];
    
    UILabel *jieshaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, lineImg.frame.origin.y+lineImg.frame.size.height+10, ScreenWidth-40, 12)];
    jieshaoLabel.text = @"好名字可以让你的朋友更容易记住你";
    jieshaoLabel.textColor = RGBA(137, 137, 137, 1);
    jieshaoLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
    [self.view addSubview:jieshaoLabel];
    
    // Do any additional setup after loading the view.
}

-(void)goBack:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickFinishBtn
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *selfDic = [[NSMutableDictionary alloc] init];
    
    NSString *zhanghao = [ud objectForKey:@"username"];
    
    [selfDic setObject:zhanghao forKey:@"username"];
    [selfDic setObject:self.nameText.text forKey:@"nicheng"];
    
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/user/update.do" parameters:selfDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"获取成功");
        
        NSData *data = (NSData*)responseObject;
        
        self.dataArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取服务器失败");
        [[[UIAlertView alloc] initWithTitle:@"修改失败" message:@"网络错误，请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }];

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
