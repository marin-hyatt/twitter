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
#import "DetailViewController.h"
#import "ProfileViewController.h"

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

- (void)viewWillAppear:(BOOL)animated {
    [self loadTweets];
}

- (void)loadTweets {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            //Sets tweet array property to result of API call
            self.tweetArray = (NSMutableArray*) tweets;
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
    
    //Assigns TimelineViewController as the TweetCellDelegate that will navigate to user's profile page
    cell.delegate = self;
    
    Tweet *tweet = self.tweetArray[indexPath.row];
    cell.tweet = tweet;
    
    //Refreshes cell UI with tweet data
    [cell refreshData];
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]  isEqual: @"DetailViewController"]) {
        //Gets the tweet corresponding to the tapped cell
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.timelineView indexPathForCell:tappedCell];
        Tweet *tweet = self.tweetArray[indexPath.row];
        
        // Gets the destination view controller.
        DetailViewController *detailViewController = [segue destinationViewController];
        
        // Pass the tweet to the new view controller.
        detailViewController.tweet = tweet;
        
    } else if ([[segue identifier]  isEqual: @"ComposeViewController"]){
        // Segue to compose tweets
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        //Sets timeline view controller as delegate of compose view controller
        composeController.delegate = self;
        
        //TODO: Send profile picture to Compose tweet screen

    } else {
        //Segue to Profile View Controller
        ProfileViewController *profileController = [segue destinationViewController];
        
        //Passes user to profile view controller
        profileController.user = sender;
        
    }
    
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


//Method conforming to tweet cell delegate that navigates to user profile.
- (void)tweetCell:(TweetCell *)tweetCell didTap:(User *)user {
    //Perform segue programmatically
    [self performSegueWithIdentifier:@"ProfileViewController" sender:user];
}

@end
