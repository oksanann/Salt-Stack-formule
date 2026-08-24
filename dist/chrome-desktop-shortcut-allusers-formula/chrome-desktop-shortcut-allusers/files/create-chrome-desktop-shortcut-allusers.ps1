param(
  [Parameter(Mandatory=$true)][string]$LnkPath,
  [Parameter(Mandatory=$true)][string]$ChromeExeX64,
  [Parameter(Mandatory=$true)][string]$ChromeExeX86,
  [Parameter(Mandatory=$false)][string]$ChromeExeCustom = ''
)

$target = $null

if ($ChromeExeCustom -and (Test-Path -LiteralPath $ChromeExeCustom)) {
  $target = $ChromeExeCustom
}
elseif (Test-Path -LiteralPath $ChromeExeX64) {
  $target = $ChromeExeX64
}
elseif (Test-Path -LiteralPath $ChromeExeX86) {
  $target = $ChromeExeX86
}
else {
  Write-Output "Chrome executable not found. Skipping shortcut creation: $LnkPath"
  exit 0
}

$lnkDir = Split-Path -Parent $LnkPath
if ($lnkDir -and -not (Test-Path -LiteralPath $lnkDir)) {
  New-Item -ItemType Directory -Path $lnkDir -Force | Out-Null
}

# Create/update shortcut via COM
$wsh = New-Object -ComObject WScript.Shell
$shortcut = $wsh.CreateShortcut($LnkPath)
$shortcut.TargetPath = $target
$shortcut.WorkingDirectory = (Split-Path -Parent $target)
$shortcut.IconLocation = $target
$shortcut.Description = "Google Chrome"
$shortcut.Save()

Write-Output "Shortcut created/updated: $LnkPath -> $target"

