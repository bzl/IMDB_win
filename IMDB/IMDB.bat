@ECHO OFF
setlocal enableDelayedExpansion
set movie=%~nx1

::removes quotes
set movie=%movie:"= %

::removes dot
set movie=%movie:.= %

::removes hyphen
set movie=%movie:-= %

::removes brackets
set movie=%movie:[= %
set movie=%movie:]= %

::removes parantheses
set movie=%movie:(= %
set movie=%movie:)= %

::cut string after 1080p
call :Fix movie 1080p

::cut string after 1080
call :Fix movie 1080

::cut string after 720p
call :Fix movie 720p

::cut string after 720
call :Fix movie 720

::cut string after BDRip
call :Fix movie BDRip

::cut string after BRRip
call :Fix movie BRRip

::cut string after HDTV
call :Fix movie HDTV

::cut string after HD
call :Fix movie HD

::cut string after HDRip
call :Fix movie HDRip

::cut string after x264
call :Fix movie x264

::cut string after h264
call :Fix movie h264

::cut string after BluRay
call :Fix movie BluRay

::Trims trailing/leading spaces
call :Trim movie %movie%

echo Movie final name: %movie%

::Prepares movie name for IMDB search format
set movie=%movie: =+%
start http://www.imdb.com/find?q=%movie%
::cmd /c "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" -url http://www.imdb.com/find?q=%movie%

EndLocal
exit /b

:Trim
SetLocal EnableDelayedExpansion
set Params=%*
for /f "tokens=1*" %%a in ("!Params!") do EndLocal & set %1=%%b
exit /b

::Fix basically cuts off as soon as we hit the keyword we searched for.
:Fix
set tempMovie=
for %%a in (%movie%) do (
   if %%a == %2 (
   goto Mexico
   )
    set tempMovie=!tempMovie! %%a
)
::Jump to Mexico when we have isolated the important part of the movie name.
:Mexico
set %1=%tempMovie%
exit /b