﻿# NVDA 懒人版

本程序基于 NVDA 官方版程序创建，主要修改了个别比较影响简体中文用户使用的选项，集成了部分较常用的插件和语音等。具体介绍如下：


## 对于设置选项的修改

1. 语音设置：关闭 eSpeak NG、 Microsoft Speech API version 4、 Microsoft Speech API version 5、 Windows OneCore、AiSound5、WorldVoice、IBMTTS 等接口的“激活拼读功能”选项，以避免出现个别字符发音怪异的现象；
2. 输入法设置：关闭“自动读出所有可用的候选”，以避免中文输入过程中对所有候选字的连续朗读，干扰输入；
3. 对象查看：启用“读出工具提示”，用以自动读出文件大小等信息；
4. 浏览模式：关闭“页面加载完成后朗读所有内容”，避免影响操作；
5. 文档格式：关闭“表格的单元坐标”，以避免过于冗余的朗读，此选项如有需要，可考虑临时启用，或为特定程序创建专用配置；
6. 高级设置：将“Windows 控制台支持”更改为“UIA 如果可用”、启用“在所有的增强终端读出密码”、将“Diff 算法”更改为“允许 Diff Match Patch”，以解决 CMD 等命令行程序在某些情况下的字符重复朗读等问题；
7. WorldVoice 插件：启用“检测语言时忽略数字和常见的标点符号”、将小数点的‘.’（点）朗读方式更改为“点”，“语音”更改为“Ting-Ting”，“音量”更改为“80”，“数字语言”更改为“中文(简体，中国)”，“数字模式”更改为“数值”，使此插件更加易用，特别感谢 Eureka 提供数据；
8. 插件更新器：将“插件更新源”更改为“NVDA 中文站”，以便于中文插件的更新；
9. IBMTTS 插件：禁用“自动检查 IBMTTS 更新”、将“速度”更改为“30”，“音量”更改为“100”，“采样率”更改为“22 kHz”，同时尝试将 IBMTTS 库设置为安装版 VVTTS 的相应动态链接库，使此插件更加易用。

上述设置在安装程序的“选择组件”页面，选择“默认安装”、“完整安装”或“最小安装”时均会自动应用，如选择自定义安装，需选中“修改部分 NVDA 设置”复选框方可成功应用。
为了避免误操作，造成您原有设置的丢失，故如检测到您的 NVDA 用户配置文件夹存在“NVDA.ini”文件，程序将不会自动选择上述选项，如仍要应用这些配置，需在“选择组件”页面选择“自定义安装”并选中“修改部分 NVDA 设置”复选框才可。


## 集成的语音引擎

本程序增加了一些语音引擎共安装和使用，具体如下：

- VVTTS 语音引擎（默认安装）
- IBMTTS 语音引擎（VVTTS 插件版，为实现最佳使用效果，该插件需与 VVTTS 语音引擎一同安装，默认安装）
- AiSound5 语音引擎
- WorldVoice 语音（默认安装）

上述标有“默认安装”的语音引擎及所需运行库，在安装程序的“选择组件”页面，选择“默认安装”时会自动安装，其他语音引擎需选择“完整安装”才会被自动安装，亦可选择“自定义安装”进行选择性安装。


## 常用插件的集成

本程序内含一些比较常用的插件，具体包括：

- 插件文档（默认安装）
- 插件更新器（默认安装）
- 音频管理器（仅 Windows 10 及以上版本的系统可见，默认安装）
- 百度翻译（默认安装）
- 剪贴板朗读增强（默认安装）
- DragAndDrop （对象拖放）（默认安装）
- 触摸手势增强
- 金色光标（默认安装）
- 中文输入法支持（默认安装）
- 禁止 Microsoft Edge UIA 通知
- 数字处理
- NVDA 中文社区更新镜像源（默认安装）
- PC QQ增强（默认安装）
- 快速调节
- 远程支持（默认安装）
- 资源监控器（默认安装）
- 取消系统静音（默认安装）
- 唤醒扬声器
- PC微信增强（默认安装）
- 新翼OCR（默认安装）
- Windows 应用增强（仅 Windows 10 及以上版本的系统可见，默认安装）

上述标有“默认安装”的插件，在安装程序的“选择组件”页面，选择“默认安装”时会自动安装，其他插件需选择“完整安装”才会被自动安装，亦可选择“自定义安装”进行选择性安装。
以上插件的快捷键及使用说明，可查看插件帮助或 NVDA 中文站的相关介绍页面。


## 其他说明

1. 运行本程序时，根据您的 NVDA 配置文件夹中是否存在 NVDA.ini 文件，会弹出不同的欢迎引导对话框，请根据提示选择所需的安装模式亦或者是否清空及是否备份您的现有配置，如选择备份您现有的 NVDA 配置，则备份的文件位于 `"%UserProfile%\Documents\NVDABackup"` 文件夹下；
2. 在本程序的“选择附加任务”页面，还提供了“在欢迎界面启用 NVDA”、“语音合成器设置”、“导入 VVTTS 语音字典（仅用于 SAPI4）”、“修改 DragAndDrop 插件的台式机快捷键与笔记本键盘方案相同”、“清空用户配置文件夹”等附加选项，可按需选择使用。其中：“语音合成器设置”选项可设置 NVDA 首次运行时的默认语音引擎；“导入 VVTTS 语音字典（仅用于 SAPI4）”选项用以解决部分字符在SAPI4 接口的 VVTTS 发音错误或读乱码的问题；“修改 DragAndDrop 插件的台式机快捷键与笔记本键盘方案相同”选项仅对简体中文语言生效，用以解决台式机键盘方案下的部分热键冲突。
3. 本程序的压缩包中附带有“NVDA 配置恢复工具.exe”文件，如运行本程序时，您的 NVDA 配置文件夹中存在 NVDA.ini 文件，并且您选择了清空及备份您的现有配置文件，则可通过此程序将其恢复到您的 NVDA 配置文件夹，恢复后的效果与未使用本程序进行安装基本相同，恢复后备份的配置文件即会被删除；
4. 通过本程序安装的 IBM ViaVoice TTS Runtime v6.405 语音引擎、Microsoft Visual C++ 2012 Redistributable (x86) 等组件，无法被自动删除，如需删除，请到程序和功能自行卸载；
5. 本程序的界面消息仅支持以简体中文显示，当检测到本程序在其他语言的操作系统上运行时，为了避免其他语言的语音引擎无法识别简体中文，进而导致本程序无法顺利安装，故将会以英语显示一个错误对话框，可根据对话框提示启动原始 NVDA 安装流程，本程序对简体中文用户定制的设置、插件等个性化功能将不会安装。


## 更新日志

### 2021-4-24
- #### 执行脚本
  - 删除文件前，增加了判断文件是否存在；
- #### 安装程序
  - 增加了NVDA+'模拟application；
  - 更新插件。

### 2021-5-4
- #### 安装程序
  - 显示安装向导前增加了是否执行快速安装的选项。

### 2021-5-15
- #### 安装程序
  - 在选择任务页面增加了在欢迎界面启用NVDA的选项

### 2021-8-2
- #### 安装程序
  - 更新 NVDA；
  - 将更新日志集成到ReadMe文档中；
  - 完善ReadMe文档；
  - 新增插件：快速调节、数字处理；
  - 移除NVDA+'模拟application（此功能由“快速调节”插件代替）；
  - 更新插件；
- #### NVDA设置
  - 新增：将“Diff 算法”更改为“允许 Diff Match Patch”。

### 2021-9-14
- #### 安装程序
  - 更新 NVDA；
  - 新增：“选择附加任务”页面增加“导入 VVTTS 语音字典”，解决部分字符 VVTTS 发音错误或读乱码的问题；
  - 改进：仅当未检测到 %Appdata%\NVDA\NVDA.ini 文件时才显示是否执行快速安装的对话框，并将默认按钮设为“是”；
  - 改进：将“修改 DragAndDrop 插件的台式机快捷键与笔记本键盘方案相同以避免热键冲突”调整成仅简体中文语言生效并更名为“修- 改 DragAndDrop 插件的台式机快捷键与笔记本键盘方案相同”；
  - 移除快捷键设置的所有内容（相关内容已集成到NVDA官方简体中文语言环境）；
  - 完善ReadMe文档；
  - 完善了完成页面的部分提示；
  - 更新插件；
  - 将Windows 10 应用增强更名为Windows 应用增强（相关内部名称不做调整），并解决与改进输入法朗读的冲突问题；
- #### NVDA设置
  - 集成了 WorldVoice(VE) 语音的默认设置（感谢 Eureka）。

### 2021-9-19
- #### 安装脚本
  - 新增：配置备份恢复程序，用以恢复通过本程序备份的 NVDA 配置；
  - 新增：自动压缩相关程序为 Zip 文件；
- #### 安装程序
  - 新增：引导清空、备份现有 NVDA 配置的交互对话框；
  - 新增语音引擎：AiSound5；
  - 新增插件：插件文档；
  - 改进：显示“准备安装”页面，用以查看安装内容；
  - 更换了 WorldVoice 插件所需的运行库
  - 完善ReadMe文档；
  - 完善了某些提示信息；
  - 更新插件；

### 2021-12-23
- #### 安装程序
  - 更新 NVDA；
  - 更新插件。

### 2022-5-23
- #### 安装程序
  - 更新 NVDA；
  - 新增插件：循环浏览模式；
  - 更新插件；
  - 调整部分插件的默认安装状态；
  - 调整 WorldVoice 及 AISound5 插件的安装流程；
  - 在线图像描述器、改进输入法朗读两款插件因不在维护，故取消集成；
  - 修复通过本程序更新金色光标插件会丢失该插件的某些配置的问题；
  - 完善ReadMe文档；
- #### NVDA设置
  - 关闭NV 宝盒语音合成器接口的“激活拼读功能”选项。

### 2022-7-21
- #### 安装程序
  - 更新 NVDA；
  - 更新插件；
  - 新增：“选择附加任务”页面选中清空用户配置文件夹后，可选择是否备份现有 NVDA 配置；
  - 完善ReadMe文档。

### 2022-9-19
- #### 安装程序
  - 更新 NVDA；
  - 新增插件：中文输入法支持、PC微信增强；
  - 更新插件。

### 2022-10-1
- #### 安装程序
  - 更新 NVDA；
  - 更新插件；

### 2022-10-4
- #### 安装程序
  - 更新 NVDA；
  - 去除：修复因卸载某些程序导致 NVDA 在一些列表等处无法朗读的问题（此功能已在NVDA中集成）；
  - 调整部分语音引擎和插件的默认安装状态；
  - 完善ReadMe文档；
  - 更新插件。

### 2022-11-10
- #### 安装程序
  - 更新 NVDA；
  - 更新插件。

### 2022-12-23
- #### 全局
  - 程序更名：自本版起，本程序正式更名为 NVDA 懒人版
- #### 安装程序
  - 更新 NVDA；
  - 即时翻译插件因官方插件翻译接口无法使用，故不在集成；
  - 完善ReadMe文档；
  - 更新插件。

### 2023-1-5
- #### 安装程序
  - 更新 NVDA；
  - 更新插件。

### 2023-2-7
- #### 安装程序
  - 更新 NVDA；
  - 新增语音引擎：IBMTTS 语音引擎（VVTTS 插件版）
  - 新增插件：VIYF 镜像源支持；
  - 恢复：对及时翻译插件的集成；
  - 改进：在 64 位操作系统中，本程序将以 64 位模式运行；
  - 完善ReadMe文档；
  - 更新插件。
- #### NVDA设置
  - 更改 IBMTTS 插件的部分设置；
  - 将插件更新器的插件更新源更改为NVDA 中文站。

### 2023-4-23
- #### 安装脚本
  - 改进：为生成的程序压缩包增加版本号；
- #### 安装程序
  - 更新 NVDA；
  - 完善ReadMe文档；
  - 新增插件：取消系统静音、新翼OCR；
  - 蓝牙音频插件被唤醒扬声器插件替换；
  - VIYF 镜像源支持插件被NVDA 中文社区更新镜像源插件替换；
  - 不在集成的插件：插件包生成、循环浏览模式
  - 更新插件。
- #### NVDA设置
  - 更改 IBMTTS 插件的部分设置；

### 2023-6-11
- #### 安装程序
  - 完善ReadMe文档；
  - 及时翻译插件被百度翻译插件替换；
  - 音频控制插件被音频管理器插件替换；
  - 去除新翼OCR插件的64 位操作系统要求；
  - 更新插件。

### 2023-9-4
- #### 安装程序
  - 更新 NVDA；
  - 新增插件：禁止 Microsoft Edge UIA 通知；
  - 恢复：音频控制插件（仅 Windows 8.1及以下系统可见）；
  - 音频管理器插件调整为仅 Windows 10 及以上系统可见；
  - 更新插件。

### 2023-10-30
- #### 安装程序
  - 更新 NVDA；
  - 新增插件：PC QQ增强；
  - 调整部分语音引擎和插件的默认安装状态；
  - 更新插件。

### 2024--
- #### 全局
  - 自本版起，本程序的源代码将托管至[GitHub](https://github.com/nvdacn/NVDA_Lazy_Edition)；
  - 改进：调整 ReadMe 文件，已使其在 GitHub 正确显示；
  - 改进：优化存储库文件夹结构；
  - 调整：支持的操作系统现为 Windows 8.1及以上；
- #### 脚本
  - 改进：将程序压缩包的版本部分更改为本程序的生成日期；
  - 改进：重写备份配置恢复程序，该程序在原有恢复已备份配置的基础上，还会恢复懒人版程序“修改 DragAndDrop 插件的台式机快捷键与笔记本键盘方案相同”选项对 NVDA 简体中文语言按键与首饰配置文件的修改；
- #### 安装程序
  - 更新 NVDA；
  - 调整：非简体中文语言的操作系统运行本程序，将以英语显示不受支持的提示；
  - 修正：通过本程序更新从插件商店安装的插件后，在插件商店仍然能检测到相同版本插件的问题；
  - 完善ReadMe文档；
  - 新增插件：；
  - 不在集成的插件：NV宝盒、音频控制、YY 补丁；
  - 更新插件。
- #### NVDA设置
  - 更新了部分 WorldVoice 插件的设置参数；

