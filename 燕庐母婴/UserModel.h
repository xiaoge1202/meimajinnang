//
//  UserModel.h
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/4.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic,strong) NSMutableDictionary *bitthday;
@property (nonatomic,strong) NSString *huaiyuntianshu;
@property (nonatomic,strong) NSString *nicheng;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *qianming;
@property (nonatomic,strong) NSString *touxiang;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *useraddr;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *zhuangtai;
@property (nonatomic,strong) NSString *huaiyuntime;
+(UserModel*)sharedUserModel;
-(void)releaseUser;
@end
