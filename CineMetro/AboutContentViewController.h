//
//  AboutContentViewController.h
//  CineMetro
//
//  Created by George Haristos on 29/11/14.
//  Copyright (c) 2014 George Haristos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property NSUInteger pageIndex;
@property NSString *imageFile;
@property NSString *text;
@end
