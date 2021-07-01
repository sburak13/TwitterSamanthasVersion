//
//  DetailsViewController.m
//  twitter
//
//  Created by samanthaburak on 6/30/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.authorLabel2.text = self.tweet.user.name;
    self.tweetTextLabel2.text = self.tweet.text;
    self.usernameLabel2.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.retweetCountLabel2.text = [[@(self.tweet.retweetCount) stringValue] stringByAppendingString:@" Retweets"];
    self.favCountLabel2.text = [[@(self.tweet.favoriteCount) stringValue] stringByAppendingString:@" Likes"];
    
    self.dateLabel.text = [self.tweet.createdAtString stringByAppendingString:[@"     " stringByAppendingString:self.tweet.timeCreatedAt]];
    
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    
    self.profileView2.image = nil;
    [self.profileView2 setImageWithURL:url];
    
}

- (IBAction)didTapFavorite2:(id)sender {
    UIButton *btn = (UIButton *)sender;
    self.tweet.favorited = !self.tweet.favorited;
    if (self.tweet.favorited) {
        self.tweet.favoriteCount += 1;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                [btn setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
            }
        }];
    } else {
        self.tweet.favoriteCount -= 1;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
                [btn setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
            }
        }];
    }
    self.favCountLabel2.text =  [[@(self.tweet.favoriteCount) stringValue] stringByAppendingString:@" Likes"];
}

- (IBAction)didTapRetweet2:(id)sender {
    UIButton *btn = (UIButton *)sender;
    self.tweet.retweeted = !self.tweet.retweeted;
    if (self.tweet.retweeted) {
        self.tweet.retweetCount += 1;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                [btn setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
            }
        }];
    } else {
        self.tweet.retweetCount -= 1;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
                [btn setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
            }
        }];
    }
    self.retweetCountLabel2.text = [[@(self.tweet.retweetCount) stringValue] stringByAppendingString:@" Retweets"];
    
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
