//
//  HAViewController.m
//  StatusbarUnderView
//
//  Created by Takahiro Nishinobu on 2014/01/15.
//  Copyright (c) 2014年 Takahiro Nishinobu. All rights reserved.
//

#import "HAViewController.h"

@interface HAViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation HAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    //iOS7以降での処理
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        //ステータスバーの高さを取得
        float statusBarHeight = MIN([UIApplication sharedApplication].statusBarFrame.size.height, [UIApplication sharedApplication].statusBarFrame.size.width);
        //ステータスバーの高さ分、BaseViewのY座標をたす
        CGPoint viewPoint = (CGPoint) { CGRectGetMinX(_baseView.frame), CGRectGetMinY(_baseView.frame) + statusBarHeight };
        //ステータスバーの高さ分、BaseViewのHeightをへらす
        CGSize viewSize = (CGSize) { CGRectGetWidth(_baseView.frame), CGRectGetHeight(_baseView.frame) - statusBarHeight };
        
        //反映
        _baseView.frame = (CGRect) { viewPoint, viewSize };
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_myTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = @"TEST";
    return cell;
}

@end
