//
//  SettingsViewController.m
//  newtipcalc
//
//  Created by Osvaldo Sabina on 6/5/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;

- (IBAction)onControlChange:(id)sender;
- (int)getDefaultTipIndex;
- (void)saveDefaultTipIndex:(int)tipIndex;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title = @"Settings";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    // Load default
    self.defaultTipControl.selectedSegmentIndex = [self getDefaultTipIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onControlChange:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: self.defaultTipControl.selectedSegmentIndex forKey:@"DefaultTipIndex"];
    [defaults synchronize];
    
    [self saveDefaultTipIndex: self.defaultTipControl.selectedSegmentIndex];
}

- (int)getDefaultTipIndex; {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:@"DefaultTipIndex"];
}

- (void)saveDefaultTipIndex:(int)tipIndex {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: tipIndex forKey:@"DefaultTipIndex"];
    [defaults synchronize];
}
@end
