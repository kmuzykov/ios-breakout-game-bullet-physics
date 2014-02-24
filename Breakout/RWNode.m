//
//  RWNode.m
//  HelloOpenGL
//
//  Created by Main Account on 8/31/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "RWNode.h"

@implementation RWNode {
    const char *_name;
    GLuint _vao;
    GLuint _vertexBuffer;
    unsigned int _vertexCount;
    GLKBaseEffect *_shader;
}

- (instancetype)initWithName:(const char *)name shader:(GLKBaseEffect *)shader vertices:(Vertex *)vertices
  vertexCount:(unsigned int)vertexCount {
    if ((self = [self init])) {
        
        // Initialize passed in variables
        _name = name;
        _vertexCount = vertexCount;
        _shader = shader;
        self.position = GLKVector3Make(0, 0, 0);
        self.rotationX = 0;
        self.rotationY = 0;
        self.rotationZ = 0;
        self.scale = 1.0;
        self.children = [NSMutableArray array];
      
        if (vertices) {
      
            // Create the vertex array
            glGenVertexArraysOES(1, &_vao);
            glBindVertexArrayOES(_vao);
            
            // Generate the vertex buffer
            glGenBuffers(1, &_vertexBuffer);
            glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
            glBufferData(GL_ARRAY_BUFFER, vertexCount * sizeof(Vertex), vertices, GL_STATIC_DRAW);

            // Enable vertex attributes and set pointers
            glEnableVertexAttribArray(GLKVertexAttribPosition);
            glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE,
                                  sizeof(Vertex), (const GLvoid *) offsetof(Vertex, Position));
            glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
            glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE,
              sizeof(Vertex), (const GLvoid *) offsetof(Vertex, TexCoord));
            glEnableVertexAttribArray(GLKVertexAttribNormal);
            glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE,
                                  sizeof(Vertex), (const GLvoid *) offsetof(Vertex, Normal));
          
            // Reset bindings
            glBindVertexArrayOES(0);
            glBindBuffer(GL_ARRAY_BUFFER, 0);
        }
        
    }
    return self;
}

- (instancetype)initWithName:(const char *)name shader:(GLKBaseEffect *)shader vertices:(Vertex *)vertices vertexCount:(unsigned int)vertexCount textureName:(NSString *)textureName specularColor:(GLKVector4)specularColor diffuseColor:(GLKVector4)diffuseColor shininess:(float)shininess {
  if ((self = [self initWithName:name shader:shader vertices:vertices vertexCount:vertexCount])) {
    [self loadTexture:textureName];
    self.specularColor = specularColor;
    self.diffuseColor = diffuseColor;
    self.shininess = shininess;

  }
  return self;
}

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix {
  
    // Render children
    GLKMatrix4 modelViewMatrix = GLKMatrix4Multiply(parentModelViewMatrix, [self modelMatrix]);
    for (RWNode * child in self.children) {
        [child renderWithParentModelViewMatrix:modelViewMatrix];
    }
  
    if (_vao == 0) return;
  
    // Mark the OGL commands
    glPushGroupMarkerEXT(0, _name);
    {        

        _shader.transform.modelviewMatrix = parentModelViewMatrix;
        _shader.light0.position = GLKVector4Make(0, 0, 1, 0);

        // Prepare the effect
        _shader.transform.modelviewMatrix = modelViewMatrix;
        _shader.texture2d0.name = _texture;
        _shader.light0.enabled = GL_TRUE;
        _shader.light0.diffuseColor = _diffuseColor;

        _shader.light0.ambientColor = GLKVector4Make(1, 1, 1, 1.0);
        _shader.light0.specularColor = _specularColor;
        _shader.material.shininess = _shininess;
        _shader.lightingType = GLKLightingTypePerPixel;
      
        [_shader prepareToDraw];
        
        // Bind to the vertex object array for this model
        glBindVertexArrayOES(_vao);
        
        // Draw the model using triangles
        glDrawArrays(GL_TRIANGLES, 0, _vertexCount);
        
        // Important to unbind
        glBindVertexArrayOES(0);
    }
    glPopGroupMarkerEXT();
}

- (GLKMatrix4)modelMatrix {
  
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4Translate(modelMatrix, self.position.x, self.position.y, self.position.z);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationX, 1, 0, 0);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationY, 0, 1, 0);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationZ, 0, 0, 1);
    modelMatrix = GLKMatrix4Scale(modelMatrix, self.scale, self.scale, self.scale);
    return modelMatrix;
    
}

- (void)updateWithDelta:(GLfloat)aDelta {
    // Update children
    for (RWNode * child in self.children) {
        [child updateWithDelta:aDelta];
    }
}

- (void)loadTexture:(NSString *)filename {
    NSDictionary *options = @{ GLKTextureLoaderOriginBottomLeft: @YES };
    NSError *error;
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
    GLKTextureInfo *info = [GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
    if (info == nil) {
        NSLog(@"Error loading file: %@", error.localizedDescription);
    } else {
        self.texture = info.name;
    }
}

// Quick hack to return a 2D bounding box for this object based on its width and height fields, in the Z=0 plane
- (CGRect)boundingBoxWithModelViewMatrix:(GLKMatrix4)parentModelViewMatrix {
    
    GLKMatrix4 modelViewMatrix = GLKMatrix4Multiply(parentModelViewMatrix, [self modelMatrix]);
    
    GLKVector4 lowerLeft = GLKVector4Make(-self.width/2, -self.height/2, 0, 1);
    lowerLeft = GLKMatrix4MultiplyVector4(modelViewMatrix, lowerLeft);
    GLKVector4 upperRight = GLKVector4Make(self.width/2, self.height/2, 0, 1);
    upperRight = GLKMatrix4MultiplyVector4(modelViewMatrix, upperRight);
    
    CGRect boundingBox = CGRectMake(lowerLeft.x, lowerLeft.y, upperRight.x - lowerLeft.x, upperRight.y - lowerLeft.y);
    return boundingBox;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
}

@end
