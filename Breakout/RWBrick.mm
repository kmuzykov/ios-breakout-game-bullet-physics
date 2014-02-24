//
//  RWBrick.m
//  HelloGLKit
//
//  Created by Main Account on 8/10/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "RWBrick.h"
#import "brick.h"

@implementation RWBrick

- (id)initWithShader:(GLKBaseEffect *)shader {
    if ((self = [super initWithName:"Brick"
                               mass:0.0f        //1
                             convex:YES         //2
                                tag:kBrickTag   //3
                             shader:shader
                           vertices:(Vertex *)Cube_brick_Vertices
                        vertexCount:sizeof(Cube_brick_Vertices)/sizeof(Cube_brick_Vertices[0])
                        textureName:@"brick.png"
                      specularColor:Cube_brick_specular
                       diffuseColor:Cube_brick_diffuse
                          shininess:Cube_brick_shininess])) {
        self.width = 2.0;
        self.height = 1.0;
    }
    return self;
}

- (void)updateWithDelta:(GLfloat)aDelta {

    // If there is no delta value then don't bother updating
    if (aDelta == 0) return;
    
    // Increase the amount of rotation
    self.rotationY += M_PI_4 * aDelta;
    self.rotationZ+= M_PI_4 * aDelta;
  
    [super updateWithDelta:aDelta];
    
}

@end
