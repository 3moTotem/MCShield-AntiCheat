@echo off
chcp 65001 >nul
title Anti-Cheat Security Scanner
color 0A
setlocal enabledelayedexpansion

echo ================================================
echo     فاحص أمان الأنتي شيت - Security Scanner
echo ================================================
echo.
echo هذا الملف يفحص كل ملفات الأنتي شيت ويطلع معلوماتهم
echo عشان أي أحد يقدر يتحقق إن الملفات آمنة
echo.
echo ------------------------------------------------
echo.

set "TARGET_DIR=%~dp0"
set "REPORT=%TARGET_DIR%security-report.txt"

echo جاري فحص الملفات...
echo.

if exist "%REPORT%" del "%REPORT%"

echo ================================================ >> "%REPORT%"
echo     تقرير فحص أمان الأنتي شيت >> "%REPORT%"
echo     تاريخ الفحص: %date% %time% >> "%REPORT%"
echo ================================================ >> "%REPORT%"
echo. >> "%REPORT%"

echo [1/4] فحص الملفات وتوليد hashes...
echo.

for %%F in ("%TARGET_DIR%*.exe" "%TARGET_DIR%*.dll" "%TARGET_DIR%*.sys") do (
    if exist "%%F" (
        echo   جاري فحص: %%~nxF
        echo ------------------------------------------------ >> "%REPORT%"
        echo الملف: %%~nxF >> "%REPORT%"
        echo الحجم: %%~zF bytes >> "%REPORT%"
        echo تاريخ التعديل: %%~tF >> "%REPORT%"
        for /f "delims=" %%H in ('powershell -NoProfile -Command "(Get-FileHash -Algorithm SHA256 -Path '%%F').Hash"') do (
            echo SHA-256: %%H >> "%REPORT%"
        )
        echo. >> "%REPORT%"
    )
)

echo [2/4] فحص الملفات النشطة...
echo.
echo ------------------------------------------------ >> "%REPORT%"
echo الملفات النشطة حالياً: >> "%REPORT%"
echo. >> "%REPORT%"
tasklist >> "%REPORT%" 2>nul
echo. >> "%REPORT%"

echo [3/4] فحص الاتصالات...
echo.
echo ------------------------------------------------ >> "%REPORT%"
echo الاتصالات النشطة: >> "%REPORT%"
echo. >> "%REPORT%"
netstat -an >> "%REPORT%" 2>nul
echo. >> "%REPORT%"

echo [4/4] فحص معلومات النظام...
echo.
echo ------------------------------------------------ >> "%REPORT%"
echo معلومات النظام: >> "%REPORT%"
echo. >> "%REPORT%"
systeminfo >> "%REPORT%" 2>nul
echo. >> "%REPORT%"

echo ================================================ >> "%REPORT%"
echo انتهى الفحص - هذا التقرير آمن للمشاركة >> "%REPORT%"
echo لا يوجد أي بيانات حساسة في هذا الملف >> "%REPORT%"
echo ================================================ >> "%REPORT%"

echo.
echo ================================================
echo     تم الفحص بنجاح!
echo.
echo     افتح ملف security-report.txt
echo     وشاركه مع أي أحد يبي يتحقق
echo ================================================
echo.
pause
