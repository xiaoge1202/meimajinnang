//
//  AppDelegate.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/5/28.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "AppDelegate.h"
#import "Baby-VC.h"
#import "Circle-VC.h"
#import "Search-VC.h"
#import "Find-VC.h"
#import "Self-VC.h"
#import "EnterViewController.h"
#import "GuideViewController.h"

#import "UMSocial.h"
#import "WXApi.h"
#import "UMSocialWechatHandler.h"

#import "UMSocialQQHandler.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [FIR handleCrashWithKey:@"97142aec441113c3787c2c6edfbed897"];
    
    [UMSocialData setAppKey:@"507fcab25270157b37000010"];
    [UMSocialData openLog:YES];
    
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    
    //打开新浪微博的SSO开关

    
    //设置分享到<a href="http://www.it165.net/qq/qqkj/" target="_blank" class="keylink">QQ空间</a>的应用Id，和分享url 链接
    
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    
//    [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeImage;
    
    //设置支持没有客户端情况下使用SSO授权
    
    [UMSocialQQHandler setSupportWebView:YES];


    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
        [UIColor whiteColor], NSForegroundColorAttributeName,        [UIFont fontWithName:@"Microsoft Yahei UI" size:20.0], NSFontAttributeName, nil]];
    
    TabBar_VC *tab = [[TabBar_VC alloc]init];;
    tab.delegate = self;
    tab.tabBarController.tabBar.backgroundColor = RGBA(43, 44, 54, 1);
    tab.tabBar.backgroundColor = RGBA(43, 44, 54, 1);

  
    ASIDownloadCache *cache = [[ASIDownloadCache alloc] init];
    self.myCache = cache;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    [self.myCache setStoragePath:[documentDirectory stringByAppendingPathComponent:@"resource"]];
    [self.myCache setDefaultCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    
    ASIDownloadCache *cache1 = [[ASIDownloadCache alloc] init];
    self.myCache1 = cache1;
    [self.myCache1 setStoragePath:[documentDirectory stringByAppendingPathComponent:@"selftouxiang"]];
    [self.myCache1 setDefaultCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    
    
    EnterViewController *loginVC = [[EnterViewController alloc] init];
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    GuideViewController *guideVC = [[GuideViewController alloc] init];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"firstLogin"]) {
        
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"welcome"]) {
            self.window.rootViewController = guideVC;
        }
        else
        {
            self.window.rootViewController = loginNav;
        }
    }else{
        
        self.window.rootViewController = tab;
    }
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    return [ShareSDK handleOpenURL:url wxDelegate:self];
    //return [ShareSDK handleOpenURL:url wxDelegate:self];
    //return [WXApi handleOpenURL:url delegate:self];
    return [TencentOAuth HandleOpenURL:url];

}
//获取url路径
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //return
    //[UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
    return [TencentOAuth HandleOpenURL:url];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [UMSocialSnsService applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
