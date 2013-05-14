//
//  STSegmentedControl.h
//  STSegmentedControl
//
/*
The MIT License

Copyright (c) 2011 Cedric Vandendriessche

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
 */

#import <Foundation/Foundation.h>

#define STSegmentedControlHeight 43.0

enum {
    STSegmentedControlNoSegment = -1 // segment index for no selected segment
};

@interface STSegmentedControl : UIControl {
	NSMutableArray *segments;
	UIImage *normalImageLeft;
	UIImage *normalImageMiddle;
	UIImage *normalImageRight;
	UIImage *selectedImageLeft;
	UIImage *selectedImageMiddle;
	UIImage *selectedImageRight;
	NSUInteger numberOfSegments;
	NSInteger selectedSegmentIndex;
	BOOL programmaticIndexChange;
	BOOL momentary;
}

- (id)initWithItems:(NSArray *)items; // items can be NSStrings or UIImages.

- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)index; // insert before segment number
- (void)insertSegmentWithImage:(NSString *)image atIndex:(NSUInteger)index;
- (void)removeSegmentAtIndex:(NSUInteger)index;
- (void)removeAllSegments;

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)index;
- (NSString *)titleForSegmentAtIndex:(NSUInteger)index;

- (void)setImage:(NSString *)image forSegmentAtIndex:(NSUInteger)index;
- (UIImage *)imageForSegmentAtIndex:(NSUInteger)index;

@property (nonatomic ,retain) NSMutableArray *segments; // at least two (2) NSStrings are needed for a STSegmentedControl to be displayed
@property (nonatomic,retain) UIImage *normalImageLeft;
@property (nonatomic,retain) UIImage *normalImageMiddle;
@property (nonatomic,retain) UIImage *normalImageRight;
@property (nonatomic,retain) UIImage *selectedImageLeft;
@property (nonatomic,retain) UIImage *selectedImageMiddle;
@property (nonatomic, retain) UIImage *selectedImageRight;
@property (nonatomic, readonly) NSUInteger numberOfSegments;
@property (nonatomic, getter=isMomentary) BOOL momentary; // if set, then we don't keep showing selected state after tracking ends. default is NO

// returns last segment pressed. default is STSegmentedControlNoSegment until a segment is pressed. Becomes STSegmentedControlNoSegment again when altering the amount of segments
// the UIControlEventValueChanged action is invoked when the segment changes via a user event. Set to UISegmentedControlNoSegment to turn off selection
@property (nonatomic, readwrite) NSInteger selectedSegmentIndex;

-(void)initializeImages;

@end
