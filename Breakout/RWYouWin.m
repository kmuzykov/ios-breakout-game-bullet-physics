//
//  RWYouWin.m
//  HelloGLKit
//
//  Created by Main Account on 8/28/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "RWYouWin.h"
#import "youwin.h"

@implementation RWYouWin

- (id)initWithShader:(GLKBaseEffect *)shader {
    if ((self = [super initWithName:"YouWin" shader:shader vertices:(Vertex *)Text_Mesh_youwin_Vertices vertexCount:sizeof(Text_Mesh_youwin_Vertices)/sizeof(Text_Mesh_youwin_Vertices[0]) textureName:@"youwin.png" specularColor:Text_Mesh_youwin_specular diffuseColor:Text_Mesh_youwin_diffuse shininess:Text_Mesh_youwin_shininess])) {
        
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
