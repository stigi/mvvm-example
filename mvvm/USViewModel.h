//
//  USViewModel.h
//  mvvm
//
//  Created by Ullrich Schäfer on 16/04/14.
//  Copyright (c) 2014 Ullrich Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class USAPIController;


@interface USViewModel : NSObject

- (instancetype)initWithAPIController:(USAPIController *)apiController;

- (void)loadDataIfNeeded;

#pragma mark - Properties

@property (readonly) NSString *name;
@property (readonly) BOOL preventSecretInput;

@property (readonly, getter=isLoading) BOOL loading;


#pragma mark - Updating

- (void)updateModelWithName:(NSString *)name
                     secret:(NSString *)secret;

@end


@interface USViewModel (Deprecated_Nonfunctional)
- (id)init NS_UNAVAILABLE;
@end
