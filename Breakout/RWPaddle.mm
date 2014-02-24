//
//  RWPaddle.m
//  HelloGLKit
//
//  Created by Main Account on 8/10/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "RWPaddle.h"
#import "paddle.h"

@implementation RWPaddle

- (id)initWithShader:(GLKBaseEffect *)shader {
    if ((self = [super initWithName:"Paddle"
                               mass:0.0f        //1
                             convex:YES         //2
                                tag:kPaddleTag  //3
                             shader:shader
                           vertices:(Vertex *)Paddle_Cube_paddle_Vertices
                        vertexCount:sizeof(Paddle_Cube_paddle_Vertices)/sizeof(Paddle_Cube_paddle_Vertices[0])
                        textureName:@"paddle.png"
                      specularColor:Paddle_Cube_paddle_specular
                       diffuseColor:Paddle_Cube_paddle_diffuse
                          shininess:Paddle_Cube_paddle_shininess])) {
 
        self.width = 5.0;
        self.height = 1.0;
 
    }
    return self;
}

@end
