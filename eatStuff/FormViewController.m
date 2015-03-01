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
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *partyText;
@property (weak, nonatomic) IBOutlet UITextField *restaurantNameTextField;

@end

@implementation FormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   NSLog(@"%@", self.dataFromServer);
   NSLog(@"%@", self.urlString);
   _restaurantNameTextField.text = _dataFromServer[@"name"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];
}

- (IBAction)postRequestJSON:(id)sender {
   /*
   NSString *nameString = [[NSString alloc]initWithFormat:_nameText.text];
    NSString *emailString = [[NSString alloc]initWithFormat:_emailText.text];*/
   self.partySize = [NSNumber numberWithInt:[_partyText.text intValue]];
   
   NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:_nameText.text,@"name",self.partySize,@"partySize",_emailText.text,@"email",nil];
   NSError *error = [[NSError alloc]init];
   NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:&error];
   
   NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
   NSURL *theURL = [NSURL URLWithString:self.urlString];
   [request setURL:theURL];
   [request setHTTPMethod:@"POST"];
   [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type" ];
   [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
   [request setHTTPBody:jsonData];
   
   NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
   [connection start];
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
