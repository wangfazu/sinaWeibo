//
//  weiBoViewController.m
//  sinaWeibo
//
//  Created by app on 17/4/13.
//  Copyright © 2017年 Feizj. All rights reserved.
//

#import "weiBoViewController.h"

@interface weiBoViewController ()

@end

@implementation weiBoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微博";
    // Do any additional setup after loading the view.
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(applicationWidth/2-40, applicationHeight/2-40, 80, 80)];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
}

- (void)btnclick{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = dRedirectURL;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SenddMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1",@"obj2"],
                         @"Other_Info_3": @{@"key1":@"obj1", @"key2": @"obj2"}
                         };
    [WeiboSDK sendRequest:request];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
