//
//  TimelineViewController.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCell.h"

@interface TimelineViewController : UIViewController<TweetCellDelegate>
- (void)tweetCell:(TweetCell *)tweetCell didTap:(User *)user;

@end
