//
//  HomeMainController.m
//  OrderBreakfast
//
//  Created by old's mac on 2017/7/18.
//  Copyright © 2017年 scnu. All rights reserved.
//

#import "HomeMainController.h"
#import "CreateOrderController.h"

@interface HomeMainController ()

@end

@implementation HomeMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    UIView *firstView = [[UIView alloc] init];
    firstView.backgroundColor = [UIColor colorWithRGB:0xb3c6e6];
    [self.view addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_centerY);
    }];
    
    UIButton *createButton = [[UIButton alloc] init];
    createButton.layer.masksToBounds = YES;
    createButton.layer.cornerRadius = 40;
    createButton.backgroundColor = COLOR_BLUE;
    [createButton setTitle:@"我要跑腿" forState:UIControlStateNormal];
    createButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [firstView addSubview:createButton];
    [createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@80);
        make.center.equalTo(firstView);
    }];
    
    UIView *secondView = [[UIView alloc] init];
    secondView.backgroundColor = [UIColor colorWithRGB:0xe9b4b4];
    [self.view addSubview:secondView];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_centerY);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    UIButton *helpButton = [[UIButton alloc] init];
    helpButton.layer.masksToBounds = YES;
    helpButton.layer.cornerRadius = 40;
    helpButton.backgroundColor = COLOR_RED;
    [helpButton addTarget:self action:@selector(createAction:) forControlEvents:UIControlEventTouchUpInside];
    [helpButton setTitle:@"我要帮助" forState:UIControlStateNormal];
    helpButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [secondView addSubview:helpButton];
    [helpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@80);
        make.center.equalTo(secondView);
    }];
}

- (void)createAction:(UIButton *)button {
    CreateOrderController *createCon = [[CreateOrderController alloc] init];
    [self.navigationController pushViewController:createCon animated:YES];
}

@end
