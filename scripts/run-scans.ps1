<#
.SYNOPSIS
    Aegis Shield - Unified Security Scan Suite
.DESCRIPTION
    Executes dependency scanning (pip-audit, npm audit), secret scanning (gitleaks),
    and dynamic application security testing (OWASP ZAP via Docker).
    Consolidates reports into the ./reports directory.
#>

$ErrorActionPreference = "Continue";
$RootDir = Split-Path -Parent $PSScriptRoot;
$ReportsDir = "$RootDir\reports";
$SampleAppDir = "$RootDir\sample-app";

if (-not (Test-Path $ReportsDir)) {
    New-Item -ItemType Directory -Path $ReportsDir -Force | Out-Null;
}

Write-Host "`n=======================================================" -ForegroundColor Cyan;
Write-Host "   AEGIS SHIELD: AUTOMATED SECURITY TOOLING SUITE       " -ForegroundColor Cyan;
Write-Host "=======================================================`n" -ForegroundColor Cyan;

# -------------------------------------------------------------
# 1. PYTHON DEPENDENCY SCAN (pip-audit)
# -------------------------------------------------------------
Write-Host "[1/4] Running Python Dependency Scan (pip-audit)..." -ForegroundColor Yellow;
$pipAuditOutput = "$ReportsDir\pip-audit-report.json";
$reqFile = "$SampleAppDir\requirements.txt";
try {
    py -m pip_audit -r "$reqFile" -f json -o "$pipAuditOutput";
    Write-Host "  -> pip-audit complete. Report saved to reports/pip-audit-report.json" -ForegroundColor Green;
} catch {
    Write-Host "  -> pip-audit reported vulnerabilities or encountered an issue." -ForegroundColor Yellow;
}

# -------------------------------------------------------------
# 2. JAVASCRIPT DEPENDENCY SCAN (npm audit)
# -------------------------------------------------------------
Write-Host "`n[2/4] Running JavaScript Dependency Scan (npm audit)..." -ForegroundColor Yellow;
$npmAuditOutput = "$ReportsDir\npm-audit-report.json";
Push-Location "$SampleAppDir";
try {
    npm audit --json | Out-File -Encoding utf8 "$npmAuditOutput";
    Write-Host "  -> npm audit complete. Report saved to reports/npm-audit-report.json" -ForegroundColor Green;
} catch {
    Write-Host "  -> npm audit execution failed." -ForegroundColor Red;
} finally {
    Pop-Location;
}

# -------------------------------------------------------------
# 3. SECRET SCANNING (gitleaks)
# -------------------------------------------------------------
Write-Host "`n[3/4] Running Secret Scan (gitleaks)..." -ForegroundColor Yellow;
$gitleaksOutput = "$ReportsDir\gitleaks-report.json";
try {
    gitleaks detect --source "$RootDir" -v --report-path "$gitleaksOutput" --no-banner;
    Write-Host "  -> gitleaks complete. Report saved to reports/gitleaks-report.json" -ForegroundColor Green;
} catch {
    Write-Host "  -> gitleaks detected potential secret leaks." -ForegroundColor Red;
}

# -------------------------------------------------------------
# 4. DYNAMIC APPLICATION SECURITY TESTING (OWASP ZAP)
# -------------------------------------------------------------
Write-Host "`n[4/4] Running DAST Scan (OWASP ZAP via Docker)..." -ForegroundColor Yellow;
$appProcess =$null;

try {
    Write-Host "  -> Spawning background server on port 8080..." -ForegroundColor Gray;
    $appPath = "$SampleAppDir\app.py";
    $appProcess = Start-Process py -ArgumentList "`"$appPath`"" -WorkingDirectory "$RootDir" -PassThru;

    $isReady =$false;
    for ($i = 0; $i -lt 10; $i++) {
        Start-Sleep -Seconds 1;
        $tcp = New-Object System.Net.Sockets.TcpClient;
        try {
            $tcp.Connect("127.0.0.1", 8080);
            if ($tcp.Connected) {
                $isReady =$true;
                $tcp.Close();
                break;
            }
        } catch { }
        finally {
            $tcp.Dispose();
        }
    }

    if (-not $isReady) {
        Write-Host "  -> Warning: Port 8080 not responding yet, proceeding with scan attempt..." -ForegroundColor DarkYellow;
    } else {
        Write-Host "  -> Sample app verified listening on port 8080." -ForegroundColor Gray;
    }

    $dockerCheck = docker ps 2>&1;
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  -> Executing OWASP ZAP baseline scan container..." -ForegroundColor Gray;
        docker run --rm -v "${ReportsDir}:/zap/wrk:rw" -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t http://host.docker.internal:8080 -r zap-report.html -J zap-report.json;
        Write-Host "  -> ZAP scan complete. Reports saved to reports/zap-report.html & zap-report.json" -ForegroundColor Green;
    } else {
        Write-Host "  -> Docker daemon is not active. Skipping containerized DAST scan." -ForegroundColor DarkYellow;
    }
} catch {
    Write-Host "  -> OWASP ZAP run encountered an error: $_" -ForegroundColor Red;
} finally {
    if ($appProcess -and -not $appProcess.HasExited) {
        Write-Host "  -> Stopping background application server (PID: $($appProcess.Id))..." -ForegroundColor Gray;
        Stop-Process -Id $appProcess.Id -Force;
    }
}

Write-Host "`n=======================================================" -ForegroundColor Cyan;
Write-Host "   SECURITY SCAN COMPLETE. ALL REPORTS IN ./reports/    " -ForegroundColor Cyan;
Write-Host "=======================================================`n" -ForegroundColor Cyan;
