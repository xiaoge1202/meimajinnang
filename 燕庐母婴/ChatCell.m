//
//  ChatCell.m
//  KeyBoardTest
//
//  Created by wangqiulei on 11-8-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChatCell.h"
#define KFacialSizeWidth 24
#define KFacialSizeHeight 24

@implementation ChatCell
@synthesize data;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void) drawRect:(CGRect)rect
{
	UIFont *fon=[UIFont systemFontOfSize:14.0f];
	CGFloat upX=0;
    CGFloat upY=0;
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
				UIImage *img=[UIImage imageNamed:imageName];
				[img drawInRect:CGRectMake(upX, upY, 24, 24)];
				upX=24+upX;

			}else {
                
                for (int j = 0; j<[str length]; j++) 
                {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (upX > 200) 
                    {
                        upY = upY + 24;
                        upX = 0;
                    }
                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(ScreenWidth, 40)];
                    [str drawInRect:CGRectMake(upX, upY, size.width, self.bounds.size.height) withFont:fon];
                    upX=upX+size.width;
                }
			}
        }	
	}
}


@end
