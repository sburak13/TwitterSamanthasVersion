//
//  DetailsViewController.h
//  twitter
//
//  Created by samanthaburak on 6/30/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *profileView2;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel2;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel2;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel2;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel2;
@property (weak, nonatomic) IBOutlet UILabel *favCountLabel2;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic, weak) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END
