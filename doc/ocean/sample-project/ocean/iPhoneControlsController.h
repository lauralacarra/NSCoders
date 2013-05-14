//
//  iPhoneControlsController.h
//  ocean
//
//  Created by Tope on 23/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADVPopoverProgressBar.h"

@interface iPhoneControlsController : UIViewController

@property (nonatomic, strong) UISlider* slider;

@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;

@property (nonatomic, strong) ADVPopoverProgressBar *progressBar;

@property (nonatomic, strong) IBOutlet UITextField *textInput;
@property (strong, nonatomic) IBOutlet UIProgressView *nativePB;

-(IBAction)valueChanged:(id)sender;

-(CALayer *)createShadowWithFrame:(CGRect)frame;

-(IBAction)doneTyping:(UITextField*)sender;
@end
