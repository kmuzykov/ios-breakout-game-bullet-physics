//
//  RWDirector.h
//  HelloGLKit
//
//  Created by Ray Wenderlich on 8/14/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import <AVFoundation/AVFoundation.h>

@class RWNode;

@interface RWDirector : NSObject

+ (instancetype)sharedInstance;
- (void)playBackgroundMusic:(NSString *)filename;
- (AVAudioPlayer *)preloadSoundEffect:(NSString *)filename;
- (void)playPopEffect;

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) RWNode *scene;

@end
