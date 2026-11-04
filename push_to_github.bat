@echo off
chcp 65001 >nul
title Отправка проекта на GitHub — dilovar6666/olimp
color 0B

set "MINGIT_PATH=%LOCALAPPDATA%\MinGit\cmd;%LOCALAPPDATA%\MinGit\ucrt64\bin;%LOCALAPPDATA%\MinGit\usr\bin"
set "PATH=%MINGIT_PATH%;%PATH%"
cd /d "%~dp0"

echo =====================================================================
echo       🚀 Отправка интерактивного тренажера на GitHub
echo          Репозиторий: https://github.com/dilovar6666/olimp
echo =====================================================================
echo.

git status
echo.
echo ---------------------------------------------------------------------
echo Выберите способ авторизации:
echo [1] Войти через браузер (Git Credential Manager)
echo [2] Ввести GitHub Personal Access Token (Токен доступа)
echo [3] Открыть страницу создания токена на GitHub
echo [4] Просто выполнить: git push -u origin main
echo ---------------------------------------------------------------------
set /p choice="Ваш выбор (1/2/3/4): "

if "%choice%"=="1" goto browser_login
if "%choice%"=="2" goto token_login
if "%choice%"=="3" goto create_token
if "%choice%"=="4" goto direct_push
goto browser_login

:create_token
start https://github.com/settings/tokens/new?scopes=repo&description=olimp_upload
echo Открыта страница генерации токена с галочкой 'repo'.
echo Нажмите Generate token, скопируйте его и выберите пункт 2.
echo.
pause
goto token_login

:token_login
echo.
echo Вставьте ваш Personal Access Token (нажмите правую кнопку мыши в окне):
set /p ghtoken="Токен: "
if "%ghtoken%"=="" goto token_login
git remote set-url origin https://dilovar6666:%ghtoken%@github.com/dilovar6666/olimp.git
echo.
echo Отправляем файлы в репозиторий...
git push -u origin main
if %ERRORLEVEL% equ 0 (
    echo.
    echo ===============================================================
    echo 🎉 УСПЕХ! Проект успешно выгружен на GitHub!
    echo Ссылка: https://github.com/dilovar6666/olimp
    echo Страница: https://dilovar6666.github.io/olimp/
    echo ===============================================================
) else (
    echo.
    echo ❌ Ошибка при отправке. Проверьте правильность токена.
)
goto finish

:browser_login
echo.
echo Запуск авторизации через браузер...
git push -u origin main
if %ERRORLEVEL% equ 0 (
    echo.
    echo ===============================================================
    echo 🎉 УСПЕХ! Проект успешно выгружен на GitHub!
    echo Ссылка: https://github.com/dilovar6666/olimp
    echo ===============================================================
)
goto finish

:direct_push
echo.
git push -u origin main
goto finish

:finish
echo.
echo Нажмите любую клавишу для выхода...
pause >nul
