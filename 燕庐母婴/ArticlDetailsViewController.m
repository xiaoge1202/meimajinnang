//
//  ArticlDetailsViewController.m
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/11.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "ArticlDetailsViewController.h"

@interface ArticlDetailsViewController ()
{
    CGSize size;
}
@end

@implementation ArticlDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ssssssss%@",self.dataDic);
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    self.ud = [NSUserDefaults standardUserDefaults];
    NSString *userid = [self.ud objectForKey:@"userid"];
    NSString *wenzhangid = [self.dataDic objectForKey:@"id"];
    self.dict = [[NSMutableDictionary alloc] init];
    [self.dict setObject:userid forKey:@"userid"];
    [self.dict setObject:wenzhangid forKey:@"wenzhangid"];
    
    [self addLabel];
    self.navigationItem.title = @"文 章 详 情";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 16, 18, 18);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    [self.view addSubview:self.tabelView];
    [self setExtraCellLineHidden:self.tabelView];
    
    
    // Do any additional setup after loading the view.
}

-(void)addLabel
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, ScreenWidth-15, 15)];
    //self.titleLabel.text = @"想怀孕，未准爸妈必知的关键时间点！";
    self.titleLabel.text = [self.dataDic objectForKey:@"biaoti"];
    self.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:15];
    self.titleLabel.textColor = RGBA(89, 87, 87, 1);
    
    self.expertLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+10, 120, 10)];
    //self.expertLabel.text = @"专家：燕庐母婴";
    self.expertLabel.text = [NSString stringWithFormat:@"专家：%@",[self.dataDic objectForKey:@"zhuanjia"]];
    self.expertLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
    self.expertLabel.textColor = RGBA(137, 137, 137, 1);
    
    self.guankanLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-135,self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+10 , 120, 10)];
    self.guankanLabel.text = [NSString stringWithFormat:@"观看%@次",[self.dataDic objectForKey:@"yueducishu"]];
    self.guankanLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
    self.guankanLabel.textColor = RGBA(137, 137, 137, 1);
    self.guankanLabel.textAlignment = NSTextAlignmentRight;
    
    self.guideExpertLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, 120, 10)];
    self.guideExpertLabel.text = [NSString stringWithFormat:@"指导专家：%@",[self.dataDic objectForKey:@"zuozhe"]];
    self.guideExpertLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
    self.guideExpertLabel.textColor = RGBA(137, 137, 137, 1);
    
    
    
    if ([[self.dataDic objectForKey:@"tupian"] isEqual:@"3"] || [[self.dataDic objectForKey:@"tupian"] isEqual:@"4"] || [[self.dataDic objectForKey:@"tupian"] isEqual:@"5"]) {
        self.fenxiangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.fenxiangBtn.frame = CGRectMake(ScreenWidth/2, 14, 40, 10);
        [self.fenxiangBtn setTitle:@"分享" forState:UIControlStateNormal];
        [self.fenxiangBtn setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
        [self.fenxiangBtn setImage:[UIImage imageNamed:@"yifenxiang"] forState:UIControlStateSelected];
        [self.fenxiangBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
        [self.fenxiangBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
        [self.fenxiangBtn addTarget:self action:@selector(clickfenxiangBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.fenxiangBtn.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        
        self.shoucangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.shoucangBtn.frame = CGRectMake(self.fenxiangBtn.frame.origin.x+self.fenxiangBtn.frame.size.width+10, 14, 50, 10);
//        [self.shoucangBtn setTitle:@"收藏" forState:UIControlStateNormal];
//        [self.shoucangBtn setImage:[UIImage imageNamed:@"weishoucang"] forState:UIControlStateNormal];
//        [self.shoucangBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateSelected];
//        [self.shoucangBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
        [self.shoucangBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
        [self.shoucangBtn addTarget:self action:@selector(clickshoucangBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.shoucangBtn.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        
        [self.manager POST:@"http://101.200.234.127:8080/YanLu/wenzhangshoucang/panduan.do" parameters:self.dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSData *data = responseObject;
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"收藏＝＝＝＝%@",str);
            if ([str isEqualToString:@"false"]) {
                [self.shoucangBtn setTitle:@"收藏" forState:UIControlStateNormal];
                [self.shoucangBtn setImage:[UIImage imageNamed:@"weishoucang"] forState:UIControlStateNormal];
                [self.shoucangBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
            }
            else
            {
                [self.shoucangBtn setTitle:@"已收藏" forState:UIControlStateNormal];
                [self.shoucangBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
                [self.shoucangBtn setTitleColor:RGBA(236, 119, 147, 1) forState:UIControlStateNormal];
            }
            [self.tabelView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"获取相响应失败");
        }];
        
        self.dianzanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.dianzanBtn.frame = CGRectMake(self.shoucangBtn.frame.origin.x+self.shoucangBtn.frame.size.width+10, 14, 40, 10);
        
        //[self.dianzanBtn setImage:[UIImage imageNamed:@"yizan"] forState:UIControlStateSelected];
        [self.dianzanBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
        [self.dianzanBtn addTarget:self action:@selector(clickshoucangBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.dianzanBtn.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        NSLog(@"dict===%@",self.dict);
        [self.manager POST:@"http://101.200.234.127:8080/YanLu/dianzan/panduan.do" parameters:self.dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSData *data = responseObject;
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"点赞＝＝＝＝%@",str);
            if ([str isEqualToString:@"false"]) {
                [self.dianzanBtn setTitle:@"点赞" forState:UIControlStateNormal];
                [self.dianzanBtn setImage:[UIImage imageNamed:@"weizan"] forState:UIControlStateNormal];
                [self.dianzanBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
            }
            else
            {
                [self.dianzanBtn setTitle:@"已赞" forState:UIControlStateNormal];
                [self.dianzanBtn setImage:[UIImage imageNamed:@"yizan"] forState:UIControlStateNormal];
                [self.dianzanBtn setTitleColor:RGBA(236, 119, 147, 1) forState:UIControlStateNormal];
            }
            [self.tabelView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"获取相响应失败");
        }];
        
        self.neirongtitle = [[UILabel alloc] initWithFrame:CGRectMake(15, self.guideExpertLabel.frame.origin.y+self.guideExpertLabel.frame.size.height+14, ScreenWidth-15, 13)];
        self.neirongtitle.textColor = RGBA(89, 87, 87, 1);
        //self.neirongtitle.text = [NSString stringWithFormat:@"大家都知道的时间"];
        self.neirongtitle.text = [self.dataDic objectForKey:@"biaoti"];
        self.neirongtitle.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:13];
        
        self.neirong = [[UILabel alloc] initWithFrame:CGRectMake(15, self.neirongtitle.frame.origin.y+self.neirongtitle.frame.size.height+14, ScreenWidth-32, 85)];
        self.neirong.textColor = RGBA(89, 87, 87, 1);
        //self.neirong.numberOfLines = 5;
        self.neirong.text = [self.dataDic objectForKey:@"neirong"];
        self.neirong.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:13];
        self.neirong.NumberOfLines = 0;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:self.neirong.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        size = [self.neirong.text boundingRectWithSize:CGSizeMake(ScreenWidth-20, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        [self.neirong setFrame:CGRectMake(15, self.neirongtitle.frame.origin.y+self.neirongtitle.frame.size.height+14, size.width, size.height)];
        //self.neirong.text = [NSString stringWithFormat:@"每个月排卵期前后。排卵期算法：从下次来潮的第一天算起，倒数14天或减去14天就是排卵日，排卵日及其前5天和后四天加在一起称为排卵期。而精子在女性输卵管最容易怀孕的时间，备孕夫妇主要推算的也是这个时间。"];
        
    }
    else
    {
        
        self.titleView = [[UIImageView alloc] initWithFrame:CGRectMake(14, self.guideExpertLabel.frame.origin.y+self.guideExpertLabel.frame.size.height+9, 294, 222)];
        [NSThread detachNewThreadSelector:@selector(loadLabelTableView:) toTarget:self withObject:[self.dataDic objectForKey:@"tupian"]];
        
        self.fenxiangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.fenxiangBtn.frame = CGRectMake(ScreenWidth/2, self.titleView.frame.origin.y+self.titleView.frame.size.height+9, 40, 10);
        [self.fenxiangBtn setTitle:@"分享" forState:UIControlStateNormal];
        [self.fenxiangBtn setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
        [self.fenxiangBtn setImage:[UIImage imageNamed:@"yifenxiang"] forState:UIControlStateSelected];
        [self.fenxiangBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
        [self.fenxiangBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
        [self.fenxiangBtn addTarget:self action:@selector(clickfenxiangBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.fenxiangBtn.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        
        self.shoucangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.shoucangBtn.frame = CGRectMake(self.fenxiangBtn.frame.origin.x+self.fenxiangBtn.frame.size.width+10, self.titleView.frame.origin.y+self.titleView.frame.size.height+9, 50, 10);
        
        //[self.shoucangBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateSelected];
        [self.shoucangBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
        [self.shoucangBtn addTarget:self action:@selector(clickshoucangBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.shoucangBtn.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        NSLog(@"dict===%@",self.dict);
        [self.manager POST:@"http://101.200.234.127:8080/YanLu/wenzhangshoucang/panduan.do" parameters:self.dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSData *data = responseObject;
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"收藏＝＝＝＝%@",str);
            if ([str isEqualToString:@"false"]) {
                [self.shoucangBtn setTitle:@"收藏" forState:UIControlStateNormal];
                [self.shoucangBtn setImage:[UIImage imageNamed:@"weishoucang"] forState:UIControlStateNormal];
                [self.shoucangBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
            }
            else
            {
                [self.shoucangBtn setTitle:@"已收藏" forState:UIControlStateNormal];
                [self.shoucangBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
                [self.shoucangBtn setTitleColor:RGBA(236, 119, 147, 1) forState:UIControlStateNormal];
            }
            [self.tabelView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"获取响应失败");
        }];
        
        self.dianzanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.dianzanBtn.frame = CGRectMake(self.shoucangBtn.frame.origin.x+self.shoucangBtn.frame.size.width+10, self.titleView.frame.origin.y+self.titleView.frame.size.height+9, 40, 10);
//        [self.dianzanBtn setTitle:@"点赞" forState:UIControlStateNormal];
//        [self.dianzanBtn setImage:[UIImage imageNamed:@"weizan"] forState:UIControlStateNormal];
//        [self.dianzanBtn setImage:[UIImage imageNamed:@"yizan"] forState:UIControlStateSelected];
//        [self.dianzanBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
        [self.dianzanBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
        [self.dianzanBtn addTarget:self action:@selector(clickdianzanBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.dianzanBtn.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        NSLog(@"dict===%@",self.dict);
        [self.manager POST:@"http://101.200.234.127:8080/YanLu/dianzan/panduan.do" parameters:self.dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSData *data = responseObject;
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"点赞＝＝＝＝%@",str);
            if ([str isEqualToString:@"false"]) {
                [self.dianzanBtn setTitle:@"点赞" forState:UIControlStateNormal];
                [self.dianzanBtn setImage:[UIImage imageNamed:@"weizan"] forState:UIControlStateNormal];
                [self.dianzanBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
            }
            else
            {
                [self.dianzanBtn setTitle:@"已赞" forState:UIControlStateNormal];
                [self.dianzanBtn setImage:[UIImage imageNamed:@"yizan"] forState:UIControlStateNormal];
                [self.dianzanBtn setTitleColor:RGBA(236, 119, 147, 1) forState:UIControlStateNormal];
            }
            [self.tabelView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"获取相响应失败");
        }];
        
        self.neirongtitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 13, ScreenWidth-15, 13)];
        self.neirongtitle.textColor = RGBA(89, 87, 87, 1);
        //self.neirongtitle.text = [NSString stringWithFormat:@"大家都知道的时间"];
        self.neirongtitle.text = [self.dataDic objectForKey:@"biaoti"];
        self.neirongtitle.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:13];
        
        self.neirong = [[UILabel alloc] initWithFrame:CGRectMake(15, self.neirongtitle.frame.origin.y+self.neirongtitle.frame.size.height+13, ScreenWidth-32, 85)];
        self.neirong.textColor = RGBA(89, 87, 87, 1);
//        self.neirong.numberOfLines = 5;
//        self.neirong.text = [NSString stringWithFormat:@"每个月排卵期前后。排卵期算法：从下次来潮的第一天算起，倒数14天或减去14天就是排卵日，排卵日及其前5天和后四天加在一起称为排卵期。而精子在女性输卵管最容易怀孕的时间，备孕夫妇主要推算的也是这个时间。"];
//        self.neirong.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:13];
        self.neirong.text = [self.dataDic objectForKey:@"neirong"];
        self.neirong.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:13];
        self.neirong.NumberOfLines = 0;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:self.neirong.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        size = [self.neirong.text boundingRectWithSize:CGSizeMake(ScreenWidth-20, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        [self.neirong setFrame:CGRectMake(15, self.neirongtitle.frame.origin.y+self.neirongtitle.frame.size.height+14, size.width, size.height)];
        //self.neirong.text = [NSString stringWithFormat:@"每个月排卵期前后。排卵期算法：从下次来潮的第一天算起，倒数14天或减去14天就是排卵日，排卵日及其前5天和后四天加在一起称为排卵期。而精子在女性输卵管最容易怀孕的时间，备孕夫妇主要推算的也是这个时间。"];
       
    }
    
    self.zhishiBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.zhishiBtn.frame = CGRectMake(15, self.neirong.frame.origin.y+self.neirong.frame.size.height+15, 65, 9);
    [self.zhishiBtn setTitle:@"相关知识视频" forState:UIControlStateNormal];
    [self.zhishiBtn setTitleColor:RGBA(236, 119, 147, 1) forState:UIControlStateNormal];
    [self.zhishiBtn.titleLabel setFont:[UIFont fontWithName:@"Microsoft Yahei UI" size:9]];
    [self.zhishiBtn addTarget:self action:@selector(clickzhishiBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.bizhiLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 9, ScreenWidth-15, 14)];
    self.bizhiLabel.textColor = RGBA(89, 87, 87, 1);
    self.bizhiLabel.text = [NSString stringWithFormat:@"王爱华专家：坐月子必知"];
    self.bizhiLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:14];
    
    self.jiedaLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 9, ScreenWidth-15, 14)];
    self.jiedaLabel.textColor = RGBA(89, 87, 87, 1);
    self.jiedaLabel.text = [NSString stringWithFormat:@"董飞剑专家：权威专家解答"];
    self.jiedaLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:14];
    
}

-(void)loadLabelTableView:(NSString*)str
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
    self.titleView.image = [UIImage imageWithData:data];
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[self.dataDic objectForKey:@"tupian"] isEqual:@"3"] || [[self.dataDic objectForKey:@"tupian"] isEqual:@"4"] || [[self.dataDic objectForKey:@"tupian"] isEqual:@"5"]) {
        return 4;
    }
    else{
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    if ([[self.dataDic objectForKey:@"tupian"] isEqual:@"3"] || [[self.dataDic objectForKey:@"tupian"] isEqual:@"4"] || [[self.dataDic objectForKey:@"tupian"] isEqual:@"5"]){
        switch (indexPath.row) {
            case 0:
                [cell addSubview:self.titleLabel];
                [cell addSubview:self.expertLabel];
                [cell addSubview:self.guankanLabel];
                break;
                
            case 1:
                [cell addSubview:self.guideExpertLabel];
                [cell addSubview:self.fenxiangBtn];
                [cell addSubview:self.shoucangBtn];
                [cell addSubview:self.dianzanBtn];
                [cell addSubview:self.neirongtitle];
                [cell addSubview:self.neirong];
                [cell addSubview:self.zhishiBtn];
                break;
                
            case 2:
                [cell addSubview:self.bizhiLabel];
                break;
                
            case 3:
                [cell addSubview:self.jiedaLabel];
                break;
                
            default:
                break;
        }
    }
    else
    {
        switch (indexPath.row) {
            case 0:
                [cell addSubview:self.titleLabel];
                [cell addSubview:self.expertLabel];
                [cell addSubview:self.guankanLabel];
                break;
                
            case 1:
                [cell addSubview:self.guideExpertLabel];
                [cell addSubview:self.titleView];
                [cell addSubview:self.fenxiangBtn];
                [cell addSubview:self.shoucangBtn];
                [cell addSubview:self.dianzanBtn];
                break;
                
            case 2:
                [cell addSubview:self.neirongtitle];
                [cell addSubview:self.neirong];
                [cell addSubview:self.zhishiBtn];
                break;
                
            case 3:
                [cell addSubview:self.bizhiLabel];
                break;
                
            case 4:
                [cell addSubview:self.jiedaLabel];
                break;
                
            default:
                break;
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.dataDic objectForKey:@"tupian"] isEqual:@"3"] || [[self.dataDic objectForKey:@"tupian"] isEqual:@"4"] || [[self.dataDic objectForKey:@"tupian"] isEqual:@"5"]) {
        switch (indexPath.row) {
            case 0:
                return 56;
                break;
                
            case 1:
                return size.height+92;
                break;
                
            default:
                return 32;
                break;
        }
    }
    else
    {
        switch (indexPath.row) {
            case 0:
                return 56;
                break;
                
            case 1:
                return 280;
                break;
                
            case 2:
                return size.height+68;
                break;
                
            default:
                return 32;
                break;
        }
    }
}

-(void)backViewController
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)clickzhishiBtn
{
    
}

-(void)clickfenxiangBtn:(UIButton*)sender
{
    
}

-(void)clickshoucangBtn:(UIButton*)sender
{
    
    
    MBProgressHUD* HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    //HUD.labelText = @"该设备不支持照相";
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-118)/2, (ScreenHeight-182)/2, 118, 118)];
    
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/wenzhangshoucang/panduan.do" parameters:self.dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = responseObject;
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if ([str isEqualToString:@"false"]) {
            [self.manager POST:@"http://101.200.234.127:8080/YanLu/wenzhangshoucang/save.do" parameters:self.dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self.shoucangBtn setTitle:@"已收藏" forState:UIControlStateNormal];
                [self.shoucangBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
                [self.shoucangBtn setTitleColor:RGBA(236, 119, 147, 1) forState:UIControlStateNormal];
                imgView.image = [UIImage imageNamed:@"添加收藏"];
                NSLog(@"收藏成功");
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"获取失败");
            }];
        }
        else
        {
            [self.manager POST:@"http://101.200.234.127:8080/YanLu/wenzhangshoucang/delete.do" parameters:self.dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self.shoucangBtn setTitle:@"收藏" forState:UIControlStateNormal];
                [self.shoucangBtn setImage:[UIImage imageNamed:@"weishoucang"] forState:UIControlStateNormal];
                [self.shoucangBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
                imgView.image = [UIImage imageNamed:@"取消收藏"];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"取消收藏成功");
            }];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取失败");
    }];
    [HUD addSubview:imgView];
    [HUD hide:YES afterDelay:2];
}

-(void)clickdianzanBtn:(UIButton*)sender
{
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/dianzan/panduan.do" parameters:self.dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = responseObject;
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if ([str isEqualToString:@"false"]) {
            [self.manager POST:@"http://101.200.234.127:8080/YanLu/dianzan/save.do" parameters:self.dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self.dianzanBtn setTitle:@"已赞" forState:UIControlStateNormal];
                [self.dianzanBtn setImage:[UIImage imageNamed:@"yizan"] forState:UIControlStateNormal];
                [self.dianzanBtn setTitleColor:RGBA(236, 119, 147, 1) forState:UIControlStateNormal];
                NSLog(@"点赞成功");
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"获取失败");
            }];
        }
        else
        {
            [self.manager POST:@"http://101.200.234.127:8080/YanLu/dianzan/delete.do" parameters:self.dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self.dianzanBtn setTitle:@"点赞" forState:UIControlStateNormal];
                [self.dianzanBtn setImage:[UIImage imageNamed:@"weizan"] forState:UIControlStateNormal];
                [self.dianzanBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"取消点赞成功");
            }];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取失败");
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
