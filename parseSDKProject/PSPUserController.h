//
//  PSPUserManagement.h
//  parseSDKProject
//
//  Created by Olivier Delecueillerie on 02/10/2014.
//  Copyright (c) 2014 lagspoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h> 
#import "PSPUser.h"

@protocol userControllerDelegate <NSObject>

-(void) popLogIn:(UIViewController *)viewController;
-(void) popSignIn:(UIViewController *)viewController;

-(void) updateUser;
@end


@interface PSPUserController: NSObject <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, userDelegate>




@property (strong, nonatomic) PSPUser *user;



+(PSPUserController *)sharedInstance;

-(void) wipeOutUserDefaults;
-(void) logOut;
-(PFLogInViewController *)logInViewController;
-(PFSignUpViewController *)signInViewController;
-(void) anonymousLogIn;

@property (weak, nonatomic) id<userControllerDelegate> delegate;

@end
