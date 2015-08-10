//
//  MyCircle-VC.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/5.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "MyCircle-VC.h"
#import "MJRefresh.h"
#import "MJRefreshFooterView.h"
#import "MJRefreshHeaderView.h"
#import "UIImageView+AFNetworking.h"
@interface MyCircle_VC ()
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    
}
@property (nonatomic) NSInteger activeIndex;

@end

@implementation MyCircle_VC

-(void)viewWillAppear:(BOOL)animated
{
    [self getDataFromServer];

}

-(void)getDataFromServer
{
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    [self.manager GET:myGuanZhuURL parameters:[@{@"userid":_userId}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.myCircleArr = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:0 error:nil];
        NSLog(@"我的圈 = %@,%d",self.myCircleArr,self.myCircleArr.count);
        [self.myCircleTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"失败");
    }];

}

- (void)addFooter
{
    __unsafe_unretained MyCircle_VC *vc = self;
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.myCircleTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        
        [self getDataFromServer];

        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [vc performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0];
        
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    footer.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        // 刷新完毕就会回调这个Block
        NSLog(@"%@----刷新完毕", refreshView.class);
    };
    _footer = footer;
}



- (void)addHeader
{
    
    __unsafe_unretained MyCircle_VC *vc = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.myCircleTableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        
        [self getDataFromServer];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [vc performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        // 刷新完毕就会回调这个Block
        NSLog(@"%@----刷新完毕", refreshView.class);
    };
    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        // 控件的刷新状态切换了就会调用这个block
        switch (state) {
            case MJRefreshStateNormal:
                NSLog(@"%@----切换到：普通状态", refreshView.class);
                break;
                
            case MJRefreshStatePulling:
                NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
                break;
                
            case MJRefreshStateRefreshing:
                NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
                break;
            default:
                break;
        }
    };
    //[header beginRefreshing];
    _header = header;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    
   
    // 刷新表格
    [self.myCircleTableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.activeIndex = 1;

    
    _user = [NSUserDefaults standardUserDefaults];
    _userId = [_user objectForKey:@"userid"];
    
//    [self getDataFromServer];
    
    self.myCircleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-158) style:UITableViewStylePlain];
    self.myCircleTableView.dataSource = self;
    self.myCircleTableView.delegate = self;
    [self.view addSubview:self.myCircleTableView];
    
    
    [self setExtraCellLineHidden:self.myCircleTableView];
    /*
    [self.myCircleTableView addHeaderWithTarget:self action:@selector(headerRefresh)];
    [self.myCircleTableView addFooterWithTarget:self action:@selector(footerRefresh)];
*/
    
    // 3.1.下拉刷新
    [self addHeader];
    
    // 3.2.上拉加载更多
    [self addFooter];

}
/*
- (void)headerRefresh{
    self.activeIndex = 1;
    
    
    [self requestDataWithIndex:self.activeIndex flag:NO];
}

- (void)footerRefresh{
    
    self.activeIndex++;
    [self requestDataWithIndex:self.activeIndex flag:YES];
}

- (void)requestDataWithIndex:(NSInteger)index flag:(BOOL)isMore{
    
    
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    [self.manager GET:myGuanZhuURL parameters:[@{@"userid":_userId}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        if (isMore == NO) {
            
            self.myCircleArr = nil;
        }
        
        NSData *data=(NSData *)responseObject;
        //源数组
        self.myCircleArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"circleArr--%@",self.myCircleArr);
        
        
        // 刷新表格
        [self.myCircleTableView reloadData];
        
        isMore ? [self.myCircleTableView footerEndRefreshing] : [self.myCircleTableView headerEndRefreshing];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
        
        isMore ? [self.myCircleTableView footerEndRefreshing] : [self.myCircleTableView headerEndRefreshing];
    }];
    
    
    
    
}

*/
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myCircleArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"str";
    CircleCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[CircleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    //cell.headImg.image = [UIImage imageNamed:@"circleImg"];
    
    [cell.headImg setImageWithURL:[NSURL URLWithString:[[self.myCircleArr objectAtIndex:indexPath.row] objectForKey:@"qtupian"]] placeholderImage:[UIImage imageNamed:@"头像"]];
    cell.circleNameLabel.text = [[self.myCircleArr objectAtIndex:indexPath.row] objectForKey:@"quanname"];
    
    
    cell.peopleNumImg.image = [UIImage imageNamed:@"人数"];
    cell.peopleNumLabel.text = [[self.myCircleArr objectAtIndex:indexPath.row] objectForKey:@"guanzhuzongshu"];
    
    
    cell.speakNumImg.image = [UIImage imageNamed:@"话题"];
    cell.speakNumLabel.text = [[self.myCircleArr objectAtIndex:indexPath.row] objectForKey:@"tiezizongshu"];

//    NSString *or = [[self.myCircleArr objectAtIndex:indexPath.row] objectForKey:@"gaunzhu"];
//    NSLog(@"=====%@",or);
    [cell.saveBtn addTarget:self action:@selector(collectCircle:) forControlEvents:UIControlEventTouchUpInside];
    cell.saveBtn.tag = indexPath.row+100;
    cell.saveBtn.backgroundColor = [UIColor whiteColor];
    cell.saveBtn.frame = CGRectMake(ScreenWidth-58, 30, 45, 18);
    [cell.saveBtn setTitle:@"取消关注" forState:UIControlStateNormal];
    [cell.saveBtn setTitleColor:RGBA(200, 200, 200,1) forState:UIControlStateNormal];
    return cell;
}

//关注按钮
-(void)collectCircle:(UIButton *)but
{
    for (int i = 0; i < [self.myCircleArr count]; i++) {
        if (but.tag == i+100) {
            
            self.dictionary = [self.myCircleArr objectAtIndex:i];
            _quanID = [self.dictionary objectForKey:@"id"];
        }
    }
    
    [self.manager GET:deleteGuanZhuURL parameters:[@{@"userid":_userId,@"quanziid":_quanID}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        [self getDataFromServer];
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
    
    CircleCell *cell= (CircleCell *)[self.myCircleTableView cellForRowAtIndexPath:rightindexPath];
    
    NSDictionary *dic = [self.myCircleArr objectAtIndex:indexPath.row];
    NSString *circleID = [dic objectForKey:@"id"];
    NSString *circleName = [dic objectForKey:@"quanname"];
    NSString *peopleNum = [dic objectForKey:@"guanzhuzongshu"];
    NSString *speakNum = [dic objectForKey:@"tiezizongshu"];
    
    
    CircleDetails_VC *circleDetails = [[CircleDetails_VC alloc] init];
    circleDetails.circleID = circleID;
    circleDetails.circleName = circleName;
    circleDetails.peopleNum = peopleNum;
    circleDetails.speakNum = speakNum;
    circleDetails.mycircleArr = self.myCircleArr;
    circleDetails.guanzhuBtnTitle = cell.saveBtn.titleLabel.text;
    NSLog(@"guanzhuStatus----%@",cell.saveBtn.titleLabel.text);
    
    circleDetails.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:circleDetails animated:YES];
}

@end
