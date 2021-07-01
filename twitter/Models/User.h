//
//  User.h
//  twitter
//
//  Created by Marin Hyatt on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* screenName;
@property (nonatomic, strong) NSData* profilePictureData;
@property (nonatomic, strong) NSData* profileBannerData;
@property (nonatomic) int userID;
@property (nonatomic) int numFollowers;
@property (nonatomic) int numFollowing;
@property (nonatomic, strong) NSString* bio;
@property (nonatomic) int numTweets;

// Initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
