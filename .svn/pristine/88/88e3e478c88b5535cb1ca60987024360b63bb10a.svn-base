//
//  More-VC.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/5.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "More-VC.h"

@interface More_VC ()

@end

@implementation More_VC

-(void)viewWillAppear:(BOOL)animated
{
    [self postToServer];
}


-(void)postToServer
{
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    [self.manager GET:circleURL parameters:[@{@"leiid":self.leiid}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.moreArr = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:0 error:nil];
        [self.moreTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"链接服务器失败");
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leiid = @"7";
    _user = [NSUserDefaults standardUserDefaults];
    _userId = [_user objectForKey:@"userid"];
    
    
    self.moreTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    self.moreTableView.dataSource = self;
    self.moreTableView.delegate = self;
    [self.view addSubview:self.moreTableView];
    
    
    [self setExtraCellLineHidden:self.moreTableView];
    
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
    return self.moreArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"str";
    cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[CircleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    cell.headImg.image = [UIImage imageNamed:@"circleImg"];
    
    
    cell.circleNameLabel.text = [[self.moreArr objectAtIndex:indexPath.row] objectForKey:@"quanname"];
    
    
    cell.peopleNumImg.image = [UIImage imageNamed:@"人数"];
    cell.peopleNumLabel.text = [[self.moreArr objectAtIndex:indexPath.row] objectForKey:@"guanzhuzongshu"];
    
    
    cell.speakNumImg.image = [UIImage imageNamed:@"话题"];
    cell.speakNumLabel.text = [[self.moreArr objectAtIndex:indexPath.row] objectForKey:@"tiezizongshu"];
    
    
    quanzi = [[self.moreArr objectAtIndex:indexPath.row] objectForKey:@"id"];
    [cell.saveBtn addTarget:self action:@selector(saveBtnIsClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.saveBtn.tag = indexPath.row;
    
    [self.manager GET:panDuanURL parameters:[@{@"userid":_userId,@"quanziid":quanzi}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSData *data = responseObject;
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"返回值 = %@",str);
        if ([str isEqualToString:@"false"]) {
            
            
            cell.saveBtn.frame = CGRectMake(ScreenWidth-55, 30, 40, 18);
            [cell.saveBtn setBackgroundColor:RGBA(237, 81, 129, 1)];
            [cell.saveBtn setTitle:@"关注" forState:UIControlStateNormal];
            [cell.saveBtn setImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
            //按钮设置图片(上左下右)
            [cell.saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
            
        }else{
            
            cell.saveBtn.backgroundColor = [UIColor whiteColor];
            cell.saveBtn.frame = CGRectMake(ScreenWidth-58, 30, 45, 18);
            [cell.saveBtn setTitle:@"已关注" forState:UIControlStateNormal];
            [cell.saveBtn setTitleColor:RGBA(200, 200, 200,1) forState:UIControlStateNormal];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"失败");
    }];
    
    return cell;
}

-(void)saveBtnIsClick:(UIButton *)sender
{
    for (int i = 0; i < [self.moreArr count]; i++) {
        if (sender.tag == i) {
            
            self.dictionary = [self.moreArr objectAtIndex:i];
            _quanID = [self.dictionary objectForKey:@"id"];
        }
    }
    
    [self.manager GET:panDuanURL parameters:[@{@"userid":_userId,@"quanziid":_quanID}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSData *data = responseObject;
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"返回值 = %@",str);
        if ([str isEqualToString:@"false"]) {
            
            [self.manager GET:addGuanZhuURL parameters:[@{@"userid":_userId,@"quanziid":quanzi}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
                
                cell.saveBtn.backgroundColor = [UIColor whiteColor];
                cell.saveBtn.frame = CGRectMake(ScreenWidth-58, 30, 45, 18);
                [cell.saveBtn setTitle:@"已关注" forState:UIControlStateNormal];
                [cell.saveBtn setTitleColor:RGBA(200, 200, 200,1) forState:UIControlStateNormal];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"失败");
            }];
            
        }else{
            
            [self.manager GET:deleteGuanZhuURL parameters:[@{@"userid":_userId,@"quanziid":quanzi}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
                
                cell.saveBtn.frame = CGRectMake(ScreenWidth-55, 30, 40, 18);
                [cell.saveBtn setBackgroundColor:RGBA(237, 81, 129, 1)];
                [cell.saveBtn setTitle:@"关注" forState:UIControlStateNormal];
                [cell.saveBtn setImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
                //按钮设置图片(上左下右)
                [cell.saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
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
    NSDictionary *dic = [self.moreArr objectAtIndex:indexPath.row];
    NSString *circleID = [dic objectForKey:@"id"];
    NSString *circleName = [dic objectForKey:@"quanname"];
    NSString *peopleNum = [dic objectForKey:@"guanzhuzongshu"];
    NSString *speakNum = [dic objectForKey:@"tiezizongshu"];
    
    
    CircleDetails_VC *circleDetails = [[CircleDetails_VC alloc] init];
    circleDetails.circleID = circleID;
    circleDetails.circleName = circleName;
    circleDetails.peopleNum = peopleNum;
    circleDetails.speakNum = speakNum;
    
    circleDetails.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:circleDetails animated:YES];
}

@end
