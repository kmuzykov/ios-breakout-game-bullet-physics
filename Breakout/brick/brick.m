#import "brick.h"

const GLKVector4 Cube_brick_ambient = {0.000000, 0.000000, 0.000000, 1.000000};
const GLKVector4 Cube_brick_diffuse = {0.640000, 0.640000, 0.640000, 1.000000};
const GLKVector4 Cube_brick_specular = {0.500000, 0.500000, 0.500000, 1.000000};
const float Cube_brick_shininess = 96.078430;

const Vertex Cube_brick_Vertices[36] = {
    {{1.000000, -0.500000, -0.500000}, {0.448251, 0.001343}, {0.000000, -1.000000, 0.000000}},
    {{1.000000, -0.500000, 0.500000}, {0.448250, 0.492744}, {0.000000, -1.000000, 0.000000}},
    {{-1.000000, -0.500000, 0.500000}, {0.173137, 0.494931}, {0.000000, -1.000000, 0.000000}},
    {{1.000000, -0.500000, -0.500000}, {0.448251, 0.001343}, {0.000000, -1.000000, 0.000000}},
    {{-1.000000, -0.500000, 0.500000}, {0.173137, 0.494931}, {0.000000, -1.000000, 0.000000}},
    {{-0.999999, -0.500000, -0.500000}, {0.173137, 0.003529}, {0.000000, -1.000000, 0.000000}},
    {{1.000000, 0.500000, -0.499999}, {0.724974, 0.481105}, {0.000000, 1.000000, 0.000000}},
    {{-0.999999, 0.500000, -0.500000}, {0.449831, 0.480277}, {0.000000, 1.000000, 0.000000}},
    {{-1.000000, 0.500000, 0.500000}, {0.449926, 0.000000}, {0.000000, 1.000000, 0.000000}},
    {{1.000000, 0.500000, -0.499999}, {0.724974, 0.481105}, {0.000000, 1.000000, 0.000000}},
    {{-1.000000, 0.500000, 0.500000}, {0.449926, 0.000000}, {0.000000, 1.000000, 0.000000}},
    {{0.999999, 0.500000, 0.500000}, {0.725068, 0.000828}, {0.000000, 1.000000, 0.000000}},
    {{1.000000, -0.500000, -0.500000}, {0.988141, 0.489126}, {1.000000, 0.000000, 0.000001}},
    {{1.000000, 0.500000, -0.499999}, {0.988576, 0.969318}, {1.000000, 0.000000, 0.000001}},
    {{0.999999, 0.500000, 0.500000}, {0.846892, 0.970791}, {1.000000, 0.000000, 0.000001}},
    {{1.000000, -0.500000, -0.500000}, {0.988141, 0.489126}, {1.000000, 0.000000, 0.000001}},
    {{0.999999, 0.500000, 0.500000}, {0.846892, 0.970791}, {1.000000, 0.000000, 0.000001}},
    {{1.000000, -0.500000, 0.500000}, {0.846457, 0.490599}, {1.000000, 0.000000, 0.000001}},
    {{1.000000, -0.500000, 0.500000}, {0.454973, 0.936455}, {-0.000000, -0.000000, 1.000000}},
    {{0.999999, 0.500000, 0.500000}, {0.454140, 0.494932}, {-0.000000, -0.000000, 1.000000}},
    {{-1.000000, 0.500000, 0.500000}, {0.725731, 0.493577}, {-0.000000, -0.000000, 1.000000}},
    {{1.000000, -0.500000, 0.500000}, {0.454973, 0.936455}, {-0.000000, -0.000000, 1.000000}},
    {{-1.000000, 0.500000, 0.500000}, {0.725731, 0.493577}, {-0.000000, -0.000000, 1.000000}},
    {{-1.000000, -0.500000, 0.500000}, {0.726565, 0.935100}, {-0.000000, -0.000000, 1.000000}},
    {{-1.000000, -0.500000, 0.500000}, {0.988962, 0.487653}, {-1.000000, -0.000000, -0.000000}},
    {{-1.000000, 0.500000, 0.500000}, {0.847278, 0.489126}, {-1.000000, -0.000000, -0.000000}},
    {{-0.999999, 0.500000, -0.500000}, {0.846843, 0.008934}, {-1.000000, -0.000000, -0.000000}},
    {{-1.000000, -0.500000, 0.500000}, {0.988962, 0.487653}, {-1.000000, -0.000000, -0.000000}},
    {{-0.999999, 0.500000, -0.500000}, {0.846843, 0.008934}, {-1.000000, -0.000000, -0.000000}},
    {{-0.999999, -0.500000, -0.500000}, {0.988527, 0.007461}, {-1.000000, -0.000000, -0.000000}},
    {{1.000000, 0.500000, -0.499999}, {0.903494, 0.493572}, {0.000000, 0.000000, -1.000000}},
    {{1.000000, -0.500000, -0.500000}, {0.901317, 0.929333}, {0.000000, 0.000000, -1.000000}},
    {{-0.999999, -0.500000, -0.500000}, {0.454067, 0.931520}, {0.000000, 0.000000, -1.000000}},
    {{1.000000, 0.500000, -0.499999}, {0.903494, 0.493572}, {0.000000, 0.000000, -1.000000}},
    {{-0.999999, -0.500000, -0.500000}, {0.454067, 0.931520}, {0.000000, 0.000000, -1.000000}},
    {{-0.999999, 0.500000, -0.500000}, {0.456245, 0.495759}, {0.000000, 0.000000, -1.000000}},
};
