//
//  ViewController.m
//  PopMenuView
//
//  Created by 张志彬 on 2018/9/13.
//  Copyright © 2018年 张志彬. All rights reserved.
//

#import "ViewController.h"
#import "PopMenuView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showMenu:(id)sender {
    PopMenuView *popMenuView = [PopMenuView showInView:self.view location:((UIButton *)sender).center titleList:@[@{@"title":@"test title 0", @"imageName":@"edit-square"}, @{@"title":@"test title 1", @"imageName":@"message"}, @{@"title":@"test title 2", @"imageName":@"plus-circle-2"}, @{@"title":@"test title 0", @"imageName":@"question-circle"}] selectActionHandler:^(int index, id object) {
        NSLog(@"select index : %d \ndata : %@", index, object);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
