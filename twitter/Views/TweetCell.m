//
//  TweetCell.m
//  twitter
//
//  Created by samanthaburak on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapFavorite:(id)sender {
    /*
    // TODO: Update the local tweet model
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;

    // TODO: Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
    
    // TODO: Update cell UI
    self.favCountLabel.text = [@(self.tweet.favoriteCount) stringValue];
    // change button image
    
    UIButton *btn = (UIButton *)sender;
    [btn setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
    */
    
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
    self.favCountLabel.text = [@(self.tweet.favoriteCount) stringValue];
    
}

- (IBAction)didTapRetweet:(id)sender {
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
    self.retweetCountLabel.text = [@(self.tweet.retweetCount) stringValue];
    
}



@end
