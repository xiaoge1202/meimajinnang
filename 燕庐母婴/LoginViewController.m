//
//  LoginViewController.m
//  YanLuMuYing
//
//  Created by 赵天韡 on 15/1/16.
//  Copyright (c) 2015年 赵天韡. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()

@end



NSString *pet_name;
NSString *password;
NSString *notarizePassword;

static NSTimer *timer;

@implementation LoginViewController



- (void)viewWillAppear:(BOOL)animated
{
    self.ucsCallservice = [[UCSVerifyService alloc]initWithDelegate:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [timer invalidate];
    timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBA(239, 239, 239, 1);
    
//    /*----------导航栏添加图片-----------*/
//    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
//    head.backgroundColor = [UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1];
//    [self.navigationController.view addSubview:head];
    
    
    //首先创建一个view
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
//    [self.navigationController.view addSubview:view];
//    
//    
//    //然后创建一个Imgview添加到view上
//    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
//    imageV.image = [UIImage imageNamed:@"导航栏"];
//    [view addSubview:imageV];
//    
//    
//    //最后创建一个label添加到imgView上
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-100)/2, 5, 100, 35)];
//    label.textColor = [UIColor whiteColor];
//    label.text = @"注     册";
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont systemFontOfSize:22];
//    [imageV addSubview:label];
    
    self.title = @"注册";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];

    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 16, 12, 20);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
    self.pet_nameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20, 40)];
    self.pet_nameField.tag = 1001;
    self.pet_nameField.placeholder = @"手机号";
    self.pet_nameField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.pet_nameField];
    
    
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.pet_nameField.frame.origin.y+self.pet_nameField.frame.size.height+6, self.view.frame.size.width-20, 40)];
    self.passwordField.tag = 1002;
    self.passwordField.placeholder = @"6-14位数字或数字字母组合";
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.passwordField];
    
    
    self.notarizePasswordField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.passwordField.frame.origin.y+self.passwordField.frame.size.height+6, self.view.frame.size.width-20, 40)];
    self.notarizePasswordField.tag = 1003;
    self.notarizePasswordField.placeholder = @"确认密码";
    self.notarizePasswordField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.notarizePasswordField];
    
    
    self.shortField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.notarizePasswordField.frame.origin.y+self.notarizePasswordField.frame.size.height+6, (self.view.frame.size.width-20)/3*2, 40)];
    self.shortField.tag = 1003;
    self.shortField.placeholder = @"输入验证码";
    self.shortField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.shortField];
    
    
    
    self.shortBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.shortBtn setFrame:CGRectMake(self.shortField.frame.origin.x+self.shortField.frame.size.width+6, self.notarizePasswordField.frame.origin.y+self.notarizePasswordField.frame.size.height+6, ScreenWidth-self.shortField.frame.size.width-26, 40)];
    [self.shortBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.shortBtn.layer.borderWidth = 1;
    self.shortBtn.layer.masksToBounds = YES;
    self.shortBtn.layer.cornerRadius = 5;
    self.shortBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.shortBtn.layer.borderColor = RGBA(226, 226, 226, 1).CGColor;
    [self.shortBtn addTarget:self action:@selector(shortBtnIsClick)forControlEvents:UIControlEventTouchUpInside];
    [self.shortBtn setTitleColor:RGBA(183, 184, 184, 1) forState:UIControlStateNormal];
    self.shortBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.shortBtn];
    
    
    
    
    self.putinBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.putinBtn setFrame:CGRectMake(10, self.shortField.frame.origin.y+self.shortField.frame.size.height +6 , ScreenWidth-20, 40)];
    [self.view addSubview:self.putinBtn];
    [self.putinBtn setTitle:@"注       册" forState:UIControlStateNormal];
    [self.putinBtn addTarget:self action:@selector(buttonClickSure)forControlEvents:UIControlEventTouchUpInside];
    [self.putinBtn setTitleColor:RGBA(46, 44, 42, 1) forState:UIControlStateNormal];
    self.putinBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.putinBtn setBackgroundColor:RGBA(220, 221, 221, 1)];
    self.putinBtn.layer.borderWidth = 1;
    self.putinBtn.layer.masksToBounds = YES;
    self.putinBtn.layer.cornerRadius = 5;
    self.putinBtn.layer.borderColor = RGBA(226, 226, 226, 1).CGColor;
}


-(void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 短信验证的协议方法【获取验证码成功 失败； 验证成功 失败】
//获取验证码成功回调
-(void)onGetValiateCodeSuccessful:(NSInteger)nResult
{
    if (nResult==0)
    {
        [self showtips:@"该手机号已被注册"];
        return;
    }
    
    
    timer = nil;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(doTimer) userInfo:nil repeats:TRUE];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer fire];
    [self.shortBtn setEnabled:NO];
    
    if (nResult==1)
    {
        [self showtips:@"已下发短信验证码"];
    }
}

// 云获取验证码失败
- (void) onGetValiateCodeFailed:(NSInteger)reason
{
    NSString *tipString;
    switch (reason) {
        case 401051:
            tipString = @"获取验证码失败";
            break;
        case 401052:
            tipString = @"验证码错误";
            break;
        case 401053:
            tipString = @"验证超时";
            break;
        case 401061:
            tipString = @"开发者账号无效";
            break;
        case 401062:
            tipString = @"验证码错误";
            break;
        case 401063:
            tipString = @"验证码过期";
            break;
        case 401064:
            tipString = @"30s内重复请求";
            break;
        case 401065:
            tipString = @"签名错误";
            break;
        case 401066:
            tipString = @"手机号码无效";
            break;
        case 401067:
            tipString = @"已经注册过";
            break;
        case 401068:
            tipString = @"未创建智能短信模板";
            break;
        case 401069:
            tipString = @"短信模板有误，需要检查是否创建智能验证短信模板，模板审核、参数";
            break;
        case 401070:
            tipString = @"应用状态有误，需要检查应用是否审核通过、是否上线";
            break;
        default:
            tipString = @"其他错误";
            break;
    }
    
    [self showtips:tipString];
}

// 云验证成功
-(void)onDoValiateCodeSuccessful:(NSInteger)nResult
{
    if (nResult==0)
    {
        [self returnDataToServer];
     }
}
// 云验证失败
- (void) onDoValiateCodeFailed:(NSInteger)reason
{
    NSString *tipString;
    switch (reason) {
        case 401051:
            tipString = @"获取验证码失败";
            break;
        case 401052:
            tipString = @"验证码错误";
            break;
        case 401053:
            tipString = @"验证超时";
            break;
        case 401061:
            tipString = @"开发者账号无效";
            break;
        case 401062:
            tipString = @"验证码错误";
            break;
        case 401063:
            tipString = @"验证码过期";
            break;
        case 401064:
            tipString = @"30s内重复请求";
            break;
        case 401065:
            tipString = @"签名错误";
            break;
        case 401066:
            tipString = @"手机号码无效";
            break;
        case 401067:
            tipString = @"已经注册过";
            break;
        case 401068:
            tipString = @"未创建智能短信模板";
            break;
        case 401069:
            tipString = @"短信模板有误，需要检查是否创建智能验证短信模板，模板审核、参数";
            break;
        case 401070:
            tipString = @"应用状态有误，需要检查应用是否审核通过、是否上线";
            break;
        default:
            tipString = @"其他错误";
            break;
    }
    
    [self showtips:tipString];
}





-(void)shortBtnIsClick
{
    [self.shortBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    if ([self isMobileNumber:self.pet_nameField.text] == NO)
//    {
//        [self showtips:@"请输入正确的手机号码"];
//    }
//    else
//    {
        timeCounter = 60;
        
        //这个http请求就是为了获取sign，如果有sign就不用这个请求，直接调用[self requestCode];
        NSString *getStateStr = [NSString stringWithFormat:@"%@phone=%@",GetValiateStateBaseUrl,self.pet_nameField.text];
        NSMutableURLRequest *getVerifyRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:getStateStr] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
        getVerifyStateConn = [[NSURLConnection alloc] initWithRequest:getVerifyRequest delegate:self];
        [getVerifyStateConn start];
        NSLog(@"输入的手机号码正确");
    //}

}

//获取验证码
-(void)requestCode
{
    
    [self.ucsCallservice getVerificationCode:@"4c1990a5c1ad2674bc94bc39a6fd0699" withAppid:@"efb7e1de9da649fa83881afea2841cd7" withAppName:@"测试DEMO" withCodetype:1 withPhone:self.pet_nameField.text withSeconds:60 withBusiness:1 withSign:signString];
    NSLog(@"获取验证码");
    
    
}

#pragma mark- 网络连接协议方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response
{
    NSHTTPURLResponse* rsp = (NSHTTPURLResponse*)response;
    long int code = [rsp statusCode];
    if (code != 200)
    {
        
        [connection cancel];
        connection = nil;
    }
    else
    {
        if (mData != nil)
        {
            mData = nil;
        }
        mData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSMutableString *connectString;
    connectString = [[NSMutableString alloc] initWithData:mData encoding:NSUTF8StringEncoding];
    NSRange resultRange = [connectString rangeOfString:@"\"result\":"];
    NSString *resultMidString = [connectString substringFromIndex:resultRange.location+resultRange.length ];
    NSRange resultTailRange = [resultMidString rangeOfString:@","];
    NSString *resultString =[resultMidString substringToIndex:resultTailRange.location];
    if ([resultString isEqualToString:@"0"])
    {
        NSRange signRange = [connectString rangeOfString:@"\"sign\":\""];
        NSString *signMidString = [connectString substringFromIndex:signRange.location+signRange.length ];
        NSRange signTailRange = [signMidString rangeOfString:@"\""];
        signString =[signMidString substringToIndex:signTailRange.location];
        [self requestCode];
        
    }
    
    
    connection = nil;
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    connection = nil;
    
    [self showtips:[NSString stringWithFormat:@"%ld",(long)[error code]]];
}


 #pragma mark- 其他 【分钟数倒数回调方法 提示框 键盘收起】
 //获取验证码成功回调  1分钟倒数计数
 - (void)doTimer
 {
 
 NSLog(@"------timeCounter--:%d",timeCounter);
 
  NSString *showTime = [NSString stringWithFormat:@"%d秒后重发", timeCounter];
 [self.shortBtn setTitle:showTime forState:UIControlStateNormal];
 

     
 if (timeCounter<=0) {
 [timer invalidate];
 timer = nil;
 
 [self.shortBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
 [self.shortBtn setEnabled:YES];
 
 }
 timeCounter--;
 }
 

//提示框
-(void)showtips:(NSString *)tipMsg
{
    
    UIAlertView *aShow = [[UIAlertView alloc]initWithTitle:nil message:tipMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [aShow show];
}



//上传账号密码信息给服务器
-(void)buttonClickSure
{
    [self.ucsCallservice doVerificationCode:@"4c1990a5c1ad2674bc94bc39a6fd0699" withAppid:@"efb7e1de9da649fa83881afea2841cd7" withPhone:self.pet_nameField.text withVerifycode:self.shortField.text];
}


//向服务器上传数据（注册信息）
-(void)returnDataToServer
{
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    pet_name = ((UITextField *)[self.view viewWithTag:1001]).text;
    password = ((UITextField *)[self.view viewWithTag:1002]).text;
    notarizePassword = ((UITextField *)[self.view viewWithTag:1003]).text;
    
    self.dic = [[NSMutableDictionary alloc]init];
    [self.dic setObject:pet_name forKey:@"username"];
    [self.dic setObject:password forKey:@"password"];
    
    if (pet_name.length == 11) {
        
        if ([password isEqualToString:notarizePassword]) {
            
            if (password.length>=6) {
                
                [self.manager POST:@"http://101.200.234.127:8080/YanLu/user/login.do" parameters:[@{@"username":pet_name}mutableCopy]
                           success:^(AFHTTPRequestOperation *operation, id responseObject)
                 {
                     // 当使用HTTP响应解析器时，服务器响应数据被封装在NSData中
                     // 此处将NSData转换成NSString、并使用UIAlertView显示登录结果
                     
                     NSString *string  = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                     NSLog(@"%@",string);
                     
                     if ([string isEqualToString:@"true"]) {
                         [[[UIAlertView alloc] initWithTitle:@"注册结果" message:@"该账号已存在" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
                     }else{
                         
                         [self.manager POST:@"http://101.200.234.127:8080/YanLu/user/save.do" parameters:self.dic
                                    success:^(AFHTTPRequestOperation *operation, id responseObject)
                          {
                              // 使用UIAlertView显示登录结果
//                              [[[UIAlertView alloc] initWithTitle:@"注册结果" message:@"注册成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
                              
                              //点击确定跳转到登录页面
                              [self dismissViewControllerAnimated:YES completion:nil];
                          }
                                    failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                    }];
                     }
                 }
                           failure:^(AFHTTPRequestOperation *operation, NSError *error){
                               NSLog(@"获取服务器响应出错！");
                           }];

            }else{
                NSLog(@"密码过于简单");
            }
        } else {
            NSLog(@"密码不一致");
        }
    } else {
        NSLog(@"手机号不正确");
    }
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



@end
