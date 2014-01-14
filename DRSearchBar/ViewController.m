//
//  ViewController.m
//  DRSearchBar
//
//  Created by david on 14-1-13.
//  Copyright (c) 2014年 david. All rights reserved.
//

#import "ViewController.h"
#import "DRSearchBar.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    DRSearchBar *searchBar = [[DRSearchBar alloc] initWithFrame:(CGRect){20,100,700,50}];
    [self.view addSubview:searchBar];
//    NSLog(@"%@",searchBar.subviews);
    for (UIView *sub in searchBar.subviews) {
        NSLog(@"%@",sub.subviews);
    }
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
