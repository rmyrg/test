
Sub ExcelBatchCreateFile()

    Dim path, file, sheet, sellRange, worksheet, fileName
    path = "C:\dev\vbs\excel\"
    file = "list.xlsx"
    sheet = "list"

    Set FS = CreateObject("Scripting.FileSystemObject")

    'Create excel object
    Set objExcel = CreateObject("Excel.Application")
    objExcel.Application.Visible = true

    Set listBook = objExcel.Workbooks.Open(path & file)
    Set listSheet = listBook.Sheets(sheet)

    Dim newBook, ret, line
    For i=4 To 100
      'Check the existence of the file
      If listSheet.Cells(i,1) ="" Then Exit For

      
      If fileName = listSheet.Cells(i,1) Then
        line = line + 1
      Else
        If not IsEmpty(newBook) Then
          newBook.Close
        End If
        line = 1
        'Set the file name
        fileName = listSheet.Cells(i,1)
      
        ret = FS.FileExists(path & fileName & ".xlsx")
        If ret Then
          Set newBook = objExcel.Workbooks.Open(path & fileName & ".xlsx")
        Else
          Set newBook = objExcel.Workbooks.Add()
        End If
 
        Set newSheet = newBook.Sheets(1)
      End If
      
      'Copy cell
      newSheet.Cells(line,4) = listSheet.Cells(i,4)

      ret = FS.FileExists(path & fileName & ".xlsx")
      If ret Then
        newBook.Save
      Else
        newBook.SaveAs(path & fileName & ".xlsx")
      End If

    Next
    newBook.Close

End Sub

ExcelBatchCreateFile