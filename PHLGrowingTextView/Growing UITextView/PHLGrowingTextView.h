//
//  PHLGrowingTextView.h
//  Growing UITextView
//
//  Created by namanhams on 29/10/12.
//  Copyright (c) 2012 namanhams. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHLGrowingTextView;

@protocol PHLGrowingTextViewDelegate <UITextViewDelegate>

@optional
- (void) textView:(PHLGrowingTextView *)textView willChangeHeight:(CGFloat)newHeight;
- (void) textViewDidChangeHeight:(PHLGrowingTextView *)textView;

@end


@interface PHLGrowingTextView : UITextView

@property (nonatomic, assign) id<PHLGrowingTextViewDelegate> delegate;
@property (nonatomic, assign) CGFloat minHeight;
@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, retain) UIImage *backgroundImage;

@end


