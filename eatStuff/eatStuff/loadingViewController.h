//
//  loadingViewController.h
//  eatStuff
//
//  Created by Pongsakorn Cherngchaosil on 3/1/15.
//  Copyright (c) 2015 Pongsakorn Cherngchaosil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingViewController : UIViewController

@property (nonatomic,strong) NSString *getURL;
@property (nonatomic,strong) UINavigationController *navVC;
@property (nonatomic,strong) NSDictionary *dataFromWebServer;

@end
