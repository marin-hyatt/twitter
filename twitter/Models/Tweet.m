//
//  Tweet.m
//  twitter
//
//  Created by Marin Hyatt on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "DateTools.h"

@implementation Tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        // Checks if tweet is a retweet
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        // If tweet is a retweet, get the user and update retweeted status. Then change the tweet to the original tweet
        if(originalTweet != nil){
            NSDictionary *userDictionary = dictionary[@"user"];
            NSLog(@"%@", userDictionary);
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];

            dictionary = originalTweet;
        }
        // Otherwise, initialize the tweet with the appropriate values from the dictionary
        self.idStr = dictionary[@"id_str"];
        
        // Gets full text if it's available, otherwise get regular text
        if([dictionary valueForKey:@"full_text"] != nil) {
               self.text = dictionary[@"full_text"]; // uses full text if Twitter API provided it
           } else {
               self.text = dictionary[@"text"]; // fallback to regular text that Twitter API provided
           }
        
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        
        // initialize user
        NSDictionary *user = dictionary[@"user"];
        NSLog(@"%@", user);
        self.user = [[User alloc] initWithDictionary:user];
        

        // Format and set createdAtString
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        // Convert String to Date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        
        double timeInterval = date.timeIntervalSinceNow;
        
        NSDate *timeAgoDate = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
        
        // Configure output format
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        // Convert Date to String
        // If more than a week has passed since the tweet, display the date. Else, use DateTool to get the time elapsed
        if (fabs(timeInterval) > 604800) {
            self.createdAtString = [formatter stringFromDate:date];
        } else {
            self.createdAtString = timeAgoDate.shortTimeAgoSinceNow;
        }
        
        // Get any (non-media) URLs in tweet if there are any
        NSDictionary *entityDictionary = dictionary[@"entities"];
        NSArray *urlArray = entityDictionary[@"urls"];
        
        if ([urlArray count] != 0) {
            self.URL = [NSURL URLWithString:urlArray[0][@"expanded_url"]];
        }
        
    }
    return self;
}

// Returns tweets when initialized with tweet dictionaries.
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    // Initializes the array
    NSMutableArray *tweets = [NSMutableArray array];
    // For every tweet dictionary, initialize the tweet and add it to the array
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}



@end
