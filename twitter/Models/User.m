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
        //Sets name, screen name, and profile picture to values taken from the dictionary returned by Twitter API
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        
        //Sets user image from string
        NSString *profilePictureURLString = dictionary[@"profile_image_url_https"];
        NSURL *url = [NSURL URLWithString:profilePictureURLString];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        self.profilePictureData = urlData;
    }
    return self;
}

@end
