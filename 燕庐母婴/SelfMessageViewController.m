//
//  SelfMessageViewController.m
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/9.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "SelfMessageViewController.h"

@interface SelfMessageViewController ()
{
    NSString* filePath;
}
@end

@implementation SelfMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个 人 信 息";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //返回按钮
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(20, 14, 16, 20);
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.messageArr = @[@"背景图",@"头像",@"昵称",@"当前状态"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-114) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    
    [self addtabCell];
    
    self.picker = [[UIImagePickerController alloc]init];
    self.picker.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

-(void)addtabCell
{
    self.touxiangImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-70, 5, 40, 40)];
    //self.touxiangImg.image = self.touxiang;
    [NSThread detachNewThreadSelector:@selector(loadLabelTableView:) toTarget:self withObject:self.touxiang];
    NSLog(@"touxiang==============%@",self.touxiang);
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, ScreenWidth-130, 20)];
    self.nameLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:16];
    self.nameLabel.textAlignment = NSTextAlignmentRight;
    self.nameLabel.text = self.name;
    
    self.backImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-97, 5, 67, 35)];
    self.backImg.image = self.back;
    
    self.babybirthLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-100, 15, 70, 20)];
    self.babybirthLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:16];
    self.babybirthLabel.textAlignment = NSTextAlignmentRight;
    //NSLog(@"状态:%@",self.state);
    self.babybirthLabel.text = self.state;
}

-(void)goBack:(UIButton*)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:16];
    
    cell.textLabel.text = [self.messageArr objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.row) {
        case 0:
            [cell.contentView addSubview:self.backImg];
            break;
            
        case 1:
            [cell.contentView addSubview:self.touxiangImg];
            break;
            
        case 2:
            [cell.contentView addSubview:self.nameLabel];
            break;
            
        case 3:
            [cell.contentView addSubview:self.babybirthLabel];
            break;
            
            
        default:
            break;
    }
    return cell;
    
}

-(void)loadLabelTableView:(NSString*)str
{
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
    //NSLog(@"tupian:%@",data);
    
    self.touxiangImg.image = [UIImage imageWithData:data];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SetNameViewController *setnameVC = [[SetNameViewController alloc] init];
    setnameVC.nameStr = self.nameLabel.text;
    
    ChangeStateViewController *changeStateVC = [[ChangeStateViewController alloc] init];

    
    
    switch (indexPath.row) {
        case 0:
            
            break;
            
        case 1:
            [self clickTouxiangBtn];
            break;
            
        case 2:
            [self.navigationController pushViewController:setnameVC animated:YES];
            break;
            
        case 3:
            [self.navigationController pushViewController:changeStateVC animated:YES];
            break;
            
        default:
            break;
    }
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
        
        
        
        self.touxiangImg.image = editedImage;
        
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
            self.manager = [AFHTTPRequestOperationManager manager];
            self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
            self.ud = [NSUserDefaults standardUserDefaults];
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
                     //[self dismissViewControllerAnimated:YES completion:nil];
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
