//
//  PopoverSegment.m
//  ocean
//
//  Created by Valentin Filip on 3/25/12.
//  Copyright (c) 2012 App Design Vault. All rights reserved.
//

#import "PopoverSegment.h"

#define BUTTON_WIDTH 155.0
#define BUTTON_SEGMENT_WIDTH 155.0
#define CAP_WIDTH 12.0

@interface PopoverSegment ()

@property (nonatomic, strong)   CustomSegmentedControl  *segments;

- (UIButton *)buttonForIndex:(NSUInteger)segmentIndex;

@end

@implementation PopoverSegment

@synthesize titles;
@synthesize delegate;
@synthesize segments;

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    
    if (!self.segments) {
        self.segments = [[CustomSegmentedControl alloc] initWithSegmentCount:titles.count 
                                                            dividerImage:nil tag:0 delegate:self];
        self.segments.frame = CGRectMake(0, (viewHeight-30)/2, viewWidth, 30);
        [self addSubview:self.segments];
    }
    
}

- (UIButton *)buttonForIndex:(NSUInteger)segmentIndex {
    UIImage* buttonImage = nil;
    UIImage* buttonPressedImage = nil;
    NSUInteger buttonWidth = 0;
    buttonWidth = 100;
    
    NSString *position = @"middle";
    if (segmentIndex == 0) {
        position = @"first";
    } else if(segmentIndex == self.titles.count-1) {
        position = @"last";
    }
    
    NSString *imgName = [NSString stringWithFormat:@"popover-menu-%@.png", position, nil];
    NSString *imgNameSelected = [NSString stringWithFormat:@"popover-menu-%@-selected.png", position, nil];
    buttonImage = [[UIImage imageNamed:imgName] stretchableImageWithLeftCapWidth:CAP_WIDTH topCapHeight:0.0];
    buttonPressedImage = [[UIImage imageNamed:imgNameSelected] stretchableImageWithLeftCapWidth:CAP_WIDTH topCapHeight:0.0];
        
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, buttonWidth, buttonImage.size.height);
    button.titleLabel.font = [UIFont boldSystemFontOfSize: 13.0f];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateSelected];
    button.titleLabel.shadowOffset = CGSizeMake(0,-1);
    
    [button setTitle:[self.titles objectAtIndex:segmentIndex] forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateSelected];
    button.adjustsImageWhenHighlighted = NO;
    
    return button;

}

- (UIButton *)buttonFor:(CustomSegmentedControl *)segmentedControl atIndex:(NSUInteger)segmentIndex {
    UIButton* button = [self buttonForIndex:segmentIndex];
    if (segmentIndex == 0)
        button.selected = YES;
    return button;
}

- (void)touchDownAtSegmentIndex:(NSUInteger)segmentIndex {
    [self.delegate selectedSegmentAtIndex:segmentIndex];
}

@end
