//
//  PlayGameViewController.h
//  Blasto2000
//
//  Created by JJ Watson on 10/10/13.
//  Copyright (c) 2013 John Watson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShipController.h"
#import "Asteroid.h"

@interface PlayGameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *guy;
@property (weak, nonatomic) IBOutlet UIImageView *asteroid1;
@property (weak, nonatomic) IBOutlet UIImageView *asteroid2;
@property (weak, nonatomic) IBOutlet UIImageView *asteroid3;
@property (weak, nonatomic) IBOutlet UIImageView *asteroid4;
@property (weak, nonatomic) IBOutlet UIImageView *asteroid5;
@property (weak, nonatomic) IBOutlet UIImageView *asteroid6;
@property (weak, nonatomic) IBOutlet UIImageView *asteroid7;
@property (weak, nonatomic) IBOutlet UIImageView *asteroid8;
@property (weak, nonatomic) IBOutlet UIImageView *asteroid9;
@property (weak, nonatomic) IBOutlet UIImageView *asteroid10;
@property (weak, nonatomic) IBOutlet UIImageView *satellite1;
@property (weak, nonatomic) IBOutlet UIImageView *satellite2;
@property (weak, nonatomic) IBOutlet UIImageView *satellite3;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (nonatomic, assign) int difficulty;
@property (strong, nonatomic) ShipController *ship;
@property (strong, nonatomic) Asteroid *asteroids;
@end
