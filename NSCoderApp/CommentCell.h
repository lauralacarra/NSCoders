//
//  CommentCell.h
//  NSCoderApp
//
//  Created by Alberto Gimeno Brieba on 13/05/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Backbeam.h>

@interface CommentCell : UITableViewCell

@property (nonatomic, strong) BBObject* comment;

- (void)drawContentView:(CGRect)r;
+ (CGFloat)heightForComment:(BBObject*)comment width:(CGFloat)width;

@end
