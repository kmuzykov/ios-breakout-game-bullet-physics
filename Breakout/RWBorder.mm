//
//  RWBorder.m
//  HelloGLKit
//
//  Created by Main Account on 8/26/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "RWBorder.h"
#import "border.h"

@implementation RWBorder

- (id)initWithShader:(GLKBaseEffect *)shader {
    if ((self = [super initWithName:"Border"
                               mass:0.0f        //1
                             convex:NO          //2
                                tag:kBorderTag  //3
                             shader:shader
                           vertices:(Vertex *)Border_Cube_Border_Vertices
                        vertexCount:sizeof(Border_Cube_Border_Vertices)/sizeof(Border_Cube_Border_Vertices[0])
                        textureName:@"border.png"
                      specularColor:Border_Cube_Border_specular
                       diffuseColor:Border_Cube_Border_diffuse
                          shininess:Border_Cube_Border_shininess])) {
 
        self.width = 27.0;
        self.height = 48.0;
 
    }
    return self;
}

@end
