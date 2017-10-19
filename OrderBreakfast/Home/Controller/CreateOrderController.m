//
//  CreateOrderController.m
//  OrderBreakfast
//
//  Created by old's mac on 2017/7/26.
//  Copyright © 2017年 scnu. All rights reserved.
//

#import "CreateOrderController.h"
#import "LCTextView.h"
#import "CreateOrderCell.h"
#import "LCArrayPickerView.h"

@interface CreateOrderController ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *placeHolderArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) LCTextView *designTextView;               // 设计要求

@end

static NSString *const cellIdentifier = @"CreateOrderCell";
static NSString *const placeholder1 = @"请输入您的任务描述";

@implementation CreateOrderController {
    UIButton *commitButton;
    NSArray *addressArray;
    NSArray *kindArray;
    NSInteger addressIndex;
    NSInteger kindIndex;
}

- (instancetype)init {
    if (self = [super init]) {
        self.viewToScrollView = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    [self setupView];
}

- (void)configData {
    _titleArray = @[@"标题",@"价格",@"选择地址",@"请选择类型",@"请选择截止时间"];
    _placeHolderArray = @[@"请输入您的跑腿标题",@"请输入您愿意提供的价格",@"",@"",@""];
    addressArray = @[@"华南师范大学西区一栋",@"华南师范大学西区二栋",@"华南师范大学西区三栋",@"华南师范大学西区四栋",@"华南师范大学西区五栋",@"华南师范大学西区六栋"];
    kindArray = @[@"早餐",@"午餐",@"晚餐",@"快递",@"外卖",@"其他"];
    _dataArray = [NSMutableArray arrayWithArray:@[@"",@"",@"",@""]];
    addressIndex = 0;
    kindIndex = 0;
}

- (void)setupView {
    self.navigationItem.title = @"下单";
    self.view.backgroundColor = COLOR_BACKGROUND_GRAY;
    _tableView = [[UITableView alloc]init];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 50;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[CreateOrderCell class] forCellReuseIdentifier:cellIdentifier];
    [self.contView addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contView);
        make.height.equalTo(@(160 + 50));
    }];
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor = COLOR_BACKGROUND_GRAY;
    [self.contView addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contView);
        make.top.equalTo(_tableView.mas_bottom);
    }];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [footView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(footView);
        make.top.equalTo(footView).offset(10);
        make.bottom.equalTo(footView).offset(-50);
    }];
    
    UILabel *TipdesignLabel = [[UILabel alloc]init];
    TipdesignLabel.font = [UIFont systemFontOfSize:15];
    TipdesignLabel.text = @"任务描述";
    [bgView addSubview:TipdesignLabel];
    [TipdesignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(18);
        make.right.equalTo(bgView).offset(-10);
        make.top.equalTo(bgView).offset(10);
    }];
    
    _designTextView = [[LCTextView alloc]init];
    _designTextView.scrollEnabled = NO;
    _designTextView.font = [UIFont systemFontOfSize:15];
    _designTextView.backgroundColor = [UIColor whiteColor];
    _designTextView.placeholder = placeholder1;
    [bgView addSubview:_designTextView];
    [_designTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(10);
        make.right.equalTo(bgView).offset(-10);
        make.top.equalTo(TipdesignLabel.mas_bottom).offset(10);
        make.height.equalTo(@40).priorityLow();
        make.bottom.equalTo(bgView).priorityHigh();
    }];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    
    commitButton = [[UIButton alloc]init];
    [commitButton setTitle:@"提交" forState:UIControlStateAll];
    [commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    [commitButton setBackgroundImage:[UIImage imageWithColor:COLOR_BLUE] forState:UIControlStateNormal];
    [commitButton setBackgroundImage:[UIImage imageWithColor:COLOR_BLUE_HIGHLIGHTED] forState:UIControlStateHighlighted];
    [commitButton setBackgroundImage:[UIImage imageWithColor:COLOR_BLUE_DISABLED] forState:UIControlStateDisabled];
    commitButton.enabled = NO;
    [bottomView addSubview:commitButton];
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(bottomView);
    }];
}

#pragma mark - tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 1) {
        CreateOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.needsArrow = NO;
        cell.textFieldCanEdit = YES;
        cell.tag = 1000 + indexPath.row;
        [cell.textField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
        [cell configCellWithTitle:_titleArray[indexPath.row] content:_dataArray[indexPath.row]];
        cell.textField.placeholder = _placeHolderArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        CreateOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.needsArrow = YES;
        cell.textFieldCanEdit = NO;
        if (indexPath.row == 3) {
            cell.noLines = YES;
        } else {
            cell.noLines = NO;
        }
        [cell configCellWithTitle:_titleArray[indexPath.row] content:_dataArray[indexPath.row]];
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = COLOR_VIEW_WHITE_SELECTED;
        cell.selectedBackgroundView = bgView;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        LCArrayPickerView *pickView = [[LCArrayPickerView alloc] initWithArray:addressArray];
        pickView.selectedIndex = addressIndex;
        pickView.didSelectPayBlock = ^(NSString *selectString, NSInteger index) {
            addressIndex = index;
            [_dataArray replaceObjectAtIndex:2 withObject:selectString];
            [tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
        };
        [pickView showView];
    } else if (indexPath.row == 3) {
        LCArrayPickerView *pickView = [[LCArrayPickerView alloc] initWithArray:kindArray];
        pickView.selectedIndex = kindIndex;
        pickView.didSelectPayBlock = ^(NSString *selectString, NSInteger index) {
            kindIndex = index;
            [_dataArray replaceObjectAtIndex:3 withObject:selectString];
            [tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
        };
        [pickView showView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - button Action
- (void)textDidChange:(UITextField *)textField {
    [self judgeButtonisEnable];
}

- (void)judgeButtonisEnable {
    
}

- (void)commitAction {
    
}

@end
