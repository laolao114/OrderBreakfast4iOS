//
//  LCBaseViewController.m
//  LCModularization
//
//  Created by J on 2017/2/14.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import "LCBaseViewController.h"

@interface LCBaseViewController () <UIScrollViewDelegate>

@end

@implementation LCBaseViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_PRIMARY;
    [self createLeftNavigationItemBtnWithImgName:@"nav_back_white" highlightImgName:nil title:nil selector:@selector(back)];
    
    // 初始化界面
    [self setupBaseView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // 如果页面已经被干掉
    if (self.navigationController.viewControllers.count == 0 || ![self.navigationController.viewControllers containsObject:self]) {
//        NSLog(@"%s - 页面已经被干掉", __func__);
        self.view = nil;
        _contView = nil;
    }
}

- (void)back {
    [self backAction:YES];
}

// 关闭页面
- (void)backAction:(BOOL)animate {
    [self.view endEditing:YES];
//    NSLog(@"%s - viewControllers:%@", __func__, self.navigationController.viewControllers);
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:animate];
    } else {
        [self dismissViewControllerAnimated:animate completion:^{
            
        }];
    }
}

// 初始化界面
- (void)setupBaseView {
    if (_viewToScrollView) {
        // 滚动容器
        UIScrollView *scrollView = [UIScrollView new];
        [self.view addSubview:scrollView];
        _scrollView = scrollView;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        // 内容容器
        UIView *contView = [UIView new];
        [_scrollView addSubview:contView];
        _contView = contView;
        _contView.backgroundColor = [UIColor clearColor];
        [_contView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.width.equalTo(_scrollView);
        }];
    } else {
        _contView = self.view;
    }
}

#pragma mark - UIScrollViewDelegate
// 滚动页面时收起键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [self.view endEditing:YES];
    
}

@end
