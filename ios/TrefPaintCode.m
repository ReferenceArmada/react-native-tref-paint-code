//
//  TrefPaintCode.m
//  TrefPaintCode
//
//  Created by The Reference Armada on 20.02.2020.
//  The Reference
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"
#import "React/RCTViewManager.h"

@interface RCT_EXTERN_MODULE(TrefPaintCode, RCTViewManager)
RCT_EXPORT_VIEW_PROPERTY(method, NSString)
RCT_EXPORT_VIEW_PROPERTY(params, NSDictionary)
@end
