#import <UIKit/UIKit.h>

@interface UIButton (WithObject)

- (void)addTarget:(id)target action:(SEL)action withObject:(id)object forControlEvents:(UIControlEvents)controlEvents;

- (void)addTarget:(id)target action:(SEL)action withObject:(id)object1 withObject:(id)object2 forControlEvents:(UIControlEvents)controlEvents;

- (void)removeTarget:(id)target action:(SEL)action withObject:(id)object forControlEvents:(UIControlEvents)controlEvents;

- (void)removeTarget:(id)target action:(SEL)action  withObject:(id)object1 withObject:(id)object2 forControlEvents:(UIControlEvents)controlEvents;

- (void)removeTarget:(id)target allAction:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
