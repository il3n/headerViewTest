//
//  ViewController.m
//  HeaderViewTest
//
//  Created by lee on 16/8/20.
//  Copyright © 2016年 jeelun. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Blur.h"

const CGFloat kTopInset = 280;
const CGFloat kNavigationBarHeight = 64;

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UIImageView *blurImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(kTopInset, 0, 0, 0);
 
    [self.tableView addSubview:self.headerView];
    self.headerView.frame = CGRectMake(0, -kTopInset, self.view.bounds.size.width, kTopInset);
    
    [self.tableView addSubview:self.blurImageView];
    self.blurImageView.frame = self.headerView.frame;
    
    
    self.tableView.contentOffset = CGPointMake(0,  -kTopInset);
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    
    // alpha
    CGFloat alpha = 0;
    
    if (point.y <= -kTopInset) { // 下拉放大
        
        CGRect rect = self.headerView.frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        self.blurImageView.frame = rect;
        
        
        
    } else if (point.y > -kTopInset && point.y <= -kNavigationBarHeight) {  // 跟随上滑
        
        alpha = 1-(fabs(point.y)-kNavigationBarHeight)/(kTopInset-kNavigationBarHeight);
        
    } else {    // 头图置顶
        
        CGRect rect = self.blurImageView.frame;
        rect.origin.y = point.y-(kTopInset-kNavigationBarHeight);
        self.blurImageView.frame = rect;
        
        alpha = 1;
    }
    
    self.blurImageView.alpha = alpha;
    self.headerView.frame = self.blurImageView.frame;
    
    NSLog(@"blurImageView.frame:%@, point.y:%@, alpha:%@", NSStringFromCGRect(self.blurImageView.frame), @(point.y), @(alpha));

}


-(void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

#pragma mark-getter

-(UIImageView *) blurImageView {
    if (!_blurImageView) {
        _blurImageView = [[UIImageView alloc] init];
        _blurImageView.contentMode = UIViewContentModeScaleAspectFill;
        UIImage *image = [UIImage imageNamed:@"headerimage"];
        _blurImageView.image = [UIImage blurImage:image withBlurNumber:0.8];
    }
    return _blurImageView;
}

-(UIImageView *) headerView {
    if (!_headerView) {
        _headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headerimage"]];
        _headerView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headerView;
}

-(UITableView *) tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
