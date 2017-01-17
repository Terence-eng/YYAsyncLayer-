//
//  YYFPSLabel.h
//  YYKitExample
//
//  Created by ibireme on 15/9/3.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Show Screen FPS...
 
 The maximum fps in OSX/iOS Simulator is 60.00.
 The maximum fps on iPhone is 59.97.
 The maxmium fps on iPad is 60.0.
 */
/**
 CADisplayLink
 A CADisplayLink object is a timer object that allows your application to synchronize its drawing to the refresh rate of the display.
 CADisplayLink是一种定时器，系统的每一帧刷新时都会被调用。
 
 CADisplayLink中的timestamp是系统每次调用时的系统时间戳，通过计算两次时间戳的间隔，可以得到每一帧所花费的时间，既可以获取当前每秒能刷新多少帧。
 */
@interface YYFPSLabel : UILabel

@end
