# For Sitecore 8.2, to switch search provider need to update lots of files
# It will take some time, if you want to switch the search provider during the development.

# How to use
# 1. Put the script under the root folder of sitecore site
# 2. Open the powershell, and run the script with search provider name
# For example:  .\switch-search.ps1 azure or  .\switch-search.ps1 solr

Param([string]$searchProvider)

Write-Output "Switch search provider to $($searchProvider)."

If ($searchProvider -eq 'azure'){
    Get-ChildItem -Path .\App_Config\Include\ -Include *solr*.config -Recurse | ForEach-Object{
        $NewName = $_.Name -Replace '\.config$', '.config.disabled'
        $Destination = Join-Path -Path $_.Directory.FullName -ChildPath $NewName
        Move-Item -Path $_.FullName -Destination $Destination -Force
    }

    Get-ChildItem -Path .\App_Config\Include\ -Include *lucene*.config -Recurse | ForEach-Object{
        $NewName = $_.Name -Replace '\.config$', '.config.disabled'
        $Destination = Join-Path -Path $_.Directory.FullName -ChildPath $NewName
        Move-Item -Path $_.FullName -Destination $Destination -Force
    }

    Get-ChildItem -Path .\App_Config\Include\ -Include *azure*.config.* -Recurse | ForEach-Object{
        $NewName = $_.Name -Replace '\.config\..*$', '.config'
        $Destination = Join-Path -Path $_.Directory.FullName -ChildPath $NewName
        Move-Item -Path $_.FullName -Destination $Destination -Force
    }
}

If($searchProvider -eq 'solr'){
    Get-ChildItem -Path .\App_Config\Include\ -Include *solr*.config.* -Recurse | ForEach-Object{
        $NewName = $_.name -Replace '\.config\..*$', '.config'
        $Destination = Join-Path -Path $_.Directory.FullName -ChildPath $NewName
        Move-Item -Path $_.FullName -Destination $Destination -Force
    }

    Get-ChildItem -Path .\App_Config\Include\ -Include *lucene*.config -Recurse | ForEach-Object{
        $NewName =$_.name -Replace '\.config$', '.config.disabled'
        $Destination = Join-Path -Path $_.Directory.FullName -ChildPath $NewName
        Move-Item -Path $_.FullName -Destination $Destination -Force
    }

    Get-ChildItem -Path .\App_Config\Include\ -Include *azure*.config -Recurse | ForEach-Object{
        $NewName =$_.name -Replace '\.config$', '.config.disabled'
        $Destination = Join-Path -Path $_.Directory.FullName -ChildPath $NewName
        Move-Item -Path $_.FullName -Destination $Destination -Force
    }
}

If($searchProvider -eq 'lucene'){
    Get-ChildItem -Path .\App_Config\Include\ -Include *solr*.config -Recurse | ForEach-Object{
        $NewName =$_.name -Replace '\.config$', '.config.disabled'
        $Destination = Join-Path -Path $_.Directory.FullName -ChildPath $NewName
        Move-Item -Path $_.FullName -Destination $Destination -Force
    }

    Get-ChildItem -Path .\App_Config\Include\ -Include *lucene*.config.* -Recurse | ForEach-Object{
        $NewName = $_.name -Replace '\.config\..*$', '.config'
        $Destination = Join-Path -Path $_.Directory.FullName -ChildPath $NewName
        Move-Item -Path $_.FullName -Destination $Destination -Force
    }

    Get-ChildItem -Path .\App_Config\Include\ -Include *azure*.config -Recurse | ForEach-Object{
        $NewName =$_.name -Replace '\.config$', '.config.disabled'
        $Destination = Join-Path -Path $_.Directory.FullName -ChildPath $NewName
        Move-Item -Path $_.FullName -Destination $Destination -Force
    }
}
