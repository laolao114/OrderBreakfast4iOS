//
//  LCCustomListView.m
//
//  Created by J on 16/5/30.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import "LCCustomListView.h"

@interface LCCustomListView ()

// 列表父容器
@property (weak, nonatomic) UIView *targetView;

@property (strong, nonatomic) NSArray *refreshAnimationArr;

@end

@implementation LCCustomListView

- (instancetype)initWithFrame:(CGRect)frame toTarget:(UIView *)target {
    self = [super initWithFrame:frame];
    
    if (self) {
        _targetView = target;
        [self configData];
        [target addSubview:self];
    }
    
    return self;
}

// 初始化数据配置
- (void)configData {
    _isFirstLoad = YES;
    _isLoadAll = NO;
    _isRequesting = NO;
    _wantNoDataTipsView = NO;
    _pageLimit = 20;
    _hideHeaderTitle = NO;
    _lastDataHandleCount = 0;
    _noDataTipsViewUserInteractionEnabled = NO;
    _isOffLoadMoreFunc = NO;
    
    _listTableViewStyle = UITableViewStylePlain;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _listFlowLayout = layout;
}

// 返回 tableView
- (UITableView *)listTableView {
    if (!_listTableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:_listTableViewStyle];
        [self addSubview:tableView];
        _listTableView = tableView;
        _listTableView.rowHeight = UITableViewAutomaticDimension;
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.backgroundColor = [UIColor clearColor];
        
        [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        if (@available(iOS 11.0, *)) {
            _listTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        //默认开启上下拉刷新加载功能，可以通过 offRefreshFunc 、 offLoadMoreFunc 定制
        [self onRefreshFunc];
        [self onLoadMoreFunc];
    }
    
    return _listTableView;
}

// 返回 collectionView
- (UICollectionView *)listCollectionView {
    if (!_listCollectionView) {
        UICollectionView *collectionView  = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_listFlowLayout];
        [self addSubview:collectionView];
        _listCollectionView = collectionView;
        _listCollectionView.backgroundColor = [UIColor clearColor];
        
        [_listCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        if (@available(iOS 11.0, *)) {
            _listCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        //默认开启上下拉刷新加载功能，可以通过 offRefreshFunc 、 offLoadMoreFunc 定制
        [self onRefreshFunc];
        [self onLoadMoreFunc];
    }
    return _listCollectionView;
}

#pragma mark - 下拉刷新
// 下拉刷新时自动调用，执行回调方法
- (void)refreshAction {
    _isRefresh = YES;
    _isLoadAll = NO;
    _isRequesting = YES;
    
    if (_willRefreshBlock) {
        _willRefreshBlock(self);
    }
}

// 关闭下拉刷新功能
- (void)offRefreshFunc {
    if (_listTableView) {
        _listTableView.mj_header = nil;
    }
    
    if (_listCollectionView) {
        _listCollectionView.mj_header = nil;
    }
}

// 代码触发下拉刷新
- (void)refresh {
    [self hideLoadFailedTips];
    [self hideNoDataTips];
    
    if (_listTableView) {
        [_listTableView.mj_header beginRefreshing];
    }
    
    if (_listCollectionView) {
        [_listCollectionView.mj_header beginRefreshing];
    }
}

// 代码结束下拉刷新
- (void)endRefresh {
    if (_listTableView) {
        if (_listTableView.mj_header) {
            [_listTableView.mj_header endRefreshing];
        }
    }
    
    if (_listCollectionView) {
        if (_listCollectionView.mj_header) {
            [_listCollectionView.mj_header endRefreshing];
        }
    }
}

// 打开下拉刷新功能
- (void)onRefreshFunc {
    if (_listTableView) {
        _listTableView.mj_header = [self createRefreshGifHeaderWithTarget:self action:@selector(refreshAction)];
    }
    
    if (_listCollectionView) {
        _listCollectionView.mj_header = [self createRefreshGifHeaderWithTarget:self action:@selector(refreshAction)];
    }
}


#pragma mark - 上拉加载
// 上拉加载时自动调用，执行回调方法
- (void)loadMoreAction {
    _isRequesting = YES;
    // 上拉加载更多状态
    _isLoadMore = YES;
    
    if (_willLoadMoreBlock) {
        _willLoadMoreBlock(self);
    }
}

// 显示加载更多
- (void)showLoadMore {
    if (_listTableView) {
        _listTableView.mj_footer.hidden = NO;
    }
    
    if (_listCollectionView) {
        _listCollectionView.mj_footer.hidden = NO;
    }
}

// 隐藏加载更多
- (void)hideLoadMore {
    if (_listTableView) {
        _listTableView.mj_footer.hidden = YES;
    }
    
    if (_listCollectionView) {
        _listCollectionView.mj_footer.hidden = YES;
    }
}

// 关闭加载更多功能
- (void)offLoadMoreFunc {
    _isOffLoadMoreFunc = YES;
    
    [self hideLoadMore];
}

// 代码结束上拉加载
- (void)endLoadMore {
    if (_listTableView) {
        if (_listTableView.mj_footer) {
            [_listTableView.mj_footer endRefreshing];
        }
    }
    
    if (_listCollectionView) {
        if (_listCollectionView.mj_footer) {
            [_listCollectionView.mj_footer endRefreshing];
        }
    }
}

// 打开上拉加载更多功能
- (void)onLoadMoreFunc {
    _isOffLoadMoreFunc = NO;
    
    if (_listTableView) {
        _listTableView.mj_footer = [self createRefreshGifFooterWithTarget:self action:@selector(loadMoreAction)];
    }
    
    if (_listCollectionView) {
        _listCollectionView.mj_footer = [self createRefreshGifFooterWithTarget:self action:@selector(loadMoreAction)];
    }
}

#pragma mark - 结束加载的状态
- (void)endRequestStatus {
    [self endRefresh];
    [self endLoadMore];
}

#pragma mark - 数据外理完之后调用，隐藏上下拉刷新
- (void)dataDidHandle:(NSInteger)count {
    _lastDataHandleCount = count;
    // 请求完
    _isRequesting = NO;
    
    // 定制处理数据时的操作
    if (_dataHandleBlock) {
        _dataHandleBlock(self);
    } else {
        if (_listTableView) {
            [_listTableView reloadData];
        }
        
        if (_listCollectionView) {
            [_listCollectionView reloadData];
        }
    }
    
    [self showListSubView];
    
    // 如果数据不为空
    if (count != 0) {
        [self hideNoDataTips];
        [self hideLoadFailedTips];
    } else {
        if (_loadFailedTipsView) {
            _loadFailedTipsView.hidden = YES;
        }
        // 如果数据为空显示提示，延迟显示
        if (_wantNoDataTipsView && (_isFirstLoad || _isRefresh)) {
            [UIView animateWithDuration:0.5 animations:^{
                [self showNoDataTips];
            }];
        }
    }
    
    // 已经加载过，不是第一次加载
    _isFirstLoad = NO;
    // 下拉刷新状态
    _isRefresh = NO;
    // 上拉加载更多状态
    _isLoadMore = NO;
    
    // 隐藏上下拉刷新
    [self endRequestStatus];
    
    
    if (!_isOffLoadMoreFunc) {
        [self showLoadMore];
    }
    
    NSLog(@"//如果返回的数据比每页的数据少，表明已经不能再加载更多 - 外理 %li 条数据 - pageLimit:%li", (long)count, (long)_pageLimit);
    // 如果返回的数据比每页的数据少，表明已经不能再加载更多
    if (count < _pageLimit) {
        _isLoadAll = YES;
    } else {
        _isLoadAll = NO;
    }
    
    if (_isLoadAll) {
        [self hideLoadMore];
    }
}

#pragma mark - 根据 _lastDataHandleCount 刷新列表，防止有时刷新列表会出现底部的加载更多
- (void)reloadTableViewAndCheckLoadMore {
    if (_listTableView) {
        [_listTableView reloadData];
    }
    
    if (_listCollectionView) {
        [_listCollectionView reloadData];
    }
    
    if (_isLoadAll) {
        [self hideLoadMore];
    }
}

#pragma mark - 刷新列表
- (void)reloadListViewData {
    if (_listTableView) {
        [_listTableView reloadData];
    }
    
    if (_listCollectionView) {
        [_listCollectionView reloadData];
    }
}

#pragma mark - 显示隐藏 tableView 或 collectionView
- (void)showListSubView {
    if (_listTableView) {
        _listTableView.hidden = NO;
    }
    
    if (_listCollectionView) {
        _listCollectionView.hidden = NO;
    }
}

- (void)hideListSubView {
    if (_listTableView) {
        _listTableView.hidden = YES;
    }
    
    if (_listCollectionView) {
        _listCollectionView.hidden = YES;
    }
}

#pragma mark - 没有数据时的提示
// 显示，如果没有先创建
- (void)showNoDataTips {
    if (!_noDataTipsView) {
        LCNoDataTipsView *noDataTipsView = [LCNoDataTipsView new];
        _noDataTipsView = noDataTipsView;
        
        if (_listTableView) {
            [_listTableView addSubview:noDataTipsView];
            [_noDataTipsView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(_listTableView);
                make.width.equalTo(@(SCREEN_WIDTH));
            }];
        }
        if (_listCollectionView) {
            [_listCollectionView addSubview:noDataTipsView];
            [_noDataTipsView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(_listTableView);
                make.width.equalTo(@(SCREEN_WIDTH));
            }];
        }
//        [self addSubview:noDataTipsView];

        // 可以点击刷新列表
        if (_noDataTipsViewUserInteractionEnabled) {
            _noDataTipsView.descStr = @"没有相关数据... 点击刷新";
            
            _noDataTipsView.userInteractionEnabled = YES;
            UITapGestureRecognizer *noDataTipsViewTap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                [self refresh];
            }];
            [_noDataTipsView addGestureRecognizer:noDataTipsViewTap];
        } else {
            _noDataTipsView.descStr = @"没有相关数据...";
        }
        
        // 自定义描述文字
        if (_noDataTipsViewDescStr.length > 0) {
            _noDataTipsView.descStr = _noDataTipsViewDescStr;
        }
    }
    
    // 自定义描述文字
    if (_noDataTipsViewDescStr.length > 0) {
        _noDataTipsView.descStr = _noDataTipsViewDescStr;
    }
    
    if (_noDataTipsViewImage) {
        _noDataTipsView.image = _noDataTipsViewImage;
    }
    
    if (_willShowNoDataViewBlock) {
        _willShowNoDataViewBlock(self, _noDataTipsView);
    }
    
    _noDataTipsView.hidden = NO;
    
//    [self hideListSubView];
    
    if (_didShowNoDataViewBlock) {
        _didShowNoDataViewBlock(self, _noDataTipsView);
    }
}

// 隐藏没有数据时的提示
- (void)hideNoDataTips {
    if (_willHideNoDataViewBlock) {
        _willHideNoDataViewBlock(self, _noDataTipsView);
    }
    
    _noDataTipsView.hidden = YES;
    
    if (_didHideNoDataViewBlock) {
        _didHideNoDataViewBlock(self, _noDataTipsView);
    }
}

// 自定义暂无内容提示文案
- (void)setNoDataTipsViewDescStr:(NSString *)noDataTipsViewDescStr {
    _noDataTipsViewDescStr = noDataTipsViewDescStr;
    
//    if (_noDataTipsView) {
//        _noDataTipsView.descStr = _noDataTipsViewDescStr;
//    }
}

- (void)setNoDataTipsViewImage:(UIImage *)noDataTipsViewImage {
    _noDataTipsViewImage = noDataTipsViewImage;
    
//    if (_noDataTipsView) {
//        _noDataTipsView.image = noDataTipsViewImage;
//    }
}

#pragma mark - 加载失败提示
- (void)showLoadFailedTips {
    [self endRequestStatus];
    
    if (!_loadFailedTipsView) {
        LCLoadFailedTipsView *loadFailedTipsView = [LCLoadFailedTipsView new];
        [self addSubview:loadFailedTipsView];
        _loadFailedTipsView = loadFailedTipsView;
        _loadFailedTipsView.hidden = YES;
        [_loadFailedTipsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        _loadFailedTipsView.reloadBlock = ^() {
            [self refresh];
            
            if (_loadFailedTipsReloadBlock) {
                _loadFailedTipsReloadBlock();
            }
        };
    }
    
    // 如果已经提示加载失败 无需处理
    if (!_loadFailedTipsView.hidden) {
        return;
    }
    
    [self hideListSubView];
    if (_noDataTipsView) {
        _noDataTipsView.hidden = YES;
    }
    
    _loadFailedTipsView.hidden = NO;

    if (_showFailedTipsBlock) {
        _showFailedTipsBlock();
    }
}

- (void)hideLoadFailedTips {
    [self showListSubView];
    _loadFailedTipsView.hidden = YES;
}

#pragma mark - 生成上下拉刷新
- (__kindof MJRefreshNormalHeader *)createRefreshGifHeaderWithTarget:(id)target action:(SEL)act
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:act];
    header.lastUpdatedTimeLabel.hidden = YES;
    if (_hideHeaderTitle) {
        header.stateLabel.hidden = YES;
    } else {
        header.stateLabel.hidden = NO;
        header.labelLeftInset = 20;
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"加载中" forState:MJRefreshStateRefreshing];
        [header setTitle:@"释放刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"" forState:MJRefreshStateWillRefresh];
        header.stateLabel.font      = [UIFont systemFontOfSize:12];
        header.stateLabel.textColor = [UIColor colorWithRGB:0x999999];
    }
    
    return header;
}

- (__kindof MJRefreshAutoNormalFooter *)createRefreshGifFooterWithTarget:(id)target action:(SEL)act
{
    MJRefreshAutoNormalFooter *footer  = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:act];
    [footer setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    footer.stateLabel.font      = [UIFont systemFontOfSize:12];
    footer.stateLabel.textColor = [UIColor colorWithRGB:0x999999];
    return footer;
}

@end
