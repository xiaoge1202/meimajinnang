//
//  PostsDetailsModel.h
//  燕庐母婴
//
//  Created by apple on 15/6/11.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "baseObject.h"

@interface PostsDetailsModel : baseObject
@property (nonatomic,strong) NSString *userID;//用户ID
@property (nonatomic,strong) NSString *userTitle;//标题
@property (nonatomic,assign) NSInteger typeId;      //类型ID
@property (nonatomic,strong) NSString *shouchang;        //收藏
@property (nonatomic,strong) NSString *dianzhan;    //点赞
@property (nonatomic,strong) NSString *headImage;         //用户头像
@property (nonatomic,strong) NSString *userName;  //用户名称
@property (nonatomic,strong) NSString *babyDay;     //宝宝出生日期
@property (nonatomic,strong) NSString *newsText;//文本内容
@property (nonatomic,strong) NSString *textImage;//文本图片
@property (nonatomic,strong) NSString *remark;      //签名

-(id)initWithJson:(NSDictionary *) dic;
@end
