//
//  PSPParseController.m
//  parseSDKProject
//
//  Created by Olivier Delecueillerie on 02/10/2014.
//  Copyright (c) 2014 lagspoon. All rights reserved.
//

#import "PSPParseController.h"
#import <Parse/Parse.h>
#import "PSPPrivateKey.h"
#import "PSPUserController.h"

@implementation PSPParseController



+(void)parseIdentification {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        [Parse setApplicationId:parseApplicationId clientKey:parseClientKey];
        [PFAnalytics trackAppOpenedWithLaunchOptions:nil];
    });
}


+(PSPParseController *) sharedInstance {
    static PSPParseController *_sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        //[Parse setApplicationId:parseApplicationId clientKey:parseClientKey];
        //[PFAnalytics trackAppOpenedWithLaunchOptions:nil];
        
        _sharedInstance = [[PSPParseController alloc] init];
        
        
        //wipe out user defaults
        [[PSPUserController sharedInstance] wipeOutUserDefaults];
    });
    return _sharedInstance;
}

@end
