param(
    [ValidateSet('TW','CN','JP','EN')]
    [string]$Language = 'TW',
    [string]$InputListFile,
    [string[]]$Inputs
)

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false

$I18N = @{
    EN = @{
        FileNotFound = 'File not found: "{0}"'
        ScanningFolder = 'Scanning folder: "{0}"'
        FfmpegMissing = '[ERROR] ffmpeg not found: "{0}"'
        FfprobeMissing = '[ERROR] ffprobe not found: "{0}"'
        NoDragInput = 'No drag input detected. Auto-processing media files next to script.'
        Usage = 'Usage:'
        Usage1 = '  1. Put ffmpeg.exe and ffprobe.exe next to this script'
        Usage2 = '  2. Drag files and/or folders onto {0}'
        Usage3 = '  3. Exports all audio + subtitle streams'
        Processing = 'Processing: "{0}"'
        UnsupportedMedia = 'Not a supported media file: "{0}"'
        SubtitleProbeFailed = 'ffprobe subtitle probe failed; continue without subtitle streams.'
        NoStreams = 'No audio/subtitle stream found.'
        AudioStream = 'Audio stream #{0} codec={1} lang={2} title={3}'
        SubtitleStream = 'Subtitle stream #{0} codec={1} lang={2} title={3}'
        ExportAudioFailed = 'Could not export audio stream #{0}'
        ExportSubtitleFailed = 'Could not export subtitle stream #{0}'
        DirectSubtitleFailed = 'Direct export failed for subtitle #{0}, trying ASS conversion...'
        NoExported = 'No stream was exported.'
        ExportedTracks = 'Exported tracks: {0}'
        ProcessedAac = 'Processed AAC: {0}'
        ProcessedSub = 'Processed SUB: {0}'
        Done = 'Done'
    }
    TW = @{
        FileNotFound = '找不到檔案: "{0}"'
        ScanningFolder = '正在掃描資料夾: "{0}"'
        FfmpegMissing = '[ERROR] 找不到 ffmpeg: "{0}"'
        FfprobeMissing = '[ERROR] 找不到 ffprobe: "{0}"'
        NoDragInput = '未偵測到拖曳輸入，將自動處理腳本旁的媒體檔。'
        Usage = '使用方式:'
        Usage1 = '  1. 將 ffmpeg.exe 與 ffprobe.exe 放在此腳本旁'
        Usage2 = '  2. 將檔案與/或資料夾拖曳到 {0}'
        Usage3 = '  3. 匯出所有音訊與字幕串流'
        Processing = '處理中: "{0}"'
        UnsupportedMedia = '非支援的媒體檔: "{0}"'
        SubtitleProbeFailed = 'ffprobe 偵測字幕失敗；將略過字幕並繼續。'
        NoStreams = '找不到音訊/字幕串流。'
        AudioStream = '音訊串流 #{0} codec={1} lang={2} title={3}'
        SubtitleStream = '字幕串流 #{0} codec={1} lang={2} title={3}'
        ExportAudioFailed = '無法匯出音訊串流 #{0}'
        ExportSubtitleFailed = '無法匯出字幕串流 #{0}'
        DirectSubtitleFailed = '字幕 #{0} 直接匯出失敗，嘗試轉為 ASS...'
        NoExported = '沒有任何串流被匯出。'
        ExportedTracks = '已匯出軌道數: {0}'
        ProcessedAac = '已處理AAC: {0}'
        ProcessedSub = '已處理SUB: {0}'
        Done = '完成'
    }
    CN = @{
        FileNotFound = '找不到文件: "{0}"'
        ScanningFolder = '正在扫描文件夹: "{0}"'
        FfmpegMissing = '[ERROR] 找不到 ffmpeg: "{0}"'
        FfprobeMissing = '[ERROR] 找不到 ffprobe: "{0}"'
        NoDragInput = '未检测到拖拽输入，将自动处理脚本同目录媒体文件。'
        Usage = '使用方法:'
        Usage1 = '  1. 将 ffmpeg.exe 和 ffprobe.exe 放在此脚本旁'
        Usage2 = '  2. 将文件和/或文件夹拖到 {0}'
        Usage3 = '  3. 导出全部音频与字幕流'
        Processing = '处理中: "{0}"'
        UnsupportedMedia = '不支持的媒体文件: "{0}"'
        SubtitleProbeFailed = 'ffprobe 字幕探测失败；将跳过字幕并继续。'
        NoStreams = '未找到音频/字幕流。'
        AudioStream = '音频流 #{0} codec={1} lang={2} title={3}'
        SubtitleStream = '字幕流 #{0} codec={1} lang={2} title={3}'
        ExportAudioFailed = '无法导出音频流 #{0}'
        ExportSubtitleFailed = '无法导出字幕流 #{0}'
        DirectSubtitleFailed = '字幕 #{0} 直接导出失败，尝试转 ASS...'
        NoExported = '没有任何流被导出。'
        ExportedTracks = '已导出轨道数: {0}'
        ProcessedAac = '已处理AAC: {0}'
        ProcessedSub = '已处理SUB: {0}'
        Done = '完成'
    }
    JP = @{
        FileNotFound = 'ファイルが見つかりません: "{0}"'
        ScanningFolder = 'フォルダーをスキャン中: "{0}"'
        FfmpegMissing = '[ERROR] ffmpeg が見つかりません: "{0}"'
        FfprobeMissing = '[ERROR] ffprobe が見つかりません: "{0}"'
        NoDragInput = 'ドラッグ入力がないため、スクリプト横のメディアを自動処理します。'
        Usage = '使い方:'
        Usage1 = '  1. ffmpeg.exe と ffprobe.exe をこのスクリプトと同じ場所に置く'
        Usage2 = '  2. ファイル/フォルダーを {0} にドラッグ&ドロップ'
        Usage3 = '  3. すべての音声/字幕ストリームを抽出'
        Processing = '処理中: "{0}"'
        UnsupportedMedia = '非対応のメディアファイルです: "{0}"'
        SubtitleProbeFailed = 'ffprobe の字幕検出に失敗。字幕なしで続行します。'
        NoStreams = '音声/字幕ストリームが見つかりません。'
        AudioStream = '音声ストリーム #{0} codec={1} lang={2} title={3}'
        SubtitleStream = '字幕ストリーム #{0} codec={1} lang={2} title={3}'
        ExportAudioFailed = '音声ストリーム #{0} の抽出に失敗しました'
        ExportSubtitleFailed = '字幕ストリーム #{0} の抽出に失敗しました'
        DirectSubtitleFailed = '字幕 #{0} の直接抽出に失敗。ASS 変換を試行します...'
        NoExported = '抽出できたストリームはありません。'
        ExportedTracks = '抽出トラック数: {0}'
        ProcessedAac = '処理したAAC: {0}'
        ProcessedSub = '処理したSUB: {0}'
        Done = '完了'
    }
}

function T(
    [string]$key,
    [Parameter(ValueFromRemainingArguments = $true)]
    [object[]]$fmtValues
) {
    if (-not $I18N.ContainsKey($Language)) { $Language = 'EN' }
    $template = $I18N[$Language][$key]
    if ($null -eq $template) { return $key }
    if ($null -eq $fmtValues -or $fmtValues.Count -eq 0) { return $template }
    $fmtArgs = $fmtValues
    if ($fmtValues.Count -eq 1 -and $fmtValues[0] -is [System.Array]) {
        $fmtArgs = $fmtValues[0]
    }
    return [string]::Format($template, $fmtArgs)
}

function Write-Info($msg) { Write-Host "[INFO] $msg" }
function Write-WarnMsg($msg) { Write-Host "[WARN] $msg" }
function Write-Fail($msg) { Write-Host "[FAIL] $msg" }
function Write-Skip($msg) { Write-Host "[SKIP] $msg" }

function Invoke-Tool([string]$exe, [string[]]$toolArgs) {
    $stdoutFile = [System.IO.Path]::GetTempFileName()
    $stderrFile = [System.IO.Path]::GetTempFileName()
    try {
        $quotedArgs = @()
        foreach ($a in $toolArgs) {
            if ($null -eq $a) {
                $quotedArgs += '""'
            } else {
                $q = [string]$a
                $q = $q -replace '(\\*)"', '$1$1\"'
                $quotedArgs += '"' + $q + '"'
            }
        }
        $argString = $quotedArgs -join ' '
        $p = Start-Process -FilePath $exe -ArgumentList $argString -NoNewWindow -Wait -PassThru -RedirectStandardOutput $stdoutFile -RedirectStandardError $stderrFile
        $stdout = Get-Content -LiteralPath $stdoutFile -Raw -ErrorAction SilentlyContinue
        $stderr = Get-Content -LiteralPath $stderrFile -Raw -ErrorAction SilentlyContinue
        return [PSCustomObject]@{
            ExitCode = $p.ExitCode
            StdOut = $stdout
            StdErr = $stderr
        }
    } finally {
        Remove-Item -LiteralPath $stdoutFile -ErrorAction SilentlyContinue
        Remove-Item -LiteralPath $stderrFile -ErrorAction SilentlyContinue
    }
}

function Sanitize-Label([string]$s, [string]$fallback) {
    if ([string]::IsNullOrWhiteSpace($s)) { $s = $fallback }
    $s = $s -replace '[\\/:*?"<>|]', '_'
    $s = $s -replace '\s+', '_'
    $s = $s.Trim('_')
    if ([string]::IsNullOrWhiteSpace($s)) { $s = $fallback }
    return $s
}

function Get-MediaFiles([string[]]$items) {
    $result = New-Object System.Collections.Generic.List[string]
    foreach ($item in $items) {
        if (-not (Test-Path -LiteralPath $item)) {
            Write-Skip (T 'FileNotFound' $item)
            continue
        }
        $resolved = (Resolve-Path -LiteralPath $item).Path
        $attr = Get-Item -LiteralPath $resolved
        if ($attr.PSIsContainer) {
            Write-Info (T 'ScanningFolder' $resolved)
            Get-ChildItem -LiteralPath $resolved -Recurse -File | ForEach-Object {
                $result.Add($_.FullName)
            }
        } else {
            $result.Add($resolved)
        }
    }
    return $result
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ffmpeg = Join-Path $scriptDir 'ffmpeg.exe'
$ffprobe = Join-Path $scriptDir 'ffprobe.exe'

if (-not (Test-Path -LiteralPath $ffmpeg)) { Write-Host (T 'FfmpegMissing' $ffmpeg); exit 1 }
if (-not (Test-Path -LiteralPath $ffprobe)) { Write-Host (T 'FfprobeMissing' $ffprobe); exit 1 }

$inputItems = New-Object System.Collections.Generic.List[string]
if ($InputListFile -and (Test-Path -LiteralPath $InputListFile)) {
    Get-Content -LiteralPath $InputListFile | ForEach-Object {
        if (-not [string]::IsNullOrWhiteSpace($_)) {
            $line = $_.Trim()
            if ($line.StartsWith('"') -and $line.EndsWith('"') -and $line.Length -ge 2) {
                $line = $line.Substring(1, $line.Length - 2)
            }
            $inputItems.Add($line)
        }
    }
}
if ($Inputs) {
    foreach ($i in $Inputs) {
        if (-not [string]::IsNullOrWhiteSpace($i)) { $inputItems.Add($i) }
    }
}

if ($inputItems.Count -eq 0) {
    $autoMedia = Get-ChildItem -LiteralPath $scriptDir -File | Where-Object {
        $_.Extension -match '^\.(mkv|mp4|avi|mov|m4v|ts|m2ts|wmv|flv|webm)$'
    } | Select-Object -ExpandProperty FullName

    if ($autoMedia -and $autoMedia.Count -gt 0) {
        Write-Info (T 'NoDragInput')
        foreach ($m in $autoMedia) { $inputItems.Add($m) }
    } else {
        Write-Host (T 'Usage')
        Write-Host (T 'Usage1')
        Write-Host (T 'Usage2' "bm-extract-aac-sub_$Language.bat")
        Write-Host (T 'Usage3')
        exit 1
    }
}

$mediaFiles = Get-MediaFiles -items @($inputItems)
$totalAacExported = 0
$totalSubExported = 0

foreach ($input in $mediaFiles) {
    Write-Host '========================================'
    Write-Host (T 'Processing' $input)

    $base = [System.IO.Path]::Combine(
        [System.IO.Path]::GetDirectoryName($input),
        [System.IO.Path]::GetFileNameWithoutExtension($input)
    )

    $audioProbe = Invoke-Tool -exe $ffprobe -toolArgs @('-v','error','-select_streams','a','-show_entries','stream=index,codec_name:stream_tags=language,title','-of','json',$input)
    if ($audioProbe.ExitCode -ne 0) {
        Write-Skip (T 'UnsupportedMedia' $input)
        if (-not [string]::IsNullOrWhiteSpace($audioProbe.StdErr)) {
            Write-WarnMsg ('ffprobe: ' + $audioProbe.StdErr.Trim())
        }
        Write-Host ''
        continue
    }
    $audioJson = $audioProbe.StdOut

    $subJson = & $ffprobe -v error -select_streams s -show_entries 'stream=index,codec_name:stream_tags=language,title' -of json "$input" 2>&1 | Out-String
    $subExit = $LASTEXITCODE
    if ($subExit -ne 0) {
        Write-WarnMsg (T 'SubtitleProbeFailed')
        if (-not [string]::IsNullOrWhiteSpace($subJson)) {
            Write-WarnMsg ('ffprobe: ' + $subJson.Trim())
        }
        $subJson = '{"streams":[]}'
    }

    $audioStreams = @()
    $subStreams = @()
    try { $audioStreams = ((ConvertFrom-Json $audioJson).streams) } catch { $audioStreams = @() }
    try { $subStreams = ((ConvertFrom-Json $subJson).streams) } catch { $subStreams = @() }

    if ((@($audioStreams).Count + @($subStreams).Count) -eq 0) {
        Write-Info (T 'NoStreams')
        Write-Host ''
        continue
    }

    $exportedThisFile = 0

    foreach ($s in @($audioStreams)) {
        $idx = [string]$s.index
        $codec = [string]$s.codec_name
        $langCode = [string]$s.tags.language
        $title = [string]$s.tags.title
        Write-Info (T 'AudioStream' $idx,$codec,$langCode,$title)

        $label = Sanitize-Label -s $(if ($title) { $title } elseif ($langCode) { $langCode } else { "track$idx" }) -fallback "track$idx"
        $out = "$base.audio.$label.aac"
        Write-Host "[EXPORT] -> `"$out`""
        $audioExport = Invoke-Tool -exe $ffmpeg -toolArgs @('-hide_banner','-loglevel','error','-y','-i',$input,'-map',"0:$idx",'-c:a','aac','-b:a','192k',$out)
        if ($audioExport.ExitCode -eq 0) {
            $exportedThisFile++
            $totalAacExported++
        } else {
            Write-Fail (T 'ExportAudioFailed' $idx)
            if (-not [string]::IsNullOrWhiteSpace($audioExport.StdErr)) {
                Write-WarnMsg ('ffmpeg: ' + $audioExport.StdErr.Trim())
            }
        }
    }

    foreach ($s in @($subStreams)) {
        $idx = [string]$s.index
        $codec = [string]$s.codec_name
        $langCode = [string]$s.tags.language
        $title = [string]$s.tags.title
        Write-Info (T 'SubtitleStream' $idx,$codec,$langCode,$title)

        $label = Sanitize-Label -s $(if ($title) { $title } elseif ($langCode) { $langCode } else { "track$idx" }) -fallback "track$idx"
        $ext = switch ($codec.ToLower()) {
            'ass' { 'ass' }
            'ssa' { 'ssa' }
            'subrip' { 'srt' }
            'webvtt' { 'vtt' }
            'mov_text' { 'srt' }
            'hdmv_pgs_subtitle' { 'sup' }
            'dvb_subtitle' { 'sup' }
            'dvd_subtitle' { 'sub' }
            default { if ([string]::IsNullOrWhiteSpace($codec)) { 'sub' } else { $codec } }
        }

        $out = "$base.sub.$label.$ext"
        Write-Host "[EXPORT] -> `"$out`""
        if ($codec -and $codec.ToLower() -eq 'mov_text') {
            & $ffmpeg -hide_banner -loglevel error -y -i "$input" -map "0:$idx" -c:s srt "$out" 2>&1 | Out-Null
            $subExport = [PSCustomObject]@{ ExitCode = $LASTEXITCODE; StdErr = '' }
        } else {
            & $ffmpeg -hide_banner -loglevel error -y -i "$input" -map "0:$idx" -c copy "$out" 2>&1 | Out-Null
            $subExport = [PSCustomObject]@{ ExitCode = $LASTEXITCODE; StdErr = '' }
        }

        if ($subExport.ExitCode -ne 0) {
            $outAss = "$base.sub.$label.ass"
            Write-WarnMsg (T 'DirectSubtitleFailed' $idx)
            & $ffmpeg -hide_banner -loglevel error -y -i "$input" -map "0:$idx" -c:s ass "$outAss" 2>&1 | Out-Null
            $subExport = [PSCustomObject]@{ ExitCode = $LASTEXITCODE; StdErr = '' }
        }

        if ($subExport.ExitCode -eq 0) {
            $exportedThisFile++
            $totalSubExported++
        } else {
            Write-Fail (T 'ExportSubtitleFailed' $idx)
        }
    }

    if ($exportedThisFile -eq 0) {
        Write-Info (T 'NoExported')
    }
}

Write-Host '========================================'
Write-Host (T 'ProcessedAac' $totalAacExported)
Write-Host (T 'ProcessedSub' $totalSubExported)
Write-Host (T 'Done')
