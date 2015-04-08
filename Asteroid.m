//
//  Asteroid.m
//  Blasto2000
//
//  Created by JJ Watson on 10/20/13.
//  Copyright (c) 2013 John Watson. All rights reserved.
//

#import "Asteroid.h"

@implementation Asteroid {
    float _minDistance;
    float _shipRadius;
    float _width;
    int *_rand;
    int *_randSpeed;
}

-(id) initWithView: (UIView*) asteroids{
    self = [super init];
    if (self){
        _view = asteroids;
       // _maxSpeed = max;
       // _shipRadius = shipRadius;
       // _minDistance = shipRadius + _view.bounds.size.width/2.0;
        _width = _view.bounds.size.height;
        int screenSize = (int) _width;
        _rand = arc4random() % screenSize;
        _randSpeed = (arc4random() % 6) + 1;
        
    }
    return self;
}

-(CGPoint) center{
    return _view.center;
}

@end
