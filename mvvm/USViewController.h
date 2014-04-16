//
//  USViewController.h
//  mvvm
//
//  Created by Ullrich Schäfer on 16/04/14.
//  Copyright (c) 2014 Ullrich Schäfer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UITextField *nameField;

@property (nonatomic, weak) IBOutlet UILabel *secretLabel;
@property (nonatomic, weak) IBOutlet UITextField *secretField;

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *hideSecretLayoutConstraint;

@property (nonatomic, weak) IBOutlet UIButton *submitButton;
@property (nonatomic, weak) IBOutlet UIButton *clearSecretButton;


- (IBAction)submit:(id)sender;
- (IBAction)clearSecret:(id)sender;

@end
