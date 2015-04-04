//  UIView+MDCShineEffect.m
//
//  Copyright (c) 2012 modocache
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//


#import "UIView+MDCShineEffect.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>


static CFTimeInterval const kMDCShineEffectDefaultDuration = 3.0;


@implementation UIView (MDCShineEffect)


#pragma mark - Public Interface

- (void)shine {
    [self shineWithRepeatCount:0];
}

- (void)shineWithRepeatCount:(float)repeatCount {
    [self shineWithRepeatCount:repeatCount
                      duration:kMDCShineEffectDefaultDuration];
}

- (void)shineWithRepeatCount:(float)repeatCount duration:(CFTimeInterval)duration {
    [self shineWithRepeatCount:repeatCount
                      duration:duration
                     maskWidth:floorf(self.frame.size.width)
                     maskHeight:floorf(self.frame.size.height)];
}

- (void)shineWithRepeatCount:(float)repeatCount
                    duration:(CFTimeInterval)duration
                   maskWidth:(CGFloat)maskWidth
                   maskHeight:(CGFloat)maskHeight{
    //CGFloat width = self.frame.size.width;
    //CGFloat height = self.frame.size.height;

    UIImage *viewImage = [self imageForView];

    CALayer *shineLayer = [CALayer layer];
    UIImage *shineImage = [self highlightedImageForImage:viewImage];
    shineLayer.contents = (id) shineImage.CGImage;
    shineLayer.frame = CGRectMake(0, 0, maskWidth*2,maskHeight);

    CALayer *mask = [CALayer layer];
    mask.backgroundColor = [UIColor clearColor].CGColor;
    UIImage *maskImage = [self maskImageForImage:viewImage width:maskWidth];
    mask.contents = (id) maskImage.CGImage;
    mask.contentsGravity = kCAGravityCenter;
    mask.frame = CGRectMake(0, 0, maskWidth, maskHeight);

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.x"];
    anim.byValue = @(maskWidth * 0);
    anim.repeatCount = repeatCount;
    anim.duration = duration;
    anim.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    [self.layer addSublayer:shineLayer];
    shineLayer.mask = mask;

    [mask addAnimation:anim forKey:@"shine"];
}


#pragma mark - Internal Methods

- (UIImage *)imageForView {
    UIGraphicsBeginImageContext(self.frame.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return viewImage;
}

- (UIImage *)highlightedImageForImage:(UIImage *)image {
    CIImage *coreImage = [CIImage imageWithCGImage:image.CGImage];
    CIImage *output = [CIFilter filterWithName:@"CIColorControls"
                                 keysAndValues:kCIInputImageKey, coreImage,
                                               @"inputBrightness", @1.0f,
                                               nil].outputImage;

    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:output fromRect:output.extent];
    UIImage *newImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);

    return newImage;
}

- (UIImage *)maskImageForImage:(UIImage *)image width:(CGFloat)maskWidth {
    CGFloat maskHeight = floorf(image.size.height);

    UIGraphicsBeginImageContext(CGSizeMake(maskWidth, maskHeight));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    id clearColor = (/*__bridge*/ id) [UIColor clearColor].CGColor;
    id blackColor = (/*__bridge*/ id) [UIColor blackColor].CGColor;
    //CGFloat locations[] = { 0.0f, 0.5f, 1.0f };
    CGFloat locations[] = { 0.0f, 0.4f, 0.5f, 0.55f, 0.6f, 0.65f, 0.7f, 0.8, 1.0f};
    NSArray *colors = @[blackColor,clearColor, blackColor, clearColor, blackColor,clearColor,blackColor,clearColor,blackColor];

    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,
                                                        (/*__bridge*/ CFArrayRef)colors,
                                                        locations);
    CGFloat midY = floorf(maskHeight/2);
//    CGPoint startPoint = CGPointMake(0, midY);
//    CGPoint endPoint = CGPointMake(floorf(maskWidth/2), midY);
//-------自定义----------------------------------------------------------------------------------------
    CGPoint startPoint = CGPointMake(0, 0);
    CGPoint endPoint = CGPointMake(floorf(maskWidth), midY*2);
//----------------------------------------------------------------------------------------------------
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CFRelease(gradient);
    CFRelease(colorSpace);

    UIImage *maskImage =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return maskImage;
}

@end
