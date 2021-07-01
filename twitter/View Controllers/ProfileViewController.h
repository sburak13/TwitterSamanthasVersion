//
//  ProfileViewController.h
//  twitter
//
//  Created by samanthaburak on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *profileView3;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel3;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel3;
@property (weak, nonatomic) IBOutlet UILabel *tweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followerCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateCreatedLabel;

@property (nonatomic, weak) User *user;

@end

NS_ASSUME_NONNULL_END
