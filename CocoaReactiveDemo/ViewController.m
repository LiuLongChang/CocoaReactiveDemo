//
//  ViewController.m
//  CocoaReactiveDemo
//
//  Created by langyue on 16/4/12.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "ViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>



@interface ViewController ()


@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passPwd;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@property(nonatomic,copy)NSString * userNameStr;
@property(nonatomic,copy)NSString * passPwdStr;



@property(nonatomic,retain)RACDisposable * loadingDispatch;



@end





@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    
    [_loginBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    [RACObserve(self, self.userNameStr) subscribeNext:^(NSString* x) {
//        
//        NSLog(@"RACObserve====  %@",x);
//        
//    }];;
    
    
    
    
//    [[RACObserve(self, self.userNameStr) filter:^BOOL(id value) {
//        
//        if ([value hasPrefix:@"2"]) {
//            return YES;
//        }else{
//            return NO;
//        }
//        
//        
//    }] subscribeNext:^(NSString* x) {
//        
//        NSLog(@"%@",x);
//        
//        
//    }];



    
    
//    [[self.passPwd.rac_textSignal filter:^BOOL(NSString* str) {
//        
//        if (str.integerValue > 20) {
//            return YES;
//        }else{
//            return NO;
//        }
//        
//    }] subscribeNext:^(NSString* str) {
//        
//        
//        NSLog(@"%@",str);
//        
//    }];
    
    
    //RACObserve(self, isConnected)
    //, NSNumber *connect
    
    
    
//    _loginBtn.enabled = NO;
//    //RAC(_loginBtn,enabled) =
    
    
     [[RACSignal
                                   combineLatest:@[self.userName.rac_textSignal,
                                                   self.passPwd.rac_textSignal,
                                                   
                                                   ]
                                   reduce:^(NSString *price, NSString *name){
                                       return @(price.length > 0 && name.length > 3);
                                   }] subscribeNext:^(NSNumber* res) {
                                       
                                       
                                       [self showingLoading];
                                       
                                       
                                       if ([res boolValue]) {
                                           NSLog(@"XXXX send request");
                                           _loginBtn.enabled = YES;
                                       }else{
                                           _loginBtn.enabled = NO;
                                       }
                                       
                                       
                                       
                                   }];
    
}


-(void)showingLoading{
    
    
    [self.loadingDispatch dispose];
    self.loadingDispatch =  [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendCompleted];
        return nil;
    }] delay:1] subscribeCompleted:^{
        NSLog(@"zzzzzzzzzzzz");
        self.loadingDispatch = nil;
    }];
    
    
}



-(void)btnAction:(UIButton*)btn{
    
    
    self.userNameStr = _userName.text;
    
    
    
    
    //NSLog(@"======== %@",self.userNameStr);
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

    

}

@end
