//
//  SearchResult-VC.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/15.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "SearchResult-VC.h"

@interface SearchResult_VC ()

@end

@implementation SearchResult_VC


-(void)viewWillAppear:(BOOL)animated
{
    [self.searchBar becomeFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"搜 索 结 果";
    
    //设置页面背景颜色
    self.view.backgroundColor = RGBA(230, 230, 230, 1);
    
    //返回按钮
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(20, 14, 16, 20);
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

    
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
    self.searchBar.text = self.searchStr;
    self.searchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:self.searchBar.bounds.size];
    self.searchBar.showsScopeBar = YES;
    [self.searchBarBackGroundView addSubview:self.searchBar];

    
    //语音按钮
    self.speechBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.speechBtn.frame = CGRectMake(self.searchBar.frame.size.width-58, 0, 23, 38);
    [self.speechBtn setImage:[UIImage imageNamed:@"语音"] forState:UIControlStateNormal];
    [self.speechBtn addTarget:self action:@selector(clickSpeechBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.speechBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [self.searchBar addSubview:self.speechBtn];

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchBarBackGroundView.frame.origin.y+self.searchBarBackGroundView.frame.size.height+7, ScreenWidth, ScreenHeight-38) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    
    
    //语音搜索
    //启动参数
    NSString *appid = @"53be3a59";
    NSString *initString = [NSString stringWithFormat:@"appid=%@",appid];
    [IFlySpeechUtility createUtility:initString];
    
    //初始化语音识别控件
    self.iflyRecognizerView = [[IFlyRecognizerView alloc]initWithCenter:self.view.center];
    self.iflyRecognizerView.delegate = self;
    [self.iflyRecognizerView setParameter: @"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    //asr_audio_path保存录音文件名,默认目录是documents
    [self.iflyRecognizerView setParameter: @"asrview.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    //设置返回的数据格式为默认plain
    [self.iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
}


- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}


-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
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



-(void)clickSpeechBtn
{
    [self.searchBar resignFirstResponder];
    self.result = @"";
    [_iflyRecognizerView start];
}


//语音搜索
- (void)onError:(IFlySpeechError *)error
{
    NSLog(@"搜索错误");
}



- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    NSDictionary *dic = [resultArray objectAtIndex:0];
    NSMutableString *result = [NSMutableString new];
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    
    _result = [NSString stringWithFormat:@"%@%@",_result,result];
    
    if (isLast) {
        
        if (_result == nil||[_result isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"无法识别，请再说一遍" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }else{
            
            self.searchBar.text = _result;
        }
    }
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self postSearchDataToServer];
}


-(void)postSearchDataToServer
{
    self.manager =[AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/zhishiku/list.do" parameters:[@{@"biaoti":self.searchBar.text}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.resultArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"连接服务错误");
    }];
}


//点击搜索框时调用
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.speechBtn.frame = CGRectMake(self.searchBar.frame.size.width-58, 0, 23, 38);
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *result = @"result";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:result];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:result];
    }
    
    cell.textLabel.text = [[self.resultArr objectAtIndex:indexPath.row] objectForKey:@"biaoti"];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Play_VC *playv = [[Play_VC alloc] init];
    playv.hidesBottomBarWhenPushed =YES;
    playv.listID = [[self.resultArr objectAtIndex:indexPath.row] objectForKey:@"id"];
    playv.canshuStr = [[self.resultArr objectAtIndex:indexPath.row] objectForKey:@"leiid"];
    [self.navigationController pushViewController:playv animated:YES];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.searchBar resignFirstResponder];
}


//滑动页面回收键盘
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [self.searchBar resignFirstResponder];
}

@end
