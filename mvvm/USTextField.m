//
//  USTextField.m
//  mvvm
//
//  Created by Ullrich Schäfer on 16/04/14.
//  Copyright (c) 2014 Ullrich Schäfer. All rights reserved.
//

#import "USTextField.h"

@implementation USTextField

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"returnKeyType"]) {
        self.returnKeyType = [value integerValue];
    } else {
        [super setValue:value forUndefinedKey:key];
    }
}

@end
