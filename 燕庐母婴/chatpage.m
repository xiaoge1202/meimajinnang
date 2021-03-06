//
//  chatpage.m
//  KeyBoardTest
//
//  Created by 森 袁 on 12-3-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "chatpage.h"

@implementation chatpage
@synthesize data;

- (void)drawRect:(CGRect)rect
{
    UIFont *fon=[UIFont systemFontOfSize:14.0f];
	CGFloat upX = 0;
    CGFloat upY = 0;
	if (data) {
		for (int i=0;i<[data count];i++) {
			NSString *str=[data objectAtIndex:i];
			if ([str hasPrefix:@"<"]&&[str hasSuffix:@">"]) 
            {
                if (upX > 200) 
                {
                    upY = upY + 24;
                    upX = 0;
                }
				NSString *imageName=[str substringWithRange:NSMakeRange(1, str.length-2)];
				UIImage *img = [UIImage imageNamed:imageName];
				[img drawInRect:CGRectMake(upX, upY, 24, 24)];
				upX = 24+upX;
                
			}else {
                for (int j = 0; j<[str length]; j++) 
                {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX > 200) 
                    {
                        upY = upY + 24;
                        upX = 0;
                    }
                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(320, 40)];
                    [str drawInRect:CGRectMake(upX, upY, size.width, self.bounds.size.height) withFont:fon];
                    upX=upX+size.width;
                }
			}
        }	
	}
}



@end
