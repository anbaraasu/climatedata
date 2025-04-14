Sub Moodle_XML()
    Dim ws As Worksheet
    Dim folderPath As String
    Dim fileName As String
    Dim xmlContent As String
    Dim lastRow As Long
    Dim i As Long
    Dim j As Long
    Dim questionText As String
    Dim preloadedAnswer As String
    Dim answer As String
    Dim testCode As String
    Dim expectedOutput As String

    ' Set the active worksheet
    Set ws = ActiveSheet

    ' Prompt the user to enter a file name
    fileName = InputBox("Enter the file name for the XML file (without extension):", "File Name", ws.Name)
    If fileName = "" Then
        MsgBox "File name cannot be empty.", vbExclamation
        Exit Sub
    End If

    ' Create the folder path based on the active sheet name
    folderPath = ThisWorkbook.Path & "\" & ws.Name
    folderPath = Replace(folderPath, "https://mytecho365-my.sharepoint.com/personal/mytech_mytech_com/Documents/", "C:\Users\mytech\mytech - mytech TECHNOLOGIES LIMITED\")
    folderPath = Replace(folderPath, "/", "\")
    
    If Dir(folderPath, vbDirectory) = "" Then
        MkDir folderPath
    End If

    ' Initialize XML content
    xmlContent = "<?xml version=""1.0"" encoding=""UTF-8""?>" & vbCrLf
    xmlContent = xmlContent & "<quiz>" & vbCrLf

    ' Determine the last row with data
    lastRow = ws.Cells(ws.Rows.Count, 1).End(xlUp).Row

    ' Loop through each question in the worksheet
    For i = 2 To lastRow
        questionText = ws.Cells(i, 1).Value ' Question text
        preloadedAnswer = ws.Cells(i, 2).Value ' Preloaded answer
        answer = ws.Cells(i, 3).Value ' Answer

        ' Start <question> tag
        xmlContent = xmlContent & "  <question type=""coderunner"">" & vbCrLf
        xmlContent = xmlContent & "    <name>" & vbCrLf
        xmlContent = xmlContent & "      <text>" & questionText & "</text>" & vbCrLf
        xmlContent = xmlContent & "    </name>" & vbCrLf
        xmlContent = xmlContent & "    <questiontext format=""html"">" & vbCrLf
        xmlContent = xmlContent & "      <text><![CDATA[<p dir=""ltr"">" & questionText & "</p>]]></text>" & vbCrLf
        xmlContent = xmlContent & "    </questiontext>" & vbCrLf
        xmlContent = xmlContent & "    <generalfeedback format=""html"">" & vbCrLf
        xmlContent = xmlContent & "      <text></text>" & vbCrLf
        xmlContent = xmlContent & "    </generalfeedback>" & vbCrLf
        xmlContent = xmlContent & "    <defaultgrade>1.0000000</defaultgrade>" & vbCrLf
        xmlContent = xmlContent & "    <penalty>0.0000000</penalty>" & vbCrLf
        xmlContent = xmlContent & "    <hidden>0</hidden>" & vbCrLf
        xmlContent = xmlContent & "    <idnumber></idnumber>" & vbCrLf
        xmlContent = xmlContent & "    <coderunnertype>nodejs</coderunnertype>" & vbCrLf
        xmlContent = xmlContent & "    <prototypetype>0</prototypetype>" & vbCrLf
        xmlContent = xmlContent & "    <allornothing>1</allornothing>" & vbCrLf
        xmlContent = xmlContent & "    <penaltyregime>10, 20, ...</penaltyregime>" & vbCrLf
        xmlContent = xmlContent & "    <precheck>0</precheck>" & vbCrLf
        xmlContent = xmlContent & "    <hidecheck>0</hidecheck>" & vbCrLf
        xmlContent = xmlContent & "    <showsource>0</showsource>" & vbCrLf
        xmlContent = xmlContent & "    <answerboxlines>18</answerboxlines>" & vbCrLf
        xmlContent = xmlContent & "    <answerboxcolumns>100</answerboxcolumns>" & vbCrLf
        xmlContent = xmlContent & "    <answerpreload>" & preloadedAnswer & "</answerpreload>" & vbCrLf
        xmlContent = xmlContent & "    <globalextra></globalextra>" & vbCrLf
        xmlContent = xmlContent & "    <useace></useace>" & vbCrLf
        xmlContent = xmlContent & "    <resultcolumns></resultcolumns>" & vbCrLf
        xmlContent = xmlContent & "    <template></template>" & vbCrLf
        xmlContent = xmlContent & "    <iscombinatortemplate></iscombinatortemplate>" & vbCrLf
        xmlContent = xmlContent & "    <allowmultiplestdins></allowmultiplestdins>" & vbCrLf
        xmlContent = xmlContent & "    <answer><![CDATA[" & answer & "]]></answer>" & vbCrLf

        ' Add additional tags after <answer>
        xmlContent = xmlContent & "    <validateonsave>1</validateonsave>" & vbCrLf
        xmlContent = xmlContent & "    <testsplitterre></testsplitterre>" & vbCrLf
        xmlContent = xmlContent & "    <language></language>" & vbCrLf
        xmlContent = xmlContent & "    <acelang></acelang>" & vbCrLf
        xmlContent = xmlContent & "    <sandbox></sandbox>" & vbCrLf
        xmlContent = xmlContent & "    <grader></grader>" & vbCrLf
        xmlContent = xmlContent & "    <cputimelimitsecs></cputimelimitsecs>" & vbCrLf
        xmlContent = xmlContent & "    <memlimitmb></memlimitmb>" & vbCrLf
        xmlContent = xmlContent & "    <sandboxparams></sandboxparams>" & vbCrLf
        xmlContent = xmlContent & "    <templateparams></templateparams>" & vbCrLf
        xmlContent = xmlContent & "    <hoisttemplateparams>1</hoisttemplateparams>" & vbCrLf
        xmlContent = xmlContent & "    <extractcodefromjson>1</extractcodefromjson>" & vbCrLf
        xmlContent = xmlContent & "    <templateparamslang>None</templateparamslang>" & vbCrLf
        xmlContent = xmlContent & "    <templateparamsevalpertry>0</templateparamsevalpertry>" & vbCrLf
        xmlContent = xmlContent & "    <templateparamsevald>{}</templateparamsevald>" & vbCrLf
        xmlContent = xmlContent & "    <twigall>0</twigall>" & vbCrLf
        xmlContent = xmlContent & "    <uiplugin></uiplugin>" & vbCrLf
        xmlContent = xmlContent & "    <uiparameters></uiparameters>" & vbCrLf
        xmlContent = xmlContent & "    <attachments>0</attachments>" & vbCrLf
        xmlContent = xmlContent & "    <attachmentsrequired>0</attachmentsrequired>" & vbCrLf
        xmlContent = xmlContent & "    <maxfilesize>10240</maxfilesize>" & vbCrLf
        xmlContent = xmlContent & "    <filenamesregex></filenamesregex>" & vbCrLf
        xmlContent = xmlContent & "    <filenamesexplain></filenamesexplain>" & vbCrLf
        xmlContent = xmlContent & "    <displayfeedback>1</displayfeedback>" & vbCrLf
        xmlContent = xmlContent & "    <giveupallowed>0</giveupallowed>" & vbCrLf
        xmlContent = xmlContent & "    <prototypeextra></prototypeextra>" & vbCrLf

        ' Add stdin, expected, extra, and display tags
        xmlContent = xmlContent & "    <stdin>" & vbCrLf
        xmlContent = xmlContent & "      <text></text>" & vbCrLf
        xmlContent = xmlContent & "    </stdin>" & vbCrLf
        xmlContent = xmlContent & "    <expected>" & vbCrLf
        xmlContent = xmlContent & "      <text>-6</text>" & vbCrLf ' Example expected value
        xmlContent = xmlContent & "    </expected>" & vbCrLf
        xmlContent = xmlContent & "    <extra>" & vbCrLf
        xmlContent = xmlContent & "      <text></text>" & vbCrLf
        xmlContent = xmlContent & "    </extra>" & vbCrLf
        xmlContent = xmlContent & "    <display>" & vbCrLf
        xmlContent = xmlContent & "      <text>SHOW</text>" & vbCrLf
        xmlContent = xmlContent & "    </display>" & vbCrLf

        ' Add test cases
        xmlContent = xmlContent & "    <testcases>" & vbCrLf
        j = 4 ' Start from column 4 for test cases
        Do While ws.Cells(i, j).Value <> ""
            testCode = ws.Cells(i, j).Value ' Test code
            expectedOutput = ws.Cells(i, j + 1).Value ' Expected output

            xmlContent = xmlContent & "      <testcase testtype=""0"" useasexample=""0"" hiderestiffail=""0"" mark=""1.0000000"">" & vbCrLf
            xmlContent = xmlContent & "        <testcode><text>" & testCode & "</text></testcode>" & vbCrLf
            xmlContent = xmlContent & "        <expected><text>" & expectedOutput & "</text></expected>" & vbCrLf
            xmlContent = xmlContent & "      </testcase>" & vbCrLf

            j = j + 2 ' Move to the next pair of test code and expected output
        Loop
        xmlContent = xmlContent & "    </testcases>" & vbCrLf

        ' End <question> tag
        xmlContent = xmlContent & "  </question>" & vbCrLf
    Next i

    ' Close the root <quiz> tag
    xmlContent = xmlContent & "</quiz>"

    ' Write the XML content to a file
    Dim filePath As String
    filePath = folderPath & "\" & fileName & ".xml"
    Dim fileNum As Integer
    fileNum = FreeFile
    Open filePath For Output As #fileNum
    Print #fileNum, xmlContent
    Close #fileNum

    ' Confirmation message
    MsgBox "XML file has been created and saved to: " & filePath, vbInformation
End Sub