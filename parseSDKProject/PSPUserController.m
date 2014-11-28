//
//  PSPUserManagement.m
//  parseSDKProject
//
//  Created by Olivier Delecueillerie on 02/10/2014.
//  Copyright (c) 2014 lagspoon. All rights reserved.
//
#import <Parse/Parse.h>

#import "PSPUserController.h"

#import "PSPSignUpViewController.h"
#import "PSPLogInViewController.h"

//specific login & signup view controller



@interface PSPUserController ()

//@property (nonatomic, strong) UIViewController *logInViewController;
//@property (nonatomic, strong) UIViewController *signInViewController;

@end

@implementation PSPUserController


/*////////////////////////////////////////////////////////////
Acessors
 ////////////////////////////////////////////////////////////*/


-(PFLogInViewController *)logInViewController {
    
    PSPLogInViewController *logInVC = [[PSPLogInViewController alloc] init];
    [logInVC setDelegate:self]; // Set ourselves as the delegate
    [logInVC setFields:PFLogInFieldsUsernameAndPassword|PFLogInFieldsLogInButton | PFLogInFieldsSignUpButton | PFLogInFieldsDismissButton];
    
    // Assign our sign up controller to be displayed from the login controller
    [logInVC setSignUpController:[self signInViewController]];

    return logInVC;
}

-(PFSignUpViewController *)signInViewController {
    // Create the sign up view controller
    PSPSignUpViewController *signUpVC = [[PSPSignUpViewController alloc] init];
    [signUpVC setDelegate:self]; // Set ourselves as the delegate
    [signUpVC setFields:PFSignUpFieldsDefault | PFSignUpFieldsAdditional];
    
    return signUpVC;
}

-(PSPUser *) user {
    if (!_user) {
        _user = [[PSPUser alloc] init];
        _user.delegate = self;
    }
    return _user;
}


/*////////////////////////////////////////////////////////////
 Skeleton
////////////////////////////////////////////////////////////*/

+(PSPUserController *) sharedInstance {
    static PSPUserController * _sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _sharedInstance = [[PSPUserController alloc] init];
        //[PSPParseController sharedInstance];
    });
    return _sharedInstance;
}

/*////////////////////////////////////////////////////////////
 Action
 ////////////////////////////////////////////////////////////*/
/*
-(void) userLogin {
    if (currentUser) {
        //[self refresh:nil];
    } else {
        
        
        // Dummy username and password
        PFUser *user = [PFUser user];
        user.username = @"Matt";
        user.password = @"password";
        user.email = @"Matt@example.com";
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                //[self refresh:nil];
            } else {
                [PFUser logInWithUsername:@"Matt" password:@"password"];
                //[self refresh:nil];
            }
        }];
    }
}
*/

-(void) wipeOutUserDefaults {
    // Wipe out old user defaults
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"objectIDArray"]){
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"objectIDArray"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];

}

-(void) logOut {
    [PFUser logOut];
    self.user.currentUser = nil;
    [self.delegate updateUser];
}


-(void) anonymousLogIn {
    [PFAnonymousUtils logInWithBlock:^(PFUser *user, NSError *error) {
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error"
                                                            message:@"Error when trying to login anonymously"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            
        } else {
            self.user.currentUser = user;
            [self.delegate updateUser];
        }
    }];
}

/*////////////////////////////////////////////////////////////
 Log In VC Delegate
 ////////////////////////////////////////////////////////////*/
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    self.user.currentUser = user;
    [self.delegate updateUser];
    [self.delegate popLogIn:self.logInViewController];
}

- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail to log in"
                                                    message:@"Please verify the information"
                                                   delegate:nil
                                          cancelButtonTitle:@"cancel"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

/*////////////////////////////////////////////////////////////
 Sign In VC Delegate
 ////////////////////////////////////////////////////////////*/
-(void) signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    self.user.currentUser = user;
    [self.delegate updateUser];
    [self.delegate popSignIn:self.signInViewController];
}

/*////////////////////////////////////////////////////////////
 PSPUser Delegate
 ////////////////////////////////////////////////////////////*/
-(BOOL) automaticallyCreateAnonymousUser {
    return NO;
}

@end
