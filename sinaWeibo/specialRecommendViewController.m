//
//  specialRecommendViewController.m
//  sinaWeibo
//
//  Created by app on 17/4/17.
//  Copyright © 2017年 Feizj. All rights reserved.
//

#import "specialRecommendViewController.h"

@interface specialRecommendViewController ()

@end

@implementation specialRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /**
     *  取消对 navigationBar 的隐藏
     */
    self.navigationController.navigationBar.hidden=NO;
    self.title = @"特别推荐";
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
