//
//  AboutContentViewController.m
//  CineMetro
//
//  Created by George Haristos on 29/11/14.
//  Copyright (c) 2014 George Haristos. All rights reserved.
//

#import "AboutContentViewController.h"

@interface AboutContentViewController ()

@end

@implementation AboutContentViewController
@synthesize imageview;
@synthesize textview;
- (void)viewDidLoad {
    [super viewDidLoad];
    imageview.image = [UIImage imageNamed:self.imageFile];
    textview.text = self.text;
    // Do any additional setup after loading the view.
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
