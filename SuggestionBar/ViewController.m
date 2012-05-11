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
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    bar = [[SuggestionBar alloc] initWithFrame:CGRectMake(0, 205, screenRect.size.width, 40)];
    [self.view addSubview: bar];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSArray *split = [textField.text componentsSeparatedByString:@" "];
    [bar setSuggestions: split];
    
    return YES;
}



@end
