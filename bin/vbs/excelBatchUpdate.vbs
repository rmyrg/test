Sub OpenFilesInFolder()

    Dim path, fso, file, files
    path = "C:\dev\vbs\excel\"

    Set fso = CreateObject("Scripting.FileSystemObject")
    Set files = fso.GetFolder(path).files

    'Create excel object
    Set objExcel = CreateObject("Excel.Application")
    objExcel.Application.Visible = true

    'Process all files in the folder
    For Each file In files

      'Open excel file
      Set book = objExcel.Workbooks.Open(file)

      'Process all sheets
      For Each objSheet In objExcel.worksheets
        objSheet.Cells(1,3) = "test"
      Next

      book.Save
      objExcel.Quit()

    Next

End Sub

OpenFilesInFolder
