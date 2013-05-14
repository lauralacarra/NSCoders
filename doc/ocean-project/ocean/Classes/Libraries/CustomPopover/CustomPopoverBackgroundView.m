//
//  CustomPopoverBackgroundView.m
//  ocean
//
//  Created by Tope on 19/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomPopoverBackgroundView.h"

@implementation CustomPopoverBackgroundView

@synthesize arrowOffset, arrowDirection;


-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) 
    {
        UIImage * bgImage = [[UIImage tallImageNamed:@"popover-background.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];        
        _imageView = [[UIImageView alloc] initWithImage:bgImage];
                               
        [self addSubview:_imageView];
    }
    return self;
}

-(void)layoutSubviews
{
    _imageView.frame = CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height);
}

+(UIEdgeInsets)contentViewInsets{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

+(CGFloat)arrowHeight{
    return 30.0;
}

+(CGFloat)arrowBase{
    return 42.0;
}

@end