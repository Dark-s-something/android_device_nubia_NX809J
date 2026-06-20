@echo off
setlocal EnableExtensions
chcp 65001 >nul

set "IMG=C:\Users\adriano\Videos\twrp\builds\TWRP-3.7.1-16-sm88XX-recovery-27238758919.img"
set "SLOT=b"

echo.
echo REDMAGIC 11 Pro NX809J - testar TWRP touch no recovery_%SLOT%
echo.
echo Este script grava SOMENTE:
echo   recovery_%SLOT%
echo.
echo Imagem:
echo "%IMG%"
echo.
echo Para restaurar stock depois, use:
echo restore_nx809j_slot_b_stock.bat
echo.

if not exist "%IMG%" (
    echo ERRO: imagem nao encontrada.
    echo.
    pause
    exit /b 1
)

where fastboot >nul 2>nul
if errorlevel 1 (
    echo ERRO: fastboot nao encontrado no PATH.
    echo.
    pause
    exit /b 1
)

echo Coloque o telefone em fastboot/bootloader.
echo Aparelhos em fastboot:
fastboot devices
echo.
echo Para cancelar, feche esta janela ou pressione Ctrl+C.
echo.
pause

echo.
echo Slot atual:
fastboot getvar current-slot 2>&1

echo.
echo Gravando recovery_%SLOT%...
fastboot flash recovery_%SLOT% "%IMG%"
if errorlevel 1 goto :failed

echo.
echo Reiniciando direto no recovery...
fastboot reboot recovery
if errorlevel 1 goto :failed

echo.
echo Enviado com sucesso. Teste o touch no TWRP.
echo.
pause
exit /b 0

:failed
echo.
echo ERRO: o teste parou por falha em um comando fastboot.
echo.
pause
exit /b 1
