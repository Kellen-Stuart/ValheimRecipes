function Get-ValheimRecipe
{
    param(
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$Name,
        [string]$Contains
    )

    $recipeDirectory = "$PSScriptRoot\Recipes"
    $recipeJsonFiles = Get-ChildItem $recipeDirectory -Recurse -File

    if(-not [string]::IsNullOrWhiteSpace($Name))
    {
        Get-RecipeByName -Name $Name
    }
    
    if(-not [string]::IsNullOrWhiteSpace($Contains))
    {
        throw "Contains is not currently supported"
        Get-RecipeContains $Contains
    }
}

function Get-RecipeByName
{
    [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]$Name

    foreach($recipeJsonFile in $recipeJsonFiles)
    {
        $recipeName = Get-ValheimRecipeName $recipeJsonFile
        if($recipeName.ToLower().Trim().Contains($Name.ToLower().Trim()))
        {
            $recipeObject = Get-Content $recipeJsonFile.FullName | Out-String | ConvertFrom-Json
            Write-Host ($recipeObject | Format-Table | Out-String)
        }
    }
}

function Get-RecipeContains
{
    [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty]$Contains
}

function Get-ValheimRecipeName
{
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $FileName
    )
    return $FileName.Substring(0, $FileName.IndexOf('.'))
}