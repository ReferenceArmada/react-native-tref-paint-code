//
//  DrawerEngine.m
//  TrefPaintCode
//
//  Created by The Reference Armada on 20.02.2020.
//  The Reference
//

#import <Foundation/Foundation.h>
#import "DrawerEngine.h"
#import <objc/runtime.h>
#import "TrefPaintCode-Swift.h"

@implementation DrawerEngine

- (void)run: (CGRect)frame
     method: (NSString *)method
     params: (NSDictionary *)params {
    
    SEL selector = NSSelectorFromString(method);
    
    Class clazz = [BundleUtil getPaintCodeClass];
    Method clazzMethod = class_getClassMethod(clazz, selector);
    unsigned int numberOfArgs = method_getNumberOfArguments(clazzMethod) - 2;
    
    NSArray *argNames = [method componentsSeparatedByString: @":"];
    
    // NSInvocation start
    
    @try {
        NSMethodSignature* methodSignature = [clazz methodSignatureForSelector:selector];
        NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        
        [invocation setTarget:clazz];
        [invocation setSelector:selector];
        
        // Set frame as first argument, always
        [invocation setArgument:&frame atIndex:2];
        
        for (int i = 0; i < numberOfArgs - 1; i++) {
            
            NSString *argName = argNames[i + 1];
            NSString *argType = [[params objectForKey:argName] objectForKey:@"type"];
            
            id argValue = [[params objectForKey:argName] objectForKey:@"value"];
            if ([argType isEqualToString:@"float"]) {
                CGFloat floatValue = [argValue floatValue];
                [invocation setArgument:&floatValue atIndex:i + 3];
            } else if([argType isEqualToString:@"double"]) {
                double doubleValue = [argValue doubleValue];
                [invocation setArgument:&doubleValue atIndex:i + 3];
            } else if([argType isEqualToString:@"string"]) {
                NSString *stringValue = argValue;
                [invocation setArgument:&stringValue atIndex:i + 3];
            } else if([argType isEqualToString:@"resizingBehaviour"]) {
                NSInteger behavior;
                if([argValue isEqualToString:@"aspectFit"]) {
                    behavior = 0;
                } else if([argValue isEqualToString:@"aspectFill"]) {
                    behavior = 1;
                } else if([argValue isEqualToString:@"stretch"]) {
                    behavior = 2;
                } else {
                    behavior = 3;
                }
                [invocation setArgument:&behavior atIndex:i + 3];
            } else if([argType isEqualToString:@"boolean"]) {
                BOOL boolValue = [argValue boolValue];
                [invocation setArgument:&boolValue atIndex:i + 3];
            } else if([argType isEqualToString:@"integer"]) {
                int intValue = [argValue intValue];
                [invocation setArgument:&intValue atIndex:i + 3];
            } else {
                NSLog(@"Unknown parameter type. Parameter types should be used from TrefPaintCodeType. arg name: %@, arg type: %@", argName, argType);
            }
        }
        
        [invocation invoke];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    }
}
@end
