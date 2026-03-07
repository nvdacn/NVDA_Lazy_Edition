;版本定义
#define BaseVersion GetDateTimeString('yyyy.mm.dd', '.', '')
#define BuildNumber GetEnv("GITHUB_RUN_NUMBER")
#define FinalVersion BaseVersion + (BuildNumber != "" ? "." + BuildNumber : "")

;根据构建环境设置语言文件
#if GetEnv("GITHUB_ACTIONS") == "true"
  #define EnglishMessages "compiler:Default.isl"
  #define ChineseSimplifiedMessages "..\Tools\InnoSetup\Languages\ChineseSimplified.isl"
#else
  #define EnglishMessages "..\Tools\InnoSetup\Languages\English.isl"
  #define ChineseSimplifiedMessages "compiler:Default.isl"
#endif
