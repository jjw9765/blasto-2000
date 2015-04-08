//
//  Blasto2000ViewController.m
//  Blasto2000
//
//  Created by JJ Watson on 10/10/13.
//  Copyright (c) 2013 John Watson. All rights reserved.
//

#import "Blasto2000ViewController.h"
#import "PlayGameViewController.h"
#import "OptionsViewController.h"
#import "SoundBuddy2.h"

@interface Blasto2000ViewController ()

@end

@implementation Blasto2000ViewController {
    PlayGameViewController *_playGameVC;
    OptionsViewController *_optionsVC;
    SoundBuddy2 *_soundBuddy;
}



- (IBAction)playGameButton:(id)sender {
    
    [_soundBuddy playSound:kSoundClick];
    
    UIStoryboard *storyboard = self.storyboard;
    if(! _playGameVC){
        // you need to set the StoryBoard ID under Identifier in the storyboard file
        _playGameVC = [storyboard instantiateViewControllerWithIdentifier:@"pgVC"];
    }
    
    _playGameVC.difficulty = self.difficulty;
    
    // Configure the new view controller here.
    // the transitions can also be done in Interface Builder
    _playGameVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:_playGameVC animated:YES completion:nil];
}


- (IBAction)optionsButton:(id)sender {
    
    [_soundBuddy playSound:kSoundClick];
    
    UIStoryboard *storyboard = self.storyboard;
    if(! _optionsVC){
        // you need to set the StoryBoard ID under Identifier in the storyboard file
        _optionsVC = [storyboard instantiateViewControllerWithIdentifier:@"opVC"];
    }
    
    _optionsVC.bVC = self;
    
    
    // Configure the new view controller here.
    // the transitions can also be done in Interface Builder
    _optionsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:_optionsVC animated:YES completion:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _soundBuddy = [[SoundBuddy2 alloc] init];
    [_soundBuddy playSound:kSoundMusic];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
