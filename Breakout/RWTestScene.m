//
//  RWTestScene.m
//  Breakout
//
//  Created by Main Account on 8/31/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "RWTestScene.h"
#import "RWMushroom.h"

@implementation RWTestScene {
    RWMushroom* _mushroom;
}

- (instancetype)initWithShader:(GLKBaseEffect *)shader {
    if ((self = [super initWithName:"RWTestScene" shader:shader vertices:nil vertexCount:0])) {
    
        _mushroom = [[RWMushroom alloc] initWithShader:shader];
        [self.children addObject:_mushroom];
      
        self.position = GLKVector3Make(0, -1, -10);
    
    }
    return self;
}

@end
