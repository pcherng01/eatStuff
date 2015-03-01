//
//  PaymentViewController.h
//  eatStuff
//
//  Created by Pongsakorn Cherngchaosil on 3/1/15.
//  Copyright (c) 2015 Pongsakorn Cherngchaosil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "Braintree/Braintree.h"


@interface PaymentViewController : UIViewController

@property (weak,nonatomic) IBOutlet UILabel *transactionIDLabel;
@property (strong,nonatomic) IBOutlet UIButton *startPaymentButton;
@property (strong,nonatomic) NSString *clientToken;
@property (strong,nonatomic) AFHTTPRequestOperationManager *manager;

@end
