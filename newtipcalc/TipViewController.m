//
//  TipViewController.m
//  newtipcalc
//
//  Created by Osvaldo Sabina on 6/5/14.
//  Copyright (c) 2014 Ozzie Sabina. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billAmountField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountField;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

@property (nonatomic) int defaultTipSelectorIndex;

- (IBAction)editDidBegin:(id)sender;
- (IBAction)editDidEnd:(id)sender;
- (IBAction)onViewTap:(id)sender;
- (IBAction)onEditBillAmount:(id)sender;

- (void)updateValues;
- (int)getSavedTipIndex;

@end

@implementation TipViewController

- (int)getSavedTipIndex {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:@"DefaultTipIndex"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calc";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tipAmountField.text = @"$0.00";
    self.totalAmountField.text = @"$0.00";
    
    self.defaultTipSelectorIndex = [self getSavedTipIndex];
    self.tipControl.selectedSegmentIndex = self.defaultTipSelectorIndex;
    [self updateValues];
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSLog(@"view will appear");
    if ([self getSavedTipIndex] != self.defaultTipSelectorIndex) {
        // Default was changed and we should update here
        self.tipControl.selectedSegmentIndex =[self getSavedTipIndex];
        self.defaultTipSelectorIndex = [self getSavedTipIndex];
    }
    [self updateValues];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view did disappear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editDidBegin:(id)sender {
}

- (IBAction)editDidEnd:(id)sender {
    float billAmount = [[self.billAmountField.text stringByReplacingOccurrencesOfString:@"$" withString:@""] floatValue];
    self.billAmountField.text = [NSString stringWithFormat: @"$%0.2f", billAmount];
}

- (IBAction)onViewTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (IBAction)onEditBillAmount:(id)sender {
    [self updateValues];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)updateValues {
    NSArray *tipValues = @[@(0.10),@(0.15),@(0.20)];

    float billAmount = [[self.billAmountField.text stringByReplacingOccurrencesOfString:@"$" withString:@""] floatValue];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = billAmount + tipAmount;
    
    self.tipAmountField.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalAmountField.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];

}

@end

