#код говно
cls

[Console]::outputEncoding = [System.Text.Encoding]::GetEncoding('cp866')
[Console]::outputEncoding
Write-Host 'Подожите'

#Переменные путей директорий и файлов
$path_main_folder = "C:\test_folder"
$path_uninstall_file = "$path_main_folder\uninstall.txt"

# Создание и наполнение файлов и директорий нужными данными
$null = New-Item $path_main_folder -ItemType Directory
$list_installed_apps = [System.Collections.ArrayList]@()
foreach ($item in (wmic product get name)){
    if ($item -ne ''){
        $null = $list_installed_apps.Add($item)
    }
}
Set-Content $path_uninstall_file $list_installed_apps

#Проверка окончания изменения файла
cls
$list_installed_apps
Write-Host 'Введите любую строку когда оставите в файле все приложения которые нужно удалить'
$null = Read-Host 'Сюда'
cls

#Финал(удаление)
$list_uninstalling_apps = Get-Content $path_uninstall_file
Write-Host $list_uninstalling_apps
if ((Read-Host 'Все ли ок?(Y - yes, N-No)') -eq 'Y'){
    foreach ($item in $list_uninstalling_apps){
        cls
        winget uninstall --name $item
    }
}
