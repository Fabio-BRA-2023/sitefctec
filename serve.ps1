# Servidor local simples para visualizar o site recriado (http://localhost:8099/)
$root = Join-Path $PSScriptRoot "site-recriado"
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:8099/")
$listener.Start()
Write-Host "Servindo $root em http://localhost:8099/"
while ($listener.IsListening) {
    try {
        $ctx = $listener.GetContext()
        $path = $ctx.Request.Url.AbsolutePath
        if ($path -eq "/") { $path = "/index.html" }
        $file = Join-Path $root ($path -replace '/', '\')
        if ((Test-Path $file -PathType Leaf) -and $file.StartsWith($root, [StringComparison]::OrdinalIgnoreCase)) {
            $bytes = [IO.File]::ReadAllBytes($file)
            $ext = [IO.Path]::GetExtension($file).ToLower()
            $mime = switch ($ext) {
                ".html" { "text/html; charset=utf-8" }
                ".css"  { "text/css; charset=utf-8" }
                ".js"   { "text/javascript; charset=utf-8" }
                ".png"  { "image/png" }
                ".jpg"  { "image/jpeg" }
                ".svg"  { "image/svg+xml" }
                ".ico"  { "image/x-icon" }
                default { "application/octet-stream" }
            }
            $ctx.Response.ContentType = $mime
            $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
        } else {
            $ctx.Response.StatusCode = 404
        }
        $ctx.Response.Close()
    } catch {
        Write-Host $_.Exception.Message
    }
}
