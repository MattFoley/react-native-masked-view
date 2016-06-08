//
//  RNMaskedView.m
//  RNMaskedView
//

#import "RNMaskedView.h"
#import "RCTConvert.h"
#import "RCTBridge.h"
#import "RCTUIManager.h"

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@implementation RNMaskedView {
  UIImage *_maskUIImage;
}

- (id)initWithBridge:(RCTBridge *)bridge
{
  self = [super initWithFrame:CGRectZero];

  if (self) {
    _bridge = bridge;
  }

  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];

  if (self.maskImage) {
    [self applyMaskForImage];
  } else if (self.maskRefs) {
    [self applyMaskForNodes];
  }
}

- (void)applyMaskForImage
{
  CALayer *mask = [CALayer layer];
  mask.contents = (id)[_maskUIImage CGImage];
  mask.frame = self.bounds; //TODO custom: CGRectMake(left, top, width, height);
  self.layer.mask = mask;
  self.layer.masksToBounds = YES;
}

- (void)applyMaskForNodes
{
  __block CGRect refRect = CGRectZero;
  CGFloat cornerRadius = [self.maskCornerRadius floatValue] ?: refRect.size.height/20;
  UIBezierPath *maskPath = [UIBezierPath bezierPath];

  if (self.shouldUnionRefs) {
    [self.maskRefs enumerateObjectsUsingBlock:^(NSNumber *maskRef, NSUInteger idx, BOOL *stop) {
      UIView *view = [self.bridge.uiManager viewForReactTag:maskRef];
      CGRect maskRect = [self.superview convertRect:view.frame fromView:view.superview];
      if (CGRectEqualToRect(refRect, CGRectZero)) {
        refRect = maskRect;
      } else {
        refRect = CGRectUnion(refRect, maskRect);
      }
    }];

    UIBezierPath *viewPath = [UIBezierPath bezierPathWithRoundedRect:refRect
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:CGSizeMake(cornerRadius,
                                                                                cornerRadius)];
    [maskPath appendPath:viewPath];
  } else {
    [self.maskRefs enumerateObjectsUsingBlock:^(NSNumber *maskRef, NSUInteger idx, BOOL *stop) {
      UIView *view = [self.bridge.uiManager viewForReactTag:maskRef];
      CGRect maskRect = [self.superview convertRect:view.frame fromView:view.superview];
      maskRect = UIEdgeInsetsInsetRect(maskRect, self.insets);
      UIBezierPath *viewPath = [UIBezierPath bezierPathWithRoundedRect:maskRect
                                                     byRoundingCorners:UIRectCornerAllCorners
                                                           cornerRadii:CGSizeMake(cornerRadius,
                                                                                  cornerRadius)];
      [maskPath appendPath:viewPath];
    }];
  }

  [maskPath appendPath:[UIBezierPath bezierPathWithRect:self.bounds]];
  CAShapeLayer *mask = [CAShapeLayer layer];
  mask.path = maskPath.CGPath;
  mask.fillRule = kCAFillRuleEvenOdd;
  mask.fillColor = [[UIColor blackColor] colorWithAlphaComponent:1.0].CGColor;
  self.layer.mask = mask;
  self.layer.masksToBounds = YES;
}


- (void)setMaskImage:(NSString *)imageString
{
  NSString *imageName = [RCTConvert NSString:imageString];
  _maskImage = imageString;
  _maskUIImage = [UIImage imageNamed:imageName];
}

- (void)displayLayer:(CALayer *)layer
{
  //    override displayLayer because the build-in RCTView
  //    #displayLayer kills the mask
}

@end
