# ライブラリ
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# フォームを作成
$form = New-Object System.Windows.Forms.Form
$form.Text = 'バッテリー残量'
$form.Size = New-Object System.Drawing.Size(160, 60)
# $form.StartPositionn = 'CenterScreen'

# フォームの初期位置を左上に設定
$form.StartPosition = 'Manual'
$form.Location = New-Object System.Drawing.Point(0, 0)


# ラベルを作成
$label = New-Object System.Windows.Forms.label

# フォームに貼り付け
$form.Controls.Add($label)

# フォームの表示位置を「最前列」に指定
$form.Topmost = $true

# タイマーでループ
$timer = New-Object System.Windows.Forms.Timer


# ここから初期表示
	$InitCharge = Get-CimInstance -ClassName Win32_Battery | Select-Object -ExpandProperty EstimatedChargeRemaining
	$CurrentCharge = "Current Charge: $InitCharge %."
	$label.Text = "$CurrentCharge"
	$label.Size = New-Object System.Drawing.Size(150, 40)
	
	# フォントを設定（フォント名, サイズ, スタイル）
	$label.Font = New-Object System.Drawing.Font("Arrial", 10, $form.Font.Style)
# ここまで初期表示

# タイマーのTickイベントに更新処理を追加
$timer.Add_Tick({
	# インスタンス情報を取得（バッテリー残量）
	$charge = Get-CimInstance -ClassName Win32_Battery | Select-Object -ExpandProperty EstimatedChargeRemaining
	$CurrentCharge = "Current Charge: $charge %."
	$label.Text = "$CurrentCharge"
	$label.Size = New-Object System.Drawing.Size(150, 40)
	
	# フォントを設定（フォント名, サイズ, スタイル）
	$label.Font = New-Object System.Drawing.Font("Arrial", 10, $form.Font.Style)
})

# 10秒ごとに更新
$timer.Interval = 10000

# タイマーを開始
$timer.Start()

# フォームを表示
[void]$form.ShowDialog()
