//
//  ComposeViewController.m
//  twitter
//
//  Created by Marin Hyatt on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "../API/APIManager.h"
#import "User.h"

@interface ComposeViewController ()
@property (nonatomic, strong) User *user;
@property (weak, nonatomic) IBOutlet UITextView *composeTextView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
- (IBAction)sendTweet:(UIBarButtonItem *)sender;
- (IBAction)closeTweet:(UIBarButtonItem *)sender;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Make API call to get user info
    [[APIManager shared] getAccountInfo:^(User *user, NSError *error) {
        if (user) {
            NSLog(@"😎😎😎 Successfully loaded user info");
            self.user = user;
            [self refreshView];
        } else {
            NSLog(@"😫😫😫 Error getting user info: %@", error.localizedDescription);
        }
    }];
}

-(void)refreshView {
    // Sets user profile picture
    self.profilePicture.image = nil;
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
    self.profilePicture.layer.masksToBounds = true;
    
    if (self.user.profilePictureData != nil) {
        self.profilePicture.image = [UIImage imageWithData:self.user.profilePictureData];
    }
}

- (IBAction)closeTweet:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)sendTweet:(UIBarButtonItem *)sender {
    NSString *text = self.composeTextView.text;
    [[APIManager shared] postTweet:text completion:^(Tweet *tweet, NSError *error) {
        if (error == nil) {
            NSLog(@"Posted tweet!");
            [self.delegate didTweet:tweet];
        } else {
            NSLog(@"Error posting tweet: %@", error.localizedDescription);
        }
    }];
}
@end
