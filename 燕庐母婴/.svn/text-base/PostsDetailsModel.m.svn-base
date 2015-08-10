//
//  PostsDetailsModel.m
//  燕庐母婴
//
//  Created by apple on 15/6/11.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "PostsDetailsModel.h"

@implementation PostsDetailsModel
@synthesize userID,userTitle,shouchang,dianzhan,headImage,userName,babyDay,newsText,textImage,remark;

-(id)initWithJson:(NSDictionary *) dic{
    
    self = [super init];
    if (self) {
        
        self->userID = [[dic objectForKey:@"userId"] stringValue];
        
        self->userTitle=[dic objectForKey:@"userTitle"];
        
        //self->typeId=[dic objectForKey:@"typeId"];
        
        self->shouchang=[dic objectForKey:@"shouchang"];
        
        self->dianzhan=[dic objectForKey:@"dianzhan"];
        
        self->headImage=[dic objectForKey:@"headImage"];
        
        self->userName = [dic objectForKey:@"userName"];
        
        self->userName = [dic objectForKey:@"userName"];
        
        self->babyDay = [dic objectForKey:@"babyDay"];
        
        self->newsText = [dic objectForKey:@"newsText"];
        
        self->textImage = [dic objectForKey:@"textImage"];
        
        self->remark = [dic objectForKey:@"remark"];
        
    }
    return self;
}
- (void)dealloc
{
    self.userID = nil;
    
    self.userTitle=nil;
    
    //self.typeId=nil;
    
    self.shouchang=nil;
    
    self.dianzhan=nil;
    
    self.headImage=nil;
    
    self.userName=nil;
    
    self.babyDay=nil;
    
    self.textImage = nil;
    
    self.remark = nil;
}


@end
