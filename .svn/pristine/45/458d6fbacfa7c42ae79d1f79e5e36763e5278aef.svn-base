//
//  TodayMustReadData.m
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/19.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "TodayMustReadData.h"
static TodayMustReadData* today = nil;
@implementation TodayMustReadData
+(TodayMustReadData*)sharedImage
{
    if (today == nil) {
        today = [[TodayMustReadData alloc] init];
    }
    return today;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    if (today == nil) {
        today = [super allocWithZone:zone];
    }
    return today;
}

+(id)copyWithZone:(struct _NSZone *)zone
{
    if (today == nil) {
        today = [super copyWithZone:zone];
    }
    return today;
}

-(NSString*)getDBPath
{
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* dbPath = [documentPath stringByAppendingPathComponent:@"image1.db"];
    NSLog(@"%@",dbPath);
    return dbPath;
}

-(void)openPphoto
{
    NSString* dbPath = [self getDBPath];
    const char* c_dbPath = [dbPath UTF8String];
    sqlite3_open(c_dbPath, &sqliteDB);
    [self initTable];
}

-(void)initTable
{
    static char* SQL = "create table TodayMustReadImg (Image text)";
    sqlite3_stmt* stmt;
    sqlite3_prepare_v2(sqliteDB, SQL, -1, &stmt, nil);
    
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
}

-(void)addImage:(NSString *)Image
{
    static char* sql = "insert into TodayMustReadImg values(?)";
    sqlite3_stmt* stmt;
    sqlite3_prepare_v2(sqliteDB, sql, -1, &stmt, nil);
    
    sqlite3_bind_text(stmt, 1, [Image UTF8String], -1, SQLITE_TRANSIENT);
    
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
}

-(void)deleteImg:(NSString *)deleImage
{
    static char* sql = "delete from TodayMustReadImg where Image = ?";
    sqlite3_stmt* stmt;
    sqlite3_prepare_v2(sqliteDB, sql, -1, &stmt, nil);
    sqlite3_bind_text(stmt, 1, [deleImage UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
}

-(NSMutableArray*)findAll
{
    static char* sql = "select * from TodayMustReadImg";
    sqlite3_stmt* stmt;
    sqlite3_prepare_v2(sqliteDB, sql, -1, &stmt, nil);
    NSMutableArray* allData = [NSMutableArray array];
    
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        NSMutableDictionary* studentData = [NSMutableDictionary dictionary];
        
        const char* footImage = (const char*)sqlite3_column_text(stmt, 0);
        [studentData setObject:[NSString stringWithUTF8String:footImage] forKey:@"Image"];
        
        [allData addObject:studentData];
    }
    sqlite3_finalize(stmt);
    return allData;
}

-(void)closePphoto
{
    sqlite3_close(sqliteDB);
}
@end
