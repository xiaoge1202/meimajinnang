//
//  Search-VC.m
//  滚动视图
//
//  Created by 董飞剑 on 15/5/28.
//  Copyright (c) 2015年 侯泽彭. All rights reserved.
//

#import "Search-VC.h"
#import "NavigationInteractiveTransition.h"

@interface Search_VC ()<UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIPanGestureRecognizer *popRecognizer;
/**
 *  方案一不需要的变量
 */
@property (nonatomic, strong) NavigationInteractiveTransition *navT;
@end

@implementation Search_VC


-(void)viewDidDisappear:(BOOL)animated
{
    [firstCell.moviePlayerCtl pause];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getdataFromServer];
}


-(void)getdataFromServer
{
    self.manager =[AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    [self.manager GET:@"http://101.200.234.127:8080/YanLu/zhishiku/list.do" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.apperArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"连接服务错误");
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"最 权 威 的 视 频 知 识 库";

     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    

    if ([self.searchStr isEqualToString:@"1"]) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(10, 16, 12, 20);
        [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    
    //取消导航栏和状态栏的边缘延展效果
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    
    self.dataArr = [NSArray arrayWithObjects:@"最 新 知 识",@"产 后 瘦 身",@"母 乳 的 好 处",@"婴 儿 猛 涨 期",@"靓 妆 护 肤", nil];
    

    //设置页面背景颜色
    self.view.backgroundColor = RGBA(230, 230, 230, 1);
    
    
    //搜索框背景视图
    self.searchBarBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(7, 7, ScreenWidth-14, 38)];
    self.searchBarBackGroundView.layer.borderWidth = 1.5;
    self.searchBarBackGroundView.layer.masksToBounds = YES;
    self.searchBarBackGroundView.layer.cornerRadius = 10;
    self.searchBarBackGroundView.layer.borderColor = RGBA(241, 153, 178, 1).CGColor;
    self.searchBarBackGroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchBarBackGroundView];
    
    
    //搜索框
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-14, 38)];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @" 大 家 都 在 搜 .....";
    self.searchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:self.searchBar.bounds.size];
    self.searchBar.showsScopeBar = YES;
    [self.searchBarBackGroundView addSubview:self.searchBar];

    
    self.searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.searchBar.frame.size.width-28, 38)];
    [self.searchBtn addTarget:self action:@selector(pushToSearchResultView) forControlEvents:UIControlEventTouchUpInside];
    [self.searchBar addSubview:self.searchBtn];
    
    
    //语音按钮
    self.speechBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.speechBtn.frame = CGRectMake(self.searchBtn.frame.origin.x+self.searchBtn.frame.size.width, 0, self.searchBar.frame.size.width-self.searchBtn.frame.size.width, 38);
    [self.speechBtn setImage:[UIImage imageNamed:@"语音"] forState:UIControlStateNormal];
    [self.speechBtn addTarget:self action:@selector(pushToSearchResultView) forControlEvents:UIControlEventTouchUpInside];
    [self.speechBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [self.searchBar addSubview:self.speechBtn];


    if ([self.searchStr isEqualToString:@"1"]) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchBarBackGroundView.frame.origin.y+self.searchBarBackGroundView.frame.size.height+7, ScreenWidth, ScreenHeight-116) style:UITableViewStylePlain];
    }
    else
    {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchBarBackGroundView.frame.origin.y+self.searchBarBackGroundView.frame.size.height+7, ScreenWidth, ScreenHeight-160) style:UITableViewStylePlain];
    }
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = RGBA(235, 235, 235, 1);
    [self setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    

    self.headTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    self.headTitleLab.text = @"     最 新 视 频 知 识";
    self.headTitleLab.textColor = [UIColor whiteColor];
    self.headTitleLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
    self.headTitleLab.backgroundColor = RGBA(237, 119, 147, 1);
    self.tableView.tableHeaderView = self.headTitleLab;
    
    UIGestureRecognizer *gesture = self.navigationController.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];
    
    //    #if USE_方案一
    //        _navT = [[NavigationInteractiveTransition alloc] initWithViewController:self];
    //        [popRecognizer addTarget:_navT action:@selector(handleControllerPop:)];
    //
    //    #elif USE_方案二
    /**
     *  获取系统手势的target数组
     */
    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
    /**
     *  获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget的私有类，它有一个属性叫_target
     */
    id gestureRecognizerTarget = [_targets firstObject];
    /**
     *  获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
     */
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    /**
     *  通过前面的打印，我们从控制台获取出来它的方法签名。
     */
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    /**
     *  创建一个与系统一模一样的手势，我们只把它的类改为UIPanGestureRecognizer
     */
    [popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];
    // Do any additional setup after loading the view.
    //#endif
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    return self.navigationController.viewControllers.count != 1 && ![[self.navigationController valueForKey:@"_isTransitioning"] boolValue];
}

-(void)backViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pushToSearchResultView
{
    searchResult = [[SearchResult_VC alloc] init];
    searchResult.hidesBottomBarWhenPushed = YES;
    searchResult.searchStr = self.searchBar.text;
    [self.navigationController pushViewController:searchResult animated:YES];
}


//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
    } else {
        
        return self.dataArr.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        static NSString *first = @"firstCell";
        firstCell = [tableView dequeueReusableCellWithIdentifier:first];
        if (!firstCell) {
            
            firstCell = [[SearchFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:first];
            firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        NSString *shipinStr = [[self.apperArr objectAtIndex:indexPath.row] objectForKey:@"shipin"];
        self.fileURL = [NSURL URLWithString:shipinStr];
        NSLog(@"fileURL ==== %@",self.fileURL);
        
        firstCell.moviePlayerCtl.contentURL = self.fileURL;
        
        //缩略图
        firstCell.imgView.image = [UIImage imageWithVideo:self.fileURL];
        
        //播放按钮
        [firstCell.PlayerBtn addTarget:self action:@selector(PlayerBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
        return firstCell;

    }else{
    
        static NSString *str = @"cell";
        SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        cell.backgroundColor = RGBA(157, 189, 228, 1);
        cell.label.text = [self.dataArr objectAtIndex:indexPath.row];
        
        switch (indexPath.row) {
            case 0:
                cell.backgroundColor = RGBA(157, 189, 228, 1);
                break;
                
            case 1:
                cell.backgroundColor = RGBA(188, 218, 134, 1);
                break;
                
            case 2:
                cell.backgroundColor = RGBA(241, 153, 178, 1);
                break;
                
            case 3:
                cell.backgroundColor = RGBA(196, 180, 215, 1);
                break;
                
            case 4:
                cell.backgroundColor = RGBA(242, 216, 151, 1);
                break;
                
            default:
                break;
        }
        return cell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return ScreenWidth/16*9;
    }else{
        
        return 50;
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
        PlayList_VC *playList = [[PlayList_VC alloc] init];
        
        playList.titleStr = [self.dataArr objectAtIndex:indexPath.row];
        playList.canShuStr = [NSString stringWithFormat:@"%d",indexPath.row+1];
        
        playList.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:playList animated:YES];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 0.001;
    } else {
        
        return 4;
    }
}


-(void)PlayerBtnPress:(UIButton *)but
{
    but.hidden = YES;
    firstCell.imgView.hidden = YES;
    [firstCell.moviePlayerCtl play];
}


@end
