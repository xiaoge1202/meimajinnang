//
//  SendVideo-VC.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/7/7.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "SendVideo-VC.h"

@interface SendVideo_VC ()

@end

@implementation SendVideo_VC

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"fileURL--%@",self.fileURL);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发 布";
    self.view.backgroundColor = RGBA(235, 235, 235, 1);

    //取消导航栏和状态栏的边缘延展效果
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;

    //获取用户ID
    _user = [NSUserDefaults standardUserDefaults];
    _userId = [_user objectForKey:@"userid"];
    
    //返回按钮
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(10, 14, 12, 20);
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backBtnTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
    //发送按钮
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendBtn.frame = CGRectMake(0, 15, 38, 21);
    [self.sendBtn setBackgroundImage:[UIImage imageNamed:@"发送帖子"] forState:UIControlStateNormal];
    [self.sendBtn addTarget:self action:@selector(sendBtnTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.sendBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 130)];
    self.textView.delegate = self;
    self.textView.tag = 1001;
    [self.view addSubview:self.textView];
    
    //实现plahold效果
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(3, 5, 200, 20)];
    self.label.enabled = NO;
    self.label.text = @"说点什么呢......";
    self.label.font =  [UIFont systemFontOfSize:11];
    self.label.textColor = RGBA(89 , 87, 87, 1);
    [self.textView addSubview:self.label];
}


-(void)backBtnTouchUpInside
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)sendBtnTouchUpInside
{
    
    self.manager =[AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/guangchang/save.do" parameters:[@{@"userid":_userId,@"neirong":self.textView.text,@"videos":self.fileURL}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //返回上一页
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"连接服务错误");
    }];

}


-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView becomeFirstResponder]) {
        self.label.hidden = YES;
    }else{
        self.label.hidden = NO;
    }
}
@end
