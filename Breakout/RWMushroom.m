//
//  RWMushroom.m
//  HelloOpenGL
//
//  Created by Main Account on 8/31/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "RWMushroom.h"
#import "mushroom.h"

@implementation RWMushroom

- (instancetype)initWithShader:(GLKBaseEffect *)shader {

  if ((self = [super initWithName:"square" shader:shader 
    vertices:(Vertex *)Mushroom_Cylinder_mushroom_Vertices 
    vertexCount:sizeof(Mushroom_Cylinder_mushroom_Vertices) / sizeof(Mushroom_Cylinder_mushroom_Vertices[0])])) {
    
    [self loadTexture:@"mushroom.png"];
    
    self.diffuseColor = GLKVector4Make(1, 1, 1, 1);
    self.specularColor = Mushroom_Cylinder_mushroom_specular;
    self.shininess = Mushroom_Cylinder_mushroom_shininess;

    self.rotationY = M_PI;
    self.rotationX = M_PI_2;
    self.scale = 0.5;

  }
  return self;
}

- (void)updateWithDelta:(GLfloat)aDelta {
    self.rotationZ += M_PI * aDelta;    
}

@end
