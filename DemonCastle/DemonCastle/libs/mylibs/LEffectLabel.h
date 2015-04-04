#import <UIKit/UIKit.h>

/*
typedef enum tagEffectDirection
{
    EffectDirectionLeftToRight=0,
    EffectDirectionRightToLeft=1,
    EffectDirectionTopToBottom=2,
    EffectDirectionBottomToTop=3,
    EffectDirectionTopLeftToBottomRight=4,
    EffectDirectionBottomRightToTopLeft=5,
    EffectDirectionBottomLeftToTopRight=6,
    EffectDirectionTopRightToBottomLeft=7
}EffectDirection;
*/

@interface LEffectLabel : UIView
{
    UILabel *_effectLabel;
    CGImageRef _alphaImage;
    CALayer *_textLayer;
}


@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIColor *effectColor;
@property (strong, nonatomic) NSString *text;
//@property (assign, nonatomic) EffectDirection effectDirection;
@property (assign, nonatomic) int effectDirection;


- (void)performEffectAnimation;


@end