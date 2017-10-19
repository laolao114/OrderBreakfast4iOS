//
//  MyAddAddressController.m
//  HeJing
//
//  Created by old's mac on 2017/7/5.
//  Copyright © 2017年 GZLC. All rights reserved.
//

#import "MyAddAddressController.h"
#import "LCTextView.h"
#import "LCAddressPickerView.h"

@interface MyAddAddressController ()

@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) LCTextView *addressField;
@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation MyAddAddressController {
    NSString *provinceName;
    NSString *cityName;
    NSString *areaName;
}

- (instancetype)init {
    if (self = [super init]) {
        self.viewToScrollView = YES;
        [self configData];
        [self setupView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)configData {
    provinceName = @"";
    cityName = @"";
    areaName = @"";
}

- (void)setupView {
    self.navigationItem.title = @"送货地址";
    self.view.backgroundColor = COLOR_BACKGROUND_GRAY;
    [self createRightNavigationItemBtnWithImgName:nil highlightImgName:nil title:@"保存" selector:@selector(saveAction)];
    
    UIView *bgView1 = [[UIView alloc]init];
    bgView1.userInteractionEnabled = YES;
    bgView1.backgroundColor = [UIColor whiteColor];
    [self.contView addSubview:bgView1];
    [bgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contView).offset(10);
        make.left.right.equalTo(self.contView).priorityHigh();
    }];
    
    UILabel *tipLinkerLabel = [[UILabel alloc]init];
    tipLinkerLabel.font = [UIFont systemFontOfSize:15];
    tipLinkerLabel.textColor = [UIColor colorWithRGB:0x333333];
    tipLinkerLabel.text = @"收货人";
    [bgView1 addSubview:tipLinkerLabel];
    [tipLinkerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(bgView1).offset(15);
    }];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = COLOR_LINE_SEPARATE;
    [bgView1 addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView1).offset(20);
        make.right.equalTo(bgView1).offset(-20);
        make.height.equalTo(@(ONE_PX));
        make.centerY.equalTo(tipLinkerLabel.mas_bottom).offset(17);
    }];
    
    _nameField = [[UITextField alloc]init];
//    _nameField.placeholder = @"请输入联系人姓名";
    _nameField.font = [UIFont systemFontOfSize:13];
    _nameField.textColor = [UIColor colorWithRGB:0x333333];
    [bgView1 addSubview:_nameField];
    [_nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView1).offset(90);
        make.right.equalTo(bgView1).offset(-20);
        make.top.equalTo(bgView1);
        make.bottom.equalTo(line1.mas_top);
    }];
    
    UILabel *tipPhoneLabel = [[UILabel alloc]init];
    tipPhoneLabel.font = [UIFont systemFontOfSize:15];
    tipLinkerLabel.textColor = [UIColor colorWithRGB:0x333333];
    tipPhoneLabel.text = @"手机号码";
    [bgView1 addSubview:tipPhoneLabel];
    [tipPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView1).offset(15);
        make.top.equalTo(tipLinkerLabel.mas_bottom).offset(35);
    }];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = COLOR_LINE_SEPARATE;
    [bgView1 addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView1).offset(20);
        make.right.equalTo(bgView1).offset(-20);
        make.height.equalTo(@(ONE_PX));
        make.centerY.equalTo(tipPhoneLabel.mas_bottom).offset(17);
    }];
    
    _phoneField = [[UITextField alloc]init];
//    _phoneField.placeholder = @"请输入联系电话";
    _phoneField.font = [UIFont systemFontOfSize:13];
    _phoneField.textColor = [UIColor colorWithRGB:0x333333];
    [bgView1 addSubview:_phoneField];
    [_phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView1).offset(90);
        make.right.equalTo(bgView1).offset(-20);
        make.top.equalTo(line1.mas_bottom);
        make.bottom.equalTo(line2.mas_top);
    }];
    
    UIView *bgView2 = [[UIView alloc]init];
    bgView2.userInteractionEnabled = YES;
    bgView2.backgroundColor = [UIColor whiteColor];
    [bgView1 addSubview:bgView2];
    [bgView2 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [self selectAreaAction];
    }]];
    [bgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.left.right.equalTo(self.contView).priorityHigh();
        make.height.equalTo(@50);
    }];
    
    UIView *line3 = [[UIView alloc]init];
    line3.backgroundColor = COLOR_LINE_SEPARATE;
    [bgView1 addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView1).offset(20);
        make.right.equalTo(bgView1).offset(-20);
        make.height.equalTo(@(ONE_PX));
        make.top.equalTo(bgView2.mas_bottom);
    }];
    
    UILabel *tipAreaLabel = [[UILabel alloc]init];
    tipAreaLabel.font = [UIFont systemFontOfSize:15];
    tipAreaLabel.textColor = [UIColor colorWithRGB:0x333333];
    tipAreaLabel.text = @"所在区域";
    [bgView2 addSubview:tipAreaLabel];
    [tipAreaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView2).offset(15);
        make.centerY.equalTo(bgView2);
    }];
    
    UIImageView *arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_arrow_grey"]];
    [bgView2 addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView2).offset(-10);
        make.centerY.equalTo(bgView2);
    }];
    [arrow setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    _addressLabel = [[UILabel alloc]init];
    _addressLabel.font = [UIFont systemFontOfSize:15];
    _addressLabel.text = @"请选择";
    _addressLabel.textColor = [UIColor colorWithRGB:0x999999];
    [bgView2 addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView2);
        make.right.equalTo(arrow.mas_left).offset(-18);
    }];
    
    _addressField = [[LCTextView alloc]init];
    _addressField.font = [UIFont systemFontOfSize:15];
    _addressField.placeholder = @"请填写详细地址，不少于5个字";
    _addressField.scrollEnabled = NO;
    _addressField.textColor = [UIColor colorWithRGB:0x333333];
    [bgView1 addSubview:_addressField];
    [_addressField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom).offset(7);
        make.left.equalTo(bgView1).offset(10);
        make.right.equalTo(bgView1).offset(-10);
        make.height.equalTo(@90).priorityLow();
        make.bottom.equalTo(bgView1);
        make.bottom.equalTo(self.contView);
    }];
}

- (void)setData:(MyAddressListModelData *)data {
    _data = data;
    provinceName = data.province;
    cityName = data.city;
    areaName = data.area;
    _nameField.text = data.name;
    _phoneField.text = data.phone;
    _addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",data.province,data.city,data.area];
    _addressField.text = data.address;
}

- (void)selectAreaAction {
    [self.view endEditing:YES];
    
    LCAddressPickerView *pickerView = [[LCAddressPickerView alloc]init];
    pickerView.didSelectBlock = ^(NSString *province, NSString *city, NSString *area) {
        _addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
        provinceName = province;
        cityName = city;
        areaName = area;
    };
    [pickerView configViewWith:provinceName andCityName:cityName andAreaName:areaName];
    [pickerView showView];
}

- (void)saveAction {
    if (!_data) {
        _data = [MyAddressListModelData new];
    }
    _data.name = _nameField.text;
    _data.phone = _phoneField.text;
    _data.province = provinceName;
    _data.city = cityName;
    _data.area = areaName;
    _data.address = _addressField.text;
    if (self.didSaveBlock) {
        self.didSaveBlock(_data);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
