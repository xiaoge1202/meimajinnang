//
//  AlreadyBaby-ViewController.m
//  燕庐母婴
//
//  Created by zhaodeyu on 15/7/15.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "AlreadyBaby-ViewController.h"

@interface AlreadyBaby_ViewController ()
{
    NSString *huaiyuntime;
    NSString *huaiyuntianshu;
    NSString *zhuangtai;
    
    UILabel *beforelabel;
    UILabel *beforelabel1;
    
    UILabel *afterlabel;
    UILabel *afterlabel1;
    
    UILabel *chushenglabel;
    
    UILabel *todaylabel;
    
    CGSize sizes;
    UILabel *textlabel;
    UILabel *textLabel;
    
    NSMutableArray *arr;
    NSString *str;
    
    UILabel *tianshulabel;
    BOOL isfirst;
    NSInteger width;
}

@end

@implementation AlreadyBaby_ViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self getud];
    [self.tableView reloadData];
    [self addSearchTextNav];
}

-(void)getud
{
    self.ud = [NSUserDefaults standardUserDefaults];
    //huaiyuntime = [self.ud objectForKey:@"huaiyuntime"];
    //huaiyuntianshu = [self.ud objectForKey:@"huaiyuntianshu"];
    huaiyuntianshu = @"180";
    NSLog(@"%@",huaiyuntianshu);
    //zhuangtai = [self.ud objectForKey:@"zhuangtai"];
}

//获取每日提醒接口数据
-(void)addmeiriTingxing:(NSString*)tianshuStr
{
    //[@{@"time":huaiyuntianshu}mutableCopy]
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [self.manager GET:@"http://101.200.234.127:8080/YanLu/jinribizuo/list.do" parameters:[@{@"time":tianshuStr}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.tixingArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"1111111%@",self.tixingArr);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
}

-(void)addyingyangzhongxin
{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *zileiId = @"1";
    NSString *start = @"0";
    [dic setObject:zileiId forKey:@"zilei_id"];
    [dic setObject:start forKey:@"start"];
    
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [self.manager GET:@"http://101.200.234.127:8080/YanLu/yingyangzhongxin/findYingYangList.do" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.yingyangArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"2222222%@",self.yingyangArr);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
}

-(void)addTuijianzhishi:(NSString*)tianshuStr
{
    //[@{@"time":huaiyuntianshu}mutableCopy]
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [self.manager GET:@"http://101.200.234.127:8080/YanLu/jinribidu/list.do" parameters:[@{@"time":tianshuStr}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.knowledgeArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"3333333%@",self.knowledgeArr);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
}

-(void)addMeizhoubibei:(NSString*)tianshuStr
{
    //[@{@"shijian":huaiyuntianshu}mutableCopy]
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [self.manager GET:@"http://101.200.234.127:8080/YanLu/benzhoubibei/list.do" parameters:[@{@"shijian":tianshuStr}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.mustPrepareArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"4444444%@",self.mustPrepareArr);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
}

-(void)addSameAgeRetie
{
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [self.manager GET:@"http://101.200.234.127:8080/YanLu/tiezi/listone.do" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.sameAgeArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"5555555%@",self.sameAgeArr);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
}

-(void)addchengzhangjilu:(NSInteger)tianshu
{
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    self.titleArr = [[NSMutableArray alloc] init];
    self.sizesArr = [[NSMutableArray alloc] init];
    if (tianshu>1&&tianshu<280) {
        for (int i = 0; i<3; i++) {
            [self.manager GET:@"http://101.200.234.127:8080/YanLu/chengzhang/list.do" parameters:[@{@"huaiyuntime":[NSString stringWithFormat:@"%d",tianshu+1-i]}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSData *data = (NSData *)responseObject;
                self.chengzhangArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"6666666%@",self.chengzhangArr);
                textlabel = [[UILabel alloc] initWithFrame:CGRectMake(25+ScreenWidth*(tianshu-i), 0, ScreenWidth-45, 10)];
                //textlabel.textAlignment = NSTextAlignmentCenter;
                textlabel.textColor = RGBA(89, 87, 87, 1);
                textlabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:13];
                textlabel.text = [[self.chengzhangArr objectAtIndex:0] objectForKey:@"zhishi"];
                textlabel.NumberOfLines = 0;
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
                //textlabel.backgroundColor = [UIColor redColor];
                paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
                NSDictionary *attributes = @{NSFontAttributeName:textlabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
                sizes = [textlabel.text boundingRectWithSize:CGSizeMake(ScreenWidth-45, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
                [textlabel setFrame:CGRectMake(25+ScreenWidth*(tianshu-i), ScreenHeight*0.55-18, sizes.width, sizes.height)];
                [self.titleArr addObject:textlabel];
                [self.sizesArr addObject:[NSString stringWithFormat:@"%f",sizes.height]];
                
                NSLog(@"%@",self.sizesArr);
                NSLog(@"侯泽彭    %d",self.chengzhangArr.count);
                [self.tableView reloadData];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"获取相响应失败");
            }];
        }
    }
    
    else
    {
        [self.manager GET:@"http://101.200.234.127:8080/YanLu/chengzhang/list.do" parameters:[@{@"huaiyuntime":[NSString stringWithFormat:@"%d",tianshu]}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSData *data = (NSData *)responseObject;
            self.chengzhangArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"6666666%@",self.chengzhangArr);
            textlabel = [[UILabel alloc] initWithFrame:CGRectMake(25+ScreenWidth*(tianshu-1), 0, ScreenWidth-45, 10)];
            //textlabel.textAlignment = NSTextAlignmentCenter;
            textlabel.textColor = RGBA(89, 87, 87, 1);
            textlabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:13];
            textlabel.text = [[self.chengzhangArr objectAtIndex:0] objectForKey:@"zhishi"];
            textlabel.NumberOfLines = 0;
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            //textlabel.backgroundColor = [UIColor redColor];
            paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
            NSDictionary *attributes = @{NSFontAttributeName:textlabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
            sizes = [textlabel.text boundingRectWithSize:CGSizeMake(ScreenWidth-45, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
            [textlabel setFrame:CGRectMake(25+ScreenWidth*(tianshu-1), ScreenHeight*0.55-18, sizes.width, sizes.height)];
            
            NSLog(@"侯泽彭    %d",self.chengzhangArr.count);
            [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"获取相响应失败");
        }];
    }
    
}

-(void)postDataFromServer
{
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    self.ud = [NSUserDefaults standardUserDefaults];
    
    NSString *pet_name = [self.ud objectForKey:@"username"];
    NSString *password = [self.ud objectForKey:@"password"];
    
    self.dataDic = [[NSMutableDictionary alloc]init];
    [self.dataDic setObject:pet_name forKey:@"username"];
    [self.dataDic setObject:password forKey:@"password"];
    
    ////////////////////////////////////////////
    // 使用AFHTTPRequestOperationManager发送POST请求
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/user/list.do" parameters:self.dataDic  // 指定请求参数
     // 获取服务器响应成功时激发的代码块
               success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         // 当使用HTTP响应解析器时，服务器响应数据被封装在NSData中
         // 此处将NSData转换成NSString、并使用UIAlertView显示登录结果
         self.dataArr = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:0 error:nil];
         NSLog(@"%@",self.dataArr);
         
         self.ud = [NSUserDefaults standardUserDefaults];
         [self.ud removeObjectForKey:@"huaiyuntianshu"];
         [self.ud removeObjectForKey:@"huaiyuntime"];
         [self.ud setObject:[[self.dataArr objectAtIndex:0] objectForKey:@"huaiyuntime"] forKey:@"huaiyuntime"];
         [self.ud setObject:[[self.dataArr objectAtIndex:0] objectForKey:@"huaiyuntianshu"] forKey:@"huaiyuntianshu"];
         [self.ud synchronize];
         
         [self.tableView reloadData];
     }
     // 获取服务器响应失败时激发的代码块
               failure:^(AFHTTPRequestOperation *operation, NSError *error){
                   NSLog(@"获取服务器响应出错！");
               }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getud];
    [self addchengzhangjilu:[huaiyuntianshu integerValue]];
    [self postDataFromServer];
    [self addmeiriTingxing:huaiyuntianshu];
    [self addTuijianzhishi:huaiyuntianshu];
    [self addMeizhoubibei:huaiyuntianshu];
    [self addyingyangzhongxin];
    [self addSameAgeRetie];
    
    isfirst = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title = @"";
    
    //[self addSearchTextNav];
    /*-------------状态栏改变背景颜色-----------*/
    //    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    //    head.backgroundColor = [UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1];
    //    [self.navigationController.view addSubview:head];
    
    self.view.backgroundColor = RGBA(235, 235, 235, 1);
    
    
    
    self.tableArr = @[@"每日提醒",@"营养中心",@"推荐知识",@"每日必备物品",@"同龄热搜贴"];
    self.imgArr = @[@"提醒",@"营养",@"推荐",@"必备",@"热贴"];
    self.textArr = @[@"为了宝贝一定要按时遵守哦！",@"让宝贝更好的吸收营养",@"做您孕期最坚实的后盾",@"呵护宝宝，呵护您",@"跟姐妹们聊一聊育儿经"];
    
    
    
    
    
    [self creatTableView];
    
    // Do any additional setup after loading the view.
}

-(void)addSearchTextNav
{
    UIImageView *navView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    navView.image = [UIImage imageNamed:@"导航栏"];
    navView.multipleTouchEnabled = YES;
    navView.userInteractionEnabled = YES;
    navView.tag = 66;
    [self.navigationController.view addSubview:navView];
    
    //    self.searchText = [[UISearchBar alloc] initWithFrame:CGRectMake(12, 27, ScreenWidth-61, 29)];
    //    self.searchText.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //    //self.searchBar.layer.borderWidth = 1.5;
    //    //self.searchBar.layer.masksToBounds = YES;
    //    //self.searchBar.layer.cornerRadius = 10;
    //    self.searchText.delegate = self;
    //    //self.searchText.placeholder = @"能不能吃...";
    //    self.searchText.layer.borderColor = [UIColor clearColor].CGColor;
    //    self.searchText.backgroundImage = [self imageWithColor:[UIColor clearColor] size:self.searchText.bounds.size];
    //    [self.searchText setImage:[UIImage imageNamed:@"放大镜1"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    //
    //    [self.searchText setSearchFieldBackgroundImage:[UIImage imageNamed:@"搜索1@2x"] forState:UIControlStateNormal];
    //    [self setSearchBarTextfiled:self.searchText];
    //    self.searchText.showsScopeBar = YES;
    //    [navView addSubview:self.searchText];
    
    self.searchText = [[UITextView alloc] initWithFrame:CGRectMake(12, 27, ScreenWidth-61, 29)];
    self.searchText.delegate = self;
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"搜索1"]];
    self.searchText.backgroundColor = color;
    NSString *stringText = @"        ";
    self.searchText.text = stringText;
    self.searchText.selectedRange = NSMakeRange(self.searchText.text.length, 0);
    [navView addSubview:self.searchText];
    
    
    UIImageView *glassImg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 7, 18, 18)];
    glassImg.image = [UIImage imageNamed:@"放大镜1"];
    [self.searchText addSubview:glassImg];
    
    UIImageView *evenlopeImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.searchText.frame.origin.x+self.searchText.frame.size.width+5, 27, 34, 29)];
    evenlopeImg.multipleTouchEnabled = YES;
    evenlopeImg.userInteractionEnabled = YES;
    evenlopeImg.image = [UIImage imageNamed:@"搜索2"];
    [navView addSubview:evenlopeImg];
    
    UIButton *evenlopeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    evenlopeBtn.frame = CGRectMake(7, 10, 16, 13);
    [evenlopeBtn setImage:[UIImage imageNamed:@"信封"] forState:UIControlStateNormal];
    [evenlopeBtn addTarget:self action:@selector(clickEvenlopeBtn) forControlEvents:UIControlEventTouchUpInside];
    [evenlopeImg addSubview:evenlopeBtn];
}
UILabel *labelss;
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.searchText.text isEqualToString:@"        "]) {
        labelss = [[UILabel alloc] initWithFrame:CGRectMake(30, 7, 150, 18)];
        labelss.text = @"请输入搜索的问题";
        labelss.textColor = [UIColor lightGrayColor];
        labelss.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        [self.searchText addSubview:labelss];
    }
    
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    labelss.text = @"";
    if ([self.searchText.text isEqualToString:@"        "])
    {
        labelss.text = @"请输入搜索的问题";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    labelss.text = @"";
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([self.searchText.text isEqualToString:@"        "]) {
        return NO;
    }
    else
    {
        return YES;
    }
    
}

-(void)clickEvenlopeBtn
{
    
}

-(void)creatTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    //self.tableView.sectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.tixingArr.count+1;
            break;
            
        case 1:
            return self.yingyangArr.count;
            break;
            
        case 2:
            return self.knowledgeArr.count;
            break;
            
        case 3:
            return self.mustPrepareArr.count;
            break;
            
        default:
            return 2;
            //return self.sameAgeArr.count;
            break;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str1 = [NSString stringWithFormat:@"cell%d%d",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:str1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    //    else
    //    {
    //        while ([cell.contentView.subviews lastObject] != nil) {
    //            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
    //        }
    //    }
    
    UIImageView *touxiangImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12, 62, 50)];
    touxiangImg.image = [UIImage imageNamed:@"宝宝头像"];
    
    UILabel *neironglabel = [[UILabel alloc] initWithFrame:CGRectMake(touxiangImg.frame.origin.x+touxiangImg.frame.size.width+15, 20, ScreenWidth-(touxiangImg.frame.origin.x+touxiangImg.frame.size.width+15), 12)];
    neironglabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
    neironglabel.textColor = RGBA(89, 87, 87, 1);
    
    UIImageView *liulanImg = [[UIImageView alloc] initWithFrame:CGRectMake(touxiangImg.frame.origin.x+touxiangImg.frame.size.width+15, neironglabel.frame.origin.y+neironglabel.frame.size.height+15, 12, 9)];
    liulanImg.image = [UIImage imageNamed:@"see"];
    
    UILabel *liulanLabel = [[UILabel alloc] initWithFrame:CGRectMake(liulanImg.frame.origin.x+liulanImg.frame.size.width+5, neironglabel.frame.origin.y+neironglabel.frame.size.height+15, 30, 9)];
    liulanLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    liulanLabel.textColor = RGBA(89, 87, 87, 1);
    
    UIImageView *huifuImg = [[UIImageView alloc] initWithFrame:CGRectMake(liulanLabel.frame.origin.x+liulanLabel.frame.size.width+50, neironglabel.frame.origin.y+neironglabel.frame.size.height+15, 12, 9)];
    huifuImg.image = [UIImage imageNamed:@"话题"];
    
    UILabel *huifuLabel = [[UILabel alloc] initWithFrame:CGRectMake(huifuImg.frame.origin.x+huifuImg.frame.size.width+5, neironglabel.frame.origin.y+neironglabel.frame.size.height+15, 30, 9)];
    huifuLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    huifuLabel.textColor = RGBA(89, 87, 87, 1);
    
    UIImageView *bibeiimgage1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12, 62, 57)];
    bibeiimgage1.image = [UIImage imageNamed:@"宝宝头像"];
    
    UILabel *bibeilabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, bibeiimgage1.frame.origin.y+bibeiimgage1.frame.size.height+10, 62, 9)];
    bibeilabel1.textColor = RGBA(89, 87, 87, 1);
    bibeilabel1.textAlignment = NSTextAlignmentCenter;
    bibeilabel1.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    
    UIImageView *bibeiimgage2 = [[UIImageView alloc] initWithFrame:CGRectMake(bibeiimgage1.frame.origin.x+bibeiimgage1.frame.size.width+(ScreenWidth-279)/3, 12, 59, 57)];
    bibeiimgage2.image = [UIImage imageNamed:@"宝宝头像"];
    
    UILabel *bibeilabel2 = [[UILabel alloc] initWithFrame:CGRectMake(bibeiimgage1.frame.origin.x+bibeiimgage1.frame.size.width+(ScreenWidth-279)/3, bibeiimgage2.frame.origin.y+bibeiimgage2.frame.size.height+10, 62, 9)];
    bibeilabel2.textAlignment = NSTextAlignmentCenter;
    bibeilabel2.textColor = RGBA(89, 87, 87, 1);
    bibeilabel2.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    
    UIImageView *bibeiimgage3 = [[UIImageView alloc] initWithFrame:CGRectMake(bibeiimgage2.frame.origin.x+bibeiimgage2.frame.size.width+(ScreenWidth-279)/3, 12, 62, 57)];
    bibeiimgage3.image = [UIImage imageNamed:@"宝宝头像"];
    
    UILabel *bibeilabel3 = [[UILabel alloc] initWithFrame:CGRectMake(bibeiimgage2.frame.origin.x+bibeiimgage2.frame.size.width+(ScreenWidth-279)/3, bibeiimgage3.frame.origin.y+bibeiimgage3.frame.size.height+10, 62, 9)];
    bibeilabel3.textAlignment = NSTextAlignmentCenter;
    bibeilabel3.textColor = RGBA(89, 87, 87, 1);
    bibeilabel3.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    
    UIImageView *bibeiimgage4 = [[UIImageView alloc] initWithFrame:CGRectMake(bibeiimgage3.frame.origin.x+bibeiimgage3.frame.size.width+(ScreenWidth-279)/3, 12, 62, 57)];
    bibeiimgage4.image = [UIImage imageNamed:@"宝宝头像"];
    
    UILabel *bibeilabel4 = [[UILabel alloc] initWithFrame:CGRectMake(bibeiimgage3.frame.origin.x+bibeiimgage3.frame.size.width+(ScreenWidth-279)/3, bibeiimgage4.frame.origin.y+bibeiimgage4.frame.size.height+10, 62, 9)];
    bibeilabel4.textColor = RGBA(89, 87, 87, 1);
    bibeilabel4.textAlignment = NSTextAlignmentCenter;
    bibeilabel4.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == self.tixingArr.count) {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, ScreenWidth-20, 14)];
                label.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:14];
                label.textColor = RGBA(89, 87, 87, 1);
                label.text = @"今日必读文章...";
                [cell addSubview:label];
            }
            else
            {
                UILabel *timelabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 160, 14)];
                timelabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:14];
                timelabel.textColor = RGBA(89, 87, 87, 1);
                timelabel.text = [[self.tixingArr objectAtIndex:indexPath.row] objectForKey:@"tixingtime"];
                [cell addSubview:timelabel];
                
                UILabel *zhishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(timelabel.frame.origin.x+timelabel.frame.size.width+20, 12, ScreenWidth-(timelabel.frame.origin.x+timelabel.frame.size.width+20), 14)];
                zhishiLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:14];
                zhishiLabel.textColor = RGBA(89, 87, 87, 1);
                zhishiLabel.text = [[self.tixingArr objectAtIndex:indexPath.row] objectForKey:@"neirong"];
                [cell addSubview:zhishiLabel];
            }
            break;
            
        case 3:
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell addSubview:bibeiimgage1];
            [cell addSubview:bibeilabel1];
            [cell addSubview:bibeiimgage2];
            [cell addSubview:bibeilabel2];
            [cell addSubview:bibeiimgage3];
            [cell addSubview:bibeilabel3];
            [cell addSubview:bibeiimgage4];
            [cell addSubview:bibeilabel4];
            bibeilabel1.text = @"防辐射服";
            bibeilabel2.text = @"隔热奶瓶";
            bibeilabel3.text = @"尿不湿";
            bibeilabel4.text = @"爬行服";
            break;
            
        default:
            [cell addSubview:touxiangImg];
            [cell addSubview:neironglabel];
            [cell addSubview:liulanImg];
            [cell addSubview:liulanLabel];
            [cell addSubview:huifuImg];
            [cell addSubview:huifuLabel];
            switch (indexPath.section) {
                case 1:
                    neironglabel.text = [[self.yingyangArr objectAtIndex:indexPath.row] objectForKey:@"biaoti"];
                    liulanLabel.text = [[self.yingyangArr objectAtIndex:indexPath.row] objectForKey:@"chakan"];
                    huifuLabel.text = [[self.yingyangArr objectAtIndex:indexPath.row] objectForKey:@"pinglun"];
                    break;
                    
                case 2:
                    neironglabel.text = [[self.knowledgeArr objectAtIndex:indexPath.row] objectForKey:@"biaoti"];
                    liulanLabel.text = [[[self.knowledgeArr objectAtIndex:indexPath.row] objectForKey:@"yueducishu"] stringValue];
                    huifuLabel.text = [[self.knowledgeArr objectAtIndex:indexPath.row] objectForKey:@"huifuzongshu"];
                    break;
                    
                case 4:
                    neironglabel.text = [[self.sameAgeArr objectAtIndex:indexPath.row] objectForKey:@"title"];
                    liulanLabel.text = [[[self.sameAgeArr objectAtIndex:indexPath.row] objectForKey:@"chakanzongshu"] stringValue];
                    huifuLabel.text = [[[self.sameAgeArr objectAtIndex:indexPath.row] objectForKey:@"pinglunzongshu"] stringValue];
                    break;
                    
                default:
                    break;
            }
            break;
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.sizesArr.count>2) {
            return ScreenHeight*0.72+58+[[self.sizesArr objectAtIndex:1] integerValue];
        }
        else
        {
            if (isfirst) {
                if ([huaiyuntianshu integerValue]==1 || [huaiyuntianshu integerValue]==280) {
                    return ScreenHeight*0.72+58+sizes.height;
                }
                else
                {
                    return ScreenHeight*0.72+58;
                }
            }
            else{
                if (width+1==1 || width+1==280) {
                    return ScreenHeight*0.72+58+sizes.height;
                }
                else
                {
                    return ScreenHeight*0.72+58;
                }
            }
            
        }
    }
    else if(section == 2)
    {
        return 133;
    }
    else
    {
        return 58;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        return 20;
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
            return 34;
            break;
            
        case 3:
            return 101;
            break;
            
        default:
            return 72;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    if (section == 0) {
        
        UIView *titleView;
        if (self.sizesArr.count>2) {
            titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.72+58+[[self.sizesArr objectAtIndex:1] integerValue])];
        }
        
        //        else
        //        {
        //            titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.72+58+sizes.height)];
        //        }
        titleView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgView;
        if (self.sizesArr.count>2) {
            imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.72+[[self.sizesArr objectAtIndex:1] integerValue])];
        }
        if (isfirst) {
            if ([huaiyuntianshu integerValue]==1 || [huaiyuntianshu integerValue]==280) {
                titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.72+58+sizes.height)];
                titleView.backgroundColor = [UIColor whiteColor];
                imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.72+sizes.height)];
            }
        }
        else
        {
            if (width+1==1 || width+1==280) {
                titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.72+58+sizes.height)];
                titleView.backgroundColor = [UIColor whiteColor];
                imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.72+sizes.height)];
            }
        }
        
        //        else
        //        {
        //            imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.72+sizes.height)];
        //        }
        imgView.userInteractionEnabled = YES;
        imgView.multipleTouchEnabled = YES;
        imgView.image = [UIImage imageNamed:@"背景"];
        [titleView addSubview:imgView];
        
        UITapGestureRecognizer *singleTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
        [titleView addGestureRecognizer:singleTouch];
        
        UIImageView *shengView = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 0, ScreenWidth+20, 65)];
        shengView.image = [UIImage imageNamed:@"细绳"];
        [imgView addSubview:shengView];
        
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        self.scrollView.contentSize = CGSizeMake(ScreenWidth*56+ScreenWidth/5*4, 1);
        self.scrollView.userInteractionEnabled = YES;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.scrollEnabled = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.delegate = self;
        //if (isfirst) {
        [self.scrollView setContentOffset:CGPointMake(([huaiyuntianshu integerValue]-3)*ScreenWidth/5, 0) animated:YES];
        //}
        //else
        //{
        //[self.scrollView setContentOffset:CGPointMake((width-2)*ScreenWidth/5, 0) animated:YES];
        //}
        
        [imgView addSubview:self.scrollView];
        
        
        
        UIImageView *todayImg = [[UIImageView alloc] initWithFrame:CGRectMake(([huaiyuntianshu integerValue]-1)*ScreenWidth/5, 15, 75, 93)];
        //if (isfirst) {
        todayImg.image = [UIImage imageNamed:@"今天"];
        //}
        //        else
        //        {
        //            todayImg.image = [UIImage imageNamed:@"之前"];
        //        }
        [self.scrollView addSubview:todayImg];
        
        todaylabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 38, 34, 32)];
        todaylabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        todaylabel.textColor = RGBA(238, 128, 135, 1);
        todaylabel.numberOfLines = 2;
        todaylabel.textAlignment = NSTextAlignmentCenter;
        [todayImg addSubview:todaylabel];
        
        
        UIImageView *beforeImg = [[UIImageView alloc] initWithFrame:CGRectMake(([huaiyuntianshu integerValue]-3)*ScreenWidth/5, 20, 68, 74)];
        beforeImg.image = [UIImage imageNamed:@"之前"];
        [self.scrollView addSubview:beforeImg];
        
        beforelabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 23, 28, 32)];
        beforelabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        beforelabel.textColor = RGBA(201, 160, 99, 1);
        beforelabel.numberOfLines = 2;
        beforelabel.textAlignment = NSTextAlignmentCenter;
        beforelabel.transform=CGAffineTransformMakeRotation(M_PI/7);
        [beforeImg addSubview:beforelabel];
        
        
        UIImageView *beforeImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(([huaiyuntianshu integerValue]-2)*ScreenWidth/5, 25, 68, 74)];
        beforeImg1.image = [UIImage imageNamed:@"之前"];
        beforeImg1.transform=CGAffineTransformMakeRotation(-M_PI/3.5);
        [self.scrollView addSubview:beforeImg1];
        
        beforelabel1 = [[UILabel alloc] initWithFrame:CGRectMake(25, 23, 28, 32)];
        beforelabel1.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        beforelabel1.textColor = RGBA(201, 160, 99, 1);
        beforelabel1.numberOfLines = 2;
        beforelabel1.textAlignment = NSTextAlignmentCenter;
        beforelabel1.transform=CGAffineTransformMakeRotation(M_PI/7);
        [beforeImg1 addSubview:beforelabel1];
        
        
        UIImageView *afterImg = [[UIImageView alloc] initWithFrame:CGRectMake(([huaiyuntianshu integerValue])*ScreenWidth/5, 20, 68, 74)];
        //if (isfirst) {
        afterImg.image = [UIImage imageNamed:@"之后"];
        //}
        //        else
        //        {
        //            afterImg.image = [UIImage imageNamed:@"今天"];
        //        }
        [self.scrollView addSubview:afterImg];
        
        afterlabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 23, 28, 32)];
        afterlabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        afterlabel.textColor = RGBA(201, 160, 99, 1);
        afterlabel.numberOfLines = 2;
        afterlabel.textAlignment = NSTextAlignmentCenter;
        afterlabel.transform=CGAffineTransformMakeRotation(-M_PI/12);
        [afterImg addSubview:afterlabel];
        
        
        UIImageView *afterImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(([huaiyuntianshu integerValue]+1)*ScreenWidth/5, 20, 68, 74)];
        afterImg1.image = [UIImage imageNamed:@"之后"];
        afterImg1.transform=CGAffineTransformMakeRotation(M_PI/7);
        [self.scrollView addSubview:afterImg1];
        
        afterlabel1 = [[UILabel alloc] initWithFrame:CGRectMake(25, 23, 28, 32)];
        afterlabel1.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        afterlabel1.textColor = RGBA(201, 160, 99, 1);
        afterlabel1.numberOfLines = 2;
        afterlabel1.textAlignment = NSTextAlignmentCenter;
        //afterlabel1.transform=CGAffineTransformMakeRotation(M_PI/12);
        [afterImg1 addSubview:afterlabel1];
        
        UIImageView *afterImgss = [[UIImageView alloc] initWithFrame:CGRectMake(([huaiyuntianshu integerValue]+2)*ScreenWidth/5, 20, 68, 74)];
        afterImgss.image = [UIImage imageNamed:@"之后"];
        afterImgss.transform=CGAffineTransformMakeRotation(M_PI/7);
        [self.scrollView addSubview:afterImgss];
        
        UILabel *afterlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(25, 23, 28, 32)];
        afterlabel2.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        afterlabel2.textColor = RGBA(201, 160, 99, 1);
        afterlabel2.numberOfLines = 2;
        afterlabel2.textAlignment = NSTextAlignmentCenter;
        //afterlabel1.transform=CGAffineTransformMakeRotation(M_PI/12);
        afterlabel2.text = [NSString stringWithFormat:@"宝宝%d天",width+3];
        [afterImgss addSubview:afterlabel2];
        
        if (isfirst) {
            if([huaiyuntianshu integerValue]==1)
            {
                todaylabel.text = [NSString stringWithFormat:@"宝宝%@天",huaiyuntianshu];
                beforelabel.text = @"未出生";
                beforelabel1.text = @"未出生";
                afterlabel.text = [NSString stringWithFormat:@"宝宝%d天",[huaiyuntianshu integerValue]+1];
                afterlabel1.text = [NSString stringWithFormat:@"宝宝%d天",[huaiyuntianshu integerValue]+2];
            }
            else if ([huaiyuntianshu integerValue]==2)
            {
                todaylabel.text = [NSString stringWithFormat:@"宝宝%@天",huaiyuntianshu];
                beforelabel.text = @"未出生";
                beforelabel1.text = [NSString stringWithFormat:@"宝宝%d天",[huaiyuntianshu integerValue]-1];
                afterlabel.text = [NSString stringWithFormat:@"宝宝%d天",[huaiyuntianshu integerValue]+1];
                afterlabel1.text = [NSString stringWithFormat:@"宝宝%d天",[huaiyuntianshu integerValue]+2];
            }
            else if ([huaiyuntianshu integerValue]==279)
            {
                todaylabel.text = [NSString stringWithFormat:@"宝宝%@天",huaiyuntianshu];
                beforelabel.text = [NSString stringWithFormat:@"宝宝%d天",[huaiyuntianshu integerValue]-2];
                beforelabel1.text = [NSString stringWithFormat:@"宝宝%d天",[huaiyuntianshu integerValue]-1];
                afterlabel.text = [NSString stringWithFormat:@"宝宝%d天",[huaiyuntianshu integerValue]+1];
                afterlabel1.text = @"已出生";
            }
            else if ([huaiyuntianshu integerValue]==280)
            {
                todaylabel.text = [NSString stringWithFormat:@"宝宝%@天",huaiyuntianshu];
                beforelabel.text = [NSString stringWithFormat:@"宝宝%d天",[huaiyuntianshu integerValue]-2];
                beforelabel1.text = [NSString stringWithFormat:@"宝宝%d天",[huaiyuntianshu integerValue]-1];
                afterlabel.text = @"已出生";
                afterlabel1.text = @"已出生";
            }
            else
            {
                todaylabel.text = [NSString stringWithFormat:@"宝宝%@天",huaiyuntianshu];
                beforelabel.text = [NSString stringWithFormat:@"宝宝%d天",[huaiyuntianshu integerValue]-2];
                beforelabel1.text = [NSString stringWithFormat:@"宝宝%d天",[huaiyuntianshu integerValue]-1];
                afterlabel.text = [NSString stringWithFormat:@"宝宝%d天",[huaiyuntianshu integerValue]+1];
                afterlabel1.text = [NSString stringWithFormat:@"宝宝%d天",[huaiyuntianshu integerValue]+2];
            }
            
        }
        else
        {
            
            if(width+1==1)
            {
                todaylabel.text = [NSString stringWithFormat:@"宝宝%d天",width+1];
                beforelabel.text = @"未出生";
                beforelabel1.text = @"未出生";
                afterlabel.text = [NSString stringWithFormat:@"宝宝%d天",width+2];
                afterlabel1.text = [NSString stringWithFormat:@"宝宝%d天",width+3];
            }
            else if (width+1==2)
            {
                todaylabel.text = [NSString stringWithFormat:@"宝宝%d天",width+1];
                beforelabel.text = @"未出生";
                beforelabel1.text = [NSString stringWithFormat:@"宝宝%d天",width];
                afterlabel.text = [NSString stringWithFormat:@"宝宝%d天",width+2];
                afterlabel1.text = [NSString stringWithFormat:@"宝宝%d天",width+3];
            }
            else if (width+1==279)
            {
                todaylabel.text = [NSString stringWithFormat:@"宝宝%d天",width+1];
                beforelabel.text = [NSString stringWithFormat:@"宝宝%d天",width-1];
                beforelabel1.text = [NSString stringWithFormat:@"宝宝%d天",width];
                afterlabel.text = [NSString stringWithFormat:@"宝宝%d天",width+1];
                afterlabel1.text = @"已出生";
            }
            else if (width+1==280)
            {
                todaylabel.text = [NSString stringWithFormat:@"宝宝%d天",width+1];
                beforelabel.text = [NSString stringWithFormat:@"宝宝%d天",width-1];
                beforelabel1.text = [NSString stringWithFormat:@"宝宝%d天",width];
                afterlabel.text = @"已出生";
                afterlabel1.text = @"已出生";
            }
            else
            {
                todaylabel.text = [NSString stringWithFormat:@"宝宝%d天",width+1];
                beforelabel.text = [NSString stringWithFormat:@"宝宝%d天",width-1];
                beforelabel1.text = [NSString stringWithFormat:@"宝宝%d天",width];
                
                afterlabel.text = [NSString stringWithFormat:@"宝宝%d天",width+2];
                afterlabel1.text = [NSString stringWithFormat:@"宝宝%d天",width+3];
            }
            
            
        }
        
        self.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, titleView.frame.size.height-158)];
        self.titleScrollView.contentSize = CGSizeMake(ScreenWidth*279, 1);
        self.titleScrollView.userInteractionEnabled = YES;
        self.titleScrollView.pagingEnabled = YES;
        self.titleScrollView.showsHorizontalScrollIndicator = NO;
        self.titleScrollView.showsVerticalScrollIndicator = NO;
        self.titleScrollView.delegate = self;
        if (isfirst) {
            [self.titleScrollView setContentOffset:CGPointMake(([huaiyuntianshu integerValue]-1)*ScreenWidth, 0) animated:YES];
        }
        else
        {
            [self.titleScrollView setContentOffset:CGPointMake(width*ScreenWidth, 0) animated:YES];
        }
        //self.titleScrollView.scrollEnabled = NO;
        [titleView addSubview:self.titleScrollView];
        
        if (isfirst) {
            //            UIView *indexView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*([huaiyuntianshu integerValue]-1), 0, ScreenWidth, self.titleScrollView.frame.size.height)];
            //            indexView.tag = [huaiyuntianshu integerValue]-1;
            //            [self.titleScrollView addSubview:indexView];
            if ([huaiyuntianshu integerValue]>1&&[huaiyuntianshu integerValue]<280) {
                for (int i = 0; i<3; i++) {
                    UIButton *todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    todayBtn.frame = CGRectMake(28+ScreenWidth*([huaiyuntianshu integerValue]-i), 0, 35, 34);
                    [todayBtn setImage:[UIImage imageNamed:@"今"] forState:UIControlStateNormal];
                    [todayBtn addTarget:self action:@selector(clickTodayBtn) forControlEvents:UIControlEventTouchUpInside];
                    [self.titleScrollView addSubview:todayBtn];
                    
                    UIImageView *jingxiangImg = [[UIImageView alloc] initWithFrame:CGRectMake(28+ScreenWidth*([huaiyuntianshu integerValue]-i), 15, ScreenWidth-78, ScreenWidth-100)];
                    jingxiangImg.userInteractionEnabled = YES;
                    jingxiangImg.multipleTouchEnabled = YES;
                    jingxiangImg.image = [UIImage imageNamed:@"镜像"];
//                    jingxiangImg.backgroundColor = [UIColor redColor];
                    [self.titleScrollView addSubview:jingxiangImg];
                    
//                    UIButton *miyuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    miyuBtn.frame = CGRectMake((ScreenWidth-78)*0.12, 3, (ScreenWidth-78)*0.6, (ScreenWidth-100)*0.35);
//                    [miyuBtn setImage:[UIImage imageNamed:@"密语"] forState:UIControlStateNormal];
//                    miyuBtn.transform=CGAffineTransformMakeRotation(-M_PI/72);
//                    [jingxiangImg addSubview:miyuBtn];
//                    
//                    UILabel *miyulabel = [[UILabel alloc] initWithFrame:CGRectMake(miyuBtn.frame.size.width-75, (0.1*jingxiangImg.frame.size.width-12)/2, 55, 12)];
//                    miyulabel.text = @"宝妈密语";
//                    miyulabel.textColor = RGBA(53, 109, 181, 1);
//                    miyulabel.layer.cornerRadius = 6;
//                    miyulabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
//                    [miyuBtn addSubview:miyulabel];
                    
                    
                    UIButton *tizhongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    tizhongBtn.frame = CGRectMake(28,5, jingxiangImg.frame.size.width/2, jingxiangImg.frame.size.height-20);
                    tizhongBtn.transform=CGAffineTransformMakeRotation(-M_PI/28);
                    [tizhongBtn setImage:[UIImage imageNamed:@"体重2"] forState:UIControlStateNormal];
                    //[miyuBtn setTitle:@"宝马密语" forState:UIControlStateNormal];
                    [jingxiangImg addSubview:tizhongBtn];
                    
                    UILabel *tizhonglabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 55, 12, 32)];
                    tizhonglabel.text = @"体重";
                    tizhonglabel.textColor = RGBA(238, 128, 135, 1);
                    //tizhonglabel.layer.cornerRadius = 6;
                    tizhonglabel.textAlignment = NSTextAlignmentCenter;
                    tizhonglabel.lineBreakMode = NSLineBreakByCharWrapping;
                    tizhonglabel.numberOfLines = 0;
                    tizhonglabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
                    [tizhongBtn addSubview:tizhonglabel];
                    
                    UILabel *countlabel = [[UILabel alloc] initWithFrame:CGRectMake(7, tizhonglabel.frame.origin.y+tizhonglabel.frame.size.height, 20, 30)];
                    countlabel.text = [NSString stringWithFormat:@"%@kg",[[self.chengzhangArr objectAtIndex:0] objectForKey:@"tizhong"]];
                    countlabel.textColor = RGBA(238, 123, 135, 1);
                    //tizhonglabel.layer.cornerRadius = 6;
                    countlabel.textAlignment = NSTextAlignmentCenter;
                    countlabel.lineBreakMode = NSLineBreakByCharWrapping;
                    countlabel.numberOfLines = 0;
                    countlabel.transform=CGAffineTransformMakeRotation(-M_PI/36);
                    countlabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
                    [tizhongBtn addSubview:countlabel];
                    
//                    UIButton *chushengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    chushengBtn.frame = CGRectMake((ScreenWidth-78)*0.39, tizhongBtn.frame.origin.y+tizhongBtn.frame.size.height-(ScreenWidth-100)*0.373, (ScreenWidth-78)*0.6, (ScreenWidth-100)*0.35);
//                    //chushengBtn.transform=CGAffineTransformMakeRotation(-M_PI/28);
//                    [chushengBtn setImage:[UIImage imageNamed:@"已出生日期"] forState:UIControlStateNormal];
//                    //[miyuBtn setTitle:@"宝马密语" forState:UIControlStateNormal];
//                    [jingxiangImg addSubview:chushengBtn];
//                    
//                    tianshulabel = [[UILabel alloc] initWithFrame:CGRectMake(20,chushengBtn.frame.size.height-((0.1*jingxiangImg.frame.size.width-12)/2)-12, 100, 12)];
//                    tianshulabel.text = [NSString stringWithFormat:@"宝宝已经%d天",[huaiyuntianshu integerValue]+1-i];
//                    tianshulabel.textColor = RGBA(81, 135, 23, 1);
//                    //tianshulabel.layer.cornerRadius = 6;
//                    tianshulabel.transform=CGAffineTransformMakeRotation(-M_PI/72);
//                    tianshulabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
//                    [chushengBtn addSubview:tianshulabel];
                    
                    UIButton *shengaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    shengaoBtn.frame = CGRectMake(jingxiangImg.frame.size.width/2, 0, jingxiangImg.frame.size.width/2, jingxiangImg.frame.size.height-20);
                    shengaoBtn.transform=CGAffineTransformMakeRotation(M_PI/72);
                    [shengaoBtn setImage:[UIImage imageNamed:@"身高2"] forState:UIControlStateNormal];
                    //[miyuBtn setTitle:@"宝马密语" forState:UIControlStateNormal];
                    [jingxiangImg addSubview:shengaoBtn];
                    
                    UILabel *shengaolabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 65, 12, 32)];
                    shengaolabel.text = @"身高";
                    shengaolabel.textColor = RGBA(201, 160, 99, 1);
                    //tizhonglabel.layer.cornerRadius = 6;
                    shengaolabel.textAlignment = NSTextAlignmentCenter;
                    shengaolabel.lineBreakMode = NSLineBreakByCharWrapping;
                    shengaolabel.numberOfLines = 0;
                    shengaolabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
                    [shengaoBtn addSubview:shengaolabel];
                    
                    UILabel *shengaocount = [[UILabel alloc] initWithFrame:CGRectMake(shengaoBtn.frame.size.width-(0.1*jingxiangImg.frame.size.width-12)-20, shengaolabel.frame.origin.y+shengaolabel.frame.size.height, 20, 30)];
                    shengaocount.text = [NSString stringWithFormat:@"%@cm",[[self.chengzhangArr objectAtIndex:0] objectForKey:@"shengao"]];
                    shengaocount.textColor = RGBA(201, 160, 99, 1);
                    //tizhonglabel.layer.cornerRadius = 6;
                    shengaocount.textAlignment = NSTextAlignmentCenter;
                    shengaocount.lineBreakMode = NSLineBreakByCharWrapping;
                    shengaocount.numberOfLines = 0;
                    shengaocount.transform=CGAffineTransformMakeRotation(M_PI/36);
                    shengaocount.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
                    [shengaoBtn addSubview:shengaocount];
                    
                    UIImageView *touxiangImg = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-78)*0.21, (ScreenWidth-100)*0.1, (ScreenWidth-78)*0.68, (ScreenWidth-100)*0.71)];
                    touxiangImg.userInteractionEnabled = YES;
                    touxiangImg.multipleTouchEnabled = YES;
                    touxiangImg.image = [UIImage imageNamed:@"视频头像"];
                    [jingxiangImg addSubview:touxiangImg];
                    
                    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    playBtn.frame = CGRectMake(touxiangImg.frame.size.width*0.7/2.2, touxiangImg.frame.size.height*0.7/2, touxiangImg.frame.size.width*0.4, touxiangImg.frame.size.width*0.3);
                    [playBtn setImage:[UIImage imageNamed:@"拍摄"] forState:UIControlStateNormal];
                    [playBtn addTarget:self action:@selector(clickPlayBtn) forControlEvents:UIControlEventTouchUpInside];
                    [touxiangImg addSubview:playBtn];
                    
                    UILabel *babyJiLu = [[UILabel alloc]initWithFrame:CGRectMake(touxiangImg.frame.size.width*0.7/2.5, playBtn.frame.origin.y + playBtn.frame.size.height + 10, touxiangImg.frame.size.width*0.5, touxiangImg.frame.size.width*0.2)];
                    babyJiLu.textColor = [UIColor whiteColor];
                    babyJiLu.font = [UIFont systemFontOfSize:13];
                    babyJiLu.text = @"宝宝成长记录";
                    
                    [touxiangImg addSubview:babyJiLu];
                    
                    UIImageView *chushengImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*0.58/2+ScreenWidth*([huaiyuntianshu integerValue]-i), jingxiangImg.frame.origin.y+jingxiangImg.frame.size.height, ScreenWidth*0.42, 38)];
                    chushengImg.image = [UIImage imageNamed:@"出生背景"];
                    [self.titleScrollView addSubview:chushengImg];
                    
                    chushenglabel = [[UILabel alloc] initWithFrame:CGRectMake( chushengImg.frame.size.width*0.09, 0, chushengImg.frame.size.width, chushengImg.frame.size.height)];
                    chushenglabel.textAlignment = NSTextAlignmentCenter;
                    chushenglabel.textColor = [UIColor whiteColor];
                    chushenglabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:16];
                    chushenglabel.text = [NSString stringWithFormat:@"据出生%d天",280-[huaiyuntianshu integerValue]-1+i];
                    [chushengImg addSubview:chushenglabel];
                    
                    if (self.titleArr.count>2) {
                        [self.titleScrollView addSubview:[self.titleArr objectAtIndex:i]];
                    }
                    
                }
            }
            
            else
            {
                UIButton *todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                todayBtn.frame = CGRectMake(28+ScreenWidth*([huaiyuntianshu integerValue]-1), 0, 35, 34);
                [todayBtn setImage:[UIImage imageNamed:@"今"] forState:UIControlStateNormal];
                [todayBtn addTarget:self action:@selector(clickTodayBtn) forControlEvents:UIControlEventTouchUpInside];
                [self.titleScrollView addSubview:todayBtn];
                
                UIImageView *jingxiangImg = [[UIImageView alloc] initWithFrame:CGRectMake(28+ScreenWidth*([huaiyuntianshu integerValue]-1), 15, ScreenWidth-78, ScreenWidth-100)];
                jingxiangImg.userInteractionEnabled = YES;
                jingxiangImg.multipleTouchEnabled = YES;
                jingxiangImg.image = [UIImage imageNamed:@"镜像"];
                [self.titleScrollView addSubview:jingxiangImg];
                
//                UIButton *miyuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//                miyuBtn.frame = CGRectMake((ScreenWidth-78)*0.12, 3, (ScreenWidth-78)*0.6, (ScreenWidth-100)*0.35);
//                [miyuBtn setImage:[UIImage imageNamed:@"密语"] forState:UIControlStateNormal];
//                //[miyuBtn setTitle:@"宝马密语" forState:UIControlStateNormal];
//                miyuBtn.transform=CGAffineTransformMakeRotation(-M_PI/72);
//                [jingxiangImg addSubview:miyuBtn];
//                
//                UILabel *miyulabel = [[UILabel alloc] initWithFrame:CGRectMake(miyuBtn.frame.size.width-75, (0.1*jingxiangImg.frame.size.width-12)/2, 55, 12)];
//                miyulabel.text = @"宝妈密语";
//                miyulabel.textColor = RGBA(53, 109, 181, 1);
//                miyulabel.layer.cornerRadius = 6;
//                miyulabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
//                [miyuBtn addSubview:miyulabel];
//                
                
                UIButton *tizhongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                tizhongBtn.frame = CGRectMake(28,5, jingxiangImg.frame.size.width/2, jingxiangImg.frame.size.height-20);
                tizhongBtn.transform=CGAffineTransformMakeRotation(-M_PI/28);
                [tizhongBtn setImage:[UIImage imageNamed:@"体重"] forState:UIControlStateNormal];
                //[miyuBtn setTitle:@"宝马密语" forState:UIControlStateNormal];
                [jingxiangImg addSubview:tizhongBtn];
                
                UILabel *tizhonglabel = [[UILabel alloc] initWithFrame:CGRectMake(28, jingxiangImg.frame.size.height-10, 12, 32)];
                tizhonglabel.text = @"体重";
                tizhonglabel.textColor = RGBA(238, 128, 135, 1);
                //tizhonglabel.layer.cornerRadius = 6;
                tizhonglabel.textAlignment = NSTextAlignmentCenter;
                tizhonglabel.lineBreakMode = NSLineBreakByCharWrapping;
                tizhonglabel.numberOfLines = 0;
                tizhonglabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
                [tizhongBtn addSubview:tizhonglabel];
                
                UILabel *countlabel = [[UILabel alloc] initWithFrame:CGRectMake((0.1*jingxiangImg.frame.size.width-20)/2, tizhonglabel.frame.origin.y+tizhonglabel.frame.size.height, 20, 30)];
                countlabel.text = [NSString stringWithFormat:@"%@kg",[[self.chengzhangArr objectAtIndex:0] objectForKey:@"tizhong"]];
                countlabel.textColor = RGBA(238, 123, 135, 1);
                //tizhonglabel.layer.cornerRadius = 6;
                countlabel.textAlignment = NSTextAlignmentCenter;
                countlabel.lineBreakMode = NSLineBreakByCharWrapping;
                countlabel.numberOfLines = 0;
                countlabel.transform=CGAffineTransformMakeRotation(-M_PI/36);
                countlabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
                [tizhongBtn addSubview:countlabel];
                
//                UIButton *chushengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//                chushengBtn.frame = CGRectMake((ScreenWidth-78)*0.39, tizhongBtn.frame.origin.y+tizhongBtn.frame.size.height-(ScreenWidth-100)*0.373, (ScreenWidth-78)*0.6, (ScreenWidth-100)*0.35);
//                //chushengBtn.transform=CGAffineTransformMakeRotation(-M_PI/28);
//                [chushengBtn setImage:[UIImage imageNamed:@"已出生日期"] forState:UIControlStateNormal];
//                //[miyuBtn setTitle:@"宝马密语" forState:UIControlStateNormal];
//                [jingxiangImg addSubview:chushengBtn];
//                
//                tianshulabel = [[UILabel alloc] initWithFrame:CGRectMake(20,chushengBtn.frame.size.height-((0.1*jingxiangImg.frame.size.width-12)/2)-12, 100, 12)];
//                tianshulabel.text = [NSString stringWithFormat:@"宝宝已经%d天",[huaiyuntianshu integerValue]];
//                tianshulabel.textColor = RGBA(81, 135, 23, 1);
//                //tianshulabel.layer.cornerRadius = 6;
//                tianshulabel.transform=CGAffineTransformMakeRotation(-M_PI/72);
//                tianshulabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
//                [chushengBtn addSubview:tianshulabel];
                
                UIButton *shengaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                shengaoBtn.frame = CGRectMake(jingxiangImg.frame.size.width/2, 0, jingxiangImg.frame.size.width/2, jingxiangImg.frame.size.height-20);
                shengaoBtn.transform=CGAffineTransformMakeRotation(M_PI/72);
                [shengaoBtn setImage:[UIImage imageNamed:@"身高"] forState:UIControlStateNormal];
                //[miyuBtn setTitle:@"宝马密语" forState:UIControlStateNormal];
                [jingxiangImg addSubview:shengaoBtn];
                
                UILabel *shengaolabel = [[UILabel alloc] initWithFrame:CGRectMake(shengaoBtn.frame.size.width-(0.1*jingxiangImg.frame.size.width-12)-12, shengaoBtn.frame.size.height-80, 12, 32)];
                shengaolabel.text = @"身高";
                shengaolabel.textColor = RGBA(201, 160, 99, 1);
                //tizhonglabel.layer.cornerRadius = 6;
                shengaolabel.textAlignment = NSTextAlignmentCenter;
                shengaolabel.lineBreakMode = NSLineBreakByCharWrapping;
                shengaolabel.numberOfLines = 0;
                shengaolabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
                [shengaoBtn addSubview:shengaolabel];
                
                UILabel *shengaocount = [[UILabel alloc] initWithFrame:CGRectMake(shengaoBtn.frame.size.width-(0.1*jingxiangImg.frame.size.width-12)-20, shengaolabel.frame.origin.y+shengaolabel.frame.size.height, 20, 30)];
                shengaocount.text = [NSString stringWithFormat:@"%@cm",[[self.chengzhangArr objectAtIndex:0] objectForKey:@"shengao"]];
                shengaocount.textColor = RGBA(201, 160, 99, 1);
                //tizhonglabel.layer.cornerRadius = 6;
                shengaocount.textAlignment = NSTextAlignmentCenter;
                shengaocount.lineBreakMode = NSLineBreakByCharWrapping;
                shengaocount.numberOfLines = 0;
                shengaocount.transform=CGAffineTransformMakeRotation(M_PI/36);
                shengaocount.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
                [shengaoBtn addSubview:shengaocount];
                
                UIImageView *touxiangImg = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-78)*0.21, (ScreenWidth-100)*0.1, (ScreenWidth-78)*0.68, (ScreenWidth-100)*0.71)];
                touxiangImg.userInteractionEnabled = YES;
                touxiangImg.multipleTouchEnabled = YES;
                touxiangImg.image = [UIImage imageNamed:@"视频头像"];
                [jingxiangImg addSubview:touxiangImg];
                
                UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                playBtn.frame = CGRectMake(touxiangImg.frame.size.width*0.7/2, touxiangImg.frame.size.height*0.7/2, touxiangImg.frame.size.width*0.3, touxiangImg.frame.size.width*0.3);
                [playBtn setImage:[UIImage imageNamed:@"拍摄"] forState:UIControlStateNormal];
                [playBtn addTarget:self action:@selector(clickPlayBtn) forControlEvents:UIControlEventTouchUpInside];
                [touxiangImg addSubview:playBtn];
                
                UIImageView *chushengImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*0.58/2+ScreenWidth*([huaiyuntianshu integerValue]-1), jingxiangImg.frame.origin.y+jingxiangImg.frame.size.height, ScreenWidth*0.42, 38)];
                chushengImg.image = [UIImage imageNamed:@"出生背景"];
                [self.titleScrollView addSubview:chushengImg];
                
                chushenglabel = [[UILabel alloc] initWithFrame:CGRectMake( chushengImg.frame.size.width*0.09, 0, chushengImg.frame.size.width, chushengImg.frame.size.height)];
                chushenglabel.textAlignment = NSTextAlignmentCenter;
                chushenglabel.textColor = [UIColor whiteColor];
                chushenglabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:16];
                chushenglabel.text = [NSString stringWithFormat:@"据出生%d天",280-[huaiyuntianshu integerValue]];
                [chushengImg addSubview:chushenglabel];
                
                [self.titleScrollView addSubview:textlabel];
            }
            
        }
        
        else
        {
            //            UIView *indexView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth*width, 0, ScreenWidth, self.titleScrollView.frame.size.height)];
            //            indexView.tag = width;
            //            [self.titleScrollView addSubview:indexView];
            if (width+1>1&&width+1<280)
            {
                for (int i = 0; i<3; i++) {
                    UIButton *todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    todayBtn.frame = CGRectMake(28+ScreenWidth*(width+1-i), 0, 35, 34);
                    [todayBtn setImage:[UIImage imageNamed:@"今"] forState:UIControlStateNormal];
                    [todayBtn addTarget:self action:@selector(clickTodayBtn) forControlEvents:UIControlEventTouchUpInside];
                    [self.titleScrollView addSubview:todayBtn];
                    
                    UIImageView *jingxiangImg = [[UIImageView alloc] initWithFrame:CGRectMake(28+ScreenWidth*(width+1-i), 15, ScreenWidth-78, ScreenWidth-100)];
                    jingxiangImg.userInteractionEnabled = YES;
                    jingxiangImg.multipleTouchEnabled = YES;
                    jingxiangImg.image = [UIImage imageNamed:@"镜像"];
                    [self.titleScrollView addSubview:jingxiangImg];
                    
                    UIButton *miyuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    miyuBtn.frame = CGRectMake((ScreenWidth-78)*0.12, 3, (ScreenWidth-78)*0.6, (ScreenWidth-100)*0.35);
                    [miyuBtn setImage:[UIImage imageNamed:@"密语"] forState:UIControlStateNormal];
                    //[miyuBtn setTitle:@"宝马密语" forState:UIControlStateNormal];
                    miyuBtn.transform=CGAffineTransformMakeRotation(-M_PI/72);
                    [jingxiangImg addSubview:miyuBtn];
                    
                    UILabel *miyulabel = [[UILabel alloc] initWithFrame:CGRectMake(miyuBtn.frame.size.width-75, (0.1*jingxiangImg.frame.size.width-12)/2, 55, 12)];
                    miyulabel.text = @"宝妈密语";
                    miyulabel.textColor = RGBA(53, 109, 181, 1);
                    miyulabel.layer.cornerRadius = 6;
                    miyulabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
                    [miyuBtn addSubview:miyulabel];
                    
                    
                    UIButton *tizhongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    tizhongBtn.frame = CGRectMake((ScreenWidth-78)*0.13, miyuBtn.frame.size.height-15, (ScreenWidth-78)*0.35, (ScreenWidth-100)*0.6);
                    tizhongBtn.transform=CGAffineTransformMakeRotation(-M_PI/28);
                    [tizhongBtn setImage:[UIImage imageNamed:@"体重"] forState:UIControlStateNormal];
                    //[miyuBtn setTitle:@"宝马密语" forState:UIControlStateNormal];
                    [jingxiangImg addSubview:tizhongBtn];
                    
                    UILabel *tizhonglabel = [[UILabel alloc] initWithFrame:CGRectMake((0.1*jingxiangImg.frame.size.width-12)/2, 20, 12, 32)];
                    tizhonglabel.text = @"体重";
                    tizhonglabel.textColor = RGBA(238, 128, 135, 1);
                    //tizhonglabel.layer.cornerRadius = 6;
                    tizhonglabel.textAlignment = NSTextAlignmentCenter;
                    tizhonglabel.lineBreakMode = NSLineBreakByCharWrapping;
                    tizhonglabel.numberOfLines = 0;
                    tizhonglabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
                    [tizhongBtn addSubview:tizhonglabel];
                    
                    UILabel *countlabel = [[UILabel alloc] initWithFrame:CGRectMake((0.1*jingxiangImg.frame.size.width-20)/2, tizhonglabel.frame.origin.y+tizhonglabel.frame.size.height, 20, 30)];
                    countlabel.text = [NSString stringWithFormat:@"%@kg",[[self.chengzhangArr objectAtIndex:0] objectForKey:@"tizhong"]];
                    countlabel.textColor = RGBA(238, 123, 135, 1);
                    //tizhonglabel.layer.cornerRadius = 6;
                    countlabel.textAlignment = NSTextAlignmentCenter;
                    countlabel.lineBreakMode = NSLineBreakByCharWrapping;
                    countlabel.numberOfLines = 0;
                    countlabel.transform=CGAffineTransformMakeRotation(-M_PI/36);
                    countlabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
                    [tizhongBtn addSubview:countlabel];
                    
                    UIButton *chushengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    chushengBtn.frame = CGRectMake((ScreenWidth-78)*0.39, tizhongBtn.frame.origin.y+tizhongBtn.frame.size.height-(ScreenWidth-100)*0.373, (ScreenWidth-78)*0.6, (ScreenWidth-100)*0.35);
                    //chushengBtn.transform=CGAffineTransformMakeRotation(-M_PI/28);
                    [chushengBtn setImage:[UIImage imageNamed:@"已出生日期"] forState:UIControlStateNormal];
                    //[miyuBtn setTitle:@"宝马密语" forState:UIControlStateNormal];
                    [jingxiangImg addSubview:chushengBtn];
                    
                    tianshulabel = [[UILabel alloc] initWithFrame:CGRectMake(20,chushengBtn.frame.size.height-((0.1*jingxiangImg.frame.size.width-12)/2)-12, 100, 12)];
                    tianshulabel.text = [NSString stringWithFormat:@"宝宝已经%d天",width+2-i];
                    tianshulabel.textColor = RGBA(81, 135, 23, 1);
                    //tianshulabel.layer.cornerRadius = 6;
                    tianshulabel.transform=CGAffineTransformMakeRotation(-M_PI/72);
                    tianshulabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
                    [chushengBtn addSubview:tianshulabel];
                    
                    UIButton *shengaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    shengaoBtn.frame = CGRectMake(miyuBtn.frame.origin.x+miyuBtn.frame.size.width-(ScreenWidth-78)*0.08, 0, (ScreenWidth-78)*0.35, (ScreenWidth-100)*0.7);
                    shengaoBtn.transform=CGAffineTransformMakeRotation(M_PI/72);
                    [shengaoBtn setImage:[UIImage imageNamed:@"身高"] forState:UIControlStateNormal];
                    //[miyuBtn setTitle:@"宝马密语" forState:UIControlStateNormal];
                    [jingxiangImg addSubview:shengaoBtn];
                    
                    UILabel *shengaolabel = [[UILabel alloc] initWithFrame:CGRectMake(shengaoBtn.frame.size.width-(0.1*jingxiangImg.frame.size.width-12)-12, shengaoBtn.frame.size.height-80, 12, 32)];
                    shengaolabel.text = @"身高";
                    shengaolabel.textColor = RGBA(201, 160, 99, 1);
                    //tizhonglabel.layer.cornerRadius = 6;
                    shengaolabel.textAlignment = NSTextAlignmentCenter;
                    shengaolabel.lineBreakMode = NSLineBreakByCharWrapping;
                    shengaolabel.numberOfLines = 0;
                    shengaolabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
                    [shengaoBtn addSubview:shengaolabel];
                    
                    UILabel *shengaocount = [[UILabel alloc] initWithFrame:CGRectMake(shengaoBtn.frame.size.width-(0.1*jingxiangImg.frame.size.width-12)-20, shengaolabel.frame.origin.y+shengaolabel.frame.size.height, 20, 30)];
                    shengaocount.text = [NSString stringWithFormat:@"%@cm",[[self.chengzhangArr objectAtIndex:0] objectForKey:@"shengao"]];
                    shengaocount.textColor = RGBA(201, 160, 99, 1);
                    //tizhonglabel.layer.cornerRadius = 6;
                    shengaocount.textAlignment = NSTextAlignmentCenter;
                    shengaocount.lineBreakMode = NSLineBreakByCharWrapping;
                    shengaocount.numberOfLines = 0;
                    shengaocount.transform=CGAffineTransformMakeRotation(M_PI/36);
                    shengaocount.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
                    [shengaoBtn addSubview:shengaocount];
                    
                    UIImageView *touxiangImg = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-78)*0.21, (ScreenWidth-100)*0.1, (ScreenWidth-78)*0.68, (ScreenWidth-100)*0.71)];
                    touxiangImg.userInteractionEnabled = YES;
                    touxiangImg.multipleTouchEnabled = YES;
                    touxiangImg.image = [UIImage imageNamed:@"视频头像"];
                    [jingxiangImg addSubview:touxiangImg];
                    
                    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    playBtn.frame = CGRectMake(touxiangImg.frame.size.width*0.7/2, touxiangImg.frame.size.height*0.7/2, touxiangImg.frame.size.width*0.3, touxiangImg.frame.size.width*0.3);
                    [playBtn setImage:[UIImage imageNamed:@"拍摄"] forState:UIControlStateNormal];
                    [playBtn addTarget:self action:@selector(clickPlayBtn) forControlEvents:UIControlEventTouchUpInside];
                    [touxiangImg addSubview:playBtn];
                    
                    
                    UILabel *babyJiLu = [[UILabel alloc]initWithFrame:CGRectMake(touxiangImg.frame.size.width*0.7/2.5, playBtn.frame.origin.y + playBtn.frame.size.height + 10, touxiangImg.frame.size.width*0.5, touxiangImg.frame.size.width*0.2)];
                    babyJiLu.textColor = [UIColor whiteColor];
                    babyJiLu.font = [UIFont systemFontOfSize:13];
                    babyJiLu.text = @"宝宝成长记录";
                    
                    [touxiangImg addSubview:babyJiLu];
                    
                    
                    UIImageView *chushengImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*0.58/2+ScreenWidth*(width+1-i), jingxiangImg.frame.origin.y+jingxiangImg.frame.size.height, ScreenWidth*0.42, 38)];
                    chushengImg.image = [UIImage imageNamed:@"出生背景"];
                    [self.titleScrollView addSubview:chushengImg];
                    
                    chushenglabel = [[UILabel alloc] initWithFrame:CGRectMake( chushengImg.frame.size.width*0.09, 0, chushengImg.frame.size.width, chushengImg.frame.size.height)];
                    chushenglabel.textAlignment = NSTextAlignmentCenter;
                    chushenglabel.textColor = [UIColor whiteColor];
                    chushenglabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:16];
                    chushenglabel.text = [NSString stringWithFormat:@"据出生%d天",280-width-2+i];
                    [chushengImg addSubview:chushenglabel];
                    
                    if (self.titleArr.count>2) {
                        [self.titleScrollView addSubview:[self.titleArr objectAtIndex:i]];
                    }
                }
            }
            
            else
            {
                UIButton *todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                todayBtn.frame = CGRectMake(28+ScreenWidth*width, 0, 35, 34);
                [todayBtn setImage:[UIImage imageNamed:@"今"] forState:UIControlStateNormal];
                [todayBtn addTarget:self action:@selector(clickTodayBtn) forControlEvents:UIControlEventTouchUpInside];
                [self.titleScrollView addSubview:todayBtn];
                
                UIImageView *jingxiangImg = [[UIImageView alloc] initWithFrame:CGRectMake(28+ScreenWidth*width, 15, ScreenWidth-78, ScreenWidth-100)];
                jingxiangImg.userInteractionEnabled = YES;
                jingxiangImg.multipleTouchEnabled = YES;
                jingxiangImg.image = [UIImage imageNamed:@"镜像"];
                [self.titleScrollView addSubview:jingxiangImg];
                
                UIButton *miyuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                miyuBtn.frame = CGRectMake((ScreenWidth-78)*0.12, 3, (ScreenWidth-78)*0.6, (ScreenWidth-100)*0.35);
                [miyuBtn setImage:[UIImage imageNamed:@"密语"] forState:UIControlStateNormal];
                //[miyuBtn setTitle:@"宝马密语" forState:UIControlStateNormal];
                miyuBtn.transform=CGAffineTransformMakeRotation(-M_PI/72);
                [jingxiangImg addSubview:miyuBtn];
                
                UILabel *miyulabel = [[UILabel alloc] initWithFrame:CGRectMake(miyuBtn.frame.size.width-75, (0.1*jingxiangImg.frame.size.width-12)/2, 55, 12)];
                miyulabel.text = @"宝妈密语";
                miyulabel.textColor = RGBA(53, 109, 181, 1);
                miyulabel.layer.cornerRadius = 6;
                miyulabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
                [miyuBtn addSubview:miyulabel];
                
                
                UIButton *tizhongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                tizhongBtn.frame = CGRectMake((ScreenWidth-78)*0.13, miyuBtn.frame.size.height-15, (ScreenWidth-78)*0.35, (ScreenWidth-100)*0.6);
                tizhongBtn.transform=CGAffineTransformMakeRotation(-M_PI/28);
                [tizhongBtn setImage:[UIImage imageNamed:@"体重"] forState:UIControlStateNormal];
                //[miyuBtn setTitle:@"宝马密语" forState:UIControlStateNormal];
                [jingxiangImg addSubview:tizhongBtn];
                
                UILabel *tizhonglabel = [[UILabel alloc] initWithFrame:CGRectMake((0.1*jingxiangImg.frame.size.width-12)/2, 20, 12, 32)];
                tizhonglabel.text = @"体重";
                tizhonglabel.textColor = RGBA(238, 128, 135, 1);
                //tizhonglabel.layer.cornerRadius = 6;
                tizhonglabel.textAlignment = NSTextAlignmentCenter;
                tizhonglabel.lineBreakMode = NSLineBreakByCharWrapping;
                tizhonglabel.numberOfLines = 0;
                tizhonglabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
                [tizhongBtn addSubview:tizhonglabel];
                
                UILabel *countlabel = [[UILabel alloc] initWithFrame:CGRectMake((0.1*jingxiangImg.frame.size.width-20)/2, tizhonglabel.frame.origin.y+tizhonglabel.frame.size.height, 20, 30)];
                countlabel.text = [NSString stringWithFormat:@"%@kg",[[self.chengzhangArr objectAtIndex:0] objectForKey:@"tizhong"]];
                countlabel.textColor = RGBA(238, 123, 135, 1);
                //tizhonglabel.layer.cornerRadius = 6;
                countlabel.textAlignment = NSTextAlignmentCenter;
                countlabel.lineBreakMode = NSLineBreakByCharWrapping;
                countlabel.numberOfLines = 0;
                countlabel.transform=CGAffineTransformMakeRotation(-M_PI/36);
                countlabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
                [tizhongBtn addSubview:countlabel];
                
                UIButton *chushengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                chushengBtn.frame = CGRectMake((ScreenWidth-78)*0.39, tizhongBtn.frame.origin.y+tizhongBtn.frame.size.height-(ScreenWidth-100)*0.373, (ScreenWidth-78)*0.6, (ScreenWidth-100)*0.35);
                //chushengBtn.transform=CGAffineTransformMakeRotation(-M_PI/28);
                [chushengBtn setImage:[UIImage imageNamed:@"已出生日期"] forState:UIControlStateNormal];
                //[miyuBtn setTitle:@"宝马密语" forState:UIControlStateNormal];
                [jingxiangImg addSubview:chushengBtn];
                
                tianshulabel = [[UILabel alloc] initWithFrame:CGRectMake(20,chushengBtn.frame.size.height-((0.1*jingxiangImg.frame.size.width-12)/2)-12, 100, 12)];
                tianshulabel.text = [NSString stringWithFormat:@"宝宝已经%d天",width+1];
                tianshulabel.textColor = RGBA(81, 135, 23, 1);
                //tianshulabel.layer.cornerRadius = 6;
                tianshulabel.transform=CGAffineTransformMakeRotation(-M_PI/72);
                tianshulabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
                [chushengBtn addSubview:tianshulabel];
                
                UIButton *shengaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                shengaoBtn.frame = CGRectMake(miyuBtn.frame.origin.x+miyuBtn.frame.size.width-(ScreenWidth-78)*0.08, 0, (ScreenWidth-78)*0.35, (ScreenWidth-100)*0.7);
                shengaoBtn.transform=CGAffineTransformMakeRotation(M_PI/72);
                [shengaoBtn setImage:[UIImage imageNamed:@"身高"] forState:UIControlStateNormal];
                //[miyuBtn setTitle:@"宝马密语" forState:UIControlStateNormal];
                [jingxiangImg addSubview:shengaoBtn];
                
                UILabel *shengaolabel = [[UILabel alloc] initWithFrame:CGRectMake(shengaoBtn.frame.size.width-(0.1*jingxiangImg.frame.size.width-12)-12, shengaoBtn.frame.size.height-80, 12, 32)];
                shengaolabel.text = @"身高";
                shengaolabel.textColor = RGBA(201, 160, 99, 1);
                //tizhonglabel.layer.cornerRadius = 6;
                shengaolabel.textAlignment = NSTextAlignmentCenter;
                shengaolabel.lineBreakMode = NSLineBreakByCharWrapping;
                shengaolabel.numberOfLines = 0;
                shengaolabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
                [shengaoBtn addSubview:shengaolabel];
                
                UILabel *shengaocount = [[UILabel alloc] initWithFrame:CGRectMake(shengaoBtn.frame.size.width-(0.1*jingxiangImg.frame.size.width-12)-20, shengaolabel.frame.origin.y+shengaolabel.frame.size.height, 20, 30)];
                shengaocount.text = [NSString stringWithFormat:@"%@cm",[[self.chengzhangArr objectAtIndex:0] objectForKey:@"shengao"]];
                shengaocount.textColor = RGBA(201, 160, 99, 1);
                //tizhonglabel.layer.cornerRadius = 6;
                shengaocount.textAlignment = NSTextAlignmentCenter;
                shengaocount.lineBreakMode = NSLineBreakByCharWrapping;
                shengaocount.numberOfLines = 0;
                shengaocount.transform=CGAffineTransformMakeRotation(M_PI/36);
                shengaocount.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
                [shengaoBtn addSubview:shengaocount];
                
                UIImageView *touxiangImg = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-78)*0.21, (ScreenWidth-100)*0.1, (ScreenWidth-78)*0.68, (ScreenWidth-100)*0.71)];
                touxiangImg.userInteractionEnabled = YES;
                touxiangImg.multipleTouchEnabled = YES;
                touxiangImg.image = [UIImage imageNamed:@"视频头像"];
                [jingxiangImg addSubview:touxiangImg];
                
                UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                playBtn.frame = CGRectMake(touxiangImg.frame.size.width*0.7/2, touxiangImg.frame.size.height*0.7/2, touxiangImg.frame.size.width*0.3, touxiangImg.frame.size.width*0.3);
                [playBtn setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
                [playBtn addTarget:self action:@selector(clickPlayBtn) forControlEvents:UIControlEventTouchUpInside];
                [touxiangImg addSubview:playBtn];
                
                UIImageView *chushengImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*0.58/2+ScreenWidth*width, jingxiangImg.frame.origin.y+jingxiangImg.frame.size.height, ScreenWidth*0.42, 38)];
                chushengImg.image = [UIImage imageNamed:@"出生背景"];
                [self.titleScrollView addSubview:chushengImg];
                
                chushenglabel = [[UILabel alloc] initWithFrame:CGRectMake( chushengImg.frame.size.width*0.09, 0, chushengImg.frame.size.width, chushengImg.frame.size.height)];
                chushenglabel.textAlignment = NSTextAlignmentCenter;
                chushenglabel.textColor = [UIColor whiteColor];
                chushenglabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:16];
                chushenglabel.text = [NSString stringWithFormat:@"据出生%d天",280-width-1];
                [chushengImg addSubview:chushenglabel];
                
                [self.titleScrollView addSubview:textlabel];
            }
        }
        
        
        UIImageView *tixingImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, imgView.frame.size.height+15, 33, 33)];
        tixingImg.image = [UIImage imageNamed:[self.imgArr objectAtIndex:section]];
        [titleView addSubview:tixingImg];
        
        UILabel *tixinglabel = [[UILabel alloc] initWithFrame:CGRectMake(tixingImg.frame.origin.x+tixingImg.frame.size.width+12, imgView.frame.size.height+15, ScreenWidth-(tixingImg.frame.origin.x+tixingImg.frame.size.width+42), 15)];
        tixinglabel.textColor = RGBA(238, 128, 135, 1);
        tixinglabel.text = [self.tableArr objectAtIndex:section];
        tixinglabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:15];
        [titleView addSubview:tixinglabel];
        
        UILabel *tixingText = [[UILabel alloc] initWithFrame:CGRectMake(tixingImg.frame.origin.x+tixingImg.frame.size.width+12, tixinglabel.frame.origin.y+tixinglabel.frame.size.height+5, ScreenWidth-(tixingImg.frame.origin.x+tixingImg.frame.size.width+42), 8)];
        tixingText.textColor = RGBA(89, 87, 87, 1);
        tixingText.text = [self.textArr objectAtIndex:section];
        tixingText.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:8];
        [titleView addSubview:tixingText];
        
        UIButton *jinruBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        jinruBtn.frame = CGRectMake(ScreenWidth-26, imgView.frame.size.height+21, 10, 18);
        [jinruBtn setImage:[UIImage imageNamed:@"进入"] forState:UIControlStateNormal];
        [jinruBtn addTarget:self action:@selector(clickJinruBtn) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:jinruBtn];
        
        return titleView;
    }
    else if(section == 2)
    {
        UIView *biaotouView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 133)];
        biaotouView.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *singleTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
        [biaotouView addGestureRecognizer:singleTouch];
        
        UIImageView *biaotouImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 77)];
        biaotouImg.image = [UIImage imageNamed:@"表头"];
        biaotouImg.userInteractionEnabled = YES;
        biaotouImg.multipleTouchEnabled = YES;
        [biaotouView addSubview:biaotouImg];
        
        UIButton *maotouBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        maotouBtn.frame = CGRectMake(20, 12, 56, 56);
        [maotouBtn setImage:[UIImage imageNamed:@"猫头"] forState:UIControlStateNormal];
        [maotouBtn addTarget:self action:@selector(clickmaotouBtn) forControlEvents:UIControlEventTouchUpInside];
        [biaotouImg addSubview:maotouBtn];
        
        UIButton *jiangbeiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        jiangbeiBtn.frame = CGRectMake(maotouBtn.frame.origin.x+maotouBtn.frame.size.width+(ScreenWidth-264)/3, 12, 56, 56);
        [jiangbeiBtn setImage:[UIImage imageNamed:@"奖杯"] forState:UIControlStateNormal];
        [jiangbeiBtn addTarget:self action:@selector(clickjiangbeiBtn) forControlEvents:UIControlEventTouchUpInside];
        [biaotouImg addSubview:jiangbeiBtn];
        
        UIButton *downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        downloadBtn.frame = CGRectMake(jiangbeiBtn.frame.origin.x+jiangbeiBtn.frame.size.width+(ScreenWidth-264)/3, 12, 56, 56);
        [downloadBtn setImage:[UIImage imageNamed:@"下载"] forState:UIControlStateNormal];
        [downloadBtn addTarget:self action:@selector(clickdownloadBtn) forControlEvents:UIControlEventTouchUpInside];
        [biaotouImg addSubview:downloadBtn];
        
        UIButton *yusanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        yusanBtn.frame = CGRectMake(ScreenWidth-76, 12, 56, 56);
        [yusanBtn setImage:[UIImage imageNamed:@"雨伞"] forState:UIControlStateNormal];
        [yusanBtn addTarget:self action:@selector(clickyusanBtn) forControlEvents:UIControlEventTouchUpInside];
        [biaotouImg addSubview:yusanBtn];
        
        UIImageView *titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, biaotouImg.frame.size.height+15, 33, 33)];
        titleImg.image = [UIImage imageNamed:[self.imgArr objectAtIndex:section]];
        [biaotouView addSubview:titleImg];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleImg.frame.origin.x+titleImg.frame.size.width+12, biaotouImg.frame.size.height+15, ScreenWidth-(titleImg.frame.origin.x+titleImg.frame.size.width+42), 15)];
        titleLabel.textColor = RGBA(238, 128, 135, 1);
        titleLabel.text = [self.tableArr objectAtIndex:section];
        titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:15];
        [biaotouView addSubview:titleLabel];
        
        UILabel *titletext = [[UILabel alloc] initWithFrame:CGRectMake(titleImg.frame.origin.x+titleImg.frame.size.width+12, titleLabel.frame.origin.y+titleLabel.frame.size.height+5, ScreenWidth-(titleImg.frame.origin.x+titleImg.frame.size.width+42), 8)];
        titletext.textColor = RGBA(89, 87, 87, 1);
        titletext.text = [self.textArr objectAtIndex:section];
        titletext.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:8];
        [biaotouView addSubview:titletext];
        
        return biaotouView;
        
    }
    else
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 58)];
        headerView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *singleTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
        [headerView addGestureRecognizer:singleTouch];
        
        UIImageView *titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 33, 33)];
        titleImg.image = [UIImage imageNamed:[self.imgArr objectAtIndex:section]];
        [headerView addSubview:titleImg];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleImg.frame.origin.x+titleImg.frame.size.width+12, 15, ScreenWidth-(titleImg.frame.origin.x+titleImg.frame.size.width+42), 15)];
        titleLabel.textColor = RGBA(238, 128, 135, 1);
        titleLabel.text = [self.tableArr objectAtIndex:section];
        titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:15];
        [headerView addSubview:titleLabel];
        
        UILabel *titletext = [[UILabel alloc] initWithFrame:CGRectMake(titleImg.frame.origin.x+titleImg.frame.size.width+12, titleLabel.frame.origin.y+titleLabel.frame.size.height+5, ScreenWidth-(titleImg.frame.origin.x+titleImg.frame.size.width+42), 8)];
        titletext.textColor = RGBA(89, 87, 87, 1);
        titletext.text = [self.textArr objectAtIndex:section];
        titletext.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:8];
        [headerView addSubview:titletext];
        if (section == 1) {
            self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(ScreenWidth-117,21, 106, 25)];
            self.searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            //self.searchBar.layer.borderWidth = 1.5;
            //self.searchBar.layer.masksToBounds = YES;
            //self.searchBar.layer.cornerRadius = 10;
            self.searchBar.delegate = self;
            self.searchBar.placeholder = @"能不能吃...";
            self.searchBar.layer.borderColor = [UIColor clearColor].CGColor;
            self.searchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:self.searchBar.bounds.size];
            [self.searchBar setImage:[UIImage imageNamed:@"放大镜2"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
            [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"搜索3@2x"] forState:UIControlStateNormal];
            [self setSearchBarTextfiled:self.searchBar];
            self.searchBar.showsScopeBar = YES;
            [headerView addSubview:self.searchBar];
        }
        
        return headerView;
    }
}

//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    //    color = RGBA(235, 235, 235, 1);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(void)clickPlayBtn
{
    
}

-(void)clickJinruBtn
{
    
}

-(void)clickmaotouBtn
{
    
}

-(void)clickjiangbeiBtn
{
    
}

-(void)clickdownloadBtn
{
    
}

-(void)clickyusanBtn
{
    
}

- (void)setSearchBarTextfiled:(UISearchBar *)searchBar{
    for (UIView *view in searchBar.subviews){
        for (id subview in view.subviews){
            if ( [subview isKindOfClass:[UITextField class]] ){
                [(UITextField *)subview setTintColor:RGBA(137, 137, 137, 1)];
                [(UITextField *)subview setFont:[UIFont fontWithName:@"Microsoft Yahei UI" size:10]];
                return;
            }
        }
    }
}



//# pragma mark - LTInfiniteScrollView delegate

float lastContentOffset;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.titleScrollView) {
        lastContentOffset = scrollView.contentOffset.x;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.titleScrollView) {
        isfirst = NO;
        width = self.titleScrollView.contentOffset.x/ScreenWidth;
        [self addchengzhangjilu:width+1];
        [self addmeiriTingxing:[NSString stringWithFormat:@"%d",width+1]];
        [self addTuijianzhishi:[NSString stringWithFormat:@"%d",width+1]];
        [self addMeizhoubibei:[NSString stringWithFormat:@"%d",width+1]];
        
        //[self.scrollView setContentOffset:CGPointMake((width-2)*ScreenWidth/5, 0) animated:YES];
        
        if (lastContentOffset < scrollView.contentOffset.x)
        {
            
        }
        else
        {
            NSLog(@"向右滑动");
        }
    }
    
    
    
    //[self.tableView reloadData];
}

//- (CGPoint)contentOffsetForIndex:(NSInteger)index
//{
//    CGFloat x = ScreenWidth/5*279 / 2 + index*ScreenWidth/5 - CGRectGetWidth(self.view.bounds) / 2;
//    return CGPointMake(x, 0);
//}

-(void)clickTodayBtn
{
    isfirst = YES;
    //self.scrollView.scrollView.contentOffset = CGPointMake( ScreenWidth/5*280/ 2-CGRectGetWidth(self.view.bounds) / 2, 0);
    //[self.scrollView reloadData];
    [self addchengzhangjilu:[huaiyuntianshu integerValue]];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 20)];
    //    text = [[UITextField alloc] initWithFrame:CGRectMake(5, 10, ScreenWidth-30, 20)];
    //    //label.borderStyle = UITextBorderStyleRoundedRect;
    //    text.placeholder = @"各位美妈们输入文字编辑“今日随手记”哦！";
    //    text.font = [UIFont fontWithName:nil size:12];
    //    text.delegate = self;
    //    [footerView addSubview:text];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(10, 5, 12, 12);
    [sendBtn setImage:[UIImage imageNamed:@"意见反馈"] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendBtn) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:sendBtn];
    
    UILabel *yijianLabel = [[UILabel alloc] initWithFrame:CGRectMake(sendBtn.frame.origin.x+sendBtn.frame.size.width+5, 8, 100, 9)];
    yijianLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    yijianLabel.textColor = RGBA(89, 87, 87, 1);
    yijianLabel.text = @"意见反馈";
    [footerView addSubview:yijianLabel];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    if (section == 4) {
        return footerView;
    }
    
    else
    {
        return view;
    }
    
    
    
    
}

-(void)sendBtn
{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchBar resignFirstResponder];
    [self.searchText resignFirstResponder];
    ArticlDetailsViewController *articlVC = [[ArticlDetailsViewController alloc] init];
    articlVC.hidesBottomBarWhenPushed = YES;
    
    NutritionCenterVC *nutriVC = [[NutritionCenterVC alloc] init];
    nutriVC.hidesBottomBarWhenPushed = YES;
    
    if(indexPath.section<4)
    {
        switch (indexPath.section) {
            case 0:
                if (indexPath.row != self.tixingArr.count) {
                    articlVC.dataDic = [self.tixingArr objectAtIndex:indexPath.row];
                    for (UIView *subviews in [self.navigationController.view subviews]) {
                        if (subviews.tag==66) {
                            [subviews removeFromSuperview];
                        }
                    }
                    [self.navigationController pushViewController:articlVC animated:YES];
                }
                
                break;
                
            case 1:
                for (UIView *subviews in [self.navigationController.view subviews]) {
                    if (subviews.tag==66) {
                        [subviews removeFromSuperview];
                    }
                }
                nutriVC.idStr = [[self.yingyangArr objectAtIndex:indexPath.row] objectForKey:@"id"];
                nutriVC.biaotiStr = [[self.yingyangArr objectAtIndex:indexPath.row] objectForKey:@"biaoti"];
                [self.navigationController pushViewController:nutriVC animated:YES];
                break;
                
            case 2:
                articlVC.dataDic = [self.knowledgeArr objectAtIndex:indexPath.row];
                for (UIView *subviews in [self.navigationController.view subviews]) {
                    if (subviews.tag==66) {
                        [subviews removeFromSuperview];
                    }
                }
                [self.navigationController pushViewController:articlVC animated:YES];
                break;
                
            case 3:
                articlVC.dataDic = [self.mustPrepareArr objectAtIndex:indexPath.row];
                for (UIView *subviews in [self.navigationController.view subviews]) {
                    if (subviews.tag==66) {
                        [subviews removeFromSuperview];
                    }
                }
                [self.navigationController pushViewController:articlVC animated:YES];
                break;
                
                
            default:
                break;
        }
        //UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:articlVC];
        
    }
    if (indexPath.section == 4) {
        
        NSDictionary *dict = [self.sameAgeArr objectAtIndex:indexPath.row];
        
        NSString *tieziID =[dict objectForKey:@"id"];
        NSString *neirong =[dict objectForKey:@"neirong"];
        NSString *title = [dict objectForKey:@"title"];
        NSString *quanziID=[dict objectForKey:@"quanziid"];
        NSString *userid=[dict objectForKey:@"userid"];
        NSString *dianzanzongshu=[[dict objectForKey:@"dianzanzongshu"]stringValue];
        NSString *time=[dict objectForKey:@"time"];
        
        PostsDetails_VC *Posts = [[PostsDetails_VC alloc] init];
        Posts.TidCount = tieziID;
        Posts.userId=userid;
        NSLog(@"用户id%@",userid);
        Posts.quanziID=quanziID;
        NSLog(@"帖子ID = %@",tieziID);
        Posts.title = title;
        Posts.neirong = neirong;
        Posts.zannumber=dianzanzongshu;
        Posts.quanName=@"北京妈妈圈";
        Posts.time=time;
        Posts.hidesBottomBarWhenPushed =YES;
        for (UIView *subviews in [self.navigationController.view subviews]) {
            if (subviews.tag==66) {
                [subviews removeFromSuperview];
            }
        }
        [self.navigationController pushViewController:Posts animated:YES];
    }
    
}

-(void)dismissKeyboard:(id)sender{
    [self.searchText resignFirstResponder];
    [self.searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
