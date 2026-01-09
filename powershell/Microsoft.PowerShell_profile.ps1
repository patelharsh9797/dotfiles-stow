$ENV:STARSHIP_CONFIG = "$HOME\AppData\Local\starship\starship.toml"

Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Import-Module Terminal-Icons


#Invoke-Expression (&mcfly init powershell)
Invoke-Expression -Command $(mcfly init powershell | out-string)
#$env:MCFLY_RESULTS = "50"
#$env:MCFLY_FUZZY = "true"
#$env:MCFLY_LIGHT = "FALSE"
#$env:MCFLY_KEY_SCHEME="vim"


#Set-PSReadLineOption -PredictionSource History
#Set-PSReadLineOption -PredictionViewStyle ListView
#Set-PSReadLineOption -ShowToolTips
#Set-PSReadLineOption -BellStyle None
#Set-PSReadLineKeyHandler -Key Ctrl+r -Function ReverseSearchHistory
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -Colors @{
  Command            = 'Cyan'
  Parameter          = 'Gray'
  Operator           = 'DarkGray'
  Variable           = 'Green'
  String             = 'Yellow'
  InlinePrediction   = 'DarkGray'
}


Set-Alias cl clear
Set-Alias ll ls
Set-Alias grep findstr


function goto_wsl { set-location \\wsl.localhost\Ubuntu\home\harsh\ }
New-Alias WSL_DIR goto_wsl

function cnvim { cd C:\Users\Harsh\AppData\Local\nvim && nvim . }
function venvAct { .\.venv\Scripts\activate }
function envAct { .\env\Scripts\activate }
function seminal_venv { cd C:\Users\Harsh\Desktop\seminal\data-scraping\ && .\.venv\Scripts\activate }

function winget_up { winget upgrade --all -u }
function scoop_up { scoop update -a }

function yt_dlp_update { yt-dlp -U }
function yt_dlp_mp3_best {
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        $Args
    )
    yt-dlp -x --audio-format mp3 --audio-quality 0 @Args
}

function yt_dlp_video_1080 {
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        $Args
    )
    yt-dlp -S "res:1080,fps" @Args
}


# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
