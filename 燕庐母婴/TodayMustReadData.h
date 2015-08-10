//
//  TodayMustReadData.h
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/19.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface TodayMustReadData : NSObject
{
    sqlite3* sqliteDB;
}

+(TodayMustReadData*)sharedImage;

-(void)openPphoto;

-(void)initTable;

-(void)addImage:(NSString *)Image;

-(void)deleteImg:(NSString*)deleImage;

-(NSMutableArray*)findAll;

-(void)closePphoto;
@end
