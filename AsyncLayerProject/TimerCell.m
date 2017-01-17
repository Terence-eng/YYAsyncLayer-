//
//  TimerCell.m
//  AsyncLayerProject
//
//  Created by 陈伟鑫 on 2017/1/8.
//  Copyright © 2017年 陈伟鑫. All rights reserved.
//

#import "TimerCell.h"

@interface TimerCell ()

@property (nonatomic, strong) NSTimer *currenTimer;

//@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation TimerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.currenTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(currentimeAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.currenTimer forMode:NSRunLoopCommonModes];
    }
    return self;
}


- (void)currentimeAction {
    ++ self.countTime;
    self.textLabel.text = [NSString stringWithFormat:@"%d",self.countTime];
}


- (void)dealloc {
    if (self.currenTimer.isValid) {
        [self.currenTimer invalidate];
    }
    
    NSLog(@"cell delloc");
}
@end
