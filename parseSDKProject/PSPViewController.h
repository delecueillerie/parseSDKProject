//
//  PSPViewController.h
//  parseSDKProject
//
//  Created by Olivier Delecueillerie on 02/10/2014.
//  Copyright (c) 2014 lagspoon. All rights reserved.
//

#import <UIKit/UIKit.h>

//Controller
#import "PSPUserController.h"

@interface PSPViewController : UIViewController <userControllerDelegate>

@property (strong, nonatomic) NSMutableArray *mArrayData;
@end
