//
//  hotTopicDetailViewController.m
//  sinaWeibo
//
//  Created by app on 17/4/17.
//  Copyright © 2017年 Feizj. All rights reserved.
//

#import "hotTopicDetailViewController.h"

@interface hotTopicDetailViewController ()

@end

@implementation hotTopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"热门话题";
    self.title = self.array;
  
    
    /**
     *  取消对 navigationBar 的隐藏
     */
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.hidden=YES;
    
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
