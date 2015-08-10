//
//  Baby-VC.m
//  滚动视图
//
//  Created by 董飞剑 on 15/5/28.
//  Copyright (c) 2015年 侯泽彭. All rights reserved.
//

#import "Baby-VC.h"

@interface Baby_VC ()
{
    UIImageView *titleImageView;
    UIButton *deleBtn1;
    UIImageView *deleImageView1;
    
    UITextField *text;
    NSString *str;
    
    NSDictionary *dic;
    NSMutableArray *arr;
    
    NSDictionary *group1;
    NSDictionary *group2;
    NSDictionary *group3;
    NSDictionary *group4;
    
    NSMutableArray *btnArr;
    NSMutableArray *imgArr;
    
    NSString *huaiyuntianshu;
    NSString *zhuangtai;
}
@end

@implementation Baby_VC

-(void)viewWillAppear:(BOOL)animated
{
//    self.ud = [NSUserDefaults standardUserDefaults];
//    str = [self.ud objectForKey:@"huaiyuntime"];
//    NSLog(@"%@",str);
//    huaiyuntianshu = [self.ud objectForKey:@"huaiyuntianshu"];
//    NSLog(@"%@",huaiyuntianshu);
//    [self.tableView reloadData];
    [self getud];
    [self titleImage];
    [self.tableView reloadData];
}

-(void)getud
{
    self.ud = [NSUserDefaults standardUserDefaults];
    str = [self.ud objectForKey:@"huaiyuntime"];
    NSLog(@"%@",str);
    huaiyuntianshu = [self.ud objectForKey:@"huaiyuntianshu"];
    NSLog(@"11111%@",[self.ud objectForKey:@"zhuangtai"]);
    zhuangtai = [self.ud objectForKey:@"zhuangtai"];
}

-(void)getDataMessage
{
    [self getud];
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/chengzhang/list.do" parameters:[@{@"time":str}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.babyGrowArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"babyGrowArr:%@",self.babyGrowArr);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
    
    
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/jinribizuo/list.do" parameters:[@{@"time":str}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.todayMustDoArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"ssss%@",self.todayMustDoArr);

        if (self.todayMustDoArr.count>0){
            dic = [self.todayMustDoArr objectAtIndex:0];
            arr = [[NSMutableArray alloc] init];
            [arr addObject:[dic objectForKey:@"one"]];
            [arr addObject:[dic objectForKey:@"two"]];
            [arr addObject:[dic objectForKey:@"three"]];
            [arr addObject:[dic objectForKey:@"four"]];
            [arr addObject:[dic objectForKey:@"five"]];
            [arr addObject:[dic objectForKey:@"six"]];
            [arr addObject:[dic objectForKey:@"seven"]];
            [arr addObject:[dic objectForKey:@"eight"]];
            [arr addObject:[dic objectForKey:@"nine"]];
            [arr addObject:[dic objectForKey:@"ten"]];
        }
       
        
        [self.tableView reloadData];
        [self deleteImg];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
    
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/jinribidu/list.do" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.todayMustReadArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"222------%@",self.todayMustReadArr);
        
//        if (self.todayMustReadArr.count>0) {
//            [[TodayMustReadData sharedImage] openPphoto];
//            NSArray *array = [[TodayMustReadData sharedImage] findAll];
//            if (array.count > 0) {
//            for (int i = 0; i<self.todayMustReadArr.count; i++) {
//                [[TodayMustReadData sharedImage] deleteImg:[[self.todayMustReadArr objectAtIndex:i] objectForKey:@"tupian"]];
//            }
//            }
//            
//            for (int i = 0; i<self.todayMustReadArr.count; i++) {
//                
//                [[TodayMustReadData sharedImage] addImage:[[self.todayMustReadArr objectAtIndex:i] objectForKey:@"tupian"]];
//            }
//            self.todayMustReadImgArr = [[TodayMustReadData sharedImage] findAll];
//            NSLog(@"img====================%@",self.todayMustReadImgArr);
//            [[TodayMustReadData sharedImage] closePphoto];
//        }
//            self.allshuoshuoArr = [[ShuoshuoDataBase sharedShuoshuo] findAll];
        
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
    
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/benzhoubibei/list.do" parameters:[@{@"time":str}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.weekMustPrePareArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"------%@",self.weekMustPrePareArr);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
    
    //本周注意事项
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/zhuyishixiang/list.do" parameters:[@{@"time":str}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.weekAttentionArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"------%@",self.weekAttentionArr);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
    
    
}

-(void)addJinrisuishoiji
{
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [self.manager GET:@"http://101.200.234.127:8080/YanLu/suishouji/list.do" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.todayRecordArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"------%@",self.todayRecordArr);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
}

-(void)titleImage
{
    titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
    titleImageView.image = [UIImage imageNamed:@"未标题-4-01"];
    //[self.view addSubview:titleImageView];
    
    UIImageView *timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth, 50)];
    timeImageView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.75];
    [titleImageView addSubview:timeImageView];
    
    self.weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2+20, 0, (ScreenWidth/2-20)/2, timeImageView.frame.size.height/2)];
    self.weekLabel.textAlignment = NSTextAlignmentCenter;
    self.weekLabel.textColor = RGBA(231, 50, 120, 1);
    self.weekLabel.font = [UIFont fontWithName:nil size:18];
//    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    NSArray *array1 = [[formatter stringFromDate:[NSDate date]] componentsSeparatedByString:@"-"];
//    NSArray *array2 = [str componentsSeparatedByString:@"-"];
//    
//    NSInteger year = [[array1 objectAtIndex:0] integerValue] - [[array2 objectAtIndex:0] integerValue];
//    NSInteger month = [[array1 objectAtIndex:1] integerValue] - [[array2 objectAtIndex:1] integerValue];
//    NSInteger date = [[array1 objectAtIndex:2] integerValue] - [[array2 objectAtIndex:2] integerValue];
//    if (year>0) {
//        NSInteger monthcount = 12 - [[array2 objectAtIndex:1] integerValue] + [[array1 objectAtIndex:1] integerValue];
//    }
    
    
    if ([zhuangtai isEqualToString:@"怀孕中"]) {
        NSInteger weekcount = [huaiyuntianshu integerValue]/7;
        NSInteger timecount = [huaiyuntianshu integerValue]%7;
        if (timecount==0) {
            self.weekLabel.text = [NSString stringWithFormat:@"第%d周",weekcount];
        }
        else
        {
            self.weekLabel.text = [NSString stringWithFormat:@"第%d周",weekcount+1];
        }
    }
    else if ([zhuangtai isEqualToString:@"已出生"])
    {
        NSInteger weekcount = [huaiyuntianshu integerValue]/30;
        NSInteger timecount = [huaiyuntianshu integerValue]%30;
        if (timecount==0) {
            self.weekLabel.text = [NSString stringWithFormat:@"第%d个月",weekcount];
        }
        else
        {
            self.weekLabel.text = [NSString stringWithFormat:@"第%d个月",weekcount+1];
        }
    }
    else{
        self.weekLabel.text = @"未怀孕";
    }
    [timeImageView addSubview:self.weekLabel];
    
    self.weekdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.weekLabel.frame.origin.x+self.weekLabel.frame.size.width, 0, (ScreenWidth/2-20)/2, timeImageView.frame.size.height/2)];
    self.weekdayLabel.textAlignment = NSTextAlignmentCenter;
    self.weekdayLabel.textColor = RGBA(231, 50, 120, 1);
    self.weekdayLabel.font = [UIFont fontWithName:nil size:14];
    if ([zhuangtai isEqualToString:@"备孕中"]) {
        self.weekdayLabel.text = @"(备孕中)";
    }
    else
    {
        self.weekdayLabel.text = [NSString stringWithFormat:@"(%@天)",huaiyuntianshu];
    }
    self.weekdayLabel.textAlignment = NSTextAlignmentLeft;
    [timeImageView addSubview:self.weekdayLabel];
    
    self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2, timeImageView.frame.size.height/2, ScreenWidth/2, timeImageView.frame.size.height/2)];
    self.dayLabel.textAlignment = NSTextAlignmentCenter;
    self.dayLabel.textColor = RGBA(231, 50, 120, 1);
    self.dayLabel.font = [UIFont fontWithName:nil size:14];
    if ([zhuangtai isEqualToString:@"怀孕中"]) {
        NSInteger b = 280 - [huaiyuntianshu integerValue];
        self.dayLabel.text = [NSString stringWithFormat:@"据宝宝出生还有%d天",b];
    }
    else if ([zhuangtai isEqualToString:@"已出生"])
    {
        self.dayLabel.text = [NSString stringWithFormat:@"宝宝已出生%@天",huaiyuntianshu];
    }
    else{
        self.dayLabel.text = @"备孕中，要加油哦！";
    }
    
    [timeImageView addSubview:self.dayLabel];
}

-(void)creatTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-90) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    //self.tableView.sectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
}
//隐藏状态栏
//- (BOOL)prefersStatusBarHidden{
//    return YES;
//}

-(void)deleteImg
{
    for (int i = 0; i<arr.count; i++) {
        deleBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        deleBtn1.frame = CGRectMake(ScreenWidth-35, 12, 15, 15);
        deleBtn1.selected = NO;
        deleBtn1.tag = i+100;
        [deleBtn1 setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
        [deleBtn1 addTarget:self action:@selector(clickdeleBtn2:) forControlEvents:UIControlEventTouchUpInside];
        [btnArr addObject:deleBtn1];
        
        deleImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 19, 100, 2)];
        //deleImageView.image = [UIImage imageNamed:@""];
        deleImageView1.tag = i+100;
        deleImageView1.backgroundColor = [UIColor redColor];
        deleImageView1.hidden = YES;
        [imgArr addObject:deleImageView1];
    }
    
    NSLog(@"btnArr%@",btnArr);
        NSLog(@"imgArr%@",imgArr);
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataMessage];
    [self addJinrisuishoiji];
    
    btnArr = [[NSMutableArray alloc] init];
    imgArr = [[NSMutableArray alloc] init];

    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    /*-------------状态栏改变背景颜色-----------*/
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    head.backgroundColor = [UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1];
    [self.navigationController.view addSubview:head];
    
    self.view.backgroundColor = RGBA(235, 235, 235, 1);
    
    self.tableArr = @[@"宝宝成长记录",@"今日必做事项",@"今日必读知识",@"本周必备物品",@"本周注意事项",@"今题随手记"];

    [self titleImage];
    [self creatTableView];
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            //return self.babyGrowArr.count;
            return 2;
            break;
            
        case 1:
            return arr.count;
            break;
            
        case 2:
            return self.todayMustReadArr.count;
            break;
            
        case 3:
            return self.weekMustPrePareArr.count;
            break;
            
        case 4:
            return self.weekAttentionArr.count;
            break;
            
        default:
            return self.todayRecordArr.count;
            break;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [text resignFirstResponder];
    
    static NSString *str1 = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:str1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    //头像
    UIImageView *touxiangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 70, 70)];
    touxiangImageView.layer.cornerRadius = 35;
    touxiangImageView.image = [UIImage imageNamed:@"头像"];
    //文字记录
    UILabel *babyLabel = [[UILabel alloc] initWithFrame:CGRectMake(touxiangImageView.frame.origin.x+touxiangImageView.frame.size.width+10, touxiangImageView.frame.origin.y, ScreenWidth-touxiangImageView.frame.size.width-20, touxiangImageView.frame.size.height)];
    babyLabel.numberOfLines = 5;
//    babyLabel.text = @"    在准妈妈的肚子里，胎宝宝的变化速度非常快。到本周，胎宝宝差不多有一个葡萄干那么重，它的顶臀长现在大约有2-4厘米，顶臀长是指胎宝宝的坐高或者是胎宝宝的头顶到臀部之间的距离。";
  //  NSLog(@"%ld",self.babyGrowArr.count);
    babyLabel.text = [NSString stringWithFormat:@"   %@",[[self.babyGrowArr objectAtIndex:0] objectForKey:@"zhishi"]];
    
    babyLabel.font = [UIFont fontWithName:nil size:12];
    babyLabel.textColor = [UIColor grayColor];
    
    UIButton *TVButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    TVButton1.frame = CGRectMake(2, 4, (ScreenWidth-6)/2, 78);
    [TVButton1 setImage:[UIImage imageNamed:@"视频搜索"] forState:UIControlStateNormal];
    [TVButton1 addTarget:self action:@selector(clickTV1Btn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *TVButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    TVButton2.frame = CGRectMake(TVButton1.frame.origin.x+TVButton1.frame.size.width+2, 4, (ScreenWidth-6)/2, 78);
    [TVButton2 setImage:[UIImage imageNamed:@"TV"] forState:UIControlStateNormal];
    [TVButton2 addTarget:self action:@selector(clickTV2Btn) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 66, 55)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imgView.frame.origin.x+imgView.frame.size.width+5, 0, ScreenWidth-imgView.frame.size.width-10, 65)];
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                group1=[[NSDictionary alloc]initWithObjectsAndKeys:indexPath,@"indexpath",cell,@"cell", nil];
                [NSThread detachNewThreadSelector:@selector(loadLabelTableView:) toTarget:self withObject:group1];
                //[cell.contentView addSubview:touxiangImageView];
                [cell.contentView addSubview:babyLabel];
                [cell.contentView addSubview:touxiangImageView];
            }
            else
            {
                [cell.contentView addSubview:TVButton1];
                [cell.contentView addSubview:TVButton2];
            }
            break;
            
        case 1:
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = [arr objectAtIndex:indexPath.row];
            
            [cell addSubview:[imgArr objectAtIndex:indexPath.row]];
            [cell addSubview:[btnArr objectAtIndex:indexPath.row]];
            break;
            
        case 2:
            [cell addSubview:label];
            label.text = [[self.todayMustReadArr objectAtIndex:indexPath.row] objectForKey:@"neirong"];
            [cell addSubview:imgView];
            
            //group2=[[NSDictionary alloc]initWithObjectsAndKeys:indexPath,@"indexpath",cell,@"cell", nil];
            //[NSThread detachNewThreadSelector:@selector(loadLabelTableView:) toTarget:self withObject:group2];
            if (cell) {
                NSURL *url = [NSURL URLWithString:[[self.todayMustReadImgArr objectAtIndex:indexPath.row] objectForKey:@"Image"]];
                
                
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
                    imgView.image = [UIImage imageWithData:data];
                }];
            }
            
            break;
            
        case 3:
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:label];
            label.text = [[self.weekMustPrePareArr objectAtIndex:indexPath.row] objectForKey:@"wupinming"];
            //[cell addSubview:imgView];
            //imgView.image = [UIImage imageNamed:[[self.weekMustPrePareArr objectAtIndex:indexPath.row] objectForKey:@"tupian"]];
            group3=[[NSDictionary alloc]initWithObjectsAndKeys:indexPath,@"indexpath",cell,@"cell", nil];
            [NSThread detachNewThreadSelector:@selector(loadLabelTableView:) toTarget:self withObject:group3];
            break;
            
        case 4:
            [cell.contentView addSubview:label];
//            label.text = [[self.weekAttentionArr objectAtIndex:indexPath.row] objectForKey:@"neirong"];
            
            
            label.text = [[self.weekAttentionArr objectAtIndex:indexPath.row] objectForKey:@"neirong"];

            group4=[[NSDictionary alloc]initWithObjectsAndKeys:indexPath,@"indexpath",cell,@"cell", nil];
            [NSThread detachNewThreadSelector:@selector(loadLabelTableView:) toTarget:self withObject:group4];
            [cell addSubview:imgView];
//            imgView.image = [UIImage imageNamed:[[self.weekAttentionArr objectAtIndex:indexPath.row] objectForKey:@"tupian"]];
            
            imgView.image = [UIImage imageNamed:@"666.jpg"];
            
            break;
            
        case 5:
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = [[self.todayRecordArr objectAtIndex:indexPath.row] objectForKey:@"suishouji"];
            break;
            
        default:
            break;
    }
    return cell;
    
}

-(void)loadLabelTableView:(NSDictionary *)group
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 66, 55)];
    NSData *data;
    if (group == group1) {
        data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.babyGrowArr objectAtIndex:[[group objectForKey:@"indexpath"] row]] objectForKey:@"tupian"]]];
        imageView.frame = CGRectMake(10, 15, 80, 80);
        imageView.layer.cornerRadius = 35;
    }
    else if (group == group2)
    {
        data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.todayMustReadArr objectAtIndex:[[group objectForKey:@"indexpath"] row]] objectForKey:@"tupian"]]];
    }
    else if (group == group3)
    {
        data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.weekMustPrePareArr objectAtIndex:[[group objectForKey:@"indexpath"] row]] objectForKey:@"tupian"]]];
    }
    else if (group == group4)
    {
        data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.weekAttentionArr objectAtIndex:[[group objectForKey:@"indexpath"] row]] objectForKey:@"tupian"]]];
    }
    //NSLog(@"tupian:%@",data);
    UIImage *img=[UIImage imageWithData:data];
    
    imageView.image=img;
    
    [[group objectForKey:@"cell"]  addSubview:imageView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 178;
    }
    else
    {
        return 38;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 5) {
        return 40;
    }
    else
    {
        self.tableView.sectionFooterHeight = 0;
        return 0;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                return 90;
            }
            else
            {
                return 86;
            }
            break;
            
        case 1:
            return 40;
            break;
            
        default:
            return 65;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    if (section == 0) {
        UIImageView *headerView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 140, ScreenWidth, 40)];
        headerView1.image = [UIImage imageNamed:@"section"];
        //headerView1.backgroundColor = RGBA(245, 178, 178,1);
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 40)];
        //label.textAlignment = NSTextAlignmentCenter;
        label1.textColor = [UIColor whiteColor];
        label1.font = [UIFont fontWithName:nil size:18];
        label1.text = [self.tableArr objectAtIndex:section];
        [headerView1 addSubview:label1];
        
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenHeight, 178)];
        [titleView addSubview:titleImageView];
        [titleView addSubview:headerView1];
        return titleView;
    }
    else
    {
        UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 38)];
        headerView.image = [UIImage imageNamed:@"section"];
        //headerView.backgroundColor = RGBA(245, 178, 178,1);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 40)];
        //label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont fontWithName:nil size:18];
        label.text = [self.tableArr objectAtIndex:section];
        [headerView addSubview:label];
        
        return headerView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 40)];
    text = [[UITextField alloc] initWithFrame:CGRectMake(5, 10, ScreenWidth-30, 20)];
    //label.borderStyle = UITextBorderStyleRoundedRect;
    text.placeholder = @"各位美妈们输入文字编辑“今日随手记”哦！";
    text.font = [UIFont fontWithName:nil size:12];
    text.delegate = self;
    [footerView addSubview:text];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 30, ScreenWidth-40, 1)];
    imgView.backgroundColor = [UIColor lightGrayColor];
    [footerView addSubview:imgView];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(imgView.frame.origin.x+imgView.frame.size.width+5, 15, 20, 15);
    [sendBtn setImage:[UIImage imageNamed:@"发送"] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendBtn) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:sendBtn];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    if (section == 5) {
        return footerView;
    }
    
    else
    {
        return view;
    }
    
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.manager GET:@"http://101.200.234.127:8080/YanLu/chengzhang/list.do" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.babyGrowArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
    
    NSString *userid = [self.ud objectForKey:@"userid"];
    NSMutableDictionary *xiangxiDic = [[NSMutableDictionary alloc] init];
    [xiangxiDic setObject:userid forKey:@"userid"];
    [xiangxiDic setObject:str forKey:@"huaiyuntianshu"];

    [self.manager POST:@"http://101.200.234.127:8080/YanLu/jinribidu/list.do" parameters:xiangxiDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.todayMustReadArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
    
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/zhuyishixiang/list.do" parameters:xiangxiDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.weekAttentionArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
    
    ArticlDetailsViewController *articlVC = [[ArticlDetailsViewController alloc] init];
    
    if(indexPath.section == 2 ||indexPath.section == 4)
    {
        switch (indexPath.section) {
            case 0:
                //articlVC.dataDic = [self.babyGrowArr objectAtIndex:indexPath.row];
                break;
                
            case 1:
                //articlVC.dataArray = self.todayMustDoArr;
                break;
                
            case 2:
                articlVC.dataDic = [self.todayMustReadArr objectAtIndex:indexPath.row];
                break;
                
            case 3:
                //articlVC.dataArray = self.weekMustPrePareArr;
                break;
                
            case 4:
                articlVC.dataDic = [self.weekAttentionArr objectAtIndex:indexPath.row];
                break;
                
            default:
                break;
        }
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:articlVC];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
    
}

-(void)sendBtn
{
    if ([text.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发表失败" message:@"请输入你想要记录的内容" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        self.ud = [NSUserDefaults standardUserDefaults];
        NSString *userId = [self.ud objectForKey:@"userid"];
        
        NSMutableDictionary *userdic = [NSMutableDictionary dictionary];
        [userdic setObject:userId forKey:@"userid"];
        [userdic setObject:text.text forKey:@"suishouji"];
        [userdic setObject:@"" forKey:@"tupian"];
        
        self.manager = [AFHTTPRequestOperationManager manager];
        self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
        
        [self.manager POST:@"http://101.200.234.127:8080/YanLu/suishouji/save.do" parameters:userdic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"上传成功");
            [self addJinrisuishoiji];
            [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"获取相响应失败");
        }];
    }
}

-(void)clickTV1Btn
{
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    app.tab.selectedIndex = 2;
}

-(void)clickTV2Btn
{
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    app.tab.selectedIndex = 4;
}

-(void)clickdeleBtn2:(UIButton*)btn
{
    if (!btn.selected) {
        NSLog(@"11111");
        ((UIImageView*)[self.view viewWithTag:btn.tag]).hidden = NO;
        btn.selected = !btn.selected;
    }else
    {
        NSLog(@"2222");
        ((UIImageView*)[self.view viewWithTag:btn.tag]).hidden = YES;
        btn.selected = !btn.selected;
    }
    
    NSLog(@"%d",btn.tag);
    [self.tableView reloadData];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    self.tableView.contentOffset = CGPointMake(0, self.tableView.contentSize.height);
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.tableView.contentOffset = CGPointMake(0, self.tableView.contentSize.height-ScreenHeight+114);
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [text resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.tableView endEditing:YES];
}

/*
 Marion,
 Copperplate 铜版体,
 "Heiti SC 黑体-简",
 "Iowan Old Style",
 "Courier New",
 "Apple SD Gothic Neo",
 "Heiti TC",
 "Gill Sans",
 "Marker Felt",
 Thonburi,
 "Avenir Next Condensed",
 "Tamil Sangam MN",
 "Helvetica Neue",
 "Gurmukhi MN",
 "Times New Roman",
 Georgia,
 "Apple Color Emoji",
 "Arial Rounded MT Bold",
 Kailasa,
 "Kohinoor Devanagari",
 "Sinhala Sangam MN",
 "Chalkboard SE",
 Superclarendon,
 "Gujarati Sangam MN",
 Damascus,
 Noteworthy,
 "Geeza Pro",
 Avenir,
 "Academy Engraved LET",
 Mishafi,
 Futura,
 Farah,
 "Kannada Sangam MN",
 "Arial Hebrew",
 Arial,
 "Party LET",
 Chalkduster,
 "Hiragino Kaku Gothic ProN",
 "Hoefler Text",
 Optima,
 Palatino,
 "Malayalam Sangam MN",
 "Lao Sangam MN",
 "Al Nile",
 "Bradley Hand",
 "Hiragino Mincho ProN",
 "Trebuchet MS",
 Helvetica,
 Courier,
 Cochin,
 "Devanagari Sangam MN",
 "Oriya Sangam MN",
 "Snell Roundhand",
 "Zapf Dingbats",
 "Bodoni 72",
 Verdana,
 "American Typewriter",
 "Avenir Next",
 Baskerville,
 "Khmer Sangam MN",
 Didot,
 "Savoye LET",
 "Bodoni Ornaments",
 Symbol,
 Menlo,
 "Bodoni 72 Smallcaps",
 "DIN Alternate",
 Papyrus,
 "Euphemia UCAS",
 "Telugu Sangam MN",
 "Bangla Sangam MN",
 Zapfino,
 "Bodoni 72 Oldstyle",
 "DIN Condensed"
 */

@end
