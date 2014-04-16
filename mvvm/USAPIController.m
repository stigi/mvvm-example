//
//  USAPIController.m
//  mvvm
//
//  Created by Ullrich Schäfer on 16/04/14.
//  Copyright (c) 2014 Ullrich Schäfer. All rights reserved.
//

#import "USModel.h"

#import "USAPIController.h"

@implementation USAPIController

- (void)loadModelWithBlock:(USAPIModelCompletionHandler)block;
{
    USModel *model = [[USModel alloc] init];
    
    model.name = @"Testman";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (block) block(model, nil);
    });
}


- (void)updateModelWithName:(NSString *)name
                     secret:(NSString *)secret
                      block:(USAPIModelCompletionHandler)block
{
    USModel *model = [[USModel alloc] init];
    
    model.name = name;
    model.secret = secret;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (block) block(model, nil);
    });
}
@end
