//
//  RWBall.m
//  HelloGLKit
//
//  Created by Main Account on 8/10/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "RWBall.h"
#import "ball.h"

@implementation RWBall

- (id)initWithShader:(GLKBaseEffect *)shader {
    if ((self = [super initWithName:"Ball"
                               mass: 1.0f       //1
                             convex: YES        //2
                                tag: kBallTag   //3
                             shader:shader
                           vertices:(Vertex *)Ball_Sphere_ball_Vertices
                        vertexCount:sizeof(Ball_Sphere_ball_Vertices)/sizeof(Ball_Sphere_ball_Vertices[0])
                        textureName:@"ball.png"
                      specularColor:Ball_Sphere_ball_specular
                       diffuseColor:Ball_Sphere_ball_diffuse
                          shininess:Ball_Sphere_ball_shininess])) {
        self.width = 1.0;
        self.height = 1.0;
    }
    return self;
}

@end
