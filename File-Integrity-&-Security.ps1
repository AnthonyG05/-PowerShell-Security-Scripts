# A:
function Compute_FileHash  {
    #Reads users Input.
    $filePath = Read-Host "please input your file"

    #Takes the file and gets the Files hash.
    $fileHash = (Get-FileHash -Path $filePath -Algorithm SHA256).Hash
    
    #Sends the hash to a file.
    $fileHash | 
        Out-File -FilePath "\outPut\" -Append 
    
}


# B:
function copiesAndModify {
    #Copies the files and for one of them it changes the name.
    Copy-Item -Path "\wordlist.txt\" -Destination "\wordlistVersion2.txt\"
    Copy-Item -Path "\wordlist.txt\" -Destination "\wordlistVersion2.txt\"
    #Adds a line of text to copy wordlist.txt.
    $fileTextChanger = "Hi how are you my friend!"
    
    #Sends the hash to a file.
    $fileTextChanger | 
        Out-File -FilePath "\wordlist.txt\" -Encoding utf8
}


# C:
function Verify_FileIntegrity {

    #Inputs the files.
    $copiedFiles1 = Get-ChildItem -Path "\wordlistVersion2.txt\"
    $copiedFiles2 = Get-ChildItem -Path "\wordlist.txt\"
    $originalCopy = Get-Content -Path "\outPut\"
    
    #Makes a array of the copied files to get the hash of the file
    $copiedFileArray = @($copiedFiles1, $copiedFiles2)
    
    #This for loop takes the hash of the copied files.
    foreach($copied in $copiedFileArray){
        $fileHashCopiedFile = (Get-FileHash -Path $copied.FullName -Algorithm SHA256).Hash
        
        #This if statement checks if the hash of the copied files match the original files hash.
        if ($fileHashCopiedFile -eq $originalCopy ) {
            Write-Host "$($copied.Name) The files hash is the same as the original files hash"
        }else {
            Write-Host "$($copied.Name) The files hash is not the same as the original files hash"
        }

    }
}


Compute_FileHash
copiesAndModify
Verify_FileIntegrity
