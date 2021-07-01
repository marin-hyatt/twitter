//
//  User.m
//  twitter
//
//  Created by Marin Hyatt on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        // Sets name, screen name, and profile picture to values taken from the dictionary returned by Twitter API
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        
        // Sets user image from string
        NSString *profilePictureURLString = dictionary[@"profile_image_url_https"];
        NSString *resizedProfilePictureURLString = [profilePictureURLString stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
        NSURL *profileUrl = [NSURL URLWithString:resizedProfilePictureURLString];
        NSData *profileUrlData = [NSData dataWithContentsOfURL:profileUrl];
        
        // Resizes profile picture
        
        self.profilePictureData = profileUrlData;
        
        // Sets banner image from string
        NSString *bannerURLString = dictionary[@"profile_banner_url"];
        NSURL *bannerUrl = [NSURL URLWithString:bannerURLString];
        NSData *bannerUrlData = [NSData dataWithContentsOfURL:bannerUrl];
        self.profileBannerData = bannerUrlData;
        
        // Sets user id
        self.userID = [dictionary[@"id"] integerValue];
        
        // Sets number of followers
        self.numFollowers = [dictionary[@"followers_count"] integerValue];
        
        // Sets num following
        self.numFollowing = [dictionary[@"friends_count"] integerValue];
        
        // Sets bio
        self.bio = dictionary[@"description"];
        
        // Sets num tweets
        self.numTweets =[dictionary[@"statuses_count"] integerValue];
        
        
    }
    return self;
}

@end
