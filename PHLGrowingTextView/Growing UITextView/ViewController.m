//
//  ViewController.m
//  Growing UITextView
//
//  Created by namanhams on 29/10/12.
//  Copyright (c) 2012 namanhams. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    PHLGrowingTextView *textView = [[PHLGrowingTextView alloc] init];
    textView.frame = CGRectMake(60, 200, 200, 25);
    textView.text = @"Abc\n\n\n";
    textView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
    textView.delegate = self;
    textView.maxHeight = 200;
    textView.minHeight = 30;
    [self.view addSubview:textView];
}

- (void) textView:(PHLGrowingTextView *)textView willChangeToHeight:(CGFloat)newHeight {
    NSLog(@"willChangeToHeight %f", newHeight);
}

- (void) textView:(PHLGrowingTextView *)textView didChangeFromHeight:(CGFloat)oldHeight {
    NSLog(@"didChangeHeight %f", textView.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end