# A:
function EncodeToBase64 {

    $PlainText = Get-Content "\wordList.txt\" -Raw
    
    $encoding = [System.Text.Encoding]::Unicode.GetBytes( $PlainText)
    $EncodedString = [System.Convert]::ToBase64String($encoding)
    
    $EncodedString |
        Out-File -FilePath "\Outputs\" 
    
}
EncodeToBase64

# B:
function DecodeFromBase64  {
        $original = Get-Content "\wordList.txt\" -Raw
        $EncodedString = Get-Content "\Outputs\" -Raw
        
        $decoded = [System.Convert]::FromBase64String($EncodedString)
        $DecodedPlainText = [System.Text.Encoding]::Unicode.GetString($decoded)
        
        Write-Host $DecodedPlainText
        
        if($DecodedPlainText -eq $original) {
            Write-Host "Decoded words are the same as the original"
        } 
        else {
            Write-Host "Decoded words are not the same as the original"
        }
    
}
DecodeFromBase64
