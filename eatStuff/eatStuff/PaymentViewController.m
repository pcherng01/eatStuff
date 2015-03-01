//
//  PaymentViewController.m
//  eatStuff
//
//  Created by Pongsakorn Cherngchaosil on 3/1/15.
//  Copyright (c) 2015 Pongsakorn Cherngchaosil. All rights reserved.
//

#import "PaymentViewController.h"
#import "ScanViewController.h"

@interface PaymentViewController () <BTDropInViewControllerDelegate>

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   self.manager = [AFHTTPRequestOperationManager manager];
   [self getToken];
}

-(void)getToken{
   [self.manager GET:@"https://eatstuff.ngrok.com/client_token" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      // do something
      self.clientToken = responseObject[@"clientToken"];
      self.startPaymentButton.enabled = true;
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      NSLog(@"%@",error);
   }];
}

-(IBAction)startPayment:(id)sender{
   Braintree *braintree = [Braintree braintreeWithClientToken:self.clientToken];
   BTDropInViewController *dropInViewController = [braintree dropInViewControllerWithDelegate:self];
   
   dropInViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(userDidCancelPayment)];
   
   dropInViewController.summaryTitle = @"A Braintree Mug";
   dropInViewController.summaryDescription = @"Enough for a good cup of coffee";
   dropInViewController.displayAmount = @"$10";
   
   UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:dropInViewController];
   
   [self presentViewController:navigationController animated:YES completion:nil];
}


-(void)dropInViewControllerDidCancel:(BTDropInViewController *)viewController{
   [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dropInViewControllerWillComplete:(BTDropInViewController *)viewController
{
   [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dropInViewController:(BTDropInViewController *)viewController didSucceedWithPaymentMethod:(BTPaymentMethod *)paymentMethod{
   [self postNonceToServer:paymentMethod.nonce];
   [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)userDidCancelPayment{
   [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

-(void)postNonceToServer:(NSString *)paymentMethodNonce {
   [self.manager POST:@"https://eatstuff.ngrok.com/purchase" parameters:@{@"payment_method_nonce":paymentMethodNonce} success:^(AFHTTPRequestOperation *operation, id responseObject) {
      NSString *transactionID = responseObject[@"transaction"][@"id"];
      NSLog(@"%@",transactionID);
      self.transactionIDLabel.text = [[NSString alloc]initWithFormat:@"Transaction ID: %@", transactionID];
   } failure:^(AFHTTPRequestOperation *operation, NSError *error){
      NSLog(@"Error: %@",error);
   }];
}
- (IBAction)goToScan:(id)sender {
   ScanViewController *scanVC = [[ScanViewController alloc]init];
   // Push it onto the top of the navigation controller's stack
   [self.navigationController pushViewController:scanVC animated:YES];
}
- (IBAction)postCheck:(id)sender {
   NSString *stringz = @"ele";
   NSDictionary *data = [NSDictionary dictionary];
   NSError *error = [[NSError alloc]init];
   NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:&error];
   
   NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
   NSURL *theURL = [NSURL URLWithString:@"https://eatstuff.ngrok.com/buy"];
   [request setURL:theURL];
   [request setHTTPMethod:@"POST"];
   [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type" ];
   [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
   [request setHTTPBody:jsonData];
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
