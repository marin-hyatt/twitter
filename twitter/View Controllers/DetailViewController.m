//
//  DetailViewController.m
//  twitter
//
//  Created by Marin Hyatt on 6/30/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *timestamp;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCount;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.screenName.text = self.tweet.user.name;
    self.name.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.tweetText.text = self.tweet.text;
    self.favoriteCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
    self.favoriteButton.selected = self.tweet.favorited;
    self.retweetButton.selected = self.tweet.retweeted;
    
    //Set profile picture
    self.profilePicture.image = nil;
    
    if (self.tweet.user.profilePicture != nil) {
        NSString *URLString = self.tweet.user.profilePicture;
        NSURL *url = [NSURL URLWithString:URLString];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        self.profilePicture.image = [UIImage imageWithData:urlData];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
