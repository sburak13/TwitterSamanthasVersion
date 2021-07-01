//
//  ProfileViewController.m
//  twitter
//
//  Created by samanthaburak on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"


@interface ProfileViewController ()


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.authorLabel3.text = self.user.name;
    self.usernameLabel3.text = [@"@" stringByAppendingString:self.user.screenName];
    
    NSString *URLString = self.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    self.profileView3.image = nil;
    [self.profileView3 setImageWithURL:url];
    
    self.tweetCountLabel.text = [[@(self.user.tweetCount) stringValue] stringByAppendingString:@" Tweets"];
    self.followerCountLabel.text = [[@(self.user.followerCount) stringValue] stringByAppendingString:@" Followers"];
    self.followingCountLabel.text = [[@(self.user.followingCount) stringValue] stringByAppendingString:@" Following"];
    
    self.dateCreatedLabel.text = [@"Joined " stringByAppendingString:self.user.createdAtString];
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
