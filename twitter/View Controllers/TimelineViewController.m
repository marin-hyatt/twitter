//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "../API/APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"

@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate>

- (IBAction)logoutPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *timelineView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSMutableArray *tweetArray;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timelineView.dataSource = self;
    self.timelineView.delegate = self;
    
    //Initialize refresh control for pull to refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadTweets) forControlEvents:UIControlEventValueChanged];
    [self.timelineView insertSubview:self.refreshControl atIndex:0];
    
    [self loadTweets];
}

- (void)loadTweets {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            //Sets tweet array property to result of API call
            self.tweetArray = (NSMutableArray*) tweets;
//            for (NSDictionary *dictionary in tweets) {
//                NSString *text = dictionary[@"text"];
//                NSLog(@"%@", text);
//            }
            [self.timelineView reloadData];
            [self.refreshControl endRefreshing];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [self.timelineView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    Tweet *tweet = self.tweetArray[indexPath.row];
    cell.tweet = tweet;
    
    //Set profile picture
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    cell.profilePicture.image = [UIImage imageWithData:urlData];
    
    //Set screen name
    cell.screenName.text = tweet.user.screenName;
    
    //Set name
    cell.name.text = [NSString stringWithFormat:@"@%@", tweet.user.name];
    
    //Set tweet text;
    cell.tweetText.text = tweet.text;
    
    //Set retweet count
    cell.retweetCount.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    
    //Set favorite count
    cell.favoriteCount.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Set navigation controller as the destination controller
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    //Sets timeline view controller as delegate of compose view controller
    composeController.delegate = self;
}



- (IBAction)logoutPressed:(UIButton *)sender {
    NSLog(@"Log out");
    //Creates app delegate, Main storyboard, and Login view controller. Then sets the root view controller (the one the user sees) to the Login view controller
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    //Clears out access tokens, basically logs user out
    [[APIManager shared] logout];
    
}
- (void)didTweet:(nonnull Tweet *)tweet {
    [self.tweetArray addObject:tweet];
    [self.timelineView reloadData];
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
