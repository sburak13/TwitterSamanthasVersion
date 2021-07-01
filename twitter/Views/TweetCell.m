//
//  TweetCell.m
//  twitter
//
//  Created by samanthaburak on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "DateTools/DateTools.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
}

- (void)updateWithTweet:(Tweet *)tweet {
    
    self.tweet = tweet;
    self.authorLabel.text = tweet.user.name;
    self.tweetTextLabel.text = tweet.text;
    self.usernameLabel.text = [@"@" stringByAppendingString:tweet.user.screenName];
    self.retweetCountLabel.text = [@(tweet.retweetCount) stringValue];
    self.favCountLabel.text = [@(tweet.favoriteCount) stringValue];
    self.timeAgoLabel.text = tweet.dateCreated.shortTimeAgoSinceNow;
    
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    self.profileView.image = nil;
    [self.profileView setImageWithURL:url];
    
}

- (IBAction)didTapFavorite:(id)sender {
    
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
