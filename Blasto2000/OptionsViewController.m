//
//  OptionsViewController.m
//  Blasto2000
//
//  Created by JJ Watson on 10/10/13.
//  Copyright (c) 2013 John Watson. All rights reserved.
//

#import "OptionsViewController.h"
#import "Blasto2000ViewController.h"
#import "SoundBuddy2.h"

@interface OptionsViewController ()

@end

@implementation OptionsViewController {
    UIButton *_easyButton;
    UIButton *_mediumButton;
    UIButton *_hardButton;
    SoundBuddy2 *_soundBuddy;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (IBAction)backToMenuButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{NSLog(@"Go Back to Main Menu");}];
    NSLog(@"%d", _bVC.difficulty);
}


- (IBAction)easyButton:(id)sender {
    NSLog(@"Easy Selected");
    [_soundBuddy playSound:kSoundClick];
    _easyButton = (UIButton *)sender;
    [_easyButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_mediumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_hardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _bVC.difficulty = 1;
    NSLog(@"in easy %d", _bVC.difficulty);
}

- (IBAction)mediumButton:(id)sender {
    NSLog(@"Medium Selected");
    [_soundBuddy playSound:kSoundClick];
    _mediumButton = (UIButton *)sender;
    [_easyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_mediumButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_hardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _bVC.difficulty = 2;
    NSLog(@"in medium %d", _bVC.difficulty);
}

- (IBAction)hardButton:(id)sender {
    NSLog(@"Hard Selected");
    [_soundBuddy playSound:kSoundClick];
    _hardButton = (UIButton *)sender;
    [_easyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_mediumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_hardButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _bVC.difficulty = 3;
    
    NSLog(@"in hard %d", _bVC.difficulty);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _soundBuddy = [[SoundBuddy2 alloc] init];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
