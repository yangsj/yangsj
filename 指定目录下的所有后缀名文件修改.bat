@echo off
:0
cls
echo.
echo.                               ╭────────╮
echo.          ╭───────┤ 使 用  说 明 ├───────╮
echo.          │                   ╰────────╯                 │
echo.          │                                                               │
echo.          │   1、本工具的用途是——把指定目录      │
echo.          │      里，某类指定后缀名的文件，批        │
echo.          │      量的修改为其它指定的后缀名。        │
echo.          │                                                               │
echo.          │   2、每一步输入完毕，都请敲回车！     │
echo.          │                                                               │
echo.          │   3、注意——只输入后缀名，不要         │
echo.          │      输入后缀名前的“.”                         │
echo.          │                                                               │
echo.          │   4、文件夹的路径中如有空格和特殊      │
echo.          │      字符，请手打输入，不要拖放！        │
echo.          │                                                               │
echo.          ╰────────────────────────╯
echo.&echo           请输入文件夹的路径，或拖放文件夹到本窗口
set LJ=
set /p LJ=
if /i "%LJ%"=="" goto 0
echo.&echo         请输入修改前的后缀名：
set q=
set /p q=
if /i "%q%"=="" goto 0
echo.&echo          请输入修改后的后缀名：
set h=
set /p h=
if /i "%h%"=="" goto 0
for /r %LJ% %%i in (*.%q%) do ren %%i *.%h%
echo.&echo.           后缀名已批量修改成功！
echo.&echo.           请打开文件夹看看吧！
start %LJ%
pause
goto 0