//
//  FormViewController.h
//  eatStuff
//
//  Created by Pongsakorn Cherngchaosil on 2/28/15.
//  Copyright (c) 2015 Pongsakorn Cherngchaosil. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FormViewController;

@interface FormViewController : UIViewController
@property (nonatomic,strong) NSString *urlString;
@property (nonatomic,strong) NSString *customerName;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,assign) NSNumber *partySize;
@property (nonatomic,strong) NSString *postString;
@property (nonatomic,strong) NSDictionary *dataFromServer;
@end
