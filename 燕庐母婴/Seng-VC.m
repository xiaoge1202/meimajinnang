//
//  Seng-VC.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/5/29.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "Seng-VC.h"
#import "fatietuView.h"
@interface Seng_VC ()

@end

@implementation Seng_VC{
    UIActionSheet *myActionSheet;
    NSData *_data;
    UIImageView *smallimage;
    UIButton *picBtn;
    fatietuView *imageView;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.navigationItem.title = @"发 帖";
    
    /*-------------状态栏改变背景颜色-----------*/
//    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
//    head.backgroundColor = [UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1];
//    [self.navigationController.view addSubview:head];
    
    
    //取消导航栏和状态栏的边缘延展效果
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    self.view.backgroundColor = RGBA(239, 239, 239, 1);
    
    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    //返回按钮
    self.backBtutton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtutton.frame = CGRectMake(20, 14, 16, 20);
    [self.backBtutton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backBtutton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtutton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //发送帖子
    UIButton *rightSend = [UIButton buttonWithType:UIButtonTypeCustom];
    rightSend.frame = CGRectMake(20, 14, 38, 21);
    [rightSend setBackgroundImage:[UIImage imageNamed:@"发送帖子"] forState:UIControlStateNormal];
    [rightSend addTarget:self action:@selector(rightSend) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightSend];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    //获取用户ID
    _user = [NSUserDefaults standardUserDefaults];
    _userId = [_user objectForKey:@"userid"];
    
    //帖子标题
    self.titleField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    self.titleField.tag = 1001;
    self.titleField.backgroundColor = RGBA(255, 255, 255, 1);
    self.titleField.placeholder = @" 标题:(2-20)个字";
    [self.view addSubview:self.titleField];
    
    self.line = [[UIView alloc] initWithFrame:CGRectMake(0, 35, ScreenWidth, 1)];
    self.line.backgroundColor = RGBA(216, 216, 216, 1);
    [self.view addSubview:self.line];
    
    //输入正文
    self.bodyView = [[UITextView alloc] initWithFrame:CGRectMake(0, 36, ScreenWidth, 180)];
    self.bodyView.tag = 1002;
    self.bodyView.delegate = self;
    [self.view addSubview:self.bodyView];
    
#pragma mark放置图片的位置
    //UIView *view=[[UIView alloc]init];
    imageView=[[fatietuView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bodyView.frame), ScreenWidth, 200)];
    //imageView.backgroundColor=[UIColor redColor];
    [self.view addSubview:imageView];
    
    
    //实现plahold效果
    label = [[UILabel alloc]initWithFrame:CGRectMake(3, 3, 200, 20)];
    label.enabled = NO;
    label.text = @"内容:(必填)";
    label.font =  [UIFont systemFontOfSize:15];
    label.textColor = RGBA(199, 199, 205, 1);
    [self.bodyView addSubview:label];
    
    
    self.faceBtu = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-38, 183, 23, 23)];
    [self.faceBtu setImage:[UIImage imageNamed:@"表情"] forState:UIControlStateNormal];
    [self.faceBtu addTarget:self action:@selector(addFace:) forControlEvents:UIControlEventTouchUpInside];
    [self.bodyView addSubview:self.faceBtu];
    
    
    picBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-79, 185, 25, 19)];
    [picBtn setImage:[UIImage imageNamed:@"拍照"] forState:UIControlStateNormal];
    [picBtn addTarget:self action:@selector(takePictures) forControlEvents:UIControlEventTouchUpInside];
    picBtn.userInteractionEnabled=YES;
    [self.bodyView addSubview:picBtn];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    UIView *keyboardView = [self getKeyboardView];
    UIView *key = [[UIView alloc] initWithFrame:keyboardView.frame];
    key.backgroundColor = [UIColor redColor];
    [keyboardView addSubview:key];
}


- (UIView *)getKeyboardView
{
    UIView *result = nil;
    NSArray *windowsArray = [UIApplication sharedApplication].windows;
    for (UIView *tmpWindow in windowsArray)
    {
        NSArray *viewArray = [tmpWindow subviews];
        for (UIView *tmpView  in viewArray)
        {
            if ([[NSString stringWithUTF8String:object_getClassName(tmpView)] isEqualToString:@"UIPeripheralHostView"])
            {
                result = tmpView;
                break;
            }
        }
        
        if (result != nil) {
            break;
        }
    }
    
    return result;
}


-(void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length] == 0) {
        [label setHidden:NO];
    }else{
        [label setHidden:YES];
    }
}
//liuxiaofeng

//发送帖子
-(void)rightSend
{
    [self.titleField resignFirstResponder];
    [self.bodyView resignFirstResponder];
    //移除smallimage
    [smallimage removeFromSuperview];
    
    if(self.bodyView.text.length==0||self.titleField.text.length==0){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"输入错误" message:@"请输入标题和内容" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
    }else if(self.titleField.text.length==0 || self.titleField.text.length>20){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"输入错误" message:@"标题长度在1-20之间" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
    }else if(self.bodyView.text.length<5||self.bodyView.text.length>200){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"输入错误" message:@"内容长度在5-200之间" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
    }
    
    
    
    if (self.titleField.text.length >0&&self.bodyView.text.length >= 5&&self.bodyView.text.length <=200&&self.titleField.text.length <20) {
        
        NSString *title = ((UITextField *)[self.view viewWithTag:1001]).text;
        NSString *body = ((UITextView *)[self.view viewWithTag:1002]).text;
        if(imageView.images.count>0){
            //传了图片
            NSString *server_base =@"http://101.200.234.127:8080/YanLu/tiezi/upload.do";
            
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:server_base]];
            
            [request setPostFormat:ASIMultipartFormDataPostFormat];
            
            for(int i=0;i<imageView.images.count;i++){
                UIImage *img=[[UIImage alloc]init];
                img=imageView.images[i];
                NSData *data=UIImageJPEGRepresentation(img, 0.5);
                [request addData:data  withFileName:[NSString stringWithFormat:@"%d.png",i] andContentType:@"image/jpg" forKey:@"fileName"];
            }
            
            
            [request setCompletionBlock:^{
                NSString *string=request.responseString;
                NSLog(@"request-----成功%@",request.responseString);
                NSLog(@"@=====成功");
                self.dataDic = [[NSMutableDictionary alloc]init];
                [self.dataDic setObject:title forKey:@"title"];
                [self.dataDic setObject:body forKey:@"neirong"];
                [self.dataDic setObject:self.idCount forKey:@"quanziid"];
                [self.dataDic setObject:_userId forKey:@"userid"];
                [self.dataDic setObject:string forKey:@"lujing"];
                
                self.manager = [AFHTTPRequestOperationManager manager];
                self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
                
                [self.manager POST:@"http://101.200.234.127:8080/YanLu/tiezi/save.do" parameters:self.dataDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    //   [self goBack];
                    NSLog(@"成功");
                    [self goBack];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                    NSLog(@"失败");
                }];
                
                
            }];
            [request setFailedBlock:^{
                NSLog(@"asi error: %@",request.error.debugDescription);
            }];
            [request startAsynchronous];
            
            
        }else{
            self.dataDic = [[NSMutableDictionary alloc]init];
            [self.dataDic setObject:title forKey:@"title"];
            [self.dataDic setObject:body forKey:@"neirong"];
            [self.dataDic setObject:self.idCount forKey:@"quanziid"];
            [self.dataDic setObject:_userId forKey:@"userid"];
            
            
            self.manager = [AFHTTPRequestOperationManager manager];
            self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
            
            [self.manager POST:@"http://101.200.234.127:8080/YanLu/tiezi/save.do" parameters:self.dataDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self goBack];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"失败");
                
            }];
            
        }
        
    }
    picBtn.userInteractionEnabled=YES;
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.titleField resignFirstResponder];
    [self.bodyView resignFirstResponder];
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

//添加表情
-(void)addFace:(UIButton *)sender
{
    sender.tag=!sender.tag;
    
    if (sender.tag) {
        //放弃第一响应者的身份
        [self.bodyView resignFirstResponder];
        //初始化滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 170)];
        
        for (int i=0; i<4; i++)
        {
            //初始化添加表情的视图
            FacialView *fview = [[FacialView alloc] initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, 175)];
            //调用FacialView类中的该方法
            [fview loadFacialView:i size:CGSizeMake(45, 45)];
            //添加代理
            fview.delegate = self;
            //将FacialView添加到滚动视图上
            [scrollView addSubview:fview];
        }
        //设置滚动视图的尺寸
        scrollView.contentSize = CGSizeMake(ScreenWidth*4, 170);
        //设置scrollView滚动
        scrollView.pagingEnabled = YES;
        self.bodyView.inputView = scrollView;
        //获取第一响应者身份
        [self.bodyView becomeFirstResponder];
        
    }else{
        
        self.bodyView.inputView = nil;
        [self.bodyView reloadInputViews];
        [self.bodyView becomeFirstResponder];
    }
}


//解析获取到的信息
-(void)parserMessage:(NSString*)message
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //调用下面的该方法
    [self getImageRange:message :array];
    //    [self.datas addObject:array];
    //
    //    //刷新页面
    //    [self.tableView reloadData];
    //
    //    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.datas.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

//获取图片的长度和坐标
-(void)getImageRange:(NSString*)message :(NSMutableArray*)array
{
    NSRange range  = [message rangeOfString:@"<"];
    NSRange range1 = [message rangeOfString:@">"];
    //判断当前字符串是否还有表情的标志。
    if (range.length&&range1.length)
    {
        if (range.location>0)
        {
            [array addObject:[message substringToIndex:range.location]];
            [array addObject:[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)]];
            NSString *str = [message substringFromIndex:range1.location+1];
            [self getImageRange:str :array];
        }
        else
        {
            NSString *nextstr = [message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
            //排除文字是“”的
            if (![nextstr isEqualToString:@""])
            {
                [array addObject:nextstr];
                NSString *str = [message substringFromIndex:range1.location+1];
                [self getImageRange:str :array];
                
            }else{
                return;
            }
        }
    }else{
        [array addObject:message];
    }
}


//选中输入框调用该方法 -调用键盘
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.3];
    
    CGRect rect1 = self.titleField.frame;
    rect1.size.height = 100;
    self.bodyView.frame = rect1;
    [UIView commitAnimations];
}


//选中表情触发该方法
-(void)selectedFacialView:(NSString*)str
{
    [label setHidden:YES];
    //初始化可变字符串
    NSMutableString *str1=[[NSMutableString alloc] initWithString:@"["];
    [str1 appendString:str];
    [str1 appendString:@"]"];
    
    NSString *str2 = [NSString stringWithFormat:@"%@%@",self.bodyView.text,str1];
    self.bodyView.text = str2;
}


-(UIView *)assembleMessageAtIndex:(NSArray *)arr
{
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    NSArray *data = arr;
    UIFont *fon = [UIFont systemFontOfSize:14.0f];
    CGFloat upX = 0;
    CGFloat upY = 0;
    if (data) {
        for (int i=0;i<[data count];i++) {
            NSString *str=[data objectAtIndex:i];
            if ([str hasPrefix:@"["]&&[str hasSuffix:@"]"])
            {
                if (upX > 200)
                {
                    upY = upY + 24;
                    upX = 0;
                }
                NSString *imageName=[str substringWithRange:NSMakeRange(1, str.length-2)];
                UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
                img.frame = CGRectMake(upX, upY, 24, 24);
                [returnView addSubview:img];
                upX = 24+upX;
                
            }else{
                
                for (int j = 0; j<[str length]; j++)
                {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX > 200)
                    {
                        upY = upY + 24;
                        upX = 0;
                    }
                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(ScreenWidth, 40)];
                    
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX, upY,size.width,size.height)];
                    la.font = fon;
                    la.text = temp;
                    [returnView addSubview:la];
                    
                    upX=upX+size.width;
                }
            }
        }
    }
    return returnView;
}


//调取摄像头
-(void)takePictures
{
    
    [self openMenu];
}
#pragma mark 拍照
-(void)openMenu
{
    //在这里呼出下方菜单按钮项
    myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [myActionSheet showInView:self.view];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == myActionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            [self takePhoto];
            break;
            
        case 1:  //打开本地相册
            [self LocalPhoto];
            break;
    }
}

//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentModalViewController:picker animated:YES];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            _data = UIImageJPEGRepresentation(image, 0.3);
        }
        else
        {
            _data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        //        //得到一个随机数
        //        int i=arc4random() % 100000000;
        //        NSLog(@"%d",i);
        NSDate *  senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"YYYYMMdd HHssmm"];
        
        NSString *  locationString=[dateformatter stringFromDate:senddate];
        
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:[NSString stringWithFormat:@"/image%@.png",locationString]] contents:_data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath, [NSString stringWithFormat:@"/image%@.png",locationString]];
        NSLog(@"$$$$$$$$$$$$$%@",filePath);
        
        
        //关闭相册界面
        [picker dismissModalViewControllerAnimated:YES];
        [self.bodyView becomeFirstResponder];
        
        
        
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
        smallimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, 30)];
        
        smallimage.image = image;
        //        //加在视图中
        if(smallimage){
            [picBtn addSubview:smallimage];
            
            picBtn.userInteractionEnabled=NO;
            
        }//
    }
    
}

@end
