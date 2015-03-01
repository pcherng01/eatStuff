//
//  loadingViewController.m
//  eatStuff
//
//  Created by Pongsakorn Cherngchaosil on 3/1/15.
//  Copyright (c) 2015 Pongsakorn Cherngchaosil. All rights reserved.
//

#import "LoadingViewController.h"
#import "FormViewController.h"

@interface LoadingViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinningWheel;
@property (nonatomic,strong) NSURLSession *session;

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
   _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
   [self.spinningWheel startAnimating];
   [self fetchFeed:self];
   
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)fetchFeed:(id)sender {
   NSString *requestString = _getURL;
   NSURL *url = [NSURL URLWithString:requestString];
   NSURLRequest *req = [NSURLRequest requestWithURL:url];
   
   NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
      
      self.dataFromWebServer = jsonObject;
      self.getURL = jsonObject[@"dataUrl"];
      FormViewController *formVC = [[FormViewController alloc]init];
      formVC.urlString = self.getURL;
      formVC.dataFromServer = self.dataFromWebServer;
      [self.navigationController pushViewController:formVC animated:YES];
      
   }];
   [dataTask resume];
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
