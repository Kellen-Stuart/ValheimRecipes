function Get-ValheimRecipe
{
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name
    )

    $recipeDirectory = "$PSScriptRoot\Recipes"
    $recipeJsonFiles = Get-ChildItem $recipeDirectory -Recurse -File

    foreach($recipeJsonFile in $recipeJsonFiles)
    {
        $recipeName = Get-RecipeName $recipeJsonFile
        if($recipeName.ToLower().Trim().Contains($Name.ToLower().Trim()))
        {
            $recipeObject = Get-Content $recipeJsonFile.FullName | Out-String | ConvertFrom-Json
            Write-Host ($recipeObject | Format-Table | Out-String)
        }
    }

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