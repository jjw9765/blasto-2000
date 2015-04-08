//
//  ShipController.h
//  Blasto2000
//
//  Created by JJ Watson on 10/20/13.
//  Copyright (c) 2013 John Watson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShipController : NSObject

//initalize object
-(id) initWithView:(UIView*)ship;

//center point of ship
-(CGPoint) center;

@end
