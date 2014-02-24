//
//  RWDirector.m
//  HelloGLKit
//
//  Created by Ray Wenderlich on 8/14/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "RWDirector.h"
#import "RWNode.h"

@implementation RWDirector {
    AVAudioPlayer *_backgroundMusicPlayer;
    AVAudioPlayer *_popEffect;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t pred;
    static RWDirector * _sharedInstance;
    dispatch_once(&pred, ^{ _sharedInstance = [[self alloc] init]; });
    return _sharedInstance;
}

- (instancetype)init {
    if ((self = [super init])) {
        _popEffect = [self preloadSoundEffect:@"pop.wav"];
    }
    return self;
}

- (void)playBackgroundMusic:(NSString *)filename
{
    _backgroundMusicPlayer = [self preloadSoundEffect:filename];
    _backgroundMusicPlayer.numberOfLoops = -1;
    [_backgroundMusicPlayer play];
}

- (AVAudioPlayer *)preloadSoundEffect:(NSString *)filename {
    NSURL *URL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
    AVAudioPlayer *retval = [[AVAudioPlayer alloc] initWithContentsOfURL:URL error:nil];
    [retval prepareToPlay];
    return retval;
}

- (void)playPopEffect {
    [_popEffect play];
}

- (void)setScene:(RWNode *)scene {
    _scene = scene;
}

@end
