//
//  SendVideo-VC.h
//  燕庐母婴
//
//  Created by 董飞剑 on 15/7/7.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "AFHTTPRequestOperationManager.h"
@interface SendVideo_VC : UIViewController<UITextViewDelegate>
{
    NSUserDefaults *_user;
    NSString *_userId;
}
@property (strong,nonatomic) AFHTTPRequestOperationManager *manager;

@property (strong,nonatomic) UIButton *backBtn;
@property (strong,nonatomic) UIButton *sendBtn;

@property (strong,nonatomic) UITextView *textView;
@property (strong,nonatomic) UILabel *label;

@property (strong,nonatomic) NSString *fileURL;

@property (strong,nonatomic) UIImageView *videoImg;

@end
