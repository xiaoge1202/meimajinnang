//
//  Self-VC.m
//  滚动视图
//
//  Created by 董飞剑 on 15/5/28.
//  Copyright (c) 2015年 侯泽彭. All rights reserved.
//

#import "Self-VC.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface Self_VC ()
{
    NSString* filePath;
    NSString *touxiang;
    UIActionSheet *myActionSheet;
    NSDictionary *d;
}
@property (strong,nonatomic) NSMutableDictionary *dic;
@end

@implementation Self_VC

-(void)viewWillAppear:(BOOL)animated
{
    [self getUserMessage];
}

-(void)creatTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-50) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 138)];
    self.tableView.tableHeaderView = sectionView;
    self.titleImgView = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.titleImgView setFrame:CGRectMake(0, 0, ScreenWidth, 138)];
    [self.titleImgView setImage:[UIImage imageNamed:@"titlebackgroundColor"] forState:UIControlStateNormal] ;
    [self.titleImgView addTarget:self action:@selector(editMessageBtn) forControlEvents:UIControlEventTouchUpInside];
    //self.titleImgView.multipleTouchEnabled = YES;
    //self.titleImgView.userInteractionEnabled = YES;
    [sectionView addSubview:self.titleImgView];
    
    self.touxiangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.touxiangBtn.frame = CGRectMake(22, 43, 63, 63);
    self.touxiangBtn.layer.cornerRadius = 32;
    self.touxiangBtn.layer.masksToBounds = YES;
    [self.touxiangBtn addTarget:self action:@selector(clickTouxiangBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.titleImgView addSubview:self.touxiangBtn];
    
    self.userName = [[UILabel alloc] initWithFrame:CGRectMake(self.touxiangBtn.frame.origin.x+self.touxiangBtn.frame.size.width+23, 61, 100, 16)];
    self.userName.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:16];
    [self.titleImgView addSubview:self.userName];
    
    self.zhuangtaiLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.touxiangBtn.frame.origin.x+self.touxiangBtn.frame.size.width+41, self.userName.frame.origin.y+self.userName.frame.size.height+11, 150, 10)];
    self.zhuangtaiLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
    [self.titleImgView addSubview:self.zhuangtaiLabel];
    
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame = CGRectMake(ScreenWidth-41, 61, 10, 15);
    [messageBtn setImage:[UIImage imageNamed:@"返回2"] forState:UIControlStateNormal];
    [self.titleImgView addSubview:messageBtn];
}

-(void)tableViewMessage
{
    self.textArr1 = @[@"我的帖子",@"我的回帖",@"我的收藏"];
    self.textArr2 = @[@"邀请好友",@"填写邀请码"];
    
    self.textArr = [NSMutableArray arrayWithObjects:self.textArr1,self.textArr2,nil];
    
    self.imgViewArr1 = @[@"帖子",@"回帖",@"我的收藏"];
    self.imgViewArr2 = @[@"邀请",@"邀请码"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*----------导航栏添加图片-----------*/
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    head.backgroundColor = [UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1];
    [self.navigationController.view addSubview:head];
    
    UIButton *setupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setupBtn.frame = CGRectMake(ScreenWidth-32, 16, 18, 18);
    [setupBtn setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    [setupBtn addTarget:self action:@selector(setupBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:setupBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self tableViewMessage];
    [self creatTableView];
    self.ud = [NSUserDefaults standardUserDefaults];
    
    // 适配
    //    WS(ws);
    //    UILabel *sv = [UILabel new];
    //    //[sv showPlaceHolder];
    //    [sv setTranslatesAutoresizingMaskIntoConstraints:NO];
    //    [self.view addSubview:sv];
    //    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.center.equalTo(ws.view);
    //        make.size.mas_equalTo(CGSizeMake(100, 40));
    //    }];
    
    self.picker = [[UIImagePickerController alloc]init];
    self.picker.delegate = self;
    
}

-(void)setupBtn
{
    SetupViewController *setupVC = [[SetupViewController alloc] init];
    UINavigationController *setupnav = [[UINavigationController alloc] initWithRootViewController:setupVC];
    [self.navigationController presentViewController:setupnav animated:YES completion:nil];
}

-(void)editMessageBtn
{
    SelfMessageViewController *selfmessageVC = [[SelfMessageViewController alloc] init];
    selfmessageVC.touxiang = [d objectForKey:@"touxiang"];
    selfmessageVC.name = [[self.dataArr objectAtIndex:0] objectForKey:@"nicheng"];
    selfmessageVC.back = self.titleImgView.imageView.image;
    selfmessageVC.state = [[self.dataArr objectAtIndex:0] objectForKey:@"zhuangtai"];
    UINavigationController *selfNav = [[UINavigationController alloc] initWithRootViewController:selfmessageVC];
    [self.navigationController presentViewController:selfNav animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.textArr1.count;
            break;
            
        default:
            return self.textArr2.count;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(41, 16, 120, 13)];
    label.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:15];
    [cell.contentView addSubview:label];
    
    UIImageView *imgview;
    
    switch (indexPath.section) {
        case 0:
            label.text = [self.textArr1 objectAtIndex:indexPath.row];
            switch (indexPath.row) {
                case 0:
                    imgview = [[UIImageView alloc] initWithFrame:CGRectMake(14, 10, 16, 21)];
                    imgview.image = [UIImage imageNamed:[self.imgViewArr1 objectAtIndex:indexPath.row]];
                    [cell.contentView addSubview:imgview];
                    break;
                    
                case 1:
                    imgview = [[UIImageView alloc] initWithFrame:CGRectMake(14, 13, 18, 15)];
                    imgview.image = [UIImage imageNamed:[self.imgViewArr1 objectAtIndex:indexPath.row]];
                    [cell.contentView addSubview:imgview];
                    break;
                    
                case 2:
                    imgview = [[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 18, 17)];
                    imgview.image = [UIImage imageNamed:[self.imgViewArr1 objectAtIndex:indexPath.row]];
                    [cell.contentView addSubview:imgview];
                    break;
                    
                default:
                    break;
            }
            break;
            
        case 1:
            label.text = [self.textArr2 objectAtIndex:indexPath.row];
            switch (indexPath.row) {
                case 0:
                    imgview = [[UIImageView alloc] initWithFrame:CGRectMake(14, 12, 17, 17)];
                    imgview.image = [UIImage imageNamed:[self.imgViewArr2 objectAtIndex:indexPath.row]];
                    [cell.contentView addSubview:imgview];
                    break;
                    
                case 1:
                    imgview = [[UIImageView alloc] initWithFrame:CGRectMake(14, 13, 17, 15)];
                    imgview.image = [UIImage imageNamed:[self.imgViewArr2 objectAtIndex:indexPath.row]];
                    [cell.contentView addSubview:imgview];
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.textArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 41;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CollectViewController *collectVC = [[CollectViewController alloc] init];
    UINavigationController *collectNav = [[UINavigationController alloc] initWithRootViewController:collectVC];
    
    MyreturnTieziViewController *myreturnVC = [[MyreturnTieziViewController alloc] init];
    UINavigationController *myreturnNav = [[UINavigationController alloc] initWithRootViewController:myreturnVC];
    
    MyTieziViewController *mytieziVC = [[MyTieziViewController alloc] init];
    UINavigationController *mytieziNav = [[UINavigationController alloc] initWithRootViewController:mytieziVC];
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    [self.navigationController presentViewController:mytieziNav animated:YES completion:nil];
                    break;
                    
                case 1:
                    [self.navigationController presentViewController:myreturnNav animated:YES completion:nil];
                    break;
                    
                case 2:
                    [self.navigationController presentViewController:collectNav animated:YES completion:nil];
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 140;
//    }
//    else
//    {
//        return 20;
//    }
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
//    
//    self.titleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
//    self.titleImgView.image = [UIImage imageNamed:@""];
//    self.titleImgView.multipleTouchEnabled = YES;
//    self.titleImgView.userInteractionEnabled = YES;
//
//    self.touxiangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.touxiangBtn.frame = CGRectMake(30, 30, 80, 80);
//    self.touxiangBtn.layer.cornerRadius = 25.0;
//    [self.touxiangBtn addTarget:self action:@selector(clickTouxiangBtn) forControlEvents:UIControlEventTouchUpInside];
//    [self.titleImgView addSubview:self.touxiangBtn];
//    
//    self.userName = [[UILabel alloc] initWithFrame:CGRectMake(self.touxiangBtn.frame.origin.x+self.touxiangBtn.frame.size.width+20, 35, 140, 40)];
//    self.userName.font = [UIFont fontWithName:nil size:25];
//    [self.titleImgView addSubview:self.userName];
//    
//    self.zhuangtaiLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.touxiangBtn.frame.origin.x+self.touxiangBtn.frame.size.width+20, self.userName.frame.origin.y+self.userName.frame.size.height, 140, 40)];
//    self.zhuangtaiLabel.font = [UIFont fontWithName:nil size:12];
//    self.zhuangtaiLabel.text = @"宝宝1岁";
//    [self.titleImgView addSubview:self.zhuangtaiLabel];
//    
//    if (section == 0) {
//        return sectionView;
//    }
//    
//    else
//    {
//        return nil;
//    }
//    
//}

-(void)getUserMessage
{
    self.ud = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *selfDic = [[NSMutableDictionary alloc] init];
    
    NSString *zhanghao = [self.ud objectForKey:@"username"];
    NSString *mima = [self.ud objectForKey:@"password"];
    
    [selfDic setObject:zhanghao forKey:@"username"];
    [selfDic setObject:mima forKey:@"password"];
    
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/user/list.do" parameters:selfDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"获取成功");
        
        NSData *data = (NSData*)responseObject;
        
        self.dataArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        d = [self.dataArr objectAtIndex:0];
        NSLog(@"111%@",d);
        self.userName.text = [d objectForKey:@"nicheng"];
        NSLog(@"aaaaa:%@",[d objectForKey:@"touxiang"]);
        if ([[d objectForKey:@"touxiang"] isEqualToString:@"1"]) {
            NSLog(@"6666666");
            [self.touxiangBtn setImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
        }
        else
        {
            [NSThread detachNewThreadSelector:@selector(loadLabelTableView:) toTarget:self withObject:[d objectForKey:@"touxiang"]];
            if (self.dataArr.count>0) {
                [[TouxiangData sharedImage] openPphoto];
                NSArray *array = [[TouxiangData sharedImage] findAll];
                if (array.count > 0) {
                    for (int i = 0; i<self.dataArr.count; i++) {
                        [[TouxiangData sharedImage] deleteImg:[[self.dataArr objectAtIndex:i] objectForKey:@"touxiang"]];
                    }
                }
                
                for (int i = 0; i<self.dataArr.count; i++) {
                    
                    [[TouxiangData sharedImage] addImage:[[self.dataArr objectAtIndex:i] objectForKey:@"touxiang"]];
                }
                [[TouxiangData sharedImage] closePphoto];
            }
        }
        if ([[d objectForKey:@"zhuangtai"] isEqualToString:@"怀孕中"]) {
            self.zhuangtaiLabel.text = [NSString stringWithFormat:@"已怀孕，宝宝还有%@天出生！",[d objectForKey:@"huaiyuntianshu"]];
        }
        else if([[d objectForKey:@"zhuangtai"] isEqualToString:@"已出生"])
        {
            self.zhuangtaiLabel.text = [NSString stringWithFormat:@"已出生%@天，要照顾好宝宝哦！",[d objectForKey:@"huaiyuntianshu"]];
        }
        else
        {
            self.zhuangtaiLabel.text = @"备孕中，要加油哦！";
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取服务器失败");
    }];
}

-(void)loadLabelTableView:(NSString*)str
{
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
    //NSLog(@"tupian:%@",data);
    
    [self.touxiangBtn setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
    
}

- (void)clickTouxiangBtn
{
    NSLog(@"111");
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //设置使用手机的后置摄像头
            self.picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;            //设置拍摄照片
            self.picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            ;
            self.picker.allowsEditing = YES;
        }
        
        [self presentViewController:self.picker animated:YES completion:nil];
        
        
    }else if (buttonIndex == 1){
        
        if (self.picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
        {
            self.picker.allowsEditing = NO;
            [self presentViewController:self.picker animated:YES completion:nil];
            
        }
    }
}

NSString *currentTime;

//当得到照片或者视频后，调用该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    //获得摄像头得到的媒体类型
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //判断媒体类型,如果是照片
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) //使用kUTTypeImage标识需加入框架MobileCoreServices.framework
    {
        UIImage *img = nil;
        //如果照片可以被编辑
        if (self.picker.allowsEditing)
        {
            img = [info objectForKey:UIImagePickerControllerEditedImage];
        }
        //如果照片不可以被编辑，获得原始图片
        else
        {
            img = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        UIImage *editedImage = [[UIImage alloc] init];
        
        
        editedImage = img;
        CGRect rect = CGRectMake(0, 0, 200, 200);
        UIGraphicsBeginImageContext(rect.size);
        [editedImage drawInRect:rect];
        editedImage = UIGraphicsGetImageFromCurrentImageContext();
        
        
        
        [self.touxiangBtn setImage:editedImage forState:UIControlStateNormal];
        
        //        NSData *yuanShiData = UIImagePNGRepresentation(editedImage);
        
        NSData *yuanShiData = UIImageJPEGRepresentation(editedImage, 0.65);
        
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        currentTime = [formatter stringFromDate:[NSDate date]];
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        
        
        
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:[NSString stringWithFormat:@"%@%@%@",@"/",currentTime,@"image.png"]] contents:yuanShiData attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        filePath = [[NSString alloc]initWithFormat:@"%@%@%@%@",DocumentsPath,  @"/",currentTime,@"image.png"];
        
        /*
         [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:[NSString stringWithFormat:@"/%@%@",mod.zhanghao,@"image.png"]] contents:yuanShiData attributes:nil];
         
         
         
         
         //得到选择后沙盒中图片的完整路径
         filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,[NSString stringWithFormat:@"/%@%@",mod.zhanghao,@"image.png"]];
         */
        NSLog(@"filePath--%@",filePath);
        
        ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://101.200.234.127:8080/YanLu/user/picload.do"]];
        request.delegate = self;
        
        // [request addData:imageData forKey:@"lujing"];
        
        //        [request addData:data forKey:@"lujing"];

        [request addFile:filePath forKey:@"filePath"];
//        [request addFile:iddd forKey:@"userid"];
        
        
        
        NSLog(@"%@",request);
//        touxiang = request.responseString;
        //        [request addPostValue:@"asihttp"forKey:@"name"];
        [request setCompletionBlock:^{
            NSLog(@"tuPianName------%@",request.responseString);
            NSLog(@"1231313132");
            //self.manager = [AFHTTPRequestOperationManager manager];
            //self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
            
            NSString *zhanghao = [self.ud objectForKey:@"username"];
            
            NSLog(@"zhanghao++++%@",zhanghao);
            self.dic = [[NSMutableDictionary alloc]init];
            [self.dic setObject:request.responseString forKey:@"touxiang"];
            [self.dic setObject:zhanghao forKey:@"username"];
            // 使用AFHTTPRequestOperationManager发送POST请求
            [self.manager POST:@"http://101.200.234.127:8080/YanLu/user/update.do" parameters:self.dic  // 指定请求参数
             // 获取服务器响应成功时激发的代码块
                       success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 // 当使用HTTP响应解析器时，服务器响应数据被封装在NSData中
                 // 此处将NSData转换成NSString、并使用UIAlertView显示登录结果
                 NSData *data = responseObject;
                 NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                 if ([str isEqualToString:@"true"]) {
                     
                     
                     NSLog(@"上传成功");
                     [self dismissViewControllerAnimated:YES completion:nil];
                 }else{
                     
                     NSLog(@"上传失败");
                 }
             }
             // 获取服务器响应失败时激发的代码块
                       failure:^(AFHTTPRequestOperation *operation, NSError *error){
                           NSLog(@"获取服务器响应出错！");
                       }];
            
            
        }];
        [request setFailedBlock:^{
            NSLog(@"asi error: %@",request.error.debugDescription);
        }];
        [request startAsynchronous];
        
        //[fileManager removeItemAtPath:filePath error:nil];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//当用户取消选择时
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//- (void)signUpBtnClick
//{
//    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"是否退出？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
//    [alert show];
//}

@end
