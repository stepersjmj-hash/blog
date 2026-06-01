@echo off
chcp 65001 >nul
cd /d "%~dp0"

set PORT=8000
set URL=http://localhost:%PORT%

echo ========================================
echo  사진 블로그 생성기 - 로컬 서버
echo ========================================
echo.
echo 서버 주소: %URL%
echo 종료: Ctrl+C 또는 이 창 닫기
echo.

REM 브라우저 자동 열기 (서버 시작 직전)
start "" "%URL%"

REM 1차: python 명령 시도
where python >nul 2>nul
if %errorlevel%==0 (
    echo [Python] 서버 시작 중...
    python -m http.server %PORT%
    goto end
)

REM 2차: py 명령 시도 (Python Launcher)
where py >nul 2>nul
if %errorlevel%==0 (
    echo [py] 서버 시작 중...
    py -m http.server %PORT%
    goto end
)

REM 3차: Node.js npx 시도
where npx >nul 2>nul
if %errorlevel%==0 (
    echo [Node.js] http-server 시작 중...
    npx --yes http-server -p %PORT% -c-1
    goto end
)

REM 모두 실패
echo.
echo [오류] Python 또는 Node.js를 찾을 수 없습니다.
echo.
echo 해결 방법:
echo   1. Microsoft Store에서 "Python" 검색 후 무료 설치
echo   2. 또는 https://www.python.org 에서 Python 다운로드
echo   3. 또는 https://nodejs.org 에서 Node.js 다운로드
echo.
pause

:end
