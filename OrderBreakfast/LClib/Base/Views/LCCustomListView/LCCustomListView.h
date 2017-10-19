//
//  LCCustomListView.h
//
//  自定义列表
//  集成了上下拉刷新、无数据提示等功能
//
//  Created by J on 16/5/30.
//  Copyright © 2016年 GZLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "LCNoDataTipsView.h"
#import "LCLoadFailedTipsView.h"

@class LCCustomListView;

// 将要下拉刷新
typedef void(^LCCustomListViewWillRefreshBlock)(LCCustomListView *listView);
// 将要上拉加载更多
typedef void(^LCCustomListViewWillLoadMoreBlock)(LCCustomListView *listView);
// 将要显示无数据提示
typedef void(^LCCustomListViewWillShowNoDataViewBlock)(LCCustomListView *listView, UIView *noDataTipsView);
// 显示无数据提示之后
typedef void(^LCCustomListViewDidShowNoDataViewBlock)(LCCustomListView *listView, UIView *noDataTipsView);
// 将要隐藏无数据提示
typedef void(^LCCustomListViewWillHideNoDataViewBlock)(LCCustomListView *listView, UIView *noDataTipsView);
// 隐藏无数据提示之后
typedef void(^LCCustomListViewDidHideNoDataViewBlock)(LCCustomListView *listView, UIView *noDataTipsView);
// 处理数据回调
typedef void(^LCCustomListViewDataHandleBlock)(LCCustomListView *listView);
// 加载失败提示回调
typedef void(^LCCustomListVieShowFailedTipsViewBlock)(void);
// 点击加载失败提示中的重新加载按钮后回调
typedef void(^LCCustomListViewLoadFailedTipsReloadBlock)(void);

@interface LCCustomListView : UIView

// 是否第一次加载
@property (nonatomic) BOOL isFirstLoad;
// 是否已经加载所有数据
@property (nonatomic) BOOL isLoadAll;
// 是否请求中
@property (nonatomic) BOOL isRequesting;
// 是否下拉刷新
@property (nonatomic) BOOL isRefresh;
// 是否上拉加载更多
@property (nonatomic) BOOL isLoadMore;
// 是否关闭了上拉加载更多功能
@property (nonatomic) BOOL isOffLoadMoreFunc;

// 没有数据时是否需要提示，默认不需要
@property (nonatomic) BOOL wantNoDataTipsView;
@property (nonatomic, strong) NSString *noDataTipsViewDescStr;
@property (nonatomic, strong) UIImage *noDataTipsViewImage;
@property (nonatomic) BOOL noDataTipsViewUserInteractionEnabled;

// 是否隐藏下拉加载的文字
@property (nonatomic) BOOL hideHeaderTitle;
// 每页多少条数据
@property (nonatomic) NSInteger pageLimit;
// 最后一次处理数据的条数
@property (nonatomic) NSInteger lastDataHandleCount;


// 默认 UITableViewStylePlain
@property (nonatomic) UITableViewStyle listTableViewStyle;
// UITableView，懒加载
@property (nonatomic, weak) UITableView *listTableView;
// listCollectionView 的 UICollectionViewFlowLayout
@property (nonatomic, strong) UICollectionViewFlowLayout *listFlowLayout;
// UICollectionView，懒加载
@property (nonatomic, weak) UICollectionView *listCollectionView;
// 暂无内容
@property (nonatomic, weak) LCNoDataTipsView *noDataTipsView;
// 加载失败
@property (nonatomic, weak) LCLoadFailedTipsView *loadFailedTipsView;
// 将要下拉刷新
@property (nonatomic, copy) LCCustomListViewWillRefreshBlock willRefreshBlock;
// 将要上拉加载更多
@property (nonatomic, copy) LCCustomListViewWillLoadMoreBlock willLoadMoreBlock;

// 将要显示无数据提示
@property (nonatomic, copy) LCCustomListViewWillShowNoDataViewBlock willShowNoDataViewBlock;
// 显示无数据提示之后
@property (nonatomic, copy) LCCustomListViewDidShowNoDataViewBlock didShowNoDataViewBlock;
// 将要隐藏无数据提示
@property (nonatomic, copy) LCCustomListViewWillHideNoDataViewBlock willHideNoDataViewBlock;
// 隐藏无数据提示之后
@property (nonatomic, copy) LCCustomListViewDidHideNoDataViewBlock didHideNoDataViewBlock;
// 处理数据之后
@property (nonatomic, copy) LCCustomListViewDataHandleBlock dataHandleBlock;
// 加载失败提示回调
@property (nonatomic, copy) LCCustomListVieShowFailedTipsViewBlock showFailedTipsBlock;
// 点击加载失败提示中的重新加载按钮后回调
@property (nonatomic, copy) LCCustomListViewLoadFailedTipsReloadBlock loadFailedTipsReloadBlock;

/**
 初始化
 
 @param frame 父 frame
 @param target 父 view
 */
- (instancetype)initWithFrame:(CGRect)frame toTarget:(UIView *)target;

/**
 触发下拉刷新
 */
- (void)refresh;

/**
 结束下拉刷新
 */
- (void)endRefresh;

/**
 关闭下拉刷新功能
 */
- (void)offRefreshFunc;

/**
 关闭上拉加载更多功能
 */
- (void)offLoadMoreFunc;

/**
 打开上拉加载更多功能
 */
- (void)onLoadMoreFunc;

/**
 打开下拉刷新功能
 */
- (void)onRefreshFunc;

/**
 结束加载的状态
 */
- (void)endRequestStatus;

/**
 数据外理完之后调用，隐藏上下拉刷新
 
 @param count 加载的数据数目
 */
- (void)dataDidHandle:(NSInteger)count;

/** 
 根据是否已经加载完所有数据的状态刷新列表，防止有时刷新列表会出现底部的加载更多
 */
- (void)reloadTableViewAndCheckLoadMore;

/**
 刷新列表
 */
- (void)reloadListViewData;

/**
 没有数据时的提示
 */
- (void)showNoDataTips;
 
/**
 隐藏没有数据时的提示
 */
- (void)hideNoDataTips;

/**
 显示加载失败提示
 */
- (void)showLoadFailedTips;

/**
 隐藏加载失败提示
 */
- (void)hideLoadFailedTips;

@end
