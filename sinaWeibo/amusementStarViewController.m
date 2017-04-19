//
//  amusementStarViewController.m
//  sinaWeibo
//
//  Created by app on 17/4/17.
//  Copyright © 2017年 Feizj. All rights reserved.
//

#import "amusementStarViewController.h"

@interface amusementStarViewController ()

@end

@implementation amusementStarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  取消对 navigationBar 的隐藏
     */
    self.navigationController.navigationBar.hidden=NO;
    self.title = @"娱乐明星";
    self.view.backgroundColor = [UIColor blueColor];


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
