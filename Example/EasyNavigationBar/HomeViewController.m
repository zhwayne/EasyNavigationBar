//
//  EASViewController.m
//  EasyNavigationBar
//
//  Created by iya on 11/18/2022.
//  Copyright (c) 2022 iya. All rights reserved.
//

#import "HomeViewController.h"
#import "Masonry.h"


@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;

@property (nonatomic) NSMutableArray *datas;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.datas = [NSMutableArray array];
    for (int i = 0; i < 30; ++i) {
        [self.datas addObject:@(i)];
    }
    
#ifdef USE_EAS_NAVIGATIOB_BAR
    EASBarButtonItem *leftItem = [[EASBarButtonItem alloc] initWithTitle:@"copy" action:^(EASBarButtonItem * _Nonnull item) {
        
    }];
    
    __weak typeof(self) weakSelf = self;
    EASBarButtonItem *pushItem = [[EASBarButtonItem alloc] initWithTitle:@"Push" action:^(EASBarButtonItem * _Nonnull item) {
        HomeViewController *viewController = [[HomeViewController alloc] init];
        [weakSelf.navigationController pushViewController:viewController animated:YES];
    }];
    self.ez_navigationItem.leftBarButtonItem = leftItem;
    self.ez_navigationItem.rightBarButtonItem = pushItem;
    self.ez_navigationItem.title = @"EASNavigationBar";
//    self.ez_navigationItem.titleColor = [UIColor whiteColor];
//    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.translucent = YES;
//    self.navigationBar.barTintColor = [UIColor systemTealColor];
#else
    self.navigationItem.title = @"UINavigatioBar";
    self.navigationController.navigationBar.barTintColor = [UIColor systemTealColor];
#endif
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.datas[indexPath.row]];
    cell.textLabel.textColor = UIColor.whiteColor;
    cell.contentView.backgroundColor = @[
        UIColor.orangeColor, UIColor.greenColor, UIColor.yellowColor
    ][arc4random() % 3];
    return cell;
}

@end