//
//  FormViewController.m
//  eatStuff
//
//  Created by Pongsakorn Cherngchaosil on 2/28/15.
//  Copyright (c) 2015 Pongsakorn Cherngchaosil. All rights reserved.
//

#import "FormViewController.h"

@interface FormViewController ()
@property (weak, nonatomic) IBOutlet UITextField *urlText;
@property (nonatomic,strong) NSURLSession *session;

@end

@implementation FormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
   NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
   _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];
   self.urlText.text = _urlString;
   
}
/*
- (IBAction)fetchFeed:(id)sender {
   NSString *requestString = _urlString;
   NSURL *url = [NSURL URLWithString:requestString];
   NSURLRequest *req = [NSURLRequest requestWithURL:url];
   
   NSURLSession
}*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
