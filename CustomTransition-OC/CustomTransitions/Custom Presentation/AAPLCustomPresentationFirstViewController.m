/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The initial view controller for the Custom Presentation demo.
 */

#import "AAPLCustomPresentationFirstViewController.h"
#import "AAPLCustomPresentationController.h"

@implementation AAPLCustomPresentationFirstViewController

#pragma mark -
#pragma mark Presentation

//| ----------------------------------------------------------------------------
- (IBAction)buttonAction:(UIButton*)sender
{
        
    UIViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];

    AAPLCustomPresentationController *presentationController  = [[AAPLCustomPresentationController alloc] initWithPresentedViewController:secondViewController presentingViewController:self];
    secondViewController.modalPresentationStyle = UIModalPresentationCustom;
    
    secondViewController.transitioningDelegate = presentationController;
    [self presentViewController:secondViewController animated:YES completion:NULL];
}

@end
