//
//  PSPUserManagement.m
//  parseSDKProject
//
//  Created by Olivier Delecueillerie on 02/10/2014.
//  Copyright (c) 2014 lagspoon. All rights reserved.
//

#import "PSPUserController.h"
#import <Parse/Parse.h>
#import "PSPPrivateKey.h"

@implementation PSPUserController


-(void) userLogin {
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        [self refresh:nil];
    } else {
        // Dummy username and password
        PFUser *user = [PFUser user];
        user.username = @"Matt";
        user.password = @"password";
        user.email = @"Matt@example.com";
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [self refresh:nil];
            } else {
                [PFUser logInWithUsername:@"Matt" password:@"password"];
                [self refresh:nil];
            }
        }];
    }
}



}

+(void) wipeOutUserDefaults {
    // Wipe out old user defaults
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"objectIDArray"]){
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"objectIDArray"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];

}


@end
