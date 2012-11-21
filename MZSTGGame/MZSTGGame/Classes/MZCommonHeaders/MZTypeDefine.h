#define MZ_INVAILD_POINT CGPointMake( -999, -999 )

//typedef float mzTime;
typedef double mzTime;

//typedef struct 
//{
//    int start;
//    int end;
//    int currentIndex;
//}MZVisitRange;

typedef enum
{
    kMZCharacterType_Unknow,
    kMZCharacterType_None,
    kMZCharacterType_Player,
    kMZCharacterType_EventControlCharacter,
    kMZCharacterType_PlayerBullet,
    kMZCharacterType_Enemy,
    kMZCharacterType_EnemyBullet,
    kMZCharacterType_Background,
    kMZCharacterType_Effect,
    kMZCharacterType_EventFlag,
    
}MZCharacterType;

typedef enum
{
    kMZTargetType_None,
    kMZTargetType_Player,
    kMZTargetType_ReferenceTarget,
    kMZTargetType_AbsolutePosition,
    kMZTargetType_FaceTo, 
    kMZTargetType_AssignPositionAddParentPosition,
    kMZTargetType_AssignPositionAddSpawnPosition,

}MZTargetType;

typedef enum
{
    kMZRotatedCenterType_None,
    kMZRotatedCenterType_AssignPosition,
    kMZRotatedCenterType_Spawn,
    kMZRotatedCenterType_Self,
    kMZRotatedCenterType_Motion,

}MZRotatedCenterType;

typedef enum
{
    kMZFaceToType_None,
    kMZFaceToType_Direction,
    kMZFaceToType_Target,
    kMZFaceToType_PreviousDirection,
//    kMZFaceToType_CurrentMovingVector, // 無作用
    
}MZFaceToType; // 以後再追加 ... 1.以預設角度轉向目標 2.XXXX 等等