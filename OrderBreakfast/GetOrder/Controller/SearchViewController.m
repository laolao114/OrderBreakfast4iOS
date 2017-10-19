//
//  SearchViewController.m
//  Lihuo
//
//  Created by Dora on 2017/1/18.
//  Copyright © 2017年 Xinglian. All rights reserved.
//

#import "SearchViewController.h"
#import "LCCustomListView.h"
#import "OrderListModel.h"
#import "OrderListCell.h"

static NSString *cellID = @"cellID";

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) LCCustomListView *listTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITextField *textField;

@end

static NSString *const cellIdentifier = @"OrderListCell";

@implementation SearchViewController {
    UIView *noDataView;
    NSInteger page;
    NSInteger pageLimit;
    BOOL isFirstLoad;
    UIView *navigationView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    _dataArray = [NSMutableArray new];
    page = 0;
    pageLimit = 15;
    isFirstLoad = YES;
    [self setupView];
    [_textField becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:LCNofityListRefresh object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LCNofityListRefresh object:nil];
}

- (void)setupView {
    self.view.backgroundColor = COLOR_BACKGROUND_GRAY;
    [self createNavigationView];
    //tableview
    LCCustomListView *listTableView = [[LCCustomListView alloc]initWithFrame:CGRectZero toTarget:self.view];
    _listTableView = listTableView;
    _tableView = _listTableView.listTableView;
    _listTableView.pageLimit = pageLimit;
    _listTableView.wantNoDataTipsView = YES;
    _listTableView.willRefreshBlock = ^(LCCustomListView *listView) {
        [self refresh];
    };
    
    _listTableView.willLoadMoreBlock = ^(LCCustomListView *listView) {
        [self loadDataWith:_textField.text];
    };
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.estimatedRowHeight = 80;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[OrderListCell class] forCellReuseIdentifier:cellIdentifier];
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(navigationView.mas_bottom);
    }];
}

#pragma mark - createNavigationView 
- (void)createNavigationView {
    navigationView = [[UIView alloc] init];
    navigationView.backgroundColor = COLOR_BLUE;
    [self.view addSubview:navigationView];
    [navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@64);
    }];
    
    UIView *fieldCon = [[UIView alloc] init];
    [navigationView addSubview:fieldCon];
    navigationView.clipsToBounds = NO;
    fieldCon.layer.cornerRadius = 2.0f;
    fieldCon.layer.masksToBounds = YES;
    fieldCon.backgroundColor = [UIColor whiteColor];
    [fieldCon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.equalTo(navigationView).offset(15);
        make.bottom.equalTo(navigationView).offset(-6);
        make.right.equalTo(navigationView).offset(-60);
    }];
    UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"order_search_normal"]];
    //    iconView.backgroundColor = COLOR_TEXT_GRAY;
    [fieldCon addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fieldCon).offset(10);
        make.centerY.equalTo(fieldCon);
    }];
    [iconView setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    _textField = [[UITextField alloc] init];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [fieldCon addSubview:_textField];
    _textField.delegate = self;
    _textField.font = [UIFont systemFontOfSize:13];
    _textField.placeholder = @"搜索名称/地址／类型";
    //    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _textField.tintColor = COLOR_BLUE;
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconView.mas_right).offset(5);
        make.right.equalTo(fieldCon);
        make.top.height.equalTo(fieldCon);
    }];
    
    UIButton *cancelbutton = [[UIButton alloc]init];
    [cancelbutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
    cancelbutton.titleLabel.font = [UIFont systemFontOfSize:17];
    [navigationView addSubview:cancelbutton];
    [cancelbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(navigationView).offset(-12);
        make.centerY.equalTo(fieldCon);
    }];
}

#pragma mark - 获取数据
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    page = 0;
    [self loadDataWith:textField.text];
    return YES;
}

#pragma mark - UITabelView DataSource Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
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
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    OrderDetailController *orderDetailCon = [[OrderDetailController alloc]init];
//    OrderListOrderInfo *data = _dataArray[indexPath.row];
//    orderDetailCon.o_id = data.o_id;
//    [self.navigationController pushViewController:orderDetailCon animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [UIView new];
    bgView.backgroundColor = COLOR_BACKGROUND_GRAY;
    return bgView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (void)back {
    [_textField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - loadData
- (void)refresh {
    page = 0;
    [self loadDataWith:_textField.text];
}
- (void)loadDataWith:(NSString *)context {
    if (isFirstLoad) {
        [LCHUD showProcessing:@"请稍等" target:nil];
    }
    [self.view endEditing:YES];
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
    [_listTableView dataDidHandle:_dataArray.count];
    
//    [LCNetworkCenter getWithPath:@"Order.lists" parameters:@{@"c_id" : c_id, @"type" : @"3", @"page" : @(page) , @"page_limit" : @(pageLimit), @"condition" : context.length > 0 ? context : @""} success:^(id responseObject) {
//        [LCHUD hide];
//        isFirstLoad = NO;
//        if (page == 1) {
//            [_dataArray removeAllObjects];
//        }
//        OrderListModel *model = [OrderListModel modelWithJSON:responseObject];
//        [_dataArray addObjectsFromArray:model.data];
//        [_listTableView dataDidHandle:model.data.count];
//    } failure:^(NSInteger errCode, NSString *errDescription) {
//        [LCHUD showDelayError:errDescription target:nil];
//    }];
}

@end
