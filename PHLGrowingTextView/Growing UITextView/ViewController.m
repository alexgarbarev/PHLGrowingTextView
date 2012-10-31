//
//  ViewController.m
//  Growing UITextView
//
//  Created by namanhams on 29/10/12.
//  Copyright (c) 2012 namanhams. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    UIImageView *_imageView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    PHLGrowingTextView *textView = [[PHLGrowingTextView alloc] init];
    textView.frame = CGRectMake(100, 0, 200, 30);
    textView.text = @"Abc\n\n\n";
    textView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
    textView.delegate = self;
    textView.maxHeight = 200;
    textView.minHeight = 30;
    [self.view addSubview:textView];
    
    UIImage *backgroundImage = [[UIImage imageNamed:@"textbox.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(13, 13, 12, 12)];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.image = backgroundImage;
//    [self.view addSubview:_imageView];
}

- (void) textView:(PHLGrowingTextView *)textView willChangeHeight:(CGFloat)newHeight {
    NSLog(@"willChangeHeight %f", newHeight);
}

- (void) textViewDidChangeHeight:(PHLGrowingTextView *)textView {
    NSLog(@"didChangeHeight %f", textView.frame.size.height);
    
    CGRect frame = _imageView.frame;
    frame.size.height = textView.frame.size.height;
    _imageView.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
