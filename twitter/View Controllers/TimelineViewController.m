//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "DateTools/DateTools.h"
#import "DetailsViewController.h"
#import "ProfileViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, TweetCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic) NSMutableArray *arrayOfTweets;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self loadTweets];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex: 0];
    
}

- (void)loadTweets {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        
        if (tweets) {
            self.arrayOfTweets = tweets;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
            NSLog(@"Successfully loaded home timeline");
            
        } else {
            NSLog(@"Error getting home timeline: %@", error.localizedDescription);
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapLogoutButton:(UIButton *)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
    
}

// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {

      // Create NSURL and NSURLRequest
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    session.configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
  
    NSURLSessionDataTask *task = [session dataTaskWithRequest:self.arrayOfTweets completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
  
        // ... Use the new data to update the data source ...

        // Reload the tableView now that there is new data
        [self.tableView reloadData];

        // Tell the refreshControl to stop spinning
          [refreshControl endRefreshing];

      }];
  
      [task resume];
}

- (void)didTweet:(Tweet*)tweet {
    
    [self.arrayOfTweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
    
}

- (void)tweetCell:(TweetCell *)tweetCell didTap:(User *)user{
    // Perform segue to profile view controller
    [self performSegueWithIdentifier:@"profileSegue" sender:user];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"composeViewSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    } else if ([[segue identifier] isEqualToString:@"detailViewSegue"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Tweet *tweet = self.arrayOfTweets[indexPath.row];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.tweet = tweet;
    } else if ([segue.identifier isEqual:@"profileSegue"]) {
        ProfileViewController *profileController = [segue destinationViewController];
        profileController.user = sender;
    }

}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    [cell updateWithTweet:tweet];
    cell.delegate = self;
    return cell;
     
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrayOfTweets.count;
    
}

@end
