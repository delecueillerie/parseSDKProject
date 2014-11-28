//
//  PSPUser.h
//  parseSDKProject
//
//  Created by Olivier Delecueillerie on 21/11/2014.
//  Copyright (c) 2014 lagspoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@protocol userDelegate <NSObject>

-(BOOL) automaticallyCreateAnonymousUser;

@end


@interface PSPUser : NSObject

@property (weak, nonatomic) id <userDelegate> delegate;
@property (nonatomic, strong) PFUser *currentUser;



-(BOOL) isLogged;
-(BOOL) isAnonymous;
-(NSString *) username;



@end
