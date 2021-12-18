cls

#convert json file into powershell object
$nvd_vulns = (Get-Content -Raw -Path ".\nvdcve-1.1-2021.json" | `
ConvertFrom-Json) | select CVE_Items

#csv file
$filename = "nvd-data.csv"

#headers for the csv file
set-content -Value "`"PublishDate`",`"Description`", `"Impact`", `"CVE`"" $filename

#array to store the data
$theV = @()

foreach ($vuln in $nvd_vulns.CVE_ITEMS) {
    #Vuln description
    $descript = $vuln.cve.description.description_data

    $keyword = "Java"
    #search for keyword
    if ($descript -imatch "$keyword") {

        #published date
        $pubDate = $vuln.publishedDate

        #description
        $z = $descript | select value
        $description = $z.value

        #impact
        $y = $vuln.impact
        $impact = $y.baseMetricV2.severity

        #cve number
        $cve = $vuln.cve.CVE_data_meta.ID
        
        #format the csv
        $theV += "`"$pubDate`", `"$description`", `"impact`", `"$cve`""
         
    }

}

"$theV" | Add-Content -Path $filename