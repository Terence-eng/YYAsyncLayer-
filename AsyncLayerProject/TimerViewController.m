//
//  TimerViewController.m
//  AsyncLayerProject
//
//  Created by 陈伟鑫 on 2017/1/8.
//  Copyright © 2017年 陈伟鑫. All rights reserved.
//

#import "TimerViewController.h"
#import "TimerCell.h"
@interface TimerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation TimerViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]initWithObjects:@"3",@"0",@"1",@"22",@"33",@"44",@"55",@"66",@"77",@"88", nil];
    }
    return _dataSource;
}
- (void)viewDidLoad {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifity = @"cell";
    TimerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity];
    if (cell == nil) {
        cell = [[TimerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifity];
        cell.countTime = [self.dataSource[indexPath.row] intValue];
    }
    return cell;
}

- (void)dealloc {
    NSLog(@"viewController delloc");
}

@end
