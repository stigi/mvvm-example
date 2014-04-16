//
//  USViewController.m
//  mvvm
//
//  Created by Ullrich Schäfer on 16/04/14.
//  Copyright (c) 2014 Ullrich Schäfer. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "USAPIController.h"
#import "USViewModel.h"

#import "USViewController.h"


@interface USViewController () <UITextFieldDelegate>
@property (readonly) USAPIController *apiController;
@property (readonly) USViewModel *viewModel;
@end


@implementation USViewController

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _apiController = [[USAPIController alloc] init];
        _viewModel = [[USViewModel alloc] initWithAPIController:self.apiController];
    }
    return self;
}


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self bindToViewModel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.viewModel loadDataIfNeeded];
}


#pragma mark - ViewModel

- (void)bindToViewModel
{
    // bind loading state
    RACSignal *loading = RACObserve(self.viewModel, loading);
    RAC(self.submitButton, enabled) = [loading not];
    RAC(self.clearSecretButton, enabled) = [loading not];
    RAC(self.activityIndicator, hidden) = [loading not];
    RAC(self.nameLabel, hidden) = loading;
    RAC(self.nameField, hidden) = loading;
    RAC(self.secretLabel, hidden) = loading;
    RAC(self.secretField, hidden) = loading;
    
    // bind name
    RAC(self.nameField, text) = RACObserve(self.viewModel, name);
    
    // bind secret
    RAC(self.nameField, returnKeyType) = [RACObserve(self.viewModel, secretSet) map:^id(NSNumber *secretSet) {
        if (secretSet.boolValue) {
            return @(UIReturnKeySend);
        }
        return @(UIReturnKeyNext);
    }];
    RAC(self.hideSecretLayoutConstraint, priority) = [RACObserve(self.viewModel, secretSet) map:^NSNumber *(NSNumber *secretSet) {
        if (secretSet.boolValue) {
            return @(UILayoutPriorityRequired - 1);
        }
        return @(UILayoutPriorityDefaultLow);
    }];
}


#pragma mark - Actions

- (IBAction)submit:(id)sender
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    [self.viewModel updateModelWithName:self.nameField.text
                                 secret:(self.secretField.text.length > 0 ? self.secretField.text : nil)];
}

- (IBAction)clearSecret:(id)sender
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    self.secretField.text = nil;
    [self.viewModel updateModelWithName:self.viewModel.name secret:nil];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeySend) {
        [self submit:textField];
        return YES;
    }
    
    if (textField == self.nameField) {
        [self.secretField becomeFirstResponder];
    }
    return YES;
}

@end
