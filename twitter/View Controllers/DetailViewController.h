//
//  DetailViewController.h
//  twitter
//
//  Created by Marin Hyatt on 6/30/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (nonatomic, strong) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END
