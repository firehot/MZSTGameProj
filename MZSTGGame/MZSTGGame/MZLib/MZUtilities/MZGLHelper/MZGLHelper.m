#import "MZGLHelper.h"
#import "MZLogMacro.h"

@implementation MZGLHelper

+(GLenum)glBlendEnumFromString:(NSString *)enumString
{
    if( [enumString isEqualToString: @"GL_ZERO"] ) return GL_ZERO;
    if( [enumString isEqualToString: @"GL_ONE"] ) return GL_ONE;
    
    if( [enumString isEqualToString: @"GL_SRC_COLOR"] ) return GL_SRC_COLOR;
    if( [enumString isEqualToString: @"GL_DST_COLOR"] ) return GL_DST_COLOR;
    
    if( [enumString isEqualToString: @"GL_ONE_MINUS_SRC_COLOR"] ) return GL_ONE_MINUS_SRC_COLOR;
    if( [enumString isEqualToString: @"GL_ONE_MINUS_DST_COLOR"] ) return GL_ONE_MINUS_DST_COLOR;
    
    if( [enumString isEqualToString: @"GL_SRC_ALPHA"] ) return GL_SRC_ALPHA;
    if( [enumString isEqualToString: @"GL_ONE_MINUS_SRC_ALPHA"] ) return GL_ONE_MINUS_SRC_ALPHA;
    if( [enumString isEqualToString: @"GL_DST_ALPHA"] ) return GL_DST_ALPHA;
    if( [enumString isEqualToString: @"GL_ONE_MINUS_DST_ALPHA"] ) return GL_ONE_MINUS_DST_ALPHA;
    if( [enumString isEqualToString: @"GL_SRC_ALPHA_SATURATE"] ) return GL_SRC_ALPHA_SATURATE;
    
    MZAssert( false, @"Unknow enumString(%@)", enumString );
    return 0;
}

+(GLenum)defaultBlendFuncSrc
{
    return GL_ONE;
}

+(GLenum)defaultBlendFuncDest
{
    return GL_ONE_MINUS_SRC_ALPHA;
}

@end
