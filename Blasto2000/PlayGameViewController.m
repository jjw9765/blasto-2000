//
//  PlayGameViewController.m
//  Blasto2000
//
//  Created by JJ Watson on 10/10/13.
//  Copyright (c) 2013 John Watson. All rights reserved.
//

#import "PlayGameViewController.h"
#import "Blasto2000ViewController.h"
#import "Asteroid.h"
#import "Satellite.h"
#import "SoundBuddy2.h"
#import "ShipController.h"
#import <CoreMotion/CoreMotion.h>
#import <QuartzCore/QuartzCore.h>

@interface PlayGameViewController ()

@end

@implementation PlayGameViewController{
    
    //Timer
    CADisplayLink *_timer;
    
    SoundBuddy2 *_soundBuddy;
    
    Blasto2000ViewController *_mainVC;
    
    //private ivars for low budget vector movement
    float _dx;
    float _dy;
    float _speed;
    
    //Accelarometer
    CMMotionManager *_motionManager;
    NSOperationQueue *_queue;
    
    ShipController *_ship;
    
    //10 Asteroids
    Asteroid *_a1, *_a2, *_a3, *_a4, *_a5, *_a6, *_a7, *_a8, *_a9, *_a10;
    
    //3 Satellites
    Satellite *_s1, *_s2, *_s3;
  
    
    //ivar for display method
    UIAlertView *_alert;
    
    //Array of Asteroids
    NSMutableArray *_asteroidsArray;
    
    //Array for Satellites
    NSMutableArray *_satellitesArray;
    
    //If get hit by Satelitte, need to dodge 5 asteroids before touching can work again
    BOOL *_satDown;
    int *_dodges;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _motionManager = [[CMMotionManager alloc]init];
    
    _soundBuddy = [[SoundBuddy2 alloc] init];
    
    _speed = 10;
    
    _dodges = 0;
    
    _satDown = NO;
    
    if(_motionManager.isDeviceMotionAvailable) {
        _motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
        
        NSLog(@"Accelerometer available");
        _queue = [NSOperationQueue currentQueue];
        [_motionManager startAccelerometerUpdatesToQueue:_queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            CMAcceleration accel = accelerometerData.acceleration;
            
           // NSLog(@"X: %f, Y: %f, Z: %f", accel.x, accel.y, accel.z);
            
            if(accel.x > 0.10 || accel.x < -0.10){
            _dx = accel.x;
            }
            
            if(accel.x > -0.10 && accel.x < 0.10){
                _dx = 0;
            }
            
            //Keep Ship on Screen
            if(self.guy.center.x > self.view.bounds.size.width + 15 && accel.x > 0.10){
                [self.guy setFrame:CGRectMake(-40, 425, self.guy.frame.size.width, self.guy.frame.size.height)];
                [_soundBuddy playSound:kSoundSwoosh];
            }
            
            if(self.guy.center.x < -20 && accel.x < -0.10){
                [self.guy setFrame:CGRectMake(self.view.bounds.size.width, 425, self.guy.frame.size.width, self.guy.frame.size.height)];
                [_soundBuddy playSound:kSoundSwoosh];
            }
        }];
        
    //create the ship
    self.ship = [[ShipController alloc] initWithView: self.guy];
        
        
        //create the asteroids
        _asteroidsArray = [[NSMutableArray alloc] init];
        _a1 = [[Asteroid alloc] initWithView:_asteroid1];
        _a2 = [[Asteroid alloc] initWithView:_asteroid2];
        _a3 = [[Asteroid alloc] initWithView:_asteroid3];
        _a4 = [[Asteroid alloc] initWithView:_asteroid4];
        _a5 = [[Asteroid alloc] initWithView:_asteroid5];
        _a6 = [[Asteroid alloc] initWithView:_asteroid6];
        _a7 = [[Asteroid alloc] initWithView:_asteroid7];
        _a8 = [[Asteroid alloc] initWithView:_asteroid8];
        _a9 = [[Asteroid alloc] initWithView:_asteroid9];
        _a10 = [[Asteroid alloc] initWithView:_asteroid10];
        
        //create the satellites
        _s1 = [[Satellite alloc] initWithView:_satellite1];
        _s2 = [[Satellite alloc] initWithView:_satellite2];
        _s3 = [[Satellite alloc] initWithView:_satellite3];
        
        //If no difficulty choice chosen, choose easy
        NSLog(@"diff=%d", self.difficulty);
        
        if(self.difficulty == 0){
            self.difficulty = 1;
        }
        
        if(self.difficulty == 1){
            _asteroidsArray = [NSMutableArray arrayWithObjects:_a1, _a2, _a3, _a4, _a5, nil];
            _satellitesArray = [NSMutableArray arrayWithObject:_s1];
        }
        
        
        if(self.difficulty == 2){
            _asteroidsArray = [NSMutableArray arrayWithObjects:_a1, _a2, _a3, _a4, _a5, _a6, _a7, nil];
            _satellitesArray = [NSMutableArray arrayWithObjects:_s1, _s2, nil];

        }
        
        if(self.difficulty == 3){
        _asteroidsArray = [NSMutableArray arrayWithObjects:_a1, _a2, _a3, _a4, _a5, _a6, _a7, _a8, _a9, _a10, nil];
        _satellitesArray = [NSMutableArray arrayWithObjects:_s1, _s2, _s3, nil];
        }
        
        [self startGame];
        
    }
    
	// Do any additional setup after loading the view.
}

-(void)startGame {
    
    if(_timer == nil){
        _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(animate)];
        
        [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

-(void)displayMessage:(NSString*)msg{
    //do not display more than one message
    if(_alert) return;
    
    //stop animation timer
    [self stop];
    
    //create and show alert message
    _alert = [[UIAlertView alloc] initWithTitle:@"Game Over!" message:msg delegate:self
                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [_alert show];
}

-(void)stop{
    if(_timer != nil){
        //remove from all run loops and nil out
        [_timer invalidate];
        _timer = nil;
    }
    
  //  self.viewPuck.hidden = YES;
}

-(void)animate{
    //move ship to new position based on direction and speed
    float x = self.guy.center.x + _dx * _speed;
    float y = self.guy.center.y;
    self.guy.center = CGPointMake(x, y);
    
    //spawn asteroids
    for(int i = 0; i < [_asteroidsArray count]; i++) {
        Asteroid *currentAsteroid = [_asteroidsArray objectAtIndex:i];
        
            //move Asteroids down screen
        int low;
        int high;
        
            if(self.difficulty == 1){
            low = 0.5;
            high = 1;
            }
        
        if(self.difficulty == 2){
            low = 1;
            high = 2;
            }
        
        if(self.difficulty == 3){
            low = 1;
            high = 3;
            }
            int rand = low + arc4random() % (high - low);
            int rand2 = arc4random() % 2 ? 1 : -1;
        
        if(rand2 == -1){
            rand = -rand;
        }
        else{
            rand = +rand;
        }
            float x1 = currentAsteroid.view.center.x + rand;
        
        
            int intSpeed = currentAsteroid.randSpeed;
            float speed = (float) intSpeed;
            float y1 = currentAsteroid.view.center.y + speed;
            currentAsteroid.view.center = CGPointMake(x1, y1);
        
        if(currentAsteroid.view.center.y > self.view.bounds.size.height + 50){
            [currentAsteroid.view setFrame:CGRectMake(arc4random() % (int)self.view.bounds.size.width - 50, -300, 61, 58)];
            if(self.difficulty == 1){
                currentAsteroid.randSpeed = (arc4random() % 5) + 1;
            }
            
            if(self.difficulty == 2){
                currentAsteroid.randSpeed = (arc4random() % 5) + 2;
            }
            
            if(self.difficulty == 3){
                currentAsteroid.randSpeed = (arc4random() % 7) + 1;
            }
        }
        
        
        
        if (CGRectIntersectsRect(self.guy.frame, currentAsteroid.view.frame)) {
            [_soundBuddy playSound:kSoundDeath];
            int score = [self.score.text intValue];
            NSString *msg;
            if(self.difficulty == 1){
            msg = [NSString stringWithFormat:@"Difficulty: Easy / Score: %d", score];
            }
            
            if(self.difficulty == 2){
                msg = [NSString stringWithFormat:@"Difficulty: Medium / Score: %d", score];
            }
            
            if(self.difficulty == 3){
                msg = [NSString stringWithFormat:@"Difficulty: Hard / Score: %d", score];
            }
            
           [self displayMessage: msg];
            
            [self mainMenu];
        }

    }
    
    //spawn satellites
    for(int j = 0; j < [_satellitesArray count]; j++) {
        Satellite *currentSatellite = [_satellitesArray objectAtIndex:j];
        
        //move Asteroids down screen
        int low;
        int high;
        
        if(self.difficulty == 1){
            low = 0.5;
            high = 1;
        }
        
        if(self.difficulty == 2){
            low = 0.5;
            high = 1;
        }
        
        if(self.difficulty == 3){
            low = 1;
            high = 2;
        }
        int rand = low + arc4random() % (high - low);
        int rand2 = arc4random() % 2 ? 1 : -1;
        
        if(rand2 == -1){
            rand = -rand;
        }
        else{
            rand = +rand;
        }
        float x1 = currentSatellite.view.center.x + rand;
        
        
        int intSpeed = currentSatellite.randSpeed;
        float speed = (float) intSpeed;
        float y1 = currentSatellite.view.center.y + speed;
        currentSatellite.view.center = CGPointMake(x1, y1);
        
        if(currentSatellite.view.center.y > self.view.bounds.size.height + 50){
            
            if(_satDown == YES){
                _dodges++;
            }
            
            if(_dodges > 4 && self.difficulty == 1){
                _satDown = NO;
            }
            
            if(_dodges > 9 && self.difficulty == 2){
                _satDown = NO;
            }
            
            if(_dodges > 19 && self.difficulty == 3){
                _satDown = NO;
            }
            
            [currentSatellite.view setFrame:CGRectMake(arc4random() % (int)self.view.bounds.size.width - 50, -300, 61, 49)];
            if(self.difficulty == 1){
                currentSatellite.randSpeed = (arc4random() % 5) + 1;
            }
            
            if(self.difficulty == 2){
                currentSatellite.randSpeed = (arc4random() % 5) + 2;
            }
            
            if(self.difficulty == 3){
                currentSatellite.randSpeed = (arc4random() % 7) + 1;
            }
        }
        
        if (CGRectIntersectsRect(self.guy.frame, currentSatellite.view.frame)) {
            
            [_soundBuddy playSound:kSoundBeep];
            
            [currentSatellite.view setFrame:CGRectMake(arc4random() % (int)self.view.bounds.size.width - 50, -300, 61, 49)];
            if(self.difficulty == 1){
                currentSatellite.randSpeed = (arc4random() % 5) + 1;
            }
            
            if(self.difficulty == 2){
                currentSatellite.randSpeed = (arc4random() % 5) + 2;
            }
            
            if(self.difficulty == 3){
                currentSatellite.randSpeed = (arc4random() % 7) + 1;
            }
        }
        
    }

}

-(void)mainMenu{
    UIStoryboard *storyboard = self.storyboard;
    if(! _mainVC){
        // you need to set the StoryBoard ID under Identifier in the storyboard file
        _mainVC = [storyboard instantiateViewControllerWithIdentifier:@"mainVC"];
    }
    
    // Configure the new view controller here.
    // the transitions can also be done in Interface Builder
    _mainVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:_mainVC animated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    //Enable interaction with UIImageViews
    [self.asteroid1 setUserInteractionEnabled:YES];
    [self.asteroid2 setUserInteractionEnabled:YES];
    [self.asteroid3 setUserInteractionEnabled:YES];
    [self.asteroid4 setUserInteractionEnabled:YES];
    [self.asteroid5 setUserInteractionEnabled:YES];
    [self.asteroid6 setUserInteractionEnabled:YES];
    [self.asteroid7 setUserInteractionEnabled:YES];
    [self.asteroid8 setUserInteractionEnabled:YES];
    [self.asteroid9 setUserInteractionEnabled:YES];
    [self.asteroid10 setUserInteractionEnabled:YES];
    
    [self.satellite1 setUserInteractionEnabled:YES];
    [self.satellite2 setUserInteractionEnabled:YES];
    [self.satellite3 setUserInteractionEnabled:YES];
    
    int score = [self.score.text intValue];
    
    for(int i = 0; i < [_asteroidsArray count]; i++) {
        Asteroid *currentAsteroid = [_asteroidsArray objectAtIndex:i];
        
        if ([touch view] == currentAsteroid.view)
        {
            if(_satDown == NO){
            [currentAsteroid.view setFrame:CGRectMake(arc4random() % (int)self.view.bounds.size.width - 50, -300, 61, 58)];
            if(self.difficulty == 1){
                currentAsteroid.randSpeed = (arc4random() % 5) + 1;
            }
            
            if(self.difficulty == 2){
                currentAsteroid.randSpeed = (arc4random() % 5) + 2;
            }
            
            if(self.difficulty == 3){
                currentAsteroid.randSpeed = (arc4random() % 7) + 1;
            }
            
            [_soundBuddy playSound:kSoundBoom];

            score++;
            self.score.text = [NSString stringWithFormat: @"%u", score];
            } else {
                [_soundBuddy playSound:kSoundBeep];
            }
        }
    }
    
    for(int i = 0; i < [_satellitesArray count]; i++) {
        Asteroid *currentSatellite = [_satellitesArray objectAtIndex:i];
        
        if ([touch view] == currentSatellite.view)
        {
            [currentSatellite.view setFrame:CGRectMake(arc4random() % (int)self.view.bounds.size.width - 50, -300, 61, 58)];
            if(self.difficulty == 1){
                currentSatellite.randSpeed = (arc4random() % 5) + 1;
            }
            
            if(self.difficulty == 2){
                currentSatellite.randSpeed = (arc4random() % 5) + 2;
            }
            
            if(self.difficulty == 3){
                currentSatellite.randSpeed = (arc4random() % 7) + 1;
            }
            
            [_soundBuddy playSound:kSoundBeep];
            
            _satDown = YES;
        }
    }

    
}

-(void)setDifficulty:(int)difficulty{
    NSLog(@"setter diff = %d", difficulty);
    _difficulty = difficulty;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touchesEnded:touches withEvent:event];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
