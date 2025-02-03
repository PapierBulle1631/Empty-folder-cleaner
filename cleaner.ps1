Add-Type -AssemblyName 'System.Windows.Forms'

#####################################################
#                                                   #
#    Create the form : button, label and textbox    #
#                                                   #
#####################################################

$form = New-Object System.Windows.Forms.Form
$form.Text = "Supprimer les dossiers vides"
$form.Size = New-Object System.Drawing.Size(600, 400)
$form.MinimumSize = New-Object System.Drawing.Size(600, 400)

$sourceLabel = New-Object System.Windows.Forms.Label
$sourceLabel.Text = 'Source :'
$sourceLabel.Location = New-Object System.Drawing.Point(10, 20)
$sourceLabel.Width = 120
$sourceLabel.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left
$form.Controls.Add($sourceLabel)

$sourceTextBox = New-Object System.Windows.Forms.TextBox
$sourceTextBox.Location = New-Object System.Drawing.Point(130, 20)
$sourceTextBox.Width = 320
$sourceTextBox.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right
$form.Controls.Add($sourceTextBox)

$sourceButton = New-Object System.Windows.Forms.Button
$sourceButton.Text = 'Parcourir'
$sourceButton.Location = New-Object System.Drawing.Point(460, 20)
$sourceButton.Width = 100
$sourceButton.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right
$form.Controls.Add($sourceButton)

# Create the destination folder label and textbox
$destinationLabel = New-Object System.Windows.Forms.Label
$destinationLabel.Text = 'Rapport :'
$destinationLabel.Location = New-Object System.Drawing.Point(10, 60)
$destinationLabel.Width = 120
$destinationLabel.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left
$form.Controls.Add($destinationLabel)

$destinationTextBox = New-Object System.Windows.Forms.TextBox
$destinationTextBox.Location = New-Object System.Drawing.Point(130, 60)
$destinationTextBox.Width = 320
$destinationTextBox.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right
$form.Controls.Add($destinationTextBox)

$destinationButton = New-Object System.Windows.Forms.Button
$destinationButton.Text = 'Parcourir'
$destinationButton.Location = New-Object System.Drawing.Point(460, 60)
$destinationButton.Width = 100
$destinationButton.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right
$form.Controls.Add($destinationButton)

# Create the output log TextBox (multiline)
$logTextBox = New-Object System.Windows.Forms.TextBox
$logTextBox.Location = New-Object System.Drawing.Point(10, 100)
$logTextBox.Width = 550
$logTextBox.Height = 200
$logTextBox.Multiline = $true
$logTextBox.ScrollBars = [System.Windows.Forms.ScrollBars]::Vertical
$logTextBox.ReadOnly = $true
$logTextBox.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right -bor [System.Windows.Forms.AnchorStyles]::Bottom
$form.Controls.Add($logTextBox)

# When the user clicks on a button to start processing
$processButton = New-Object System.Windows.Forms.Button
$processButton.Text = 'Lancer la recherche'
$processButton.Location = New-Object System.Drawing.Point(250, 315)
$graphics = [System.Drawing.Graphics]::FromImage([System.Drawing.Bitmap]::new(1, 1))
$textSize = $graphics.MeasureString($processButton.Text, $processButton.Font)
$processButton.Width = [math]::Ceiling($textSize.Width) + 10
$processButton.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right
$form.Controls.Add($processButton)











# Browse for Source Folder
$sourceButton.Add_Click({
    $folderDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderDialog.Description = "Sélectionnez le dossier de recherche. Tout les sous dossiers seront scannés et supprimés si vides."
    
    if ($folderDialog.ShowDialog() -eq 'OK') {
        $sourceTextBox.Text = $folderDialog.SelectedPath
        $logTextBox.AppendText("Dossier sélectionné pour la source : $($folderDialog.SelectedPath)`r`n")
    } else {
        $logTextBox.AppendText("Aucun dossier source sélectionné.`r`n")
    }
})

# Browse for Destination Folder
$destinationButton.Add_Click({
    $folderDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderDialog.Description = "Sélectionnez le dossier ou va être générer le rapport."

    if ($folderDialog.ShowDialog() -eq 'OK') {
        $destinationTextBox.Text = $folderDialog.SelectedPath
        $logTextBox.AppendText("Dossier sélectionné pour le rapport : $($folderDialog.SelectedPath)`r`n")
    } else {
        $logTextBox.AppendText("Aucun dossier destination sélectionné.`r`n")
    }
})

















$processButton.Add_Click({
    $sourcePath = $sourceTextBox.Text
    $destinationPath = $destinationTextBox.Text

    # Section to handle error that would prevent search from being performed
    if ([String]::IsNullOrWhiteSpace($sourcePath)) {
        $logTextBox.AppendText("Erreur : Le dossier source est vide. Veuillez sélectionner un chemin valide pour continuer`r`n")
        return
    }

    if ([String]::IsNullOrWhiteSpace($destinationPath)) {
        $logTextBox.AppendText("Erreur : Le dossier de destination est vide. Veuillez sélectionner un chemin valide pour continuer`r`n")
        return
    }

    if (-not (Test-Path $sourcePath)) {
        $logTextBox.AppendText("Erreur : Le dossier source spécifié n'existe pas.`r`n")
        return
    }

    if (-not (Test-Path $destinationPath)) {
        $logTextBox.AppendText("Erreur : Le dossier destination spécifié n'existe pas.`r`n")
        return
    }

    # Define the filename and join it to the path for the txt log creation
    $logFileName = "empty_directories_log.txt"
    $logFilePath = Join-Path -Path $destinationPath -ChildPath $logFileName
    $logTextBox.AppendText("Fichier de log : $logFilePath`r`n")
    Add-Content -Path $logFilePath -Value "




+------------------------------------------------------------------
|
|   Nouveau dossier scanné : $($sourcePath)
|
+------------------------------------------------------------------
    
    "

    # Runspace for file processing
    $runspace = [runspacefactory]::CreateRunspace()
    $runspace.Open()

    # Create a PowerShell script block to run the file search asynchronously
    $runspaceScriptBlock = {
        param($sourcePath, $destinationPath, $logTextBox, $logFilePath)

        # Process directories in the source folder
        Get-ChildItem -Path $sourcePath -Recurse -Directory | ForEach-Object {
            if ($_.GetFileSystemInfos().Count -eq 0) {
                try {
                    # Log the empty directory path and delete
                    Add-Content -Path $logFilePath -Value "Dossier vide trouvé et supprimé : $($_.FullName)"
                    $logTextBox.Invoke([Action]{
                        $logTextBox.AppendText("Dossier vide trouvé et supprimé : $($_.FullName)`r`n")
                    })
                    Remove-Item -Path $_.FullName -Force
                } catch {
                    $logTextBox.Invoke([Action]{
                        $logTextBox.AppendText("Erreur lors de la suppression du dossier : $($_.FullName)`r`n")
                    })
                }
            }
        }

        # Inform that the process is finished
        $logTextBox.Invoke([Action]{
            $logTextBox.AppendText("`r`nLe processus de suppression des dossiers vides est terminé.`r`n")
        })
            Add-Content -Path $logFilePath -Value "

+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$
$   Fin du nettoyage du dossier $($sourcePath)
$
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


----------------------------------------------------------------------------------------


    "
    }

    # Execute the script block on the runspace
    $runspaceThread = [powershell]::Create().AddScript($runspaceScriptBlock).AddArgument($sourcePath).AddArgument($destinationPath).AddArgument($logTextBox).AddArgument($logFilePath)
    $runspaceThread.BeginInvoke()

    # Notify the user that the process has started
    $logTextBox.AppendText("`r`nLe processus de suppression des dossiers vides a démarré.`r`n")
})

# Show the form
$form.ShowDialog()
