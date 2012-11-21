@class MZFaceToControl;

@protocol MZFaceToControlProtocol
@property (nonatomic, readwrite) bool visible;
@property (nonatomic, readwrite) float rotation;
@property (nonatomic, readonly) CGPoint standardPosition;
@property (nonatomic, readonly) CGPoint currentMovingVector;
@property (nonatomic, readonly) CGPoint targetPosition;
@end