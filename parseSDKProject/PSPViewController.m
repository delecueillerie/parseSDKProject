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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Navigation
/*
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


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
