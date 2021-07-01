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

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic) NSMutableArray *arrayOfTweets;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
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
            
            // self.refreshControl = [[UIRefreshControl alloc] init];
            
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            /*
             for (NSDictionary *dictionary in tweets) {
                NSString *text = dictionary[@"text"];
                NSLog(@"%@", text);
            }
             */
            
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        NSLog(@"hola");
        
        // [self.refreshControl endRefreshing];
        
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
    }

}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSLog(@"hi");
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    
    cell.tweet = tweet;
    cell.authorLabel.text = tweet.user.name;
    cell.tweetTextLabel.text = tweet.text;
    cell.usernameLabel.text = [@"@" stringByAppendingString:tweet.user.screenName];
    cell.retweetCountLabel.text = [@(tweet.retweetCount) stringValue];
    cell.favCountLabel.text = [@(tweet.favoriteCount) stringValue];
    
    cell.timeAgoLabel.text = tweet.dateCreated.shortTimeAgoSinceNow;
    
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    // NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    cell.profileView.image = nil;
    [cell.profileView setImageWithURL:url];
     
    
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}

@end
