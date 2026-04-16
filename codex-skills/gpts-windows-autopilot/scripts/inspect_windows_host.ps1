param(
  [Parameter(Mandatory = $true)]
  [string]$ProjectRoot
)

$ErrorActionPreference = "Stop"

function Get-CmdResult {
  param(
    [string]$FilePath,
    [string[]]$ArgumentList
  )

  try {
    $output = & $FilePath @ArgumentList 2>&1
    return @{
      ok = $true
      output = ($output | Out-String).Trim()
    }
  } catch {
    return @{
      ok = $false
      output = ($_ | Out-String).Trim()
    }
  }
}

function Get-FirstOpenApiUrl {
  param([string]$Path)
  if (-not (Test-Path $Path)) { return $null }
  foreach ($line in Get-Content -Path $Path -Encoding UTF8) {
    $trimmed = $line.Trim()
    if ($trimmed -like "- url:*") {
      return ($trimmed -split ":\s*", 2)[1]
    }
  }
  return $null
}

function Get-EnvMap {
  param([string]$Path)
  $map = @{}
  if (-not (Test-Path $Path)) { return $map }
  foreach ($line in Get-Content -Path $Path -Encoding UTF8) {
    if ([string]::IsNullOrWhiteSpace($line)) { continue }
    if ($line.TrimStart().StartsWith("#")) { continue }
    if ($line -notmatch "=") { continue }
    $pair = $line -split "=", 2
    $map[$pair[0].Trim()] = $pair[1].Trim()
  }
  return $map
}

$branchRoot = $ProjectRoot
if (-not (Test-Path (Join-Path $branchRoot ".env.example"))) {
  $candidate = Join-Path $ProjectRoot "Версия для Виндовс"
  if (Test-Path (Join-Path $candidate ".env.example")) {
    $branchRoot = $candidate
  } else {
    throw "Could not find Windows branch root with .env.example"
  }
}

$important = @(
  ".env.example",
  ".env",
  "openapi.gpts.yaml",
  "gpts\system_instructions.txt",
  "Запустить GPTS Agent.bat",
  "gpts_agent_control.py"
)

$files = @{}
foreach ($relative in $important) {
  $full = Join-Path $branchRoot $relative
  $files[$relative] = @{
    exists = (Test-Path $full)
    path = $full
  }
}

$envPath = Join-Path $branchRoot ".env"
$openapiPath = Join-Path $branchRoot "openapi.gpts.yaml"
$knowledgeRoot = Join-Path $branchRoot "gpts\knowledge"
$envMap = Get-EnvMap -Path $envPath
$knowledgeFiles = @()
if (Test-Path $knowledgeRoot) {
  $knowledgeFiles = Get-ChildItem -Path $knowledgeRoot -Recurse -Filter *.md | ForEach-Object { $_.FullName }
}

$workspaceRoots = ""
if ($envMap.ContainsKey("WORKSPACE_ROOTS")) {
  $workspaceRoots = $envMap["WORKSPACE_ROOTS"]
}
$firstWorkspaceRoot = ""
if ($workspaceRoots) {
  $firstWorkspaceRoot = ($workspaceRoots -split ";")[0]
}

$result = [ordered]@{
  host_platform = "windows"
  branch_root = $branchRoot
  important_files = $files
  env = @{
    exists = (Test-Path $envPath)
    agent_token_present = [bool]$envMap["AGENT_TOKEN"]
    ngrok_domain = $envMap["NGROK_DOMAIN"]
    workspace_roots = $workspaceRoots
    first_workspace_root = $firstWorkspaceRoot
    first_workspace_root_matches_branch = ($firstWorkspaceRoot -eq $branchRoot)
  }
  openapi = @{
    path = $openapiPath
    server_url = (Get-FirstOpenApiUrl -Path $openapiPath)
  }
  knowledge = @{
    root = $knowledgeRoot
    count = $knowledgeFiles.Count
    files = $knowledgeFiles
  }
  commands = @{
    py_3_13 = (Get-CmdResult -FilePath "py" -ArgumentList @("-3.13", "--version"))
    python = (Get-CmdResult -FilePath "python" -ArgumentList @("--version"))
    ngrok = (Get-CmdResult -FilePath "ngrok" -ArgumentList @("version"))
  }
}

$result | ConvertTo-Json -Depth 6
