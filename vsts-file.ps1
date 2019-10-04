
$ftp_uri = "ftp://nomansadiq.pk/"
$user = "tiles"
$pass = "dohbxlZqpwta:gm5cuvn"


$path= $env:hellopakistan





 foreach($item in Get-ChildItem -recurse $path)
{
    

    $relpath =    [system.io.path]::GetFullPath($item.FullName).SubString([system.io.path]::GetFullPath($path).Length + 1 )

    Write-Host $relpath

    if ($item.Attributes -eq "Directory")
    {
        try
        {
            Write-Host Creating $item.Name
            $makeDirectory = [System.Net.WebRequest]::Create($ftp_uri+$relpath);
            $makeDirectory.Credentials = New-Object System.Net.NetworkCredential($user,$pass)
            $makeDirectory.Method = [System.Net.WebRequestMethods+FTP]::MakeDirectory;
            # $makeDirectory.UsePassive = $true;
            $makeDirectory.UseBinary = $true
            $makeDirectory.UsePassive = $true
            $makeDirectory.GetResponse();
        }
        catch [Net.WebException]
        {
            Write-Host $item.Name Directory may be already exists.
        }
        continue;
    }
    "Uploading $item to :  $relpath"

    "ftp url :  $ftp_uri + $relpath"


    $webclient = New-Object System.Net.WebClient
    Write-Host "created new object"
    $webclient.Credentials = New-Object System.Net.NetworkCredential($user,$pass)
    Write-Host "added credentials"
    $uri = New-Object System.Uri($ftp_uri+$relpath)
    Write-Host "new url"
    $webclient.UploadFile($uri, $item.FullName)
    Write-Host "upl0ad done file "

    
    
}