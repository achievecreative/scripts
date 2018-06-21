# For Sitecore 8.2, to switch search provider need to update lots of files
# It will take some time, if you want to switch the search provider during the development.

# How to use
# 1. Put the script under the root folder of sitecore site
# 2. Open the powershell, and run the script with search provider name
# For example:  .\switch-search.ps1 azure or  .\switch-search.ps1 solr

Param([string]$searchProvider)

Write-Output "Switch search provider to $($searchProvider)."

If ($searchProvider -eq 'azure'){
    Get-ChildItem -Path .\App_Config\Include\ -Include *solr*.config -Recurse | Rename-Item -NewName {$_.name -Replace '\.config$', '.config.disabled'}
    Get-ChildItem -Path .\App_Config\Include\ -Include *lucene*.config -Recurse | Rename-Item -NewName {$_.name -Replace '\.config$', '.config.disabled'}

    Get-ChildItem -Path .\App_Config\Include\ -Include *azure*.config.* -Recurse | Rename-Item -NewName {$_.name -Replace '\.config\..*$', '.config'}
}

If($searchProvider -eq 'solr'){
    Get-ChildItem -Path .\App_Config\Include\ -Include *solr*.config.* -Recurse | Rename-Item -NewName { $_.name -Replace '\.config\..*$', '.config' }

    Get-ChildItem -Path .\App_Config\Include\ -Include *lucene*.config -Recurse | Rename-Item -NewName { $_.name -Replace '\.config$', '.config.disabled' }
    Get-ChildItem -Path .\App_Config\Include\ -Include *azure*.config -Recurse | Rename-Item -NewName { $_.name -Replace '\.config$', '.config.disabled' }
}

If($searchProvider -eq 'lucene'){
    Get-ChildItem -Path .\App_Config\Include\ -Include *solr*.config -Recurse | Rename-Item -NewName {$_.name -Replace '\.config$', '.config.disabled'}

    Get-ChildItem -Path .\App_Config\Include\ -Include *lucene*.config.* -Recurse | Rename-Item -NewName {$_.name -Replace '\.config\..*$', '.config'}

    Get-ChildItem -Path .\App_Config\Include\ -Include *azure*.config -Recurse | Rename-Item -NewName {$_.name -Replace '\.config$', '.config.disabled'}
}
