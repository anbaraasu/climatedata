Sub Raw_Transform()
    Dim ws As Worksheet
    Dim cell As Range
    Dim textData As String
    Dim lines As Variant
    Dim i As Integer
    Dim rowNum As Integer
    Dim questionNum As String, questionText As String, answerPreload As String
    Dim answer As String, testCase1 As String, expected1 As String
    Dim testCase2 As String, expected2 As String, testCase3 As String, expected3 As String
    Dim lineIndex As Integer
    
    ' Set the active worksheet
    Set ws = ActiveSheet
    
    ws.Range("A2:N20000").ClearContents
    
    ' Read the text content from column F (concatenating all non-empty cells)
    For Each cell In ws.Range("O:O")
        If cell.Value <> "" Then
            textData = textData & vbLf & cell.Value
        End If
    Next cell
    
    ' Split the text into lines
    lines = Split(textData, vbLf)
    
    ' Initialize row number for output (starting from row 2)
    rowNum = 2
    i = 0
    
    ' Loop through the lines to extract question details
    Do While i < UBound(lines)
        If InStr(lines(i), "Question ") > 0 Then
            ' Extract question number
            'questionNum = Trim(Split(lines(i), ":")(1))
            
            ' Extract question text
            questionText = Trim(Mid(lines(i + 1), InStr(lines(i + 1), ":") + 2))
            
            ' Extract answer preload
            lineIndex = i + 3 ' Start reading after "AnswerPreload:"
            answerPreload = ""
            Do While Trim(lines(lineIndex)) <> "Answer:"
                answerPreload = answerPreload & vbLf & Trim(lines(lineIndex))
                lineIndex = lineIndex + 1
            Loop
            
            ' Extract answer
            lineIndex = lineIndex + 1
            answer = ""
            Do While Not (Left(Trim(lines(lineIndex)), 10) Like "Testcase 1")
                answer = answer & vbLf & Trim(lines(lineIndex))
                lineIndex = lineIndex + 1
            Loop
            
            ' Extract test cases and expected results
            lineIndex = lineIndex + 1
            testCase1 = ""
            Do While Not (Left(Trim(lines(lineIndex)), 10) Like "Expected 1")
                testCase1 = testCase1 & vbLf & Trim(Mid(lines(lineIndex), InStr(lines(lineIndex), ":") + 2))
                lineIndex = lineIndex + 1
            Loop
            expected1 = ""
            Do While Not (Left(Trim(lines(lineIndex)), 10) Like "Testcase 2")
                expected1 = expected1 & vbLf & Trim(Mid(lines(lineIndex), InStr(lines(lineIndex), ":") + 2))
                lineIndex = lineIndex + 1
            Loop
            testCase2 = ""
            Do While Not (Left(Trim(lines(lineIndex)), 10) Like "Expected 2")
                testCase2 = testCase2 & vbLf & Trim(Mid(lines(lineIndex), InStr(lines(lineIndex), ":") + 2))
                lineIndex = lineIndex + 1
            Loop
            expected2 = ""
            Do While Not (Left(Trim(lines(lineIndex)), 10) Like "Testcase 3")
                expected2 = expected2 & vbLf & Trim(Mid(lines(lineIndex), InStr(lines(lineIndex), ":") + 2))
                lineIndex = lineIndex + 1
            Loop
            testCase3 = ""
            Do While Not (Left(Trim(lines(lineIndex)), 10) Like "Expected 3")
                testCase3 = testCase3 & vbLf & Trim(Mid(lines(lineIndex), InStr(lines(lineIndex), ":") + 2))
                lineIndex = lineIndex + 1
            Loop
            expected3 = ""
            Do While lineIndex <= UBound(lines) And Trim(lines(lineIndex)) <> ""
                expected3 = expected3 & vbLf & Trim(Mid(lines(lineIndex), InStr(lines(lineIndex), ":") + 2))
                lineIndex = lineIndex + 1
            Loop
            
            ' Write to Excel
            ws.Cells(rowNum, 1).Value = questionText
            ws.Cells(rowNum, 2).Value = "//" & questionText & answerPreload
            ws.Cells(rowNum, 3).Value = answer
            ws.Cells(rowNum, 4).Value = testCase1
            ws.Cells(rowNum, 5).Value = expected1
            ws.Cells(rowNum, 6).Value = testCase2
            ws.Cells(rowNum, 7).Value = expected2
            ws.Cells(rowNum, 8).Value = testCase3
            ws.Cells(rowNum, 9).Value = expected3
            
            ' Move to the next question block
            rowNum = rowNum + 1
            i = lineIndex + 6
        Else
            i = i + 1
        End If
    Loop
    ws.Cells.WrapText = False
    
    MsgBox "Processing Completed!", vbInformation
End Sub
