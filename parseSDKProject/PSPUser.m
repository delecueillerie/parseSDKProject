//
//  PSPUser.m
//  parseSDKProject
//
//  Created by Olivier Delecueillerie on 21/11/2014.
//  Copyright (c) 2014 lagspoon. All rights reserved.
//

#import "PSPUser.h"


@interface PSPUser ()



@end


@implementation PSPUser




/*////////////////////////////////////////////////////////////
 Acessors
 ////////////////////////////////////////////////////////////*/

-(PFUser *)currentUser {
    if (!_currentUser) {
        if ([PFUser currentUser]) {
            _currentUser = [PFUser currentUser];            
        } else {
            
            if ([self.delegate automaticallyCreateAnonymousUser]) {
                [PFAnonymousUtils logInWithBlock:^(PFUser *user, NSError *error) {
                    if (error) {
                        NSLog(@"error with anonymous log in");
                    } else {
                        _currentUser = user;
                    }
                }];
            } else {
                _currentUser = nil;
            }
            
        }
    }
    return _currentUser;
}

/*////////////////////////////////////////////////////////////
 Action
 ////////////////////////////////////////////////////////////*/

-(BOOL) isAnonymous {
    return [PFAnonymousUtils isLinkedWithUser:self.currentUser];
}

-(BOOL) isLogged {
    if ([PFUser currentUser]) {
        return YES;
    } else {
        return NO;
    }
}

-(NSString *)username {
    
    NSLog(@"username %@",[self.currentUser username]);
    if (![self isLogged]) {
        return @"not logged";
    } else {
        if ([self isAnonymous]) {
            return @"Anonymous";
        } else {
            return [self.currentUser username];
        }
    }
}

@end
