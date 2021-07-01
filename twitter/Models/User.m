//
//  User.m
//  twitter
//
//  Created by samanthaburak on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicture = dictionary[@"profile_image_url_https"];
        self.tweetCount = [dictionary[@"statuses_count"] intValue];
        self.followerCount = [dictionary[@"friends_count"] intValue];
        self.followingCount = [dictionary[@"followers_count"] intValue];
        
        // Format and set createdAtString
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        // Convert String to Date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        self.dateCreated = date;
        
        // Configure output format
        formatter.dateStyle = NSDateFormatterMediumStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        // Convert Date to String
        self.createdAtString = [formatter stringFromDate:date];
        
    }
    
    return self;
}

@end
