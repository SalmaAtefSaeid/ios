//
//  ViewController.m
//  jsonDemo
//
//  Created by JETS Mobile Lab-12 on 4/24/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *phone;
- (IBAction)login:(UIButton *)sender;

@end

@implementation ViewController{
    NSMutableData * dataReceived;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dataReceived = [NSMutableData new];
}


- (IBAction)login:(UIButton *)sender {
    NSString *stringUrl = [[NSString alloc] initWithFormat:@"http://jets.iti.gov.eg/FriendsApp/services/user/register?name=%@&phone=%@", _userName.text, _phone.text];
    NSURL *url =[NSURL URLWithString: stringUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];

}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [dataReceived appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:dataReceived options:NSJSONReadingAllowFragments error:nil];
    NSString *status = [dict objectForKey:@"status"];
    if([status isEqualToString:@"FAILING"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Status" message:@"This Phone is already Registered." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",@"Try Again", nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Status" message:@"Registered Susseccful" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        _userName.text = @"";
        _phone.text = @"";
    }
}

@end
