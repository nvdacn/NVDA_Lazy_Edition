;版本定义
#define BaseVersion GetDateTimeString('yyyy.mm.dd', '.', '')
#define BuildNumber GetEnv("GITHUB_RUN_NUMBER")
#define FinalVersion BaseVersion + (BuildNumber != "" ? "." + BuildNumber : "")

;根据构建环境设置语言文件和 7z 路径
#if GetEnv("GITHUB_ACTIONS") == "true"
  #define EnglishMessages "compiler:Default.isl"
  #define ChineseSimplifiedMessages "..\Resource\UILanguages\ChineseSimplified.isl"
  #define SevenZipDll GetEnv("SystemDrive") + "\Program Files\7-Zip\7z.dll"
  #define SevenZipExe GetEnv("SystemDrive") + "\Program Files\7-Zip\7z.exe"
#else
  #define EnglishMessages "..\Tools\InnoSetup\Languages\English.isl"
  #define ChineseSimplifiedMessages "compiler:Default.isl"
  #define SevenZipDll "..\Tools\7Zip\7z.dll"
  #define SevenZipExe "..\Tools\7Zip\7z.exe"
#endif
