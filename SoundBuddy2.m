//
//  SoundBuddy2.m
//  Paddles
//
//  Created by JJ Watson on 10/1/13.
//  Copyright (c) 2013 John Watson. All rights reserved.
//

#import "SoundBuddy2.h"

static float const kSoundDefaultVolume = .5;

@implementation SoundBuddy2 {
    NSMutableDictionary *_soundDictionary; // key:value storage
}


-(id)init{
    self = [super init];
    if(self) {
        _soundDictionary = [NSMutableDictionary dictionary];
        [self createChannel: kSoundBoom];
        [self createChannel: kSoundClick];
        [self createChannel: kSoundDeath];
        [self createChannel: kSoundSwoosh];
        [self createChannel: kSoundMusic];
        [self createChannel: kSoundBeep];
    }
    return self;
}

-(void)playSound:(NSString *)fileName{
        //AVAudio Player *player = [_soundDictionary objectforKey:fileName];
    AVAudioPlayer *player = _soundDictionary[fileName];
    player.currentTime = 0;
    if(fileName == kSoundMusic){
        player.volume = 0.5;
    }
    else {
        player.volume = kSoundDefaultVolume;
    }
    [player play];
}

-(void)createChannel:(NSString *)fileName{
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"wav"];
    
    NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
    
    NSError *error;
    
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
    
    player.volume = kSoundDefaultVolume;
    
    [player prepareToPlay];
    
    // [_soundDictionary setObject:player forKey:fileName];
    //OR
    _soundDictionary[fileName] = player;
    
    
}


@end