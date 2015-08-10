//
//  EnterViewController.m
//  帖子列表
//
//  Created by 董飞剑 on 15/1/10.
//  Copyright (c) 2015年 DongFeiJian. All rights reserved.
//

#import "EnterViewController.h"

  /****************-----登录页面-----****************/
@interface EnterViewController ()
{
    NSString *pet_name;
    NSString *password;
}

@property (strong,nonatomic) UITextField *pet_nameField;
@property (strong,nonatomic) UITextField *passwordField;
@property (strong,nonatomic) UIButton *putinBtn;
@property (strong,nonatomic) NSMutableArray *arr;
@property (strong,nonatomic) NSMutableDictionary *dic;

@end

@implementation EnterViewController



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"YES||NO"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 实例化TencentOAuth对象
    self.tencent = [[TencentOAuth alloc] initWithAppId:@"222222" andDelegate:self];
    //用户登录成功过后的跳转页面地址
    self.tencent.redirectURI = @"www.qq.com";
    /*----------导航栏添加图片-----------*/
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
//    //最后创建一个label添加到imgView上
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-100)/2, 5, 100, 35)];
//    label.textColor = [UIColor whiteColor];
//    label.text = @"登 录";
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont systemFontOfSize:22];
//    [imageV addSubview:label];
    
    self.title = @"登录";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    
    //账号输入框
    self.pet_nameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth-20, 40)];
    self.pet_nameField.tag = 1003;
    self.pet_nameField.placeholder = @"手机号/邮箱/QQ";
//    self.pet_nameField.textAlignment = NSTextAlignmentCenter;
    self.pet_nameField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.pet_nameField];
    [self.pet_nameField resignFirstResponder];
    
    //密码输入框
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.pet_nameField.frame.origin.y+self.pet_nameField.frame.size.height +6, ScreenWidth-20, 40)];
    self.passwordField.tag = 1004;
    self.passwordField.placeholder = @"登录密码";
//    self.passwordField.textAlignment = NSTextAlignmentCenter;
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.passwordField];
    [self.passwordField resignFirstResponder];
    

    
    self.putinBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.putinBtn setFrame:CGRectMake(10, self.passwordField.frame.origin.y+self.passwordField.frame.size.height +6 , ScreenWidth-20, 40)];
    [self.view addSubview:self.putinBtn];
    [self.putinBtn setTitle:@"登      录" forState:UIControlStateNormal];
    [self.putinBtn addTarget:self action:@selector(buttonClickSure)forControlEvents:UIControlEventTouchUpInside];
    [self.putinBtn setTitleColor:RGBA(46, 44, 42, 1) forState:UIControlStateNormal];
    self.putinBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.putinBtn setBackgroundColor:RGBA(220, 221, 221, 1)];
    self.putinBtn.layer.borderWidth = 1;
    self.putinBtn.layer.masksToBounds = YES;
    self.putinBtn.layer.cornerRadius = 5;
    self.putinBtn.layer.borderColor = RGBA(226, 226, 226, 1).CGColor;

    
    //新用户(注册按钮)
    UIButton *login = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    login.frame = CGRectMake(15, self.putinBtn.frame.origin.y+self.putinBtn.frame.size.height+8, 80, 20);
    [login setTitle:@"新用户注册" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [login setTitleColor:RGBA(119, 136, 195, 1) forState:UIControlStateNormal];
    [login addTarget:self action:@selector(loginView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    
    
    //忘记密码
    UIButton* memory = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    memory.frame = CGRectMake(ScreenWidth-85, self.putinBtn.frame.origin.y+self.putinBtn.frame.size.height+8, 70, 20);
    [memory setTitle:@"忘记密码" forState:UIControlStateNormal];
    [memory setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [memory setTitleColor:RGBA(119, 136, 195, 1) forState:UIControlStateNormal];
    [memory addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:memory];
    
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(90, memory.frame.origin.y+memory.frame.size.height+55, ScreenWidth-180, 20)];
    lab.text = @"第三方快捷登录";
    lab.textColor = RGBA(220, 221, 221, 1);
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    
    //微信
    UIButton *weiXin = [[UIButton alloc] initWithFrame:CGRectMake(44, lab.frame.origin.y+lab.frame.size.height + 18, 40, 40)];
    [weiXin setImage:[UIImage imageNamed:@"微信B"] forState:UIControlStateNormal];
    [weiXin setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateSelected];
    [weiXin addTarget:self action:@selector(weiXinLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weiXin];
    
    
    UILabel *weixinLab = [[UILabel alloc] initWithFrame:CGRectMake(44, weiXin.frame.origin.y+weiXin.frame.size.height+6, 40, 20)];
    weixinLab.text = @"微信";
    weixinLab.textColor = RGBA(220, 221, 221, 1);
    weixinLab.textAlignment = NSTextAlignmentCenter;
    weixinLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:weixinLab];
    

    
    //QQ登录
    UIButton *QQ = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-84, lab.frame.origin.y+lab.frame.size.height + 18, 40, 40)];
    [QQ setImage:[UIImage imageNamed:@"QQB"] forState:UIControlStateNormal];
    [QQ setImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateSelected];
    [QQ addTarget:self action:@selector(QQLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QQ];
    
    
    UILabel *QQLab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-84, weiXin.frame.origin.y+weiXin.frame.size.height+6, 40, 20)];
    QQLab.text = @"QQ";
    QQLab.textColor = RGBA(220, 221, 221, 1);
    QQLab.textAlignment = NSTextAlignmentCenter;
    QQLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:QQLab];
    
    self.dic = [NSMutableDictionary dictionary];
}


-(void)forgetPassword
{
    ForgetPassword_VC *forgetPaw = [[ForgetPassword_VC alloc] init];
    UINavigationController *forgetNVC = [[UINavigationController alloc] initWithRootViewController:forgetPaw];
    [self presentViewController:forgetNVC animated:YES completion:nil];
}


//点击登录按钮
-(void)buttonClickSure
{
    [self postDataFromServer];
}


-(void)postDataFromServer
{ 
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    pet_name = ((UITextField *)[self.view viewWithTag:1003]).text;
    NSLog(@"用户账号 = %@",pet_name);
    password = ((UITextField *)[self.view viewWithTag:1004]).text;
    NSLog(@"登录信息 = %@",self.dic);
    
    if ([pet_name isEqualToString:@""]||[password isEqualToString:@""]) {
        [[[UIAlertView alloc]initWithTitle:@"登录结果" message:@"账号或密码为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil]show];
    }
    else
    {
        self.dic = [[NSMutableDictionary alloc]init];
        [self.dic setObject:pet_name forKey:@"username"];
        [self.dic setObject:password forKey:@"password"];
        
        ////////////////////////////////////////////
        // 使用AFHTTPRequestOperationManager发送POST请求
        [self.manager POST:@"http://101.200.234.127:8080/YanLu/user/list.do" parameters:self.dic  // 指定请求参数
         // 获取服务器响应成功时激发的代码块
                   success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             // 当使用HTTP响应解析器时，服务器响应数据被封装在NSData中
             // 此处将NSData转换成NSString、并使用UIAlertView显示登录结果
             NSData *data = responseObject;
             NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             self.dataArr = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:0 error:nil];
             NSLog(@"%@",self.dataArr);
             if ([str isEqualToString:@"false"]) {
                 
                 [[[UIAlertView alloc]initWithTitle:@"登录结果" message:@"账号或密码错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil]show];
             }else{
                 [[NSUserDefaults standardUserDefaults] setObject:pet_name forKey:@"firstLogin"];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 UserModel *model = [UserModel sharedUserModel];
                 
                 NSMutableDictionary *dic = [self.dataArr objectAtIndex:0];
                 
                 //NSMutableDictionary *birthday = [dic objectForKey:@"birthday"];
                 //NSString *huaiyuntianshu = [dic objectForKey:@"huaiyuntianshu"];
                 //NSString *nicheng = [dic objectForKey:@"nicheng"];
                 NSString *pwd = [dic objectForKey:@"password"];
                 //NSString *qianming = [dic objectForKey:@"qianming"];
                 //NSString *touxiang = [dic objectForKey:@"touxiang"];
                 NSString *userId = [dic objectForKey:@"userid"];
                 //NSString *useraddr = [dic objectForKey:@"useraddr"];
                 NSString *username = [dic objectForKey:@"username"];
                 //NSString *zhuangtai = [dic objectForKey:@"zhuangtai"];
                 //NSString *huaiyuntime = [dic objectForKey:@"huaiyuntime"];
                 
                 //model.bitthday = birthday;
                 //model.huaiyuntianshu = huaiyuntianshu;
                 //model.nicheng = nicheng;
                 model.password = pwd;
                 //model.qianming = qianming;
                 //model.touxiang = touxiang;
                 model.userId = userId;
                 //model.useraddr = useraddr;
                 model.username = username;
                 //model.zhuangtai = zhuangtai;
                 //model.huaiyuntime = huaiyuntime;
                 
                 NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                 //[ud setObject:model.bitthday forKey:@"bitthday"];
                 //[ud setObject:model.huaiyuntianshu forKey:@"huaiyuntianshu"];
                 //[ud setObject:model.nicheng forKey:@"nicheng"];
                 [ud setObject:model.password forKey:@"password"];
                 //[ud setObject:model.qianming forKey:@"qianming"];
                 //[ud setObject:model.touxiang forKey:@"touxiang"];
                 [ud setObject:model.userId forKey:@"userid"];
                 //[ud setObject:model.useraddr forKey:@"useraddr"];
                 [ud setObject:model.username forKey:@"username"];
                 //[ud setObject:model.zhuangtai forKey:@"zhuangtai"];
                 //[ud setObject:model.huaiyuntime forKey:@"huaiyuntime"];
                 if([[ud objectForKey:@"huaiyuntianshu"] isKindOfClass:[NSNull class]])
                 {
                     
                 }
                 else
                 {
                     [ud removeObjectForKey:@"huaiyuntianshu"];
                     [ud removeObjectForKey:@"huaiyuntime"];
                     [ud removeObjectForKey:@"zhuangtai"];
                     
                     [ud setObject:[dic objectForKey:@"huaiyuntianshu"] forKey:@"huaiyuntianshu"];
                     [ud setObject:[[dic objectForKey:@"zhuangtai"] stringValue]  forKey:@"zhuangtai"];
                     [ud setObject:[dic objectForKey:@"huaiyuntime"] forKey:@"huaiyuntime"];
                 }
                 [ud synchronize];
                 
                 NSLog(@"55555%@",ud);
                 
                 if([[ud objectForKey:@"huaiyuntianshu"] isKindOfClass:[NSNull class]])
                 {
                     ChangeStateViewController *changeVC = [[ChangeStateViewController alloc] init];
                     changeVC.nameString = @"1";
                     [self.navigationController pushViewController:changeVC animated:YES];
                 }
                 
                 else
                 {
                     TabBar_VC *tab = [[TabBar_VC alloc]init];
                     [self presentViewController:tab animated:YES completion:nil];
                 }
                 
                 
             }
         }
         // 获取服务器响应失败时激发的代码块
                   failure:^(AFHTTPRequestOperation *operation, NSError *error){
                       NSLog(@"获取服务器响应出错！");
                   }];
    }
    
    
}


//注册页面
-(void)loginView
{
    LoginViewController *login = [[LoginViewController alloc]init];
    UINavigationController *loginNVC = [[UINavigationController alloc] initWithRootViewController:login];
    [self presentViewController:loginNVC animated:YES completion:nil];
}


-(void)weiXinLogin:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.isSelected;
//    if (btn.isSelected) {
//        
//
//    }else{
//        
//    }
    
    
}



-(void)QQLogin:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.isSelected;
    
//    [[NSUserDefaults standardUserDefaults] setObject:@"111" forKey:@"firstLogin"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    // 装有获取用户信息的数组
    self.permission = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_USER_INFO, nil];
    // 登录授权
    // permissions：授权信息列表
    // bInSafari：是否使用safari进行登录
    [self.tencent authorize:self.permission inSafari:YES];
    //NSLog(@"%@",self.permission);
    
//    if (btn.isSelected) {
//
//
//    }else{
//        
//    }
}

// AlertView
- (void)alertView:(NSString *)mes withTitle:(NSString *)title
{
    [[[UIAlertView alloc] initWithTitle:title message:mes delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}


// 登录成功
- (void)tencentDidLogin
{
    [self.tencent getUserInfo];
    
}

// 非网络错误导致登录失败
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled)
    {
        self.textView.text = @"用户取消登录";
    }
    else
    {
        self.textView.text = @"非网络错误导致登录失败";
    }
}



// 网络错误导致登录失败
- (void)tencentDidNotNetWork
{
    self.textView.text = @"网络不给力";
}

// 通知第三方界面需要被关闭
// tencentOAuth 返回回调的tencentOAuth对象
// viewController 需要关闭的viewController
- (void)tencentOAuth:(TencentOAuth *)tencentOAuth doCloseViewController:(UIViewController *)viewController
{
    
    ChangeStateViewController *changeVC = [[ChangeStateViewController alloc] init];
    changeVC.nameString = @"1";
    [self.navigationController pushViewController:changeVC animated:YES];
}

// 获取用户个人信息回调
- (void)getUserInfoResponse:(APIResponse *)response
{
    // 服务器返回原始数据的字符串
    NSString *mes = response.message;
    // 网络请求是否成功送达服务器，以及服务器返回的数据格式是否正确
    if (response.retCode == 0)
    {
        //[self alertView:[NSString stringWithFormat:@"%@",mes] withTitle:@"获取数据成功"];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if([[ud objectForKey:@"huaiyuntianshu"] isKindOfClass:[NSNull class]])
        {
            
        }
        else
        {
            [ud removeObjectForKey:@"huaiyuntianshu"];
            [ud removeObjectForKey:@"huaiyuntime"];
            [ud removeObjectForKey:@"zhuangtai"];
        }
        [ud synchronize];
        NSArray *array = [mes componentsSeparatedByString:@","];
        //[[NSUserDefaults standardUserDefaults] setObject:@"111" forKey:@"firstLogin"];
        //[[NSUserDefaults standardUserDefaults] synchronize];
        ChangeStateViewController *changeVC = [[ChangeStateViewController alloc] init];
        changeVC.nameString = @"1";
        changeVC.messageArr = array;
        [self.navigationController pushViewController:changeVC animated:YES];
        
        
    }
    else
    {
        [self alertView:nil withTitle:@"获取数据失败"];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
