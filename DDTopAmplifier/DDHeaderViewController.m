//
//  DDHeaderViewController.m
//  DDTopAmplifier
//
//  Created by Think on 2017/9/4.
//  Copyright © 2017年 Think. All rights reserved.
//

#import "DDHeaderViewController.h"
#import "UIView+Extension.h"
#import "YYWebImage.h"
#import "UIColor+Extension.h"

static NSString * const cellID = @"cell";
#define kHeaderHeight 200
@interface DDHeaderViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation DDHeaderViewController
{
    UIView *_headerView;
    UIImageView *_headerImageView;
    UIView *_lineView;
    UILabel *_titleLabel;
    UIStatusBarStyle _statusBarStyle;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
 
    [self setupTableView];
    
    [self setupHeaderView];
    
    _statusBarStyle = UIStatusBarStyleLightContent;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return _statusBarStyle;
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    tableView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
    tableView.scrollIndicatorInsets = tableView.contentInset;
    [self.view addSubview:tableView];
}

- (void)setupHeaderView
{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.dd_width, kHeaderHeight)];
    _headerView.backgroundColor = [UIColor hm_colorWithHex:0xF8F8F8];
    [self.view addSubview:_headerView];
    
    _headerImageView = [[UIImageView alloc] initWithFrame:_headerView.bounds];
    _headerImageView.backgroundColor = [UIColor hm_colorWithHex:0x000033];
    // 等比例填充
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headerImageView.clipsToBounds = YES;
    [_headerView addSubview:_headerImageView];
    
    NSURL *url = [NSURL URLWithString:@"http://bpic.588ku.com/element_origin_min_pic/17/08/14/dc6a6afe4e813168eeed6198cf64c917.jpg"];

    [_headerImageView yy_setImageWithURL:url options:YYWebImageOptionShowNetworkActivity];
    
    CGFloat lineHeight = 1 / [UIScreen mainScreen].scale;
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeaderHeight - lineHeight, _headerView.dd_width, lineHeight)];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [_headerView addSubview:_lineView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeaderHeight - 64 + (64 - 30) * 0.5 + 10, _headerView.dd_width, 30)];
    _titleLabel.textColor = [UIColor redColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text= @"Title";
    _titleLabel.hidden = YES;
    [_headerView addSubview:_titleLabel];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y + scrollView.contentInset.top;
    if (offset <= 0) {
        // 放大
        _headerView.dd_y = 0;
        _headerView.dd_height = kHeaderHeight - offset;
        _headerImageView.dd_height = _headerView.dd_height;
        _titleLabel.hidden = YES;
    }else{
        // 整体移动
        _headerView.dd_height = kHeaderHeight;
        _headerImageView.dd_height = _headerView.dd_height;
        CGFloat minY = kHeaderHeight - 64;
        _headerView.dd_y = -MIN(minY, offset);
        
        CGFloat progress = 1 - (offset/minY);
        _headerImageView.alpha = progress;
        _titleLabel.hidden = !(offset >= minY);
        
        _statusBarStyle = (progress < 0.5) ? UIStatusBarStyleDefault:UIStatusBarStyleLightContent;
    }
    _lineView.dd_y = _headerView.dd_height - _lineView.dd_height;
    
    [self.navigationController setNeedsStatusBarAppearanceUpdate];
}
@end
