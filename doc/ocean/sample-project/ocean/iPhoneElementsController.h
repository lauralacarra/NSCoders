//
//  iPhoneElementsController.h
//  ocean
//
//  Created by Tope on 23/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPhoneElementsController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableListView;

-(CALayer *)createShadowWithFrame:(CGRect)frame;

@end
