#import <objc/message.h>
#import <objc/runtime.h>

#import "UIButton+WithObject.h"

@implementation UIButton (WithObject)

- (SEL)generateAction:(SEL)action withObject:(id)object1 withObject:(id)object2 {
    NSString* replaced = [NSStringFromSelector(action) stringByReplacingOccurrencesOfString:@":" withString:@"_"];
    NSString* name = [NSString stringWithFormat:@"%@%tu%tu:", replaced, [object1 hash], [object2 hash]];
    return NSSelectorFromString(name);
}

- (void)addTarget:(id)target action:(SEL)action withObject:(id)object forControlEvents:(UIControlEvents)controlEvents {
    SEL action_ = [self generateAction:action withObject:object withObject:nil];
    IMP impl = imp_implementationWithBlock(^(id self_) {
        ((void(*)(id, SEL, id, id))objc_msgSend)(self_, action, self, [object copy]);
    });
    class_replaceMethod([target class], action_, impl, "v@:@");
    
    [self addTarget:target action:action_ forControlEvents:controlEvents];
}

- (void)addTarget:(id)target action:(SEL)action withObject:(id)object1 withObject:(id)object2 forControlEvents:(UIControlEvents)controlEvents {
    SEL action_ = [self generateAction:action withObject:object1 withObject:object2];
    IMP impl = imp_implementationWithBlock(^(id self_) {
        ((void(*)(id, SEL, id, id, id))objc_msgSend)(self_, action, self, [object1 copy], [object2 copy]);
    });
    class_replaceMethod([target class], action_, impl, "v@:@");
    
    [self addTarget:target action:action_ forControlEvents:controlEvents];
}

- (void)removeTarget:(id)target action:(SEL)action withObject:(id)object forControlEvents:(UIControlEvents)controlEvents {
    SEL action_ = [self generateAction:action withObject:object withObject:nil];
    [self removeTarget:target action:action_ forControlEvents:controlEvents];
}

- (void)removeTarget:(id)target action:(SEL)action withObject:(id)object1 withObject:(id)object2 forControlEvents:(UIControlEvents)controlEvents {
    SEL action_ = [self generateAction:action withObject:object1 withObject:object2];
    [self removeTarget:target action:action_ forControlEvents:controlEvents];
}

- (void)removeTarget:(id)target allAction:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    NSString* replaced = [NSStringFromSelector(action) stringByReplacingOccurrencesOfString:@":" withString:@"_"];
    NSString* pattern = [NSString stringWithFormat:@"^%@\\d+:$", replaced];
    
    NSError* error = nil;
    NSRegularExpression* regexp = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (error == nil) {
        for (NSString* name in [self actionsForTarget:target forControlEvent:controlEvents]) {
            if ([regexp firstMatchInString:name options:0 range:NSMakeRange(0, [name length])] != nil) {
                [self removeTarget:target action:NSSelectorFromString(name) forControlEvents:controlEvents];
            }
        }
    }
}

@end
