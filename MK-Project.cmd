@echo off
: Default Seting "Color, Title"
color a
title WorkPlace 

: UTF-8 Encoding To Deal With Multiple Languages Like "Arabic"
chcp 65001 >nul

:Re_Start
cls

: Reset & Clear The Previous Inputed Value
set "project_name="


: Check if pc has Git installed by set error level based on [git --version] value
: If pc has Git installed then no errors will appear when using [git --version] and the error number = 0
: Eles there will be a non-recognition error for [git --version] and the error number = 9009
:CheckGit
git --version > nul 2> nul
if %errorlevel%==0 ( set Git_Exist=true ) else ( if %errorlevel%==9009 ( set Git_Exist=false ) )

: The Input Field
echo:
set /p "project_name= Project Name:" 
echo:

: Filter The Input Data & Fixing Bugs
if "%project_name%"==" " ( goto Re_Start )
if not defined project_name ( goto Re_Start )
if exist "%project_name%"\ ( echo "%project_name%" is already exist, try another name... && pause && goto Re_Start )

: Make Project Folder & Files
mkdir "%project_name%" "%project_name%"\js "%project_name%"\css "%project_name%"\img
type NUL > "%project_name%"/index.html
type NUL > "%project_name%"/js/"%project_name%".js
type NUL > "%project_name%"/css/"%project_name%".css
echo Project Folders And Files Created Successfully...
echo:

: Downloade Normalize.css and save it into css folder
curl https://necolas.github.io/normalize.css/latest/normalize.css > "%project_name%"\css\normalize.css 
echo:
echo Normalize.css Has Been Added..
echo:

: initialize the new project directory as a Git repository
if %Git_Exist%==true (
cd "%project_name%"
git init
cd ..
)

echo:
echo Workplace Created Successfully...
pause >nul
exit
