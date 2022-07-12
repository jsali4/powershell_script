#код говно
cls
Write-Host 'Подожите'
$path_main_folder = "C:\test_folder"
$path_uninstall_file = "$path_main_folder\uninstall.txt"

$null = New-Item $path_main_folder -ItemType Directory

$list_installed_apps = [System.Collections.ArrayList]@()
foreach ($item in (wmic product get name)){
    if ($item -ne ''){
        $null = $list_installed_apps.Add($item)
    }
}
Set-Content $path_uninstall_file $list_installed_apps

cls
Write-Host 'Введите любую строку когда укажете в файле все приложения которые нужно удалить'
$null = Read-Host 'Сюда'
cls

$list_uninstalling_apps = Get-Content $path_uninstall_file
Write-Host $list_uninstalling_apps
if ((Read-Host 'Все ли ок?(Y - yes, N-No)') -eq 'Y'){
    foreach ($item in $list_uninstalling_apps){
        cls
        winget uninstall --name $item
    }
}
