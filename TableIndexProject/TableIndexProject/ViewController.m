//
//  ViewController.m
//  TableIndexProject
//
//  Created by 朱发明 on 2017/11/24.
//  Copyright © 2017年 朱发明. All rights reserved.
//

#import "ViewController.h"
#import "FMTableIndexView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    FMTableIndexView *indexV = [[FMTableIndexView alloc] initWithFrame:CGRectMake(100, 100, 80, 0)];
    NSArray *charArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K"];
    indexV.indexArray = charArray;
     [self.view addSubview:indexV];
    indexV.block = ^(int index) {
        //返回数组下标
        //NSLog([NSString stringWithFormat:@"%d",index]);
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
