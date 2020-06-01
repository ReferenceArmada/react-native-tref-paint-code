//
//  DrawerEngine.h
//  TrefPaintCode
//
//  Created by The Reference Armada on 20.02.2020.
//  The Reference
//

#ifndef DrawerEngine_h
#define DrawerEngine_h
#import <UIKit/UIKit.h>

@interface DrawerEngine : NSObject
- (void)run:(CGRect)frame
     method:(NSString *)method
     params:(NSDictionary *)params;

@end
#endif /* DrawerEngine_h */
