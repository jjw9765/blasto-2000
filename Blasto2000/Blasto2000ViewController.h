//
//  Blasto2000ViewController.h
//  Blasto2000
//
//  Created by JJ Watson on 10/10/13.
//  Copyright (c) 2013 John Watson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Blasto2000ViewController : UIViewController
- (IBAction)playGameButton:(id)sender;
- (IBAction)optionsButton:(id)sender;
@property (nonatomic, assign) int difficulty;
@end
