#import <XCTest/XCTest.h>

#import "UIButton+WithObject.h"

@interface UIButton_WithObjectTests : XCTestCase

@property (nonatomic) UIButton* button;
@property id result;

@end

@implementation UIButton_WithObjectTests

- (IBAction)call:(id)sender withObject:(id)object {
    self.result = @[sender, object];
}

- (IBAction)call:(id)sender withObject:(id)object1 withObject:(id)object2 {
    self.result = @[sender, object1, object2];
}

- (void)setUp {
    [super setUp];
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.result = nil;
}

- (void)testAddTargetActionWithObject {
    id object = @42;
    
    [self.button addTarget:self
                    action:@selector(call:withObject:)
                withObject:object
          forControlEvents:UIControlEventTouchUpInside];
    
    [self.button sendActionsForControlEvents:UIControlEventTouchUpOutside];
    XCTAssertNil(self.result);
    
    [self.button sendActionsForControlEvents:UIControlEventTouchUpInside];
    XCTAssertEqual(self.result[0], self.button);
    XCTAssertEqual(self.result[1], object);
}

- (void)testAddTargetActionWithObjectWithObject {
    id object1 = @"foo";
    id object2 = @"bar";
    
    [self.button addTarget:self
                    action:@selector(call:withObject:withObject:)
                withObject:object1
                withObject:object2
          forControlEvents:UIControlEventTouchUpInside];
    
    [self.button sendActionsForControlEvents:UIControlEventTouchUpOutside];
    XCTAssertNil(self.result);
    
    [self.button sendActionsForControlEvents:UIControlEventTouchUpInside];
    XCTAssertEqual(self.result[0], self.button);
    XCTAssertEqual(self.result[1], object1);
    XCTAssertEqual(self.result[2], object2);
}

- (void)testRemoveTargetActionWithObject {
    id object = @42;
    
    [self.button addTarget:self
                    action:@selector(call:withObject:)
                withObject:object
          forControlEvents:UIControlEventTouchUpInside];

    [self.button removeTarget:self
                       action:@selector(call:withObject:)
                   withObject:object
             forControlEvents:UIControlEventTouchUpInside];
    
    [self.button sendActionsForControlEvents:UIControlEventTouchUpInside];
    XCTAssertNil(self.result);
}

- (void)testRemoveTargetActionWithObjectWithObject {
    id object1 = @"foo";
    id object2 = @"bar";
    
    [self.button addTarget:self
                    action:@selector(call:withObject:withObject:)
                withObject:object1
                withObject:object2
          forControlEvents:UIControlEventTouchUpInside];
    
    [self.button removeTarget:self
                       action:@selector(call:withObject:withObject:)
                   withObject:object1
                   withObject:object2
             forControlEvents:UIControlEventTouchUpInside];
    
    [self.button sendActionsForControlEvents:UIControlEventTouchUpInside];
    XCTAssertNil(self.result);
}

- (void)testRemoveTargetAllAction1 {
    id object1 = @"foo";
    id object2 = @"bar";
    
    [self.button addTarget:self
                    action:@selector(call:withObject:)
                withObject:object1
          forControlEvents:UIControlEventTouchUpInside];
    [self.button addTarget:self
                    action:@selector(call:withObject:)
                withObject:object2
          forControlEvents:UIControlEventTouchUpInside];
    
    [self.button removeTarget:self allAction:@selector(call:withObject:) forControlEvents:UIControlEventTouchUpInside];

    [self.button sendActionsForControlEvents:UIControlEventTouchUpInside];
    XCTAssertNil(self.result);

}

- (void)testRemoveTargetAllAction2 {
    id object1 = @"foo";
    id object2 = @"bar";
    id object3 = @"baz";
    id object4 = @"qux";
    
    [self.button addTarget:self
                    action:@selector(call:withObject:withObject:)
                withObject:object1
                withObject:object2
          forControlEvents:UIControlEventTouchUpInside];
    [self.button addTarget:self
                    action:@selector(call:withObject:withObject:)
                withObject:object3
                withObject:object4
          forControlEvents:UIControlEventTouchUpInside];
    
    [self.button removeTarget:self allAction:@selector(call:withObject:withObject:) forControlEvents:UIControlEventTouchUpInside];

    [self.button sendActionsForControlEvents:UIControlEventTouchUpInside];
    XCTAssertNil(self.result);
}
@end
