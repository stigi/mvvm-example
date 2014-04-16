//
//  USAPIController.h
//  mvvm
//
//  Created by Ullrich Schäfer on 16/04/14.
//  Copyright (c) 2014 Ullrich Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>


@class USModel;

typedef void(^USAPIModelCompletionHandler)(USModel *model, NSError *error);


@interface USAPIController : NSObject

- (void)loadModelWithBlock:(USAPIModelCompletionHandler)block;

- (void)updateModelWithName:(NSString *)name
                     secret:(NSString *)secret
                      block:(USAPIModelCompletionHandler)block;
@end
