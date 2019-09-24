

$source = "G:\Documents\Website\Tiles\"
$destination = "ftp://nomansadiq.pk:21"



# create the FtpWebRequest and configure it

$files = get-childitem $source -recurse -force
foreach ($file in $files)
{
    
    $ftp = [System.Net.FtpWebRequest]::Create("ftp://nomansadiq.pk:21/" + $file.FullName)
    $ftp = [System.Net.FtpWebRequest]$ftp
    $ftp.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
    $ftp.Credentials = new-object System.Net.NetworkCredential("tiles","dohbxlZqpwta:gm5cuvn")

     Write-Host "open connection success"

    $ftp.UseBinary = $true
    $ftp.UsePassive = $true
    # read in the file to upload as a byte array

    Write-Host "file path" + $file.FullName

    $content = [System.IO.File]::ReadAllBytes($file.FullName)
    $ftp.ContentLength = $content.Length
    # get the request stream, and write the bytes into it
    $rs = $ftp.GetRequestStream()
    $rs.Write($content, 0, $content.Length)
    # be sure to clean up after ourselves
    $rs.Close()
    $rs.Dispose()
    
    Write-Host "connection closed"
}



$ftp = [System.Net.FtpWebRequest]::Create("ftp://nomansadiq.pk:21/fromftp.zip")
$ftp = [System.Net.FtpWebRequest]$ftp
$ftp.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
$ftp.Credentials = new-object System.Net.NetworkCredential("tiles","dohbxlZqpwta:gm5cuvn")
$ftp.UseBinary = $true
$ftp.UsePassive = $true
# read in the file to upload as a byte array
$content = [System.IO.File]::ReadAllBytes("G:\Documents\Website\Tiles\fromftp.zip")
$ftp.ContentLength = $content.Length
# get the request stream, and write the bytes into it
$rs = $ftp.GetRequestStream()
$rs.Write($content, 0, $content.Length)
# be sure to clean up after ourselves
$rs.Close()
$rs.Dispose()



$source = "G:\Documents\Website\Tiles"
$destination = "ftp://nomansadiq.pk:21"
$username = "tiles"
$password = "dohbxlZqpwta:gm5cuvn"
# $cred = Get-Credential
$wc = New-Object System.Net.WebClient
$wc.Credentials = New-Object System.Net.NetworkCredential($username, $password)

$files = get-childitem $source -recurse -force
foreach ($file in $files)
{
    $localfile = $file.fullname
    $wc.UploadFile($destination/$file, $file.FullName)
}

$wc.Dispose()





$source = "G:\Documents\Website\Tiles"
$destination = "ftp://nomansadiq.pk:21/"

$webclient = New-Object -TypeName System.Net.WebClient
$webclient.Credentials = New-Object System.Net.NetworkCredential($username, $password)

$files = Get-ChildItem $source

foreach ($file in $files)
{
    Write-Host "Uploading $file"
    $webclient.UploadFile("$destination/$file", $file.FullName)
} 

$webclient.Dispose()