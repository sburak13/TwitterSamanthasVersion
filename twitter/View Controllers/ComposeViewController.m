//
//  ComposeViewController.m
//  twitter
//
//  Created by samanthaburak on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSLog(@"testing");
//    NSLog(@"%@", self.textView.text);
//    NSString *newVar = self.textView.text;
}

- (IBAction)didTapTweetButton:(UIBarButtonItem *)sender {
    
    NSString *newVar = self.tweetTextView.text;
    NSLog(@"%@", self.tweetTextView.text);
    NSLog(@"hellooooo");
    NSLog(@"%@", newVar);
    
    NSString *newTweetText = self.tweetTextView.text;
    [[APIManager shared]postStatusWithText:newTweetText completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
            NSLog(@"Compose Tweet Success!");
        }
    }];
    
}

- (IBAction)didTapCloseButton:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
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
