//
//  SoundBuddy2.h
//  Paddles
//
//  Created by JJ Watson on 10/1/13.
//  Copyright (c) 2013 John Watson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

static NSString* const kSoundBoom = @"boom";
static NSString* const kSoundClick = @"clicked";
static NSString* const kSoundDeath = @"death";
static NSString* const kSoundSwoosh = @"swoosh";
static NSString* const kSoundMusic = @"music";
static NSString* const kSoundBeep = @"beep";

@interface SoundBuddy2 : NSObject
    -(void)playSound:(NSString *)fileName;
@end
