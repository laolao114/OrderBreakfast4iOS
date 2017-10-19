//
//  OrderDetailController.m
//  OrderBreakfast
//
//  Created by old's mac on 2017/9/10.
//  Copyright © 2017年 scnu. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderDetailModel.h"
#import "OrderDetailHeadView.h"

@interface OrderDetailController ()

@property (nonatomic, strong) OrderDetailHeadView *headView;

@end    

@implementation OrderDetailController {
    UIButton *commitButton;
}

- (instancetype)init {
    if (self = [super init]) {
        self.viewToScrollView = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self loadData];
}

- (void)setupView {
    self.title = @"任务详情";
    _headView = [[OrderDetailHeadView alloc] init];
    [self.contView addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contView);
        make.bottom.equalTo(self.contView).priorityLow();
    }];
    
    commitButton = [[UIButton alloc] init];
    [commitButton addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
    [commitButton setBackgroundImage:[UIImage imageWithColor:COLOR_BLUE] forState:UIControlStateNormal];
    [commitButton setBackgroundImage:[UIImage imageWithColor:COLOR_BLUE_DISABLED] forState:UIControlStateDisabled];
    [commitButton setTitle:@"帮助TA" forState:UIControlStateNormal];
    commitButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    
    [self createRightNavigationItemBtnWithImgName:@"Me_attention" highlightImgName:nil title:nil selector:@selector(rightAction:)];
}

#pragma mark - button action
- (void)commitAction:(UIButton *)button {
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self okAction];
    }];
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"注意" message:@"确定要领取这个任务吗" preferredStyle:UIAlertControllerStyleAlert];
    [alertCon addAction:cancelAction];
    [alertCon addAction:okAction];
    [self presentViewController:alertCon animated:YES completion:nil];
}

- (void)okAction {
    
}

- (void)rightAction:(UIButton *)rightAction {
    
}

- (void)loadData {
    OrderDetailModelData *data = [[OrderDetailModelData alloc] init];
    data.status = @"0";
    data.content = @"麻烦哪位大哥帮我从西三楼下带个快递，顺丰的谢谢了！";
    data.name = @"张三";
    data.price = @"1.00";
    data.avatarUrl = @"http://tva4.sinaimg.cn/crop.0.0.180.180.50/86ed1422jw1e8qgp5bmzyj2050050aa8.jpg";
    data.address = @"华南师范大学西三201";
    [_headView configViewWith:data];
}

@end
