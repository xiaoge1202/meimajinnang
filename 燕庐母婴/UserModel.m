//
//  UserModel.m
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/4.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "UserModel.h"
static UserModel *user = nil;
@implementation UserModel
+(UserModel*)sharedUserModel
{
    @synchronized(self){
        if (user == nil) {
            user = [[UserModel alloc] init];
        }
    }
    return user;
}
-(void)releaseUser
{
    user = nil;
}

-(id)init
{
    if (self == [super init]) {
        
    }
    return self;
}
@end
