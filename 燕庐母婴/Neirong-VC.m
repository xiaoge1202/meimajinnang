//
//  Neirong-VC.m
//  美妈锦囊
//
//  Created by 侯泽彭 on 15/8/7.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "Neirong-VC.h"

@interface Neirong_VC ()
{
    CGSize size;
}
@end

@implementation Neirong_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"内容详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 16, 12, 20);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0, 0, 19, 20);
    [shareBtn setImage:[UIImage imageNamed:@"转发"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem1 = [[UIBarButtonItem alloc]initWithCustomView:shareBtn];
    
    
    UIButton *shoucangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shoucangBtn.frame = CGRectMake(0, 0, 20, 20);
    [shoucangBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    [shoucangBtn addTarget:self action:@selector(clickshoucangBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem2 = [[UIBarButtonItem alloc]initWithCustomView:shoucangBtn];
    
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightitem1,rightitem2, nil];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

-(void)backViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)shareBtnPress:(UIButton *)btn
{
    [UMSocialSnsService
     presentSnsIconSheetView:self
     appKey:@"507fcab25270157b37000010"
     shareText:@"你要分享的文字"
     shareImage:[UIImage
                 imageNamed:@"icon.png"]
     shareToSnsNames:[NSArray
                      arrayWithObjects:UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatTimeline,UMShareToWechatSession,nil]
     delegate:nil];
    
}

-(void)clickshoucangBtn:(UIButton*)btn
{
    MBProgressHUD* HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    //HUD.labelText = @"该设备不支持照相";
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-118)/2, (ScreenHeight-182)/2, 118, 118)];
    imgView.image = [UIImage imageNamed:@"添加收藏"];
//    self.manager = [AFHTTPRequestOperationManager manager];
//    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
//    
//    [self.manager POST:@"http://101.200.234.127:8080/YanLu/wenzhangshoucang/panduan.do" parameters:self.dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSData *data = responseObject;
//        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        if ([str isEqualToString:@"false"]) {
//            [self.manager POST:@"http://101.200.234.127:8080/YanLu/wenzhangshoucang/save.do" parameters:self.dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                [self.shoucangBtn setTitle:@"已收藏" forState:UIControlStateNormal];
//                [self.shoucangBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
//                [self.shoucangBtn setTitleColor:RGBA(236, 119, 147, 1) forState:UIControlStateNormal];
//                imgView.image = [UIImage imageNamed:@"添加收藏"];
//                NSLog(@"收藏成功");
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                NSLog(@"获取失败");
//            }];
//        }
//        else
//        {
//            [self.manager POST:@"http://101.200.234.127:8080/YanLu/wenzhangshoucang/delete.do" parameters:self.dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                [self.shoucangBtn setTitle:@"收藏" forState:UIControlStateNormal];
//                [self.shoucangBtn setImage:[UIImage imageNamed:@"weishoucang"] forState:UIControlStateNormal];
//                [self.shoucangBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
//                imgView.image = [UIImage imageNamed:@"取消收藏"];
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                NSLog(@"取消收藏成功");
//            }];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"获取失败");
//    }];
    [HUD addSubview:imgView];
    [HUD hide:YES afterDelay:1];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [NSString stringWithFormat:@"cell%d%d",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, ScreenWidth-15, 15)];
    titleLabel.text = @"想怀孕，未准爸妈必知的关键时间点！";
    //titleLabel.text = [self.dataDic objectForKey:@"biaoti"];
    
    //self.titleLabel.text = @"内容测试";
    
    titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:15];
    titleLabel.textColor = RGBA(89, 87, 87, 1);
    
    UIImageView *nameImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, titleLabel.frame.origin.y+titleLabel.frame.size.height+12, 10, 12)];
    nameImg.image = [UIImage imageNamed:@"人数"];
    
    UILabel *nameLabel= [[UILabel alloc] initWithFrame:CGRectMake(nameImg.frame.origin.x+nameImg.frame.size.width+5, titleLabel.frame.origin.y+titleLabel.frame.size.height+15, 60, 9)];
    nameLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    nameLabel.text = @"燕庐母婴";
    nameLabel.textColor = RGBA(137, 137, 137, 1);
    
    UIImageView *liulanImg = [[UIImageView alloc] initWithFrame:CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width+50, titleLabel.frame.origin.y+titleLabel.frame.size.height+15, 12, 9)];
    liulanImg.image = [UIImage imageNamed:@"see"];
    
    
    UILabel *liulanLabel = [[UILabel alloc] initWithFrame:CGRectMake(liulanImg.frame.origin.x+liulanImg.frame.size.width+5, titleLabel.frame.origin.y+titleLabel.frame.size.height+15, 30, 9)];
    liulanLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    liulanLabel.text = @"234次";
    liulanLabel.textColor = RGBA(137, 137, 137, 1);
    
    UILabel *zhidaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, ScreenWidth-15, 9)];
    zhidaoLabel.textColor = RGBA(137, 137, 137, 1);
    zhidaoLabel.text = [NSString stringWithFormat:@"指导专家：郑玉巧 北京妇幼医院专家"];
    //zhidaoLabel.text = [self.dataDic objectForKey:@"biaoti"];
    
    
    zhidaoLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    
    UILabel *neirong= [[UILabel alloc] initWithFrame:CGRectMake(15, zhidaoLabel.frame.origin.y+zhidaoLabel.frame.size.height+10, ScreenWidth-32, 85)];
    neirong.textColor = RGBA(89, 87, 87, 1);
    //        self.neirong.numberOfLines = 5;
            neirong.text = [NSString stringWithFormat:@"每个月排卵期前后。排卵期算法：从下次来潮的第一天算起，倒数14天或减去14天就是排卵日，排卵日及其前5天和后四天加在一起称为排卵期。而精子在女性输卵管最容易怀孕的时间，备孕夫妇主要推算的也是这个时间。"];
    //        self.neirong.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:13];
    //neirong.text = [self.dataDic objectForKey:@"neirong"];
    neirong.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:13];
    neirong.NumberOfLines = 0;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:neirong.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    size = [neirong.text boundingRectWithSize:CGSizeMake(ScreenWidth-20, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    [neirong setFrame:CGRectMake(15, zhidaoLabel.frame.origin.y+zhidaoLabel.frame.size.height+14, size.width, size.height)];
    //self.neirong.text = [NSString stringWithFormat:@"每个月排卵期前后。排卵期算法：从下次来潮的第一天算起，倒数14天或减去14天就是排卵日，排卵日及其前5天和后四天加在一起称为排卵期。而精子在女性输卵管最容易怀孕的时间，备孕夫妇主要推算的也是这个时间。"];
    
    if (indexPath.row == 0) {
        [cell addSubview:titleLabel];
        [cell addSubview:nameImg];
        [cell addSubview:nameLabel];
        [cell addSubview:liulanImg];
        [cell addSubview:liulanLabel];
    }
    
    else
    {
        [cell addSubview:zhidaoLabel];
        [cell addSubview:neirong];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 60;
    }
    else
    {
        return 40+size.height;
    }
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
