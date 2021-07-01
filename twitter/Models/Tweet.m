//
//  Tweet.m
//  twitter
//
//  Created by samanthaburak on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "User.h"

@implementation Tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {

        // Is this a re-tweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if(originalTweet != nil){
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];

            // Change tweet to original tweet
            dictionary = originalTweet;
        }
        self.idStr = dictionary[@"id_str"];
        
        //OLD
        self.text = dictionary[@"text"];
        //Change to "full_text"
        self.text = dictionary[@"full_text"];
        
        
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        
        // Initialize user
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];

        // Format and set createdAtString
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSLog(@"%@", createdAtOriginalString);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        // Convert String to Date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];

        self.dateCreated = date;
        NSLog(@"%@", self.dateCreated);
        // Configure output format
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        // Convert Date to String
        self.createdAtString = [formatter stringFromDate:date];
        
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
        timeFormatter.dateFormat = @"HH:mm";
        NSString *timeString = [timeFormatter stringFromDate: self.dateCreated];
        self.timeCreatedAt = timeString;

    }
    
    return self;
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary *dictionary in dictionaries) {
        if (dictionary) {
            Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
            [tweets addObject:tweet];
        }
    }
    
    return tweets;
    
}

@end
