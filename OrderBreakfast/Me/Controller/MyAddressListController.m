//
//  MyAddressListController.m
//  HeJing
//
//  Created by old's mac on 2017/7/5.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import "MyAddressListController.h"
#import "MyAddressListCell.h"
#import "MyAddAddressController.h"

@interface MyAddressListController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) LCCustomListView *listView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic) BOOL firstLoad;

@end

static NSString *const cellIdentifier = @"MyAddressListCell";

@implementation MyAddressListController {
    NSInteger _page;
    NSInteger _pageLimit;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 0;
    _pageLimit = 20;
    _selectedIndex = -1;
    _dataArray = [NSMutableArray array];
    _firstLoad = YES;
    [self setupView];
    [self loadData];
}

- (void)setupView {
    self.navigationItem.title = @"送货地址";
    self.view.backgroundColor = COLOR_BACKGROUND_GRAY;
    LCCustomListView *listView = [[LCCustomListView alloc] initWithFrame:CGRectZero toTarget:self.view];
    _listView = listView;
    _listView.wantNoDataTipsView = YES;
    _tableView = _listView.listTableView;
    _tableView.separatorStyle = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 100;
    _listView.willLoadMoreBlock = ^(LCCustomListView *listView) {
        [self loadData];
    };
    _listView.willRefreshBlock = ^(LCCustomListView *listView) {
        _page = 0;
        [self loadData];
    };
    [_tableView registerClass:[MyAddressListCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:_listView];
    [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIButton *addButton = [[UIButton alloc] init];
    addButton.backgroundColor = COLOR_BLUE;
    addButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [addButton setTitle:@"添加地址" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButton setImage:[UIImage imageNamed:@"iocn_add_click"] forState:UIControlStateNormal];
    [addButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    [addButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    [addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@50);
    }];
}

#pragma mark - tableView delegate && datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return _dataArray.count;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyAddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    BOOL isSelected = _selectedIndex == indexPath.section;
    [cell configCellWith:_dataArray[indexPath.row] andIsSelected:isSelected];
    if (indexPath.row + 1 == _dataArray.count) {
        cell.noLine = YES;
    } else {
        cell.noLine = NO;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.didEditBlock = ^{
        MyAddAddressController *addController = [[MyAddAddressController alloc] init];
        addController.data = _dataArray[indexPath.row];
        addController.didSaveBlock = ^(MyAddressListModelData *newData) {
            [_dataArray replaceObjectAtIndex:indexPath.row withObject:newData];
            [tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:addController animated:YES];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSInteger lastIndex = _selectedIndex;
//    _selectedIndex = indexPath.section;
//    if (lastIndex >= 0) {
//        [tableView reloadRow:0 inSection:lastIndex withRowAnimation:UITableViewRowAnimationNone];
//    }
//    [tableView reloadRow:0 inSection:_selectedIndex withRowAnimation:UITableViewRowAnimationNone];
//    if (self.MyDidSelectAddressBlock) {
//        self.MyDidSelectAddressBlock(_dataArray[indexPath.section], _selectedIndex);
//    }
//    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor clearColor];
    return bgView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.01f : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

#pragma mark - button action
- (void)addAction {
    MyAddAddressController *addController = [[MyAddAddressController alloc]init];
    addController.didSaveBlock = ^(MyAddressListModelData *newData) {
        [_dataArray addObject:newData];
        [_tableView reloadData];
    };
    [self.navigationController pushViewController:addController animated:YES];
}

#pragma mark - loadData
- (void)loadData {
    if (_firstLoad) {
        [LCHUD showProcessing:@"加载中" target:nil];
    }
    _page ++;
    [LCHUD hide];
    MyAddressListModel *model = [[MyAddressListModel alloc]init];
    for (int i = 0; i < 5; i ++) {
        MyAddressListModelData *data = [[MyAddressListModelData alloc]init];
        data.province = @"广东省";
        data.city = @"广州市";
        data.area = @"天河区";
        data.name = @"郑焕泳";
        data.phone = @"15603005773";
        data.address = @"潭村路348号马赛国际商务中心511室";
        [_dataArray addObject:data];
    }
    model.data = _dataArray;
    [_listView dataDidHandle:model.data.count];
//    [LCNetworkCenter getWithPath:@"<# path #>" parameters:@{@"page": @(_page), @"page_limit":@(_pageLimit)} success:^(id responseObject) {
//        [LCHUD hide];
//        _firstLoad = NO;
//        [LCHUD hide];
//        MyAddressListModel *model = [MyAddressListModel modelWithJSON:responseObject];
//        if (_page == 1) {
//            [_dataArray removeAllObjects];
//        }
//        [_dataArray addObjectsFromArray:model.data];
//        [_listView dataDidHandle:model.data.count];
//    } failure:^(NSInteger errCode, NSString *errDescription) {
//        _firstLoad = NO;
//        [LCHUD showDelayError:errDescription target:nil];
//        [_listView endRequestStatus];
//        if (errCode == NO_NETWORK_ERROR_CODE) {
//            [_listView showLoadFailedTips];
//        }
//    }];
}

@end
