//
//  ProfileViewController.m
//  twitter
//
//  Created by Marin Hyatt on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bannerPicture;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *bio;
@property (weak, nonatomic) IBOutlet UILabel *numFollowing;
@property (weak, nonatomic) IBOutlet UILabel *numFollowers;
@property (weak, nonatomic) IBOutlet UILabel *numTweets;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshData];
}

- (void)refreshData {
    self.screenName.text = self.user.name;
    self.name.text = [NSString stringWithFormat:@"@%@", self.user.screenName];
    
    //Set profile picture
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
    self.profilePicture.layer.masksToBounds = true;
    self.profilePicture.image = nil;
    
    if (self.user.profilePictureData != nil) {
        self.profilePicture.image = [UIImage imageWithData:self.user.profilePictureData];
    }

    //Set banner picture
    self.bannerPicture.image = nil;
    
    if (self.user.profileBannerData != nil) {
        self.bannerPicture.image = [UIImage imageWithData:self.user.profileBannerData];
    }
    
    //Set number following
    self.numFollowing.text = [NSString stringWithFormat:@"%d", self.user.numFollowing];
    
    //Set number followers
    self.numFollowers.text = [NSString stringWithFormat:@"%d", self.user.numFollowers];
    
    //Set bio
    self.bio.text = self.user.bio;
    
    //Set number of tweets
    self.numTweets.text = [NSString stringWithFormat:@"%d", self.user.numTweets];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
