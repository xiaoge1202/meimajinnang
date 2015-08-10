//
//  SameAge-VC.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/5.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "SameAge-VC.h"
#import "SDRefresh.h"
#import "UIImageView+AFNetworking.h"
//#import "my"

@interface SameAge_VC ()
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;
@property (strong,nonatomic) NSString *guanzhuStatus;
@property (strong,nonatomic) NSMutableArray *fenYeArr;
@end

@implementation SameAge_VC

NSInteger jjj = 0;

-(void)viewWillAppear:(BOOL)animated
{
    [self postToServer];
}


-(void)postToServer
{
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    [self.manager GET:myGuanZhuURL parameters:[@{@"userid":_userId}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.myCircleArr = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:0 error:nil];
        
        
        
        
        
        NSLog(@"*********%@,%lu",self.myCircleArr,(unsigned long)self.myCircleArr.count);
        [self.sameAgeTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"失败");
    }];
    
    NSLog(@"page====%d",jjj);
    
    [self.manager GET:circleURL parameters:[@{@"leiid":self.leiid,@"start":[NSString stringWithFormat:@"%d",jjj],@"userid":_userId}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.fenYeArr = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:0 error:nil];
        
        NSLog(@"page++++%d",jjj);

        if (jjj == 0)
        {
            self.sameAgeArr = [[NSMutableArray alloc]initWithArray:self.fenYeArr];
            NSLog(@"%d----myCircleArr----%@",self.sameAgeArr.count,self.sameAgeArr);
        }
        else
        {
            for (int i = 0; i< [self.fenYeArr count]; i++)
            {
                [self.sameAgeArr addObject:[self.fenYeArr objectAtIndex:i]];
                NSLog(@"%d++++myCircleArr++++%@",self.sameAgeArr.count,self.sameAgeArr);
            }
            
        }
        

        
        
        
        
        NSLog(@"sameAge:%@",self.sameAgeArr);
        
        //[self addbtn];
        [self.sameAgeTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"链接服务器失败");
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    page=0;
    
    _user = [NSUserDefaults standardUserDefaults];
    _userId = [_user objectForKey:@"userid"];
    
    self.leiid = @"1";
    _user = [NSUserDefaults standardUserDefaults];
    _userId = [_user objectForKey:@"userid"];
    //关注
    self.guanzhuArr = [[NSMutableArray alloc] init];
    self.sameAgeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-158) style:UITableViewStylePlain];
    self.sameAgeTableView.dataSource = self;
    self.sameAgeTableView.delegate = self;
    [self.view addSubview:self.sameAgeTableView];
    
    [self setExtraCellLineHidden:self.sameAgeTableView];
    
    
    self.dictionary = [NSMutableDictionary dictionary];
    
    [self setupHeader];
    [self setupFooter];

}


- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sameAgeArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"str";
    cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[CircleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
   // cell.headImg.image = [UIImage imageNamed:@"circleImg"];
    [cell.headImg setImageWithURL:[NSURL URLWithString:[[self.sameAgeArr objectAtIndex:indexPath.row] objectForKey:@"qtupian"]] placeholderImage:[UIImage imageNamed:@"头像"]];
    
    cell.circleNameLabel.text = [[self.sameAgeArr objectAtIndex:indexPath.row] objectForKey:@"quanname"];
    
    
    cell.peopleNumImg.image = [UIImage imageNamed:@"人数"];
    cell.peopleNumLabel.text = [[self.sameAgeArr objectAtIndex:indexPath.row] objectForKey:@"guanzhuzongshu"];
    
    
    cell.speakNumImg.image = [UIImage imageNamed:@"话题"];
    cell.speakNumLabel.text = [[self.sameAgeArr objectAtIndex:indexPath.row] objectForKey:@"tiezizongshu"];
    
    NSString *quanzi = [[self.sameAgeArr objectAtIndex:indexPath.row] objectForKey:@"id"];
    
    [cell.saveBtn addTarget:self action:@selector(collectCircle:) forControlEvents:UIControlEventTouchUpInside];
    cell.saveBtn.tag = indexPath.row+100;
    cell.saveBtn.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:11];
    cell.saveBtn.layer.masksToBounds = YES;
    cell.saveBtn.layer.cornerRadius = 3;
    
    if (self.myCircleArr.count == 0) {
        cell.saveBtn.frame = CGRectMake(ScreenWidth-55, 30, 45, 18);
        [cell.saveBtn setBackgroundColor:RGBA(237, 81, 129, 1)];
        [cell.saveBtn setTitle:@"关注" forState:UIControlStateNormal];
        [cell.saveBtn setImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
        //按钮设置图片(上左下右)
        [cell.saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
//        self.guanzhuStatus = @"100";

    }
    NSInteger count = [[[self.sameAgeArr objectAtIndex:indexPath.row] objectForKey:@"id"] integerValue];
    NSLog(@"666666666%d",self.myCircleArr.count);
    for (int i = 0; i<self.myCircleArr.count; i++) {
        if (count == [[[self.myCircleArr objectAtIndex:i] objectForKey:@"id"] integerValue]) {
            cell.saveBtn.backgroundColor = [UIColor whiteColor];
            
//            cell.saveBtn.backgroundColor = [UIColor greenColor];
            cell.saveBtn.frame = CGRectMake(ScreenWidth-58, 30, 45, 18);
            [cell.saveBtn setTitle:@"取消关注" forState:UIControlStateNormal];
            [cell.saveBtn setTitleColor:RGBA(200, 200, 200,1) forState:UIControlStateNormal];
            [cell.saveBtn setImage:nil forState:UIControlStateNormal];
            
//            self.guanzhuStatus = @"101";

            break;

        }
        else if(i==self.myCircleArr.count - 1)
        {
            cell.saveBtn.frame = CGRectMake(ScreenWidth-55, 30, 45, 18);
            [cell.saveBtn setBackgroundColor:RGBA(237, 81, 129, 1)];
            [cell.saveBtn setTitle:@"关注" forState:UIControlStateNormal];
            [cell.saveBtn setImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
            //按钮设置图片(上左下右)
            [cell.saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
//            self.guanzhuStatus = @"100";

            
        }
    }
    
    return cell;
}


//关注按钮
-(void)collectCircle:(UIButton *)btn
{
    for (int i = 0; i < [self.sameAgeArr count]; i++) {
        if (btn.tag == i+100) {
            
            self.dictionary = [self.sameAgeArr objectAtIndex:i];
            _quanID = [self.dictionary objectForKey:@"id"];
            NSLog(@"%@",_quanID);
        }
    }
    NSLog(@"arr:%d",btn.tag);
    [self.manager GET:panDuanURL parameters:[@{@"userid":_userId,@"quanziid":_quanID}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSData *data = responseObject;
        NSString *str1 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"str111111111:%@",str1);
        if ([str1 isEqualToString:@"false"]) {
            
            [self.manager GET:addGuanZhuURL parameters:[@{@"userid":_userId,@"quanziid":_quanID}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
                //[self addbtn];
            btn.frame = CGRectMake(ScreenWidth-58, 30, 45, 18);
                [self postToServer];
                
                
                [self.sameAgeTableView reloadData];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"失败");
            }];
            
        }else{
            
            [self.manager GET:deleteGuanZhuURL parameters:[@{@"userid":_userId,@"quanziid":_quanID}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
                //[self addbtn];
                [self postToServer];
                
                
                [self.sameAgeTableView reloadData];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"失败");
            }];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"失败");
    }];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *rightindexPath=[NSIndexPath indexPathForRow:indexPath.row inSection:0];

    CircleCell *cell= (CircleCell *)[self.sameAgeTableView cellForRowAtIndexPath:rightindexPath];

    
    NSDictionary *dic = [self.sameAgeArr objectAtIndex:indexPath.row];
    NSString *circleID = [dic objectForKey:@"id"];
    NSString *circleName = [dic objectForKey:@"quanname"];
    NSString *peopleNum = [dic objectForKey:@"guanzhuzongshu"];
    NSString *speakNum = [dic objectForKey:@"tiezizongshu"];
    NSString *contents = [dic objectForKey:@"neirong"];
    NSString *quanid = [dic objectForKey:@"quanziid"];
    
    
    CircleDetails_VC *circleDetails = [[CircleDetails_VC alloc] init];
    circleDetails.circleID = circleID;
    circleDetails.circleName = circleName;
    circleDetails.peopleNum = peopleNum;
    circleDetails.speakNum = speakNum;
    circleDetails.contents=contents;
    circleDetails.quanziID=quanid;
    circleDetails.guanzhuStatus2 = self.guanzhuStatus;
    circleDetails.guanzhuBtnTitle = cell.saveBtn.titleLabel.text;
    NSLog(@"guanzhuStatus----%@",cell.saveBtn.titleLabel.text);
    //liuxiaofeng
    circleDetails.mycircleArr = self.myCircleArr;
    
    circleDetails.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:circleDetails animated:YES];


}


- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshView];
    
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:self.sameAgeTableView];
    
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    refreshHeader.beginRefreshingOperation = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
  //          [self AFNetworking];
            
            jjj++;
            [self postToServer];
            [weakRefreshHeader endRefreshing];
        });
    };
    
    // 进入页面自动加载一次数据
    [refreshHeader beginRefreshing];
}

- (void)setupFooter
{
    //[self AFNetworking];
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshView];
    [refreshFooter addToScrollView:self.sameAgeTableView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}


- (void)footerRefresh
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        jjj++;
        NSLog(@"page----%d",jjj);

        [self postToServer];
        [self.sameAgeTableView reloadData];
        [self.refreshFooter endRefreshing];
    });
}
@end
