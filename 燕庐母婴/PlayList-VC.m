//
//  PlayList-VC.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/12.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "PlayList-VC.h"
#import "Play-VC.h"
@interface PlayList_VC ()
{
    NSMutableArray *arr;
}
@end

@implementation PlayList_VC

//语音搜索
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    _iflyRecognizerView.delegate = nil;
//    [_iflyRecognizerView cancel];
//}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    _iflyRecognizerView.delegate = self;
    
    [self getData];
}

-(void)getData
{
    self.manager =[AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    [self.manager POST:@"http://101.200.234.127:8080/YanLu/zhishiku/list.do" parameters:[@{@"leiid":self.canShuStr}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.dataArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.biaotiArr = [[NSMutableArray alloc] init];
        
        for (int i = 0; i<self.dataArr.count; i++) {
            
            [self.biaotiArr addObject:[[self.dataArr objectAtIndex:i] objectForKey:@"biaoti"]];
        }
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"播放列表获取相响应失败");
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.titleStr;
    
    self.view.backgroundColor = RGBA(230, 230, 230, 1);
    
    isSearch = NO;
    //用户ID
    _user = [NSUserDefaults standardUserDefaults];
    _userId = [_user objectForKey:@"userid"];
    
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 16, 12, 20);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

    
    //取消导航栏和状态栏的边缘延展效果
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    
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

    
    //语音按钮
    self.speechBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.speechBtn.frame = CGRectMake(self.searchBar.frame.size.width-28, 0, 23, 38);
    [self.speechBtn setImage:[UIImage imageNamed:@"语音"] forState:UIControlStateNormal];
    [self.speechBtn addTarget:self action:@selector(clickSpeechBtnBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.speechBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [self.searchBar addSubview:self.speechBtn];
    
    
    //单元格
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchBarBackGroundView.frame.origin.y+self.searchBarBackGroundView.frame.size.height+7, ScreenWidth, ScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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


-(void)backViewController
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


- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSearch) {
        
        return self.searchArr.count;
    } else {
        
        return self.dataArr.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    PlayList_Cell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[PlayList_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }

    if (isSearch) {
        if (self.searchArr) {
            arr = [[NSMutableArray alloc] init];
            for (int i = 0; i<self.dataArr.count; i++) {
                for (int j = 0; j<self.searchArr.count; j++) {
                    
                    if ([[self.searchArr objectAtIndex:j] isEqual:[[self.dataArr objectAtIndex:i] objectForKey:@"biaoti"]]) {
                        [arr addObject:[self.dataArr objectAtIndex:i]];
                    }
                }
            }
        }
        
        if (arr.count!=0) {
            
            self.shipinURL = [NSURL URLWithString:[[arr objectAtIndex:indexPath.row] objectForKey:@"shipin"]];
            cell.img.image = [UIImage imageWithVideo:self.shipinURL];
            
            cell.titleLab.text = [[arr objectAtIndex:indexPath.row] objectForKey:@"biaoti"];
            
            //时间格式2015-12-04 18：39：23
            //得到当前系统时间
            //特定时间
            NSDateFormatter *date = [[NSDateFormatter alloc] init];
            [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *d=[date dateFromString:[[arr objectAtIndex:indexPath.row] objectForKey:@"time"]];
            
            NSTimeInterval late = [d timeIntervalSince1970]*1;
            NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval now = [dat timeIntervalSince1970]*1;
            NSString *timeString = [[arr objectAtIndex:indexPath.row] objectForKey:@"time"];
            
            NSTimeInterval cha = now-late;
            //liuxiaofeng
            if(cha/60<1 &&cha/60>0) {
                timeString = [NSString stringWithFormat:@"%f", cha];
                timeString = [timeString substringToIndex:timeString.length-7];
                timeString = @"刚刚";
                cell.timeLab.text = [NSString stringWithFormat:@"%@",timeString];
            }
            if (cha/3600<1) {
                timeString = [NSString stringWithFormat:@"%f", cha/60];
                timeString = [timeString substringToIndex:timeString.length-7];
                timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
                cell.timeLab.text = [NSString stringWithFormat:@"%@",timeString];
            }
            if (cha/3600>1&&cha/86400<1) {
                timeString = [NSString stringWithFormat:@"%f", cha/3600];
                timeString = [timeString substringToIndex:timeString.length-7];
                timeString = [NSString stringWithFormat:@"%@小时前", timeString];
                cell.timeLab.text = [NSString stringWithFormat:@"%@",timeString];
            }
            if (cha/86400>1)
            {
                timeString = [NSString stringWithFormat:@"%f", cha/86400];
                timeString = [timeString substringToIndex:timeString.length-7];
                timeString = [NSString stringWithFormat:@"%@天前", timeString];
                cell.timeLab.text = [NSString stringWithFormat:@"%@",timeString];
            }
            
            
            
            //收藏
            [cell.saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            cell.saveBtn.userInteractionEnabled = NO;
            NSString *listID = [[arr objectAtIndex:indexPath.row] objectForKey:@"id"];
            
            [self.manager POST:@"http://101.200.234.127:8080/YanLu/wenzhangshoucang/panduan.do" parameters:[@{@"wenzhangid":listID,@"userid":_userId}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSData *data = responseObject;
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                if ([str isEqualToString:@"true"]) {
                    
                    [cell.saveBtn setImage:[UIImage imageNamed:@"list收藏"] forState:UIControlStateNormal];
                    [cell.saveBtn setTitle:@"已收藏"  forState:UIControlStateNormal];
                    
                }else{
                    
                    [cell.saveBtn setTitle:@"收藏"  forState:UIControlStateNormal];
                    [cell.saveBtn setImage:[UIImage imageNamed:@"list未收藏"] forState:UIControlStateNormal];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"error---");
            }];
            
            
            
            //点赞
            NSString *zanNum = [[arr objectAtIndex:indexPath.row] objectForKey:@"dianzanzongshu"];
            [cell.zanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            cell.zanBtn.userInteractionEnabled = NO;
            [self.manager POST:@"http://101.200.234.127:8080/YanLu/dianzan/panduan.do" parameters:[@{@"wenzhangid":listID,@"userid":_userId}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSData *data = responseObject;
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                if ([str isEqualToString:@"true"]) {
                    
                    [cell.zanBtn setImage:[UIImage imageNamed:@"list已赞"] forState:UIControlStateNormal];
                    [cell.zanBtn setTitle:zanNum  forState:UIControlStateNormal];
                    
                }else{
                    
                    if ([zanNum isEqual:@"0"]) {
                        [cell.zanBtn setTitle:@"点赞"  forState:UIControlStateNormal];
                        
                    } else {
                        [cell.zanBtn setTitle:zanNum  forState:UIControlStateNormal];
                        
                    }
                    [cell.zanBtn setImage:[UIImage imageNamed:@"list未赞"] forState:UIControlStateNormal];
                    
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"error---");
            }];
        }
        
    } else {
        
        self.shipinURL = [NSURL URLWithString:[[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"shipin"]];
        cell.img.image = [UIImage imageWithVideo:self.shipinURL];
        
        
        cell.titleLab.text = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"biaoti"];
        
        
        //时间格式2015-12-04 18:39:23
        //得到当前系统时间
        //特定时间
        NSDateFormatter *date = [[NSDateFormatter alloc] init];
        [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *d = [date dateFromString:[[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"time"]];
        
        NSTimeInterval late = [d timeIntervalSince1970]*1;
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval now = [dat timeIntervalSince1970]*1;
        NSString *timeString = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"time"];
        
        NSTimeInterval cha = now-late;
        //liuxiaofeng
        if(cha/60<1 &&cha/60>0) {
            timeString = [NSString stringWithFormat:@"%f", cha];
            timeString = [timeString substringToIndex:timeString.length-7];
            timeString = @"刚刚";
            cell.timeLab.text = [NSString stringWithFormat:@"%@",timeString];
        }
        if (cha/3600<1) {
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
            timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
            cell.timeLab.text = [NSString stringWithFormat:@"%@",timeString];
        }
        if (cha/3600>1&&cha/86400<1) {
            timeString = [NSString stringWithFormat:@"%f", cha/3600];
            timeString = [timeString substringToIndex:timeString.length-7];
            timeString = [NSString stringWithFormat:@"%@小时前", timeString];
            cell.timeLab.text = [NSString stringWithFormat:@"%@",timeString];
        }
        if (cha/86400>1)
        {
            timeString = [NSString stringWithFormat:@"%f", cha/86400];
            timeString = [timeString substringToIndex:timeString.length-7];
            timeString = [NSString stringWithFormat:@"%@天前", timeString];
            cell.timeLab.text = [NSString stringWithFormat:@"%@",timeString];
        }
        
        
        
        
        //收藏
        [cell.saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cell.saveBtn.userInteractionEnabled = NO;
        NSString *listID = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"id"];
        
        [self.manager POST:@"http://101.200.234.127:8080/YanLu/wenzhangshoucang/panduan.do" parameters:[@{@"wenzhangid":listID,@"userid":_userId}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSData *data = responseObject;
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            if ([str isEqualToString:@"true"]) {
                
                [cell.saveBtn setImage:[UIImage imageNamed:@"list收藏"] forState:UIControlStateNormal];
                [cell.saveBtn setTitle:@"已收藏"  forState:UIControlStateNormal];
                
            }else{
                
                [cell.saveBtn setTitle:@"收藏"  forState:UIControlStateNormal];
                [cell.saveBtn setImage:[UIImage imageNamed:@"list未收藏"] forState:UIControlStateNormal];
            }

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"error---");
        }];
        
        
        
        
        
        
        //点赞
        NSString *zanNum = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"dianzanzongshu"];
        [cell.zanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cell.zanBtn.userInteractionEnabled = NO;
        [self.manager POST:@"http://101.200.234.127:8080/YanLu/dianzan/panduan.do" parameters:[@{@"wenzhangid":listID,@"userid":_userId}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSData *data = responseObject;
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            if ([str isEqualToString:@"true"]) {
                
                [cell.zanBtn setImage:[UIImage imageNamed:@"list已赞"] forState:UIControlStateNormal];
                [cell.zanBtn setTitle:@"已赞"  forState:UIControlStateNormal];
                
            }else{
                
                if ([zanNum isEqual:@"0"]) {
                    [cell.zanBtn setTitle:@"点赞"  forState:UIControlStateNormal];
                    
                } else {
                    [cell.zanBtn setTitle:zanNum  forState:UIControlStateNormal];
                    
                }
                [cell.zanBtn setImage:[UIImage imageNamed:@"list未赞"] forState:UIControlStateNormal];
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error---");
        }];

    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
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


-(void)clickSpeechBtnBtn
{
    [self.searchBar resignFirstResponder];
    
    _result = @" ";
    
    [_iflyRecognizerView start];
}


//滑动页面回收键盘
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [self.searchBar resignFirstResponder];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Play_VC *play = [[Play_VC alloc] init];
    play.hidesBottomBarWhenPushed =YES;
    if (isSearch) {
        if (arr.count==0) {
            play.listID = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"id"];
            play.canshuStr = self.canShuStr;
            
        }else{
        
            play.listID = [[arr objectAtIndex:indexPath.row] objectForKey:@"id"];
            play.canshuStr = self.canShuStr;
        }
    }else{
        
        play.listID = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"id"];
        play.canshuStr = self.canShuStr;
    }
    [self.navigationController pushViewController:play animated:YES];
}


//点击搜索框时调用
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    isSearch = YES;
    self.searchArr = [[NSArray alloc] init];
    
    self.speechBtn.frame = CGRectMake(self.searchBar.frame.size.width-58, 0, 23, 38);
}


//单击虚拟键盘上的search时激发
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self filterBySubstring:searchBar.text];
    [searchBar resignFirstResponder];
    searchBar.text = @"";
}



-(void)filterBySubstring:(NSString*)subStr
{
    isSearch = YES;
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",subStr];
    self.searchArr = [self.biaotiArr filteredArrayUsingPredicate:pred];
    
    [self.tableView reloadData];
}

@end
