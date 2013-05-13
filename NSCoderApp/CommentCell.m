//
//  CommentCell.m
//  NSCoderApp
//
//  Created by Alberto Gimeno Brieba on 13/05/13.
//  Copyright (c) 2013 nscoder_zgz. All rights reserved.
//

#import "CommentCell.h"

@interface ContentView : UIView
@end

@implementation ContentView

- (void)drawRect:(CGRect)r
{
	[(CommentCell*)[self superview] drawContentView:r];
}

@end

@interface CommentCell () {
    
}

@property (nonatomic, strong) UIView* content;

@end

static UIFont *textFont;

@implementation CommentCell

+ (void)initialize {
    textFont = [UIFont systemFontOfSize:14];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		self.content = [[ContentView alloc] initWithFrame:CGRectZero];
		self.content.opaque = NO;
        self.content.backgroundColor = [UIColor clearColor];
		[self addSubview:self.content];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)f {
	[super setFrame:f];
	CGRect b = [self bounds];
    
	// b.size.height -= 1; // leave room for the seperator line
    if (NO) { // INTERFACE_IS_PAD
        b.size.width -= 80;
        b.origin.x += 40;
    } else {
        b.size.width -= 20;
        b.origin.x += 10;
    }
	
	[self.content setFrame:b];
    [self setNeedsDisplay];
}

- (void)setNeedsDisplay {
	[super setNeedsDisplay];
	[self.content setNeedsDisplay];
}

- (void)drawContentView:(CGRect)r {
    NSString *text = [self.comment stringForField:@"text"];
    
    CGFloat padding = 10; // INTERFACE_IS_PHONE ? 10 : 20;
    CGFloat paddingTop = 7; // INTERFACE_IS_PHONE ? 7 : 14;
    CGFloat imageWidth = 45;
    CGFloat textWidth = r.size.width - imageWidth - padding*3;
    CGFloat textLeft = imageWidth + padding*2;
    
    // CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [[UIColor lightGrayColor] set];
    CGRect nameRect = CGRectMake(textLeft, paddingTop, textWidth, 16);
    
    BBObject *author = [self.comment objectForField:@"user"];
    NSString *authorNickname = [author stringForField:@"nickname"];
    
    [authorNickname drawInRect:nameRect withFont:[UIFont boldSystemFontOfSize:14] lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentLeft];
    
    UIImage *image = [UIImage imageNamed:@""];
    CGRect imageRect = CGRectMake(padding, paddingTop, imageWidth, imageWidth);
    [image drawInRect:imageRect];
    
    [[UIColor darkGrayColor] set];
    CGRect textRect = CGRectMake(textLeft, paddingTop+21, textWidth, r.size.height - 25);
    [text drawInRect:textRect withFont:textFont lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentLeft];
}

+ (CGFloat)heightForComment:(BBObject*)comment width:(CGFloat)width {
    NSString *text = [comment stringForField:@"text"];
    
    CGFloat padding = 10; // INTERFACE_IS_PHONE ? 10 : 20;
    CGFloat paddingTop = 7; // INTERFACE_IS_PHONE ? 7 : 14;
    CGFloat imageWidth = 45;
    CGFloat textWidth = width - imageWidth - padding*3;
    CGFloat min = imageWidth + paddingTop*2;
    
    CGFloat height = [text sizeWithFont:textFont
                      constrainedToSize:CGSizeMake(textWidth, 999)
                          lineBreakMode:NSLineBreakByTruncatingTail].height;
    
    height += 21 + paddingTop*2;
    return height > min ? height : min;
}

@end
