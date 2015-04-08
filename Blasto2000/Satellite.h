//
//  Satellite.h
//  Blasto2000
//
//  Created by JJ Watson on 10/24/13.
//  Copyright (c) 2013 John Watson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Satellite : NSObject

@property (assign) UITouch *touch;
@property (assign) int *rand;
@property (assign) int *randSpeed;
@property (assign) UIView *view;
@property (readonly) float maxSpeed;
@property (readonly) float speed;
@property (readonly) float dx;
@property (readonly) float dy;

// initialize object
-(id) initWithView: (UIView*) asteroids;


// returns current center position of asteroid
-(CGPoint) center;

// check for collision with paddle and alter path of puck if so
//-(BOOL)handleCollision:(ShipController*) ship;

@end
