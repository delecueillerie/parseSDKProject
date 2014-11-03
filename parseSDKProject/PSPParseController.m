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


+(void) appIdentification {
    
    static dispatch_once_t once0;
    dispatch_once(&once0, ^{
        [Parse setApplicationId:parseApplicationId clientKey:parseClientKey];
        [PFAnalytics trackAppOpenedWithLaunchOptions:nil];
        
        
        //wipe out user defaults
        [PSPUserController wipeOutUserDefaults];
    });
}

@end
