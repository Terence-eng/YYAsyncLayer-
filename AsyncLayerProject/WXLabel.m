//
//  WXLabel.m
//  AsyncLayerProject
//
//  Created by 陈伟鑫 on 2016/12/28.
//  Copyright © 2016年 陈伟鑫. All rights reserved.
//

#import "WXLabel.h"
#import "YYAsyncLayer.h"
#import <CoreText/CoreText.h>
@interface WXLabel ()<YYAsyncLayerDelegate>
{
    NSString *_text;
    UIFont *_font;
}

@end
@implementation WXLabel

- (void)setText:(NSString *)text {
    _text = text;
    [[YYTransaction transactionWithTarget:self selector:@selector(contentsNeedUpdated)] commit];

}
- (void)setFont:(UIFont *)font {
    _font = font;
    [[YYTransaction transactionWithTarget:self selector:@selector(contentsNeedUpdated)] commit];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    [[YYTransaction transactionWithTarget:self selector:@selector(contentsNeedUpdated)] commit];
}

- (void)contentsNeedUpdated {
    // do update
    [self.layer setNeedsDisplay];
}

#pragma mark -- YYAsyncLayer

+ (Class)layerClass {
    return YYAsyncLayer.class;
}

- (YYAsyncLayerDisplayTask *)newAsyncDisplayTask {
    NSString *text = _text;
    YYAsyncLayerDisplayTask *task = [YYAsyncLayerDisplayTask new];
    task.willDisplay = ^(CALayer *layer) {
        layer.contentsScale = 2;
    };
    
    __weak typeof(&*self)weakself = self;
    task.display = ^(CGContextRef context, CGSize size, BOOL(^isCancelled)(void)) {
        if (isCancelled()) return;
        if (!text.length) return;
        [weakself drawInContext:context withSize:size];
    };
    task.didDisplay = ^(CALayer * _Nonnull layer, BOOL isFinish) {
    };
    return task;
}
- (void)drawInContext:(CGContextRef)context withSize:(CGSize)size {
    //设置context的ctm，用于适应core text的坐标体系
    CGContextSaveGState(context);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, size.width, size.height));
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:_text];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, _text.length)];
    
    CTFramesetterRef ctFramesetting = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attri);
    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFramesetting, CFRangeMake(0, attri.length), path, NULL);
    //6.在CTFrame中绘制文本关联上下文
    CTFrameDraw(ctFrame, context);
    //7.释放变量
    CFRelease(path);
    CFRelease(ctFramesetting);
    CFRelease(ctFrame);

}
@end
