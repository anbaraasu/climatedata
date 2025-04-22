Private Sub Worksheet_Activate()
    On Error GoTo ErrorHandler ' Enable error handling

    ' Declare variables
    Dim OutlookApp As Object
    Dim OutlookNamespace As Object
    Dim OutlookFolder As Object
    Dim OutlookItems As Object
    Dim FilteredItems As Object
    Dim SenderFilteredItems As Object
    Dim OutlookMail As Object
    Dim ws As Worksheet
    Dim lastRow As Long
    Dim i As Long
    Dim senderEmail As String
    Dim senderName As String
    Dim emailContent As String
    Dim targetColumn As Integer

    ' Initialize Outlook application
    Set OutlookApp = CreateObject("Outlook.Application")
    If OutlookApp Is Nothing Then
        MsgBox "Unable to initialize Outlook application.", vbCritical
        Exit Sub
    End If

    Set OutlookNamespace = OutlookApp.GetNamespace("MAPI")
    If OutlookNamespace Is Nothing Then
        MsgBox "Unable to access Outlook namespace.", vbCritical
        Exit Sub
    End If

    ' Specify the folder to read emails from (e.g., "Inbox\Subfolder")
    On Error Resume Next
    Set OutlookFolder = OutlookNamespace.Folders("anbarasuv@hcltech.com").Folders("Inbox")
    On Error GoTo ErrorHandler
    If OutlookFolder Is Nothing Then
        MsgBox "Unable to access the specified Outlook folder.", vbCritical
        Exit Sub
    End If

    ' Get the items in the folder
    Set OutlookItems = OutlookFolder.Items
    If OutlookItems Is Nothing Then
        MsgBox "No items found in the specified folder.", vbCritical
        Exit Sub
    End If

    ' Filter emails received on or after April 9th, 2025
    Set FilteredItems = OutlookItems.Restrict("[ReceivedTime] >= '2025-04-09'")
    If FilteredItems.Count = 0 Then
        MsgBox "No emails found starting from April 9th, 2025.", vbInformation
        Exit Sub
    End If

    ' Sort filtered emails by received date in descending order
    FilteredItems.Sort "[ReceivedTime]", False

    ' Set the worksheet
    Set ws = ThisWorkbook.Sheets("email") ' Ensure the sheet name is correct
    If ws Is Nothing Then
        MsgBox "Unable to access the specified worksheet.", vbCritical
        Exit Sub
    End If

    ' Find the last row in column E
    lastRow = ws.Cells(ws.Rows.Count, "E").End(xlUp).Row

    ' Loop through rows starting from row 2
    For i = 2 To lastRow
        ' Get the sender email from column E and sender name from column C
        senderEmail = ws.Cells(i, "E").Value
        senderName = ws.Cells(i, "C").Value

        ' Filter emails by sender email or sender name
        Set SenderFilteredItems = FilteredItems.Restrict( _
            "[SenderEmailAddress] = '" & senderEmail & "' OR [SenderName] = '" & senderName & "'")
        If SenderFilteredItems.Count = 0 Then
            GoTo NextRow ' Skip if no emails match the sender email or sender name
        End If

        ' Loop through sender-filtered emails
        For Each OutlookMail In SenderFilteredItems
            ' Check if the email subject matches the day number
            If OutlookMail.Subject Like "*Assignment*" Then
                ' Get the email content
                emailContent = OutlookMail.Body

                ' Check if the email content is not empty before pasting
                If emailContent <> "" Then
                    ' Determine the target column based on the day assignment
                    Select Case ws.Cells(i, "E").Value
                        Case "Assignment 1"
                            targetColumn = 6 ' Column F
                        Case "Assignment 2"
                            targetColumn = 7 ' Column G
                        Case "Assignment 3"
                            targetColumn = 8 ' Column H
                        Case "Assignment 4"
                            targetColumn = 9 ' Column I
                        Case "Assignment 5"
                            targetColumn = 10 ' Column J
                        Case Else
                            MsgBox "Invalid day assignment in row " & i, vbExclamation
                            GoTo NextRow
                    End Select
                    ws.Cells(i, targetColumn).Value = emailContent
                End If
                Exit For ' Exit the loop after finding the first matching email
            End If
        Next OutlookMail

NextRow:
    Next i

    ' Clean up
    Set OutlookMail = Nothing
    Set SenderFilteredItems = Nothing
    Set FilteredItems = Nothing
    Set OutlookItems = Nothing
    Set OutlookFolder = Nothing
    Set OutlookNamespace = Nothing
    Set OutlookApp = Nothing

    MsgBox "Emails processed successfully!", vbInformation
    Exit Sub

ErrorHandler:
    MsgBox "An error occurred: " & Err.Description, vbCritical
    ' Clean up in case of error
    Set OutlookMail = Nothing
    Set SenderFilteredItems = Nothing
    Set FilteredItems = Nothing
    Set OutlookItems = Nothing
    Set OutlookFolder = Nothing
    Set OutlookNamespace = Nothing
    Set OutlookApp = Nothing
End Sub


