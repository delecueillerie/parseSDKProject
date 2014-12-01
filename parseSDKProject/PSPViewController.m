//
//  PSPViewController.m
//  parseSDKProject
//
//  Created by Olivier Delecueillerie on 02/10/2014.
//  Copyright (c) 2014 lagspoon. All rights reserved.
//


//Controller
#import "PSPViewController.h"
#import "PSPUserController.h"
#import "PSPParseController.h"

//Model
#import "PSPUser.h"

@interface PSPViewController ()

//UI
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logInBBItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logOutBBItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *signInBBItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *anonymousBBItem;


//
@property (strong, nonatomic) PSPUser *user;

@end

@implementation PSPViewController


/*/////////////////////////////////////////////////////////////////////
 Accessors
 /////////////////////////////////////////////////////////////////////*/
-(PSPUser *)user {
    if (!_user) {
        _user = [[PSPUserController sharedInstance] user];
    }
    return _user;
}


/*/////////////////////////////////////////////////////////////////////
LifeCycle VC
/////////////////////////////////////////////////////////////////////*/


-(void) viewDidLoad {
    [super viewDidLoad];
    [PSPParseController parseIdentification];
    [PSPUserController sharedInstance].delegate = self;
}

    
-(void) viewDidAppear:(BOOL)animated {
    [self updateNavigationBar];
    [self updateToolBar];
}

/*/////////////////////////////////////////////////////////////////////
 UI
 /////////////////////////////////////////////////////////////////////*/
-(void) updateToolBar {
    
}

-(void) updateNavigationBar {
    self.title = [self.user username];
}

/*/////////////////////////////////////////////////////////////////////
 Action
/////////////////////////////////////////////////////////////////////*/


- (IBAction)logIn:(id)sender {
    // Present the log in view controller
    [self.navigationController presentViewController:[[PSPUserController sharedInstance] logInViewController] animated:YES completion:NULL];
    [self updateNavigationBar];
    [self updateToolBar];
}


- (IBAction)logOut:(id)sender {
    [[PSPUserController sharedInstance] logOut];

}


- (IBAction)signIn:(id)sender {
    [self.navigationController presentViewController:[[PSPUserController sharedInstance] signInViewController] animated:YES completion:NULL];

}


- (IBAction)anonymous:(id)sender {
    [[PSPUserController sharedInstance] anonymousLogIn];

}


/*/////////////////////////////////////////////////////////////////////
 userController delegate
 /////////////////////////////////////////////////////////////////////*/

-(void) popLogIn:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:^{

    }];

}

-(void) popSignIn:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:^{

    }];

}

- (void) updateUser {
    [self updateToolBar];
    [self updateNavigationBar];
}


@end
