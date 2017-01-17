//
//  NormalTableViewController.m
//  AsyncLayerProject
//
//  Created by 陈伟鑫 on 2016/12/30.
//  Copyright © 2016年 陈伟鑫. All rights reserved.
//

#import "NormalTableViewController.h"
#import "YYFPSLabel.h"
@interface NormalTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) YYFPSLabel *fpslabel;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NormalTableViewController
- (YYFPSLabel *)fpslabel {
    if (!_fpslabel) {
        _fpslabel = [YYFPSLabel new];
        _fpslabel.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height - 50 - 64, 0, 0);
        [_fpslabel sizeToFit];
        
    }
    return _fpslabel;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.fpslabel];
    self.tableView.rowHeight = 50;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0 ; i < 100;  i ++) {
            NSString *string = [NSString stringWithFormat:@"%ld http://www.baidu.com ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 [微笑] ✺◟(∗❛ัᴗ❛ั)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫",(long)i];
            [array addObject:string];
        }
        [self.dataSource addObjectsFromArray:array];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifity = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifity];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


@end
