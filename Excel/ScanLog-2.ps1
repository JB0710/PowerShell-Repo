$csvFile = "Company_Medicaid_DME_ScanLog_20221020.csv"
$csvPath = "A:\CSVs\"
$masterFile = "A:\WorkingDir\SharePoint-ScanLog-Master.xlsx"
#$excelFile = "SharePoint-ScanLog-Master.xlsx"
#$excelPath = "Z:\AdvisorsTech\WorkingDir"
#$finalSaveFile = "SharePoint-ScanLog.xlsx"

$data = Import-Csv -Path $csvPath\$csvFile
#$TransactionId = $data.TransactionId
#$Timestamp = $data.Timestamp
#$SourcePath= $data.SourcePath
#$SourceBasename = $data.SourceBasename
#$SourceType = $data.SourceType
$SourceSize = $data.SourceSize
#$SourceModifiedAt = $data.SourceModifiedAt
#$SourceCreatedAt = $data.SourceCreatedAt
#$SourceAclsTotal = $data.SourceAclsTotal
#$SourceAccessedAt = $data.SourceAclsTotal
#$ResultCode = $data.ResultCode
#$SourceExtension = $data.SourceExtension

$SourceSize

#Import to Excel
$Excel = New-Object -ComObject excel.application
$Excel.visible = $false

$workbook = $Excel.workbooks.Open($masterFile)
$worksheet = $workbook.worksheets.Item(1)

$objRange = $worksheet.UsedRange
$a = $objRange.SpecialCells(11).row
$b = $objRange.SpecialCells(11).column

$range1 = $worksheet.range("A2:C$a")