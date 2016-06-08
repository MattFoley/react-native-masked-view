//
//  RNMaskedViewManager.m
//  RNMaskedView
//

#import "RNMaskedViewManager.h"
#import "RNMaskedView.h"
#import "RCTBridge.h"

#import <UIKit/UIKit.h>

#import <RCTConvert.h>

@implementation RNMaskedViewManager

RCT_EXPORT_MODULE();

- (UIView *)view
{
  return [[RNMaskedView alloc] initWithBridge:self.bridge];
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_VIEW_PROPERTY(maskImage, NSString);
RCT_EXPORT_VIEW_PROPERTY(shouldUnionRefs, NSNumber);
RCT_EXPORT_VIEW_PROPERTY(maskCornerRadius, NSNumber);
RCT_EXPORT_VIEW_PROPERTY(insets, UIEdgeInsets);
RCT_EXPORT_VIEW_PROPERTY(maskRefs, NSArray);


@end
