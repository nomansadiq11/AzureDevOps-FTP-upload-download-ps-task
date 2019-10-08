
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
            # $makeDirectory.UseBinary = $true
            $makeDirectory.UsePassive = $false
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


    try {

        $uri = New-Object System.Uri($ftp_uri+$relpath)
        # $webclient.UploadFile($uri, $item.FullName)

        $makefile = [System.Net.WebRequest]::UploadFile($uri, $item.FullName);
        $makefile.Credentials = New-Object System.Net.NetworkCredential($user,$pass);
        $makefile.Method = [System.Net.WebRequestMethods+FTP]::UploadFile;
        $makefile.UsePassive = $false; 
        $makefile.GetResponse();
        $makefile.Dispose(); 
        
    }
    catch  {
        Write-Host $item.Name "error creating" $_.Exception.Message
        break;
    }

    

    


    # $webclient = New-Object System.Net.WebClient
    # Write-Host "created new object"
    # $webclient.Credentials = New-Object System.Net.NetworkCredential($user,$pass)
    # Write-Host "added credentials"
    # $uri = New-Object System.Uri($ftp_uri+$relpath)
    # Write-Host "new url"
    # $webclient.UsePassive = $false
    # $webclient.UploadFile($uri, $item.FullName)
    # Write-Host "upl0ad done file "
    # $webclient.Dispose()
    # Write-Host "close connection"

    # Write-Host "2 sec wait start"
    # Start-Sleep -Seconds 2
    # Write-Host "2 sec wait end"


    
    
}