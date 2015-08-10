//
//  MyTieziViewController.m
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/18.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "MyTieziViewController.h"

@interface MyTieziViewController ()
{
    CGSize size;
}
@end

@implementation MyTieziViewController

-(void)viewDidAppear:(BOOL)animated
{
    [self getMyhuitieMessage];
}

-(void)getMyhuitieMessage
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *userid = [ud objectForKey:@"userid"];
    
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/tiezi/list.do" parameters:[@{@"userid":userid} mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.dataArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"babyGrowArr:%@",self.dataArr);
        [self.mytieziTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我 的 帖 子";
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
    
    [self creatTableView]
    ;
    // Do any additional setup after loading the view.
}

-(void)creatTableView
{
    self.mytieziTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 6, ScreenWidth, ScreenHeight-70) style:UITableViewStylePlain];
    self.mytieziTableView.delegate = self;
    self.mytieziTableView.dataSource = self;
    [self.view addSubview:self.mytieziTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    MyTieziTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[MyTieziTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    NSDictionary *dic = [self.dataArr objectAtIndex:indexPath.row];
    if ([[dic objectForKey:@"touxiang"] isEqualToString:@""]) {
        cell.touxiangImg.image = [UIImage imageNamed:@"touxiangimg"];
    }
    else
    {
        
    }
    
    cell.nameLabel.text = [dic objectForKey:@"nicheng"];
    cell.timeLabel.text = @"2015-05-23";
    cell.neirongLabel.text = [dic objectForKey:@"neirong"];
    cell.neirongLabel.NumberOfLines = 0;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:cell.neirongLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    size = [cell.neirongLabel.text boundingRectWithSize:CGSizeMake(ScreenWidth-20, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    [cell.neirongLabel setFrame:CGRectMake(10, cell.timeLabel.frame.origin.y+cell.timeLabel.frame.size.height+10, size.width, size.height)];
    //cell.huifukuangImg.frame = CGRectMake(0, 0, 260, pinglunsize.height);
    
    [cell.shoucangImg setFrame:CGRectMake(15, cell.neirongLabel.frame.origin.y+size.height+10, 11, 11)];
    [cell.shoucangLable setFrame:CGRectMake(cell.shoucangImg.frame.origin.x+cell.shoucangImg.frame.size.width+10, cell.neirongLabel.frame.origin.y+size.height+10, 30, 12)];
    [cell.zhuanfaImg setFrame:CGRectMake(cell.shoucangLable.frame.origin.x+cell.shoucangLable.frame.size.width+30, cell.neirongLabel.frame.origin.y+size.height+12, 11, 8)];
    [cell.zhuanfacountLabel setFrame:CGRectMake(cell.zhuanfaImg.frame.origin.x+cell.zhuanfaImg.frame.size.width+10, cell.neirongLabel.frame.origin.y+size.height+10, 30, 12)];
    [cell.messageImg setFrame:CGRectMake(cell.zhuanfacountLabel.frame.origin.x+cell.zhuanfacountLabel.frame.size.width+30, cell.neirongLabel.frame.origin.y+size.height+12, 10, 8)];
    [cell.messageLab setFrame:CGRectMake(cell.messageImg.frame.origin.x+cell.messageImg.frame.size.width+10, cell.neirongLabel.frame.origin.y+size.height+10, 30, 12)];
    [cell.dianzanImg setFrame:CGRectMake(cell.messageLab.frame.origin.x+cell.messageLab.frame.size.width+30, cell.neirongLabel.frame.origin.y+size.height+12, 10, 9)];
    [cell.dianzanLabel setFrame:CGRectMake(cell.dianzanImg.frame.origin.x+cell.dianzanImg.frame.size.width+10, cell.neirongLabel.frame.origin.y+size.height+10, 30, 12)];
    
    cell.shoucangLable.text = [[dic objectForKey:@"shoucangzongshu"] stringValue];
    cell.zhuanfacountLabel.text = [[dic objectForKey:@"chakanzongshu"] stringValue];
    cell.messageLab.text = [[dic objectForKey:@"pinglunzongshu"] stringValue];
    cell.dianzanLabel.text = [[dic objectForKey:@"dianzanzongshu"] stringValue];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75+size.height;
}

-(void)goBack:(UIButton*)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)clickFinishBtn
{
    
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
