//
//  ShipController.m
//  Blasto2000
//
//  Created by JJ Watson on 10/20/13.
//  Copyright (c) 2013 John Watson. All rights reserved.
//

#import "ShipController.h"

@implementation ShipController {
    UIView *_view; //paddle view with current position
    CGRect _boundary; //confined boundary
}

-(id) initWithView:(UIView*)ship{
    self = [super init];
    if(self){
        _view = ship;
    }
    return self;
}

//#5 center point of paddle
-(CGPoint)center {
    return _view.center;
}

@end
