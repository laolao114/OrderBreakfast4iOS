//
//  OrderListViewController.m
//  chubankuai
//
//  Created by old's mac on 2017/4/10.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListCell.h"
#import "OrderListModel.h"
#import "OrderListHistoryCell.h"
#import "OrderDetailController.h"

@interface OrderListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) LCCustomListView *listView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

static NSString *const cellIdentifier = @"OrderListCell";
static NSString *const cellIdentifier2 = @"OrderListHistoryCell";

@implementation OrderListViewController {
    BOOL isFirstLoad;
    NSInteger pageLimit;
    NSInteger page;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    page = 0;
    pageLimit = 15;
    isFirstLoad = YES;
    [self setupView];
    [self loadData];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor colorWithRGB:0xf7f7f7];
    LCCustomListView *listView = [[LCCustomListView alloc]initWithFrame:CGRectZero toTarget:self.view];
    _listView = listView;
    _listView.pageLimit = pageLimit;
    _listView.willRefreshBlock = ^(LCCustomListView *listView) {
        [self refresh];
    };
    _listView.willLoadMoreBlock = ^(LCCustomListView *listView) {
        [self loadData];
    };
    _listView.pageLimit = pageLimit;
    _listView.wantNoDataTipsView = YES;
    _tableView = _listView.listTableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 80;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[OrderListCell class] forCellReuseIdentifier:cellIdentifier];
    [_tableView registerClass:[OrderListHistoryCell class] forCellReuseIdentifier:cellIdentifier2];
    [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - tableView datasource && delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_type == OrderListTypeProducting) {
        OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _dataArray[indexPath.row];
        
        if (indexPath.row + 1 == _dataArray.count) {
            cell.noLines = YES;
        } else {
            cell.noLines = NO;
        }
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = COLOR_VIEW_WHITE_SELECTED;
        cell.selectedBackgroundView = bgView;
        return cell;
    } else {
        OrderListHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        cell.model = _dataArray[indexPath.row];
        cell.needsArrow = YES;
        if (indexPath.row + 1 == _dataArray.count) {
            cell.noLines = YES;
        } else {
            cell.noLines = NO;
        }
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = COLOR_VIEW_WHITE_SELECTED;
        cell.selectedBackgroundView = bgView;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [UIView new];
    bgView.backgroundColor = COLOR_BACKGROUND_GRAY;
    return bgView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderDetailController *orderDetailCon = [[OrderDetailController alloc]init];
    [self.navigationController pushViewController:orderDetailCon animated:YES];
}

#pragma mark - loadData
- (void)loadData {
    if (isFirstLoad) {
        [LCHUD showProcessing:@"请稍等" target:nil];
    }
    page ++;
    OrderListModelData *data1 = [[OrderListModelData alloc] init];
    data1.order_name = @"帮忙买下早餐，谢谢啦～";
    data1.address = @"天河区华南师范大学西六楼下";
    data1.price = @"3.00";
    data1.distance = @"1.4km";
    data1.type = @"1";
    data1.limit_time = @"1501051444";
    
    OrderListModelData *data2 = [[OrderListModelData alloc] init];
    data2.order_name = @"有没有童鞋路过东区的，帮忙拿一下快递啊啊啊";
    data2.address = @"天河区华南师范大学东区10栋楼下";
    data2.price = @"1.00";
    data2.distance = @"2.7km";
    data2.type = @"4";
    data2.limit_time = @"1501021440";
    
    OrderListModelData *data3 = [[OrderListModelData alloc] init];
    data3.order_name = @"帮忙校园兼职，有酬劳！有没有勇士！";
    data3.address = @"天河区华南师范大学西二625";
    data3.price = @"120.00";
    data3.distance = @"0.9km";
    data3.type = @"5";
    data3.limit_time = @"1501058440";
    
    OrderListModelData *data4 = [[OrderListModelData alloc] init];
    data4.order_name = @"谁能帮忙带一下晚饭，雍园二楼的茄子青菜红烧鱼";
    data4.address = @"天河区华南师范大学西四214";
    data4.price = @"1.00";
    data4.distance = @"1.4km";
    data4.type = @"3";
    data4.limit_time = @"1501001111";
    
    [LCHUD hide];
    isFirstLoad = NO;
    [_dataArray addObjectsFromArray:@[data1,data2,data3,data4]];
    [_listView dataDidHandle:_dataArray.count];
    
//    [LCNetworkCenter getWithPath:@"Order.lists" parameters:@{@"c_id" : c_id, @"type" : type, @"page" : @(page) , @"page_limit" : @(pageLimit)} success:^(id responseObject) {
//        [LCHUD hide];
//        isFirstLoad = NO;
//        if (page == 1) {
//            [_dataArray removeAllObjects];
//        }
//        OrderListModel *model = [OrderListModel modelWithJSON:responseObject];
//         [_dataArray addObjectsFromArray:model.data];
//        [_listView dataDidHandle:model.data.count];
//    } failure:^(NSInteger errCode, NSString *errDescription) {
//        [LCHUD showDelayError:errDescription target:nil];
//        [_listView endRequestStatus];
//        if (errCode == NO_NETWORK_ERROR_CODE) {
//            [_listView showLoadFailedTips];
//        }
//    }];
}

- (void)refresh {
    page = 0;
    [self loadData];
}

#pragma mark - button Action
- (void)monthOrderAction {
//    MonthOrderViewController *monthOrderCon = [[MonthOrderViewController alloc]init];
//    [self.navigationController pushViewController:monthOrderCon animated:YES];
}
@end
