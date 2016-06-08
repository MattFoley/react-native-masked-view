//
//  RNMaskedView.h
//  RNMaskedView
//

#import <UIKit/UIKit.h>
#import "RCTView.h"
#import "RCTBridge.h"

@interface RNMaskedView : RCTView

- (id)initWithBridge:(RCTBridge *)bridge;

@property (nonatomic, weak) RCTBridge *bridge;

@property (nonatomic, strong) NSString *maskImage;
@property (nonatomic, strong) NSArray *maskRefs;
@property (nonatomic, strong) NSNumber *shouldUnionRefs;
@property (nonatomic, strong) NSNumber *maskCornerRadius;
@property (nonatomic, assign) UIEdgeInsets insets;

@end
