//
//  APIManager.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"
#import "BDBOAuth1SessionManager+SFAuthenticationSession.h"
#import "Tweet.h"
#import "User.h"

@interface APIManager : BDBOAuth1SessionManager

+ (instancetype)shared;

- (void)getHomeTimelineWithCompletion:(void(^)(NSArray *tweets, NSError *error))completion;
- (void)postTweet:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion;
- (void)favoriteTweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;
- (void)unfavoriteTweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;
- (void)retweetTweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;
- (void)unretweetTweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;
- (void)getAccountInfo:(void(^)(User *user, NSError *error))completion;

@end
