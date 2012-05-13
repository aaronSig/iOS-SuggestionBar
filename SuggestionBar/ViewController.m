//
//  ViewController.m
//  SuggestionBar
//
//  Created by Aaron Signorelli on 11/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    bar = [[SuggestionBar alloc] init];
    [self.view addSubview: bar];
    
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void) viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardStateChange:)
                                                 name: UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardStateChange:)
                                                 name: UIKeyboardWillShowNotification object:nil];
}

-(void) viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) keyboardStateChange: (NSNotification *) notification
{
    NSDictionary* info = [notification userInfo];
    CGRect frameStart = [[info objectForKey: UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect frameEnd = [[info objectForKey: UIKeyboardFrameEndUserInfoKey] CGRectValue];
    frameStart = [self.view convertRect:frameStart fromView:[self.view window]];
    frameEnd = [self.view convertRect:frameEnd fromView:[self.view window]];    
    
    [UIView beginAnimations:@"slide in suggestion bar" context:nil];
    CGRect barFrame = bar.frame;
    barFrame.origin.y = frameEnd.origin.y - (frameStart.origin.y < frameEnd.origin.y ? 0 : bar.frame.size.height);
    bar.frame = barFrame;    
    [UIView commitAnimations];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSArray *split = [textField.text componentsSeparatedByString:@" "];
    [bar setSuggestions: split];
    
    return YES;
}



@end
