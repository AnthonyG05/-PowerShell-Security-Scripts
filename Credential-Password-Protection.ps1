function Encrypt_password {
   for ($i = 1; $i -le 10; $i++) 
    {
        $PlaintextPassword = Read-Host "Pleas enter 10 different passwords" -AsSecureString

        $encryptedPassword = ConvertFrom-SecureString $PlaintextPassword -Key (1..16)
        
        $encryptedPassword |   
            Out-File -FilePath "\encryptPW.txt\" -Append
    }
    
}
Encrypt_password

# B:
function Decrypt_password {

    $encryptedPassword = Get-Content "\encryptPW.txt\"
    foreach ($EncryPass in $encryptedPassword)
    {   
        $decryptedPassword = ConvertTo-SecureString $EncryPass -Key(1..16)
        
        #this was the only way i could get this to work -AsPlainText does not work for me when converting from encrypted --> plaintext
        $BSTR = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($decryptedPassword)
        $decryptedPlainText = [Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    
    Write-Host $decryptedPlainText
    }
    
}
Decrypt_password
