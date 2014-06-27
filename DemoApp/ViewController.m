#import "ViewController.h"

#import "UIButton+WithObject.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton* foo = [UIButton buttonWithType:UIButtonTypeSystem];
    [foo setTitle:@"foo" forState:UIControlStateNormal];
    [foo setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [foo setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:foo];
    
    UIButton* bar = [UIButton buttonWithType:UIButtonTypeSystem];
    [bar setTitle:@"bar" forState:UIControlStateNormal];
    [bar setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [bar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:bar];
    
    NSDictionary* views = NSDictionaryOfVariableBindings(foo, bar);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[foo]-[bar(foo)]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[foo]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[bar]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                        views:views]];
    
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
