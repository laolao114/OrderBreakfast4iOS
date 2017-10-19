//
//  MeMainController.m
//  OrderBreakfast
//
//  Created by old's mac on 2017/7/18.
//  Copyright © 2017年 scnu. All rights reserved.
//

#import "MeMainController.h"
#import "MeNormalCell.h"
#import "MeMainHeadView.h"
#import "MyAddressListController.h"


@interface MeMainController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MeMainHeadView *headView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic) BOOL firstLoad;

@end

static NSString *const cellIdentifier = @"MeNormalCell";

@implementation MeMainController {
    NSInteger _page;
    NSInteger _pageLimit;
    NSArray *iconArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)configData {
    _page = 0;
    _pageLimit = 20;
    _dataArray = [NSMutableArray arrayWithArray:@[@"收货地址",@"我的收藏",@"我的订单",@"我的跑腿",@"设置"]];
    iconArray = @[@"address_icon",@"Me_attention",@"矢量智能对象3",@"Me_wallet",@"Me_install"];
    _firstLoad = YES;
}

- (void)setupView {
    self.navigationItem.title = @"我的";
    UIView *bgView = [[UIView alloc] init];
    [self.view addSubview:bgView];
    bgView.backgroundColor = COLOR_BLUE;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@50);
    }];

    UITableView *tableView = [[UITableView alloc] init];
    _tableView = tableView;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 100;
    [_tableView registerClass:[MeNormalCell class] forCellReuseIdentifier:cellIdentifier];
    _headView = [[MeMainHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [_headView configViewWith:@"http://tva1.sinaimg.cn/crop.0.0.180.180.180/8f922e4bjw1e8qgp5bmzyj2050050aa8.jpg" andNick:@"老老" andPhone:@"15603005773"];
    _tableView.tableHeaderView = _headView;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

#pragma mark - tableView delegate && datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MeNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell configTitle:_dataArray[indexPath.row] content:@"" image:iconArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            MyAddressListController *addressListCon = [[MyAddressListController alloc] init];
            [self.navigationController pushViewController:addressListCon animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < -50) {
        [scrollView setContentOffset:CGPointMake(0, -50)];
    }
}

@end
