//
//  OrderMainController.m
//  chubankuai
//
//  Created by old's mac on 2017/4/8.
//  Copyright © 2017年 gzlc. All rights reserved.
//

#import "OrderMainController.h"
#import "OrderListViewController.h"
#import "WMPageController.h"
#import "SearchViewController.h"

@interface OrderMainController ()<WMPageControllerDelegate, WMPageControllerDataSource>

@property (nonatomic, strong) WMPageController *pageController;
@property (nonatomic, strong) NSArray *menuArr;

@end

@implementation OrderMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    _menuArr = @[@"我要跑腿",@"我要帮忙"];
    [self setupView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh) name:LCNofityListRefresh object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)setupView {
    self.navigationItem.title = @"接单";
    self.view.backgroundColor = COLOR_BACKGROUND_GRAY;
    [self createRightNavigationItemBtnWithImgName:@"nav_icon_search_normal" highlightImgName:nil title:nil selector:@selector(searchAction)];
    _pageController = [[WMPageController alloc]init];
    _pageController.delegate = self;
    _pageController.dataSource = self;
    _pageController.menuHeight         = 40.0;
    _pageController.menuBGColor        = [UIColor whiteColor];
    _pageController.menuViewStyle      = WMMenuViewStyleLine;
    _pageController.menuViewLayoutMode = WMMenuViewLayoutModeScatter;
    _pageController.menuItemWidth      = 105;
    _pageController.progressHeight     = 2;
    _pageController.titleSizeNormal    = 16;
    _pageController.titleSizeSelected  = 16;
    _pageController.titleColorNormal   = UIColorHex(0x565656);
    _pageController.titleColorSelected = COLOR_BLUE;
    _pageController.view.backgroundColor = [UIColor clearColor];
    [self addChildViewController:_pageController];
    [self.view addSubview:_pageController.view];
    [_pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    _pageController.viewFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 48 - 64);
}

#pragma mark - WMPageControllerDataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return _menuArr.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    OrderListViewController *futureListCon = [OrderListViewController new];
    if (index == 0) {
        futureListCon.type = OrderListTypeProducting;
    } else {
        futureListCon.type = OrderListTypeHistory;
    }
    return futureListCon;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return _menuArr[index];
}

#pragma mark - button action
- (void)searchAction {
    SearchViewController *searchCon = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:searchCon animated:YES];
}

- (void)refresh {
    OrderListViewController *futureListCon = (OrderListViewController *)_pageController.currentViewController;
    [futureListCon refresh];
}

@end
