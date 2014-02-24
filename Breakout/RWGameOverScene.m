//
//  RWGameOverScene.m
//  HelloGLKit
//
//  Created by Main Account on 8/28/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "RWGameOverScene.h"
#import "RWYouWin.h"
#import "RWYouLose.h"
#import "RWGameScene.h"
#import "RWDirector.h"

@implementation RWGameOverScene {
    GLfloat _timeSinceStart;
}

- (instancetype)initWithShader:(GLKBaseEffect *)shader win:(BOOL)win {
    if ((self = [super initWithName:"RWGameOverScene" shader:shader vertices:nil vertexCount:0])) {

        CGSize gameArea = CGSizeMake(27, 48);
        float sceneOffset = gameArea.height/2 / tanf(GLKMathRadiansToDegrees(85.0/2));
        self.position = GLKVector3Make(-gameArea.width/2, -gameArea.height/2 + 10, -sceneOffset);
        self.rotationX = GLKMathDegreesToRadians(-45);
                
        RWNode *message;
        if (win) {
            message = [[RWYouWin alloc] initWithShader:self.shader];
            message.diffuseColor = GLKVector4Make(0, 1, 0, 1);
        } else {
            message = [[RWYouLose alloc] initWithShader:self.shader];
            message.diffuseColor = GLKVector4Make(1, 0, 0, 1);
        }
        message.position = GLKVector3Make(13.5, 24, 0);
        [self.children addObject:message];
        
    }
    return self;
}

- (void)updateWithDelta:(GLfloat)aDelta {
    
    [super updateWithDelta:aDelta];
    
    _timeSinceStart += aDelta;
    if (_timeSinceStart > 5) {
        [[RWDirector sharedInstance] setScene:[[RWGameScene alloc] initWithShader:self.shader]];
    }
    
}

@end
