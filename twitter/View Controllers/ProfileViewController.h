//
//  ProfileViewController.h
//  twitter
//
//  Created by Marin Hyatt on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (nonatomic, strong) User *user;

@end

NS_ASSUME_NONNULL_END
