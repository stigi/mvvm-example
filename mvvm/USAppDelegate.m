//
//  USAppDelegate.m
//  mvvm
//
//  Created by Ullrich Schäfer on 16/04/14.
//  Copyright (c) 2014 Ullrich Schäfer. All rights reserved.
//

#import "USViewController.h"

#import "USAppDelegate.h"

@implementation USAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController = [[USViewController alloc] initWithNibName:@"USViewController" bundle:nil];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
