//
//  Feeling-VC.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/5.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "Feeling-VC.h"
#import "SDRefresh.h"
#import "UIImageView+AFNetworking.h"
@interface Feeling_VC ()
{
    NSInteger jjj ;
}
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;
@property (strong,nonatomic) NSMutableArray *fenYeArr;

@end

@implementation Feeling_VC

-(void)viewWillAppear:(BOOL)animated
{
    [self postToServer];
}


-(void)postToServer
{
    NSLog(@"page====%d",jjj);
    
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    [self.manager GET:circleURL parameters:[@{@"leiid":self.leiid,@"start":[NSString stringWithFormat:@"%d",jjj],@"userid":_userId}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.fenYeArr = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:0 error:nil];
        
        NSLog(@"page++++%d",jjj);
        
        if (jjj == 0)
        {
            self.feelingArr = [[NSMutableArray alloc]initWithArray:self.fenYeArr];
            NSLog(@"%d----liveArr----%@",self.feelingArr.count,self.feelingArr);
        }
        else
        {
            for (int i = 0; i < [self.fenYeArr count]; i++)
            {
                [self.feelingArr addObject:[self.fenYeArr objectAtIndex:i]];
                NSLog(@"%d++++liveArr++++%@",self.feelingArr.count,self.feelingArr);
            }
            
        }
        
        
        
        
        //[self addbtn];
        [self.feelingTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"链接服务器失败");
    }];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leiid = @"5";
    _user = [NSUserDefaults standardUserDefaults];
    _userId = [_user objectForKey:@"userid"];
    jjj = 0;
    self.feelingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-158) style:UITableViewStylePlain];
    self.feelingTableView.dataSource = self;
    self.feelingTableView.delegate = self;
    [self.view addSubview:self.feelingTableView];
    
    
    [self setExtraCellLineHidden:self.feelingTableView];
    
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
    return self.feelingArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"str";
    cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[CircleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
   // cell.headImg.image = [UIImage imageNamed:@"circleImg"];
     [cell.headImg setImageWithURL:[NSURL URLWithString:[[self.feelingArr objectAtIndex:indexPath.row] objectForKey:@"qtupian"]] placeholderImage:[UIImage imageNamed:@"头像"]];
    
    cell.circleNameLabel.text = [[self.feelingArr objectAtIndex:indexPath.row] objectForKey:@"quanname"];
    
    
    cell.peopleNumImg.image = [UIImage imageNamed:@"人数"];
    cell.peopleNumLabel.text = [[self.feelingArr objectAtIndex:indexPath.row] objectForKey:@"guanzhuzongshu"];
    
    
    cell.speakNumImg.image = [UIImage imageNamed:@"话题"];
    cell.speakNumLabel.text = [[self.feelingArr objectAtIndex:indexPath.row] objectForKey:@"tiezizongshu"];
    
    quanzi = [[self.feelingArr objectAtIndex:indexPath.row] objectForKey:@"id"];
    
    
    [cell.saveBtn addTarget:self action:@selector(saveBtnIsClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.saveBtn.tag = indexPath.row;
    
    if([[[[self.feelingArr objectAtIndex:indexPath.row] objectForKey:@"guanzhu"] stringValue]isEqualToString:@"0"]){
        cell.saveBtn.frame = CGRectMake(ScreenWidth-55, 30, 40, 18);
        [cell.saveBtn setBackgroundColor:RGBA(237, 81, 129, 1)];
        [cell.saveBtn setTitle:@"关注" forState:UIControlStateNormal];
        [cell.saveBtn setImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
        //按钮设置图片(上左下右)
        [cell.saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
    }else{
        cell.saveBtn.backgroundColor = [UIColor whiteColor];
        cell.saveBtn.frame = CGRectMake(ScreenWidth-58, 30, 45, 18);
        [cell.saveBtn setTitle:@"取消关注" forState:UIControlStateNormal];
        [cell.saveBtn setTitleColor:RGBA(200, 200, 200,1) forState:UIControlStateNormal];
        [cell.saveBtn setImage:nil forState:UIControlStateNormal];

    }
    return cell;
}

-(void)saveBtnIsClick:(UIButton *)sender
{
    for (int i = 0; i < [self.feelingArr count]; i++) {
        if (sender.tag == i) {
            
            self.dictionary = [self.feelingArr objectAtIndex:i];
            _quanID = [self.dictionary objectForKey:@"id"];
        }
    }
    
    [self.manager GET:panDuanURL parameters:[@{@"userid":_userId,@"quanziid":_quanID}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSData *data = responseObject;
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"返回值 = %@",str);
        if ([str isEqualToString:@"false"]) {
            
            [self.manager GET:addGuanZhuURL parameters:[@{@"userid":_userId,@"quanziid":_quanID}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
                
                [self postToServer];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"失败");
            }];
            
        }else{
            
            [self.manager GET:deleteGuanZhuURL parameters:[@{@"userid":_userId,@"quanziid":_quanID}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
                
                [self postToServer];
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
    
    CircleCell *cell= (CircleCell *)[self.feelingTableView cellForRowAtIndexPath:rightindexPath];
    
    NSDictionary *dic = [self.feelingArr objectAtIndex:indexPath.row];
    NSString *circleID = [dic objectForKey:@"id"];
    NSString *circleName = [dic objectForKey:@"quanname"];
    NSString *peopleNum = [dic objectForKey:@"guanzhuzongshu"];
    NSString *speakNum = [dic objectForKey:@"tiezizongshu"];
    
    
    CircleDetails_VC *circleDetails = [[CircleDetails_VC alloc] init];
    circleDetails.circleID = circleID;
    circleDetails.circleName = circleName;
    circleDetails.peopleNum = peopleNum;
    circleDetails.speakNum = speakNum;
    circleDetails.guanzhuBtnTitle = cell.saveBtn.titleLabel.text;
    NSLog(@"guanzhuStatus----%@",cell.saveBtn.titleLabel.text);
    circleDetails.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:circleDetails animated:YES];
}
//刷新

- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshView];
    
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:self.feelingTableView];
    
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
    [refreshFooter addToScrollView:self.feelingTableView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}


- (void)footerRefresh
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        jjj++;
        [self postToServer];
        [self.feelingTableView reloadData];
        [self.refreshFooter endRefreshing];
    });
}
@end
