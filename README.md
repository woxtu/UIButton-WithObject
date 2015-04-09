# UIButton+WithObject

[![CocoaPods](https://img.shields.io/cocoapods/v/UIButton+WithObject.svg?style=flat-square)](https://cocoapods.org/pods/UIButton+WithObject)

A category on UIButton that extends for adding target.

## Usage

```objectivec
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton* foo = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:foo];
    
    UIButton* bar = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:bar];
    
    // Add a target and action with an object
    [foo addTarget:self
            action:@selector(call:withMessage:)
        withObject:@"foo!"
  forControlEvents:UIControlEventTouchUpInside];
    
    [bar addTarget:self
            action:@selector(call:withMessage:)
        withObject:@"bar!"
  forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)call:(id)sender withMessage:(NSString*)message {
    // Display an object passed
    NSLog(@"%@", message);
}

@end
```

## Install

Use CocoaPods.

```ruby
pod 'UIButton+WithObject'
```

## License
Copyright (c) 2014 woxtu

Licensed under the MIT license.
