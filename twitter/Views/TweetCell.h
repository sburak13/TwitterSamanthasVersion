//
//  TweetCell.h
//  twitter
//
//  Created by samanthaburak on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;



@property (nonatomic, weak) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END
