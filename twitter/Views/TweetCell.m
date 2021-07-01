//
//  TweetCell.m
//  twitter
//
//  Created by Marin Hyatt on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "../API/APIManager.h"

@implementation TweetCell

- (IBAction)tweetFavorited:(UIButton *)sender {
    if (!self.tweet.favorited) {
        //Set tweet status to favorited and update its favorite count
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        //API call to favorite tweet
        [[APIManager shared] favoriteTweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
    } else {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        //API call to unfavorite tweet
        [[APIManager shared] unfavoriteTweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
             }
         }];
    }
    //Reloads UI
    [self refreshData];
}
- (IBAction)tweetRetweeted:(UIButton *)sender {
    if (!self.tweet.retweeted) {
        //Set tweet status to retweeted and update retweet count
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        //API call to retweet
        [[APIManager shared] retweetTweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             }
         }];
    } else {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        //API call to unretweet
        [[APIManager shared] unretweetTweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
             }
         }];
    }
    //Reloads UI
    [self refreshData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //Configures gesture recognizer to go to user's profile
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    //Attach gesture recognizer to profile picture and enables user interaction
    [self.profilePicture addGestureRecognizer:profileTapGestureRecognizer];
    [self.profilePicture setUserInteractionEnabled:YES];
}

-(void)refreshData {
    self.screenName.text = self.tweet.user.name;
    self.name.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    
    //Resizes text view to fit width of tweet
    self.tweetText.text = self.tweet.text;
    CGFloat fixedWidth = self.tweetText.frame.size.width;
    CGSize newSize = [self.tweetText sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = self.tweetText.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    self.tweetText.frame = newFrame;
    
    self.favoriteCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
    self.favoriteButton.selected = self.tweet.favorited;
    self.retweetButton.selected = self.tweet.retweeted;
    
    //Set profile picture
    self.profilePicture.layer.cornerRadius = 25;
    self.profilePicture.layer.masksToBounds = true;
    self.profilePicture.image = nil;
    
    if (self.tweet.user.profilePictureData != nil) {
        self.profilePicture.image = [UIImage imageWithData:self.tweet.user.profilePictureData];
    }
    
    
    //Set screen name
    self.screenName.text = self.tweet.user.name;
    
    //Set name
    self.name.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    
    //Set tweet text;
    self.tweetText.text = self.tweet.text;
    
    //Set retweet count
    self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
    //Set favorite count
    self.favoriteCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
    //Set timestamp
    
    self.timestamp.text = self.tweet.createdAtString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)didTapUserProfile:(UITapGestureRecognizer *)sender {
    //Calls delegate, passes in itself as the tweet cell that was tapped and the user of the tweet as the user
    [self.delegate tweetCell:self didTap:self.tweet.user];
}

@end
