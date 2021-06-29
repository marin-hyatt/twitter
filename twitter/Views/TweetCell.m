//
//  TweetCell.m
//  twitter
//
//  Created by Marin Hyatt on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

- (IBAction)tweetFavorited:(UIButton *)sender {
    if (!self.tweet.favorited) {
        //Set tweet status to favorited and update its favorite count
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
    } else {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
    }
    self.favoriteButton.selected = !self.favoriteButton.selected;
    [self refreshData];
}
- (IBAction)tweetRetweeted:(UIButton *)sender {
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)refreshData {
    self.screenName.text = self.tweet.user.name;
    self.name.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.tweetText.text = self.tweet.text;
    self.favoriteCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
//    if (self.tweet.favorited) {
//        UIImage *favorited = [UIImage imageNamed: @"../Assets.xcassets/favor_icon_red.png"];
//        [self.favoriteButton setImage:favorited forState:UIControlStateNormal];
//    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
