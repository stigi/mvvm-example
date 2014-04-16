//
//  USViewModel.m
//  mvvm
//
//  Created by Ullrich Schäfer on 16/04/14.
//  Copyright (c) 2014 Ullrich Schäfer. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "USModel.h"
#import "USAPIController.h"

#import "USViewModel.h"


@interface USViewModel ()

@property (readonly) USAPIController *apiController;

@property USModel *model;

@property (readwrite) NSString *name;
@property (readwrite, getter=hasSecretSet) BOOL secretSet;
@property (readwrite, getter=isLoading) BOOL loading;

@end


@implementation USViewModel

#pragma mark - Lifecycle

- (instancetype)initWithAPIController:(USAPIController *)apiController
{
    self = [super init];
    if (self) {
        _apiController = apiController;
        
        // binding to model
        RAC(self, name) = RACObserve(self, model.name);
        RAC(self, secretSet) = [RACObserve(self, model.secret) map:^NSNumber *(NSString *secret) {
            return @(secret != nil);
        }];
    }
    return self;
}


#pragma mark - Public

- (void)loadDataIfNeeded
{
    if (self.model) return; // no need to load
    
    self.loading = YES;
    
    [self.apiController loadModelWithBlock:^(USModel *model, NSError *error) {
        if (!error) {
            self.model = model;
        }
        self.loading = NO;
    }];
}

- (void)updateModelWithName:(NSString *)name
                     secret:(NSString *)secret
{
    self.loading = YES;
    
    [self.apiController updateModelWithName:name secret:secret block:^(USModel *model, NSError *error) {
        if (!error) {
            self.model = model;
        }
        self.loading = NO;
    }];
}


@end
