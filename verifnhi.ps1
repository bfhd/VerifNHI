Add-Type -AssemblyName System.Windows.Forms

Function Button_Verify() {
    $valid = $false
	$NHInumber = $textBox2.Text
    #Regular expression for 3 letters and 4 numbers, excluding I and O for readability
    $pattern = "^([a-hj-np-zA-HJ-NP-Z]){3}([0-9]){4}?$";
    if ($NHInumber -match $pattern) {
        $valid = $true
    } else {
        $valid = $false
    }
	$NHInumber = $NHInumber.ToUpper()
	$array = [Char[]]$NHInumber
	$i = 7
	$total = @()
	#convert each letter to a number according to it's position in the alphabet (excluding I and O, numbers are not converted), 
	#and multiply it by the inverse of it's position in the string (last digit is a checksum digit)
	#eg: 
	# A B C 1 2 3
	#converts to:
	# 1 2 3 1 2 3
	#multiplied by:
	# 7 6 5 4 3 2
	foreach ($c in $array) { 
		if ($i -gt 1) { #we don't want to do the last item in the array - it is the checksum digit
			if ($c -match "[0-9]") {
				$b = [int]$c
				$total += ($b - 48) * $i #48 is for ascii numbers
			} else {
				$b = [byte][char]$c
				$total += ([int]$b - 64) * $i #64 is for ascii letters
			}
			$i--
		}
	}
	$sum = 0
	foreach ($c in $total) {
		$sum += $c #sum the resulting numbers 
	}
	$rem = $sum % 11 #find the checksum by caculating modulus 11
	
	if ($rem -eq 0) { #if checksum is zero then the NHI number is incorrect
		$valid = $false
	} else {
		$check_digit = 11 - $rem
		if ($check_digit -eq 10) { 
			$check_digit = 0
		}
	}
	#compare the checksum
	$NHIchecksum = [byte][char]$array[6] - 48
	if ($NHIchecksum -eq $check_digit) {
		$valid = $true
	} else {
		$valid = $false
	}
	
    if ($valid -eq $false) {
        $label2.Text = 'Invalid'
        $label2.ForeColor = "red"
		$label3.Text = 'Check digit is ' + $check_digit
    } elseif ($valid -eq $true) {
        $label2.Text = 'Valid'
        $label2.ForeColor = "green"
		$label3.Text = ''
    }
}

Function Button_Generate() {
	[System.Windows.Forms.MessageBox]::Show("you clicked it!","you clicked it!")
}

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
$label2.Text = ""
$label2.AutoSize = $true
$label2.Width = 25
$label2.Height = 10
$label2.location = new-object system.drawing.point(151,98)
$label2.Font = "Microsoft Sans Serif,15,style=Bold"
$NHI.controls.Add($label2)

$label3 = New-Object system.windows.Forms.Label
$label3.Text = ""
$label3.AutoSize = $true
$label3.Width = 25
$label3.Height = 10
$label3.location = new-object system.drawing.point(151,128)
$label3.Font = "Microsoft Sans Serif,8"
$NHI.controls.Add($label3)

$Verify = New-Object system.windows.Forms.Button
$Verify.Text = "Verify!"
$Verify.Width = 60
$Verify.Height = 30
$Verify.location = new-object system.drawing.point(39,98)
$Verify.Font = "Microsoft Sans Serif,10"
$Verify.Add_MouseClick({
#add here code triggered by the event
Button_Verify

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
Button_Generate
})
$NHI.controls.Add($Generate)




[void]$NHI.ShowDialog()
$NHI.Dispose()