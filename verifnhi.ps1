Add-Type -AssemblyName System.Windows.Forms

$NHI = New-Object system.Windows.Forms.Form
$NHI.Text = "VerifNHI"
$NHI.TopMost = $true
$NHI.Width = 398
$NHI.Height = 223

$textBox2 = New-Object system.windows.Forms.TextBox
$textBox2.Width = 306
$textBox2.Height = 20
$textBox2.location = new-object system.drawing.point(38,27)
$textBox2.Font = "Microsoft Sans Serif,20"
$NHI.controls.Add($textBox2)

$label2 = New-Object system.windows.Forms.Label
$label2.Text = "Invalidasdfssssssssssssssssssssssssssssssssssss"
$label2.AutoSize = $true
$label2.Width = 25
$label2.Height = 10
$label2.location = new-object system.drawing.point(102,98)
$label2.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($label2)

$Verify = New-Object system.windows.Forms.Button
$Verify.Text = "Verify!"
$Verify.Width = 60
$Verify.Height = 30
$Verify.location = new-object system.drawing.point(39,98)
$Verify.Font = "Microsoft Sans Serif,10"
$Verify.Add_MouseClick({
#add here code triggered by the event
#[System.Windows.Forms.MessageBox]::Show("you clicked it!","you clicked it!")

})
$NHI.controls.Add($Verify)

$Generate = New-Object system.windows.Forms.Button
$Generate.Text = "Generate!"
$Generate.Width = 80
$Generate.Height = 30
$Generate.location = new-object system.drawing.point(263,98)
$Generate.Font = "Microsoft Sans Serif,10"
$Generate.Add_MouseClick({
#add here code triggered by the event
#[System.Windows.Forms.MessageBox]::Show("you clicked it!","you clicked it!")
})
$NHI.controls.Add($Generate)




[void]$NHI.ShowDialog()
$NHI.Dispose()