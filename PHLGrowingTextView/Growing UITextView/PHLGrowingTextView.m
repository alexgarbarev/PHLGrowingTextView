//
//  PHLGrowingTextView.m
//  Growing UITextView
//
//  Created by namanhams on 29/10/12.
//  Copyright (c) 2012 namanhams. All rights reserved.
//

#import "PHLGrowingTextView.h"

@interface PHLGrowingTextView () {
}

@end


@implementation PHLGrowingTextView

@synthesize delegate, minHeight, maxHeight, backgroundImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self initialize];
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    [self initialize];
    
    return self;
}

- (void) initialize {
    self.maxHeight = MAXFLOAT;
    self.minHeight = 0;
    self.backgroundColor = [UIColor clearColor];
    self.backgroundImage = [[UIImage imageNamed:@"textbox.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(13, 13, 12, 12)];
    
    [self addObserver:self
           forKeyPath:@"frame"
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:nil];
    
    [self addObserver:self
           forKeyPath:@"contentSize"
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:nil];
}

- (void) dealloc {
    [self removeObserver:self forKeyPath:@"frame"];
    [self removeObserver:self forKeyPath:@"contentSize"];
}

- (void) setMaxHeight:(CGFloat)value {
    maxHeight = value;
    
    if(self.frame.size.height > value) {
        CGRect frame = self.frame;
        frame.size.height = value;
        self.frame = frame;
    }
}

- (void) setMinHeight:(CGFloat)value {
    minHeight = value;
    
    if(self.frame.size.height < value) {
        CGRect frame = self.frame;
        frame.size.height = value;
        self.frame = frame;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentSize"]) {
        CGFloat oldHeight = [[change valueForKey:@"old"] CGSizeValue].height;
        CGFloat newHeight = [[change valueForKey:@"new"] CGSizeValue].height;
        if(oldHeight != newHeight) {
            
            CGFloat expectedHeight = newHeight;
            if(expectedHeight > self.maxHeight)
                expectedHeight = self.maxHeight;
            if(expectedHeight < self.minHeight)
                expectedHeight = self.minHeight;
            
            if([self.delegate respondsToSelector:@selector(textView:willChangeHeight:)])
                [self.delegate textView:self willChangeHeight:expectedHeight];
            
            [UIView animateWithDuration:0.02
                                  delay:0
                                options:UIViewAnimationOptionAllowAnimatedContent
                             animations:^{
                                 
                                 CGRect frame = self.frame;
                                 frame.size.height = expectedHeight;
                                 self.frame = frame;
                                 
                             } completion:^(BOOL finished) {
                                 if([self.delegate respondsToSelector:@selector(textViewDidChangeHeight:)])
                                     [self.delegate textViewDidChangeHeight:self];
                             }];
        }
    }
    else if([keyPath isEqualToString:@"frame"]) {
        CGRect oldFrame = [[change valueForKey:@"old"] CGRectValue];
        CGRect newFrame = [[change valueForKey:@"new"] CGRectValue];
        if(oldFrame.size.height != newFrame.size.height) {
            if([self.delegate respondsToSelector:@selector(textViewDidChangeHeight:)])
                [self.delegate textViewDidChangeHeight:self];
        }
    }
}

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    NSLog(@"Draw rect %f", rect.size.height);
    CGRect frame = CGRectInset(self.bounds, 0, -1);
    [self.backgroundImage drawInRect:frame];
    
    
}

@end
