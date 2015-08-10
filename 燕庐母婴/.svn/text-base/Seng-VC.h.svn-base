//
//  Seng-VC.h
//  燕庐母婴
//
//  Created by 董飞剑 on 15/5/29.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//
//》》》》》》》》》》》》》发送帖子《《《《《《《《《《《《《

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
#import "PrefixHeader.pch"
#import "FacialView.h"
//#import "chatpage.h"
//#import "ChatCell.h"
#import "ASIFormDataRequest.h"

#define KFacialSizeWidth 24
#define KFacialSizeHeight 24
@interface Seng_VC : UIViewController<UITextViewDelegate,facialViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UILabel *label;
   
    NSUserDefaults *_user;
    NSString *_userId;
    NSString* filePath;
    NSString *currentTime;

}
@property (strong, nonatomic)AFHTTPRequestOperationManager *manager;
@property (strong, nonatomic) UIButton *backBtutton;
@property (strong, nonatomic) UITextField *titleField;
@property (strong, nonatomic) UIView *line;
@property (strong, nonatomic) UITextView *bodyView;
@property (strong, nonatomic) UIView *theInputView;

@property (strong, nonatomic) UIButton *faceBtu;
@property (strong, nonatomic) UIButton *picBtu;

@property (strong, nonatomic) NSMutableDictionary *dataDic;
@property (strong, nonatomic) NSString *idCount;

@property (nonatomic,strong) UIImagePickerController *picker;

-(void)getImageRange:(NSString*)message :(NSMutableArray*)array;
-(void)parserMessage:(NSString*)message;
@end
