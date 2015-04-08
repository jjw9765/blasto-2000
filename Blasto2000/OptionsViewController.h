//
//  OptionsViewController.h
//  Blasto2000
//
//  Created by JJ Watson on 10/10/13.
//  Copyright (c) 2013 John Watson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Blasto2000ViewController.h"

@interface OptionsViewController : UIViewController
- (IBAction)backToMenuButton:(id)sender;
- (IBAction)easyButton:(id)sender;
- (IBAction)mediumButton:(id)sender;
- (IBAction)hardButton:(id)sender;
@property (weak, nonatomic) Blasto2000ViewController *bVC;
@end
