//
//  MyreturnTieziViewController.m
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/16.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "MyreturnTieziViewController.h"

@interface MyreturnTieziViewController ()
{
    CGSize pinglunsize;
    UIImage *touxiangImg;
}
@end

@implementation MyreturnTieziViewController

-(void)viewDidAppear:(BOOL)animated
{
    [[TouxiangData sharedImage] openPphoto];
    self.imgArr = [[TouxiangData sharedImage] findAll];
    [[TouxiangData sharedImage] closePphoto];
}

-(void)getMyhuitieMessage
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *userid = [ud objectForKey:@"userid"];
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/huifu/list.do" parameters:[@{@"userid":userid} mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.dataArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"babyGrowArr:%@",self.dataArr);
        [self getTouxiangImg];
        [self.myhuitieTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getMyhuitieMessage];
    
    self.navigationItem.title = @"我 的 回 帖";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = RGBA(235, 235, 235, 1);
    
    //返回按钮
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(20, 14, 16, 20);
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *setupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setupBtn.frame = CGRectMake(ScreenWidth-52, 16, 38, 21);
    [setupBtn setImage:[UIImage imageNamed:@"清空"] forState:UIControlStateNormal];
    [setupBtn addTarget:self action:@selector(clickFinishBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:setupBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self creatTableView];
    // Do any additional setup after loading the view.
}

-(void)creatTableView
{
    self.myhuitieTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 6, ScreenWidth, ScreenHeight-70) style:UITableViewStylePlain];
    self.myhuitieTableView.delegate = self;
    self.myhuitieTableView.dataSource = self;
    [self.view addSubview:self.myhuitieTableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(void)getTouxiangImg
{
    [NSThread detachNewThreadSelector:@selector(loadLabelTableView:) toTarget:self withObject:[[self.dataArr objectAtIndex:0] objectForKey:@"touxiang"]];
}

-(void)loadLabelTableView:(NSString *)str
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
    touxiangImg = [UIImage imageWithData:data];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    MyreturnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[MyreturnTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    NSDictionary *dic = [self.dataArr objectAtIndex:indexPath.row];
    if ([[dic objectForKey:@"touxiang"] isEqualToString:@"1"]) {
        cell.touxiangImg.image = [UIImage imageNamed:@"touxiangimg"];
    }
    else
    {
        //NSDictionary *group=[[NSDictionary alloc]initWithObjectsAndKeys:indexPath,@"indexpath",cell,@"cell", nil];
        //[NSThread detachNewThreadSelector:@selector(loadLabelTableView:) toTarget:self withObject:group];
        NSURL *url = [NSURL URLWithString:[[self.imgArr objectAtIndex:0] objectForKey:@"Image"]];
        
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //获取全局变量
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        //设置缓存方式
        [request setDownloadCache:appDelegate.myCache];
        //设置缓存数据存储策略，这里采取的是如果无更新或无法联网就读取缓存数据
        [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
        request.delegate = self;
        [request startAsynchronous];
        [request setCompletionBlock:^{
            
            //         NSLog(@"%@",request.responseHeaders);
            
            
            
            
            //---------------判断数据的来源:网络 or缓存------------------
            if (request.didUseCachedResponse) {
                NSLog(@"数据来自缓存");
            } else {
                NSLog(@"数据来自网络");
            }
            NSData *data = request.responseData;
            cell.touxiangImg.image = [UIImage imageWithData:data];
        }];
        //cell.touxiangImg.image = touxiangImg;
    }
    
    cell.nameLabel.text = [dic objectForKey:@"nicheng"];
    cell.neirongLabel.text = [dic objectForKey:@"neirong"];
    [self.manager GET:tieziURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data =(NSData *)responseObject;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"圈子详细信息 = %@",array);
        for (int i = 0; i<array.count; i++) {
            if ([[dic objectForKey:@"tid"] integerValue] == [[[array objectAtIndex:i] objectForKey:@"id"] integerValue]) {
                cell.pinglunLabel.text = [[array objectAtIndex:i] objectForKey:@"neirong"];
//                cell.pinglunLabel.NumberOfLines = 0;
//                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//                paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//                NSDictionary *attributes = @{NSFontAttributeName:cell.pinglunLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
//                pinglunsize = [cell.pinglunLabel.text boundingRectWithSize:CGSizeMake(ScreenWidth-20, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
//                [cell.pinglunLabel setFrame:CGRectMake(5, 8, pinglunsize.width, pinglunsize.height)];
                //cell.huifukuangImg.frame = CGRectMake(0, 0, 260, pinglunsize.height);
                break;
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
    }];
    
    return cell;
}

//-(void)loadLabelTableView:(NSDictionary *)group
//{
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 66, 55)];
//    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.dataArr objectAtIndex:[[group objectForKey:@"indexpath"] row]] objectForKey:@"tupian"]]];
//    imageView.frame = CGRectMake(6, 9, 25, 25);
//    imageView.layer.cornerRadius = 12;
//    imageView.image = [UIImage imageWithData:data];
//    [[group objectForKey:@"cell"]  addSubview:imageView];
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(void)goBack:(UIButton*)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)clickFinishBtn
{
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    
//    NSMutableDictionary *selfDic = [[NSMutableDictionary alloc] init];
//    
//    NSString *zhanghao = [ud objectForKey:@"username"];
//    
//    [selfDic setObject:zhanghao forKey:@"username"];
//    //[selfDic setObject:self.nameText.text forKey:@"nicheng"];
//    
//    self.manager = [AFHTTPRequestOperationManager manager];
//    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
//    [self.manager POST:@"http://101.200.234.127:8080/YanLu/user/update.do" parameters:selfDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"获取成功");
//        
//        NSData *data = (NSData*)responseObject;
//        
//        self.dataArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"获取服务器失败");
//        [[[UIAlertView alloc] initWithTitle:@"修改失败" message:@"网络错误，请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//    }];
    
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
