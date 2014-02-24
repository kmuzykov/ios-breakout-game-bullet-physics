//
//  RWYouLose.m
//  HelloGLKit
//
//  Created by Main Account on 8/28/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "RWYouLose.h"
#import "youlose.h"

@implementation RWYouLose

- (id)initWithShader:(GLKBaseEffect *)shader {
    if ((self = [super initWithName:"YouLose" shader:shader vertices:(Vertex *)youlose_Mesh_001_youlose_Vertices vertexCount:sizeof(youlose_Mesh_001_youlose_Vertices)/sizeof(youlose_Mesh_001_youlose_Vertices[0]) textureName:@"youlose.png" specularColor:youlose_Mesh_001_youlose_specular diffuseColor:youlose_Mesh_001_youlose_diffuse shininess:youlose_Mesh_001_youlose_shininess])) {
        
        self.rotationX = M_PI_4;
        
    }
    return self;
}

- (void)updateWithDelta:(GLfloat)aDelta {
    
    // If there is no delta value then don't bother updating
    if (aDelta == 0) return;
    
    // Increase the amount of rotation
    float amplitude = 0.5;
    float periodMod = 2;
    float periodicAmt = sin(CACurrentMediaTime()*periodMod) * amplitude * aDelta;
    self.rotationX += M_PI * periodicAmt;
    self.scale += 2*periodicAmt;
    
    [super updateWithDelta:aDelta];
    
}

@end
